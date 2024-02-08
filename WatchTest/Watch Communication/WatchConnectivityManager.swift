//
//  WatchConnectivityManager.swift
//  HealthWatch
//
//  Created by Matias La Delfa on 03/02/2023.
//

import Combine
import WatchConnectivity

struct WatchMessage: Identifiable {
    let id = UUID()
    let text: String
}

private let messageKey = "message"

final class WatchConnectivityManager: NSObject, ObservableObject {
    static let shared = WatchConnectivityManager()
    
    private override init() {
        super.init()
        // If Watch is supported start session.
        guard WCSession.isSupported() else { return }
        WCSession.default.delegate = self
        WCSession.default.activate()
        print("WATCH: Initialized")
    }
    
    /// Attempt to start a session.
    func connect() {
        guard WCSession.isSupported() else {
            print("WATCH: WCSession is not supported")
            return
        }
        WCSession.default.activate()
    }
}

// MARK: WCSessionDelegate
extension WatchConnectivityManager: WCSessionDelegate {
    /// Message handler for 'send()' method.
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
    }
    
    func session(_ session: WCSession,
                 activationDidCompleteWith activationState: WCSessionActivationState,
                 error: Error?) {
        print("WATCH: Activation complete: \(activationState)")
    }
    
    #if os(iOS)
    func sessionDidBecomeInactive(_ session: WCSession) {
        print("WATCH: Session did become inactive")
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        // Activates a session in case it gets deactivated. This can happen if the user owns several watches and we need to
        // support watch switching.
        print("WATCH: Session did become deactivate")
        session.activate()
    }
    #endif
}

// MARK: - WatchService
class WatchService<T: Codable>: NSObject, WCSessionDelegate {
    var message = PassthroughSubject<T, Never>()
    
    override init() {
        super.init()
        guard WCSession.isSupported() else { return }
        WCSession.default.delegate = self
    }
    
    /// Sends a from iOS to Watch and viceversa depending on triggering platflorm.
    func send(_ message: T) {
        guard WCSession.default.activationState == .activated else { return }
        #if os(iOS)
        guard WCSession.default.isWatchAppInstalled else { return }
        #else
        guard WCSession.default.isCompanionAppInstalled else { return }
        #endif
        
        let data = try? JSONEncoder().encode(message)
        guard let data = data else {
            print("WATCH: Send error - invalid data")
            return
        }
        
        let sendMessage = [messageKey: data]
        WCSession.default.sendMessage(sendMessage, replyHandler: nil) { error in
            print("WATCH: Send error: \(error)")
        }
    }
    
    /// Message handler for 'send()' method.
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        guard let data = message[messageKey] as? Data else { return }
        
        DispatchQueue.main.async { [weak self] in
            guard let receivedMessage = try? JSONDecoder().decode(T.self, from: data) else { return }
            self?.message.send(receivedMessage)
        }
    }
    
    func session(_ session: WCSession,
                 activationDidCompleteWith activationState: WCSessionActivationState,
                 error: Error?) {
    }
    
    #if os(iOS)
    func sessionDidBecomeInactive(_ session: WCSession) {
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
    }
    #endif
}




// MARK: - Legacy
//final class WatchManager: NSObject, WCSessionDelegate, ObservableObject {
//    private var session: WCSession
//
//    var isReachable: Bool {
//        return session.isReachable
//    }
//
//    init(session: WCSession = .default) {
//        self.session = session
//        super.init()
//        self.session.delegate = self
//        connect()
//    }
//
//    /// Attempt to start a session.
//    func connect() {
//        guard WCSession.isSupported() else {
//            print("WATCH: WCSession is not supported")
//            return
//        }
//        session.activate()
//    }
//
//    func session(_ session: WCSession,
//                 activationDidCompleteWith activationState: WCSessionActivationState,
//                 error: Error?) {
//        print("WATCH: Activation complete: \(activationState)")
//    }
//
//    #if os(iOS)
//    func sessionDidBecomeInactive(_ session: WCSession) {
//        print("WATCH: Session did become inactive")
//    }
//
//    func sessionDidDeactivate(_ session: WCSession) {
//        // Activates a session in case it gets deactivated. This can happen if the user owns several watches and we need to
//        // support watch switching.
//        print("WATCH: Session did become deactivate")
//        session.activate()
//    }
//    #endif
//}
