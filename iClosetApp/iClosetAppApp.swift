import SwiftUI
import FirebaseCore
import FirebaseAuth

@main
struct YourApp: App {
    // Register app delegate for Firebase setup
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    // Pridanie UserSettings ako @StateObject
    @StateObject var userSettings = UserSettings() // Globálny objekt pre údaje používateľa
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                // Rozhodne, ktorý pohľad ukázať podľa toho, či je používateľ prihlásený
                if let _ = Auth.auth().currentUser {
                    HomeView()
                        .environmentObject(userSettings) // Poskytneme UserSettings objekt
                } else {
                    // Ak nie je prihlásený, ukážeme LoginView
                    LoginView()
                        .environmentObject(userSettings) // Poskytneme UserSettings objekt
                }
            }
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}
