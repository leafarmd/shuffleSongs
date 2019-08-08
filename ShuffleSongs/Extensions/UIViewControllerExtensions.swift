import UIKit

extension UIViewController {
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle:.alert)
        let okAction = UIAlertAction(title: "ok", style: .cancel, handler: nil)
        
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
}
