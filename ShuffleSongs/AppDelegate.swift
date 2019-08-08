import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    let window = UIWindow(frame: UIScreen.main.bounds)
    private let navigator = UINavigationController()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        makeViewController()
        
        return true
    }
    
    private func makeViewController() {
        
        let navigationBarAppearace = UINavigationBar.appearance()
        navigationBarAppearace.tintColor = .white
        navigationBarAppearace.titleTextAttributes = [.foregroundColor : UIColor.white]
        navigationBarAppearace.barTintColor = UIColor(named: "shufflePurple")
        navigator.navigationBar.tintColor = .white
        
        let router = SongsListRouter(navigator: navigator)
        let viewController = router.makeViewController()
        
        window.rootViewController = navigator
        window.makeKeyAndVisible()
        window.rootNavigationController?.pushViewController(viewController, animated: false)
    }
}

extension UIWindow {
    var rootNavigationController: UINavigationController? {
        return rootViewController as? UINavigationController
    }
}
