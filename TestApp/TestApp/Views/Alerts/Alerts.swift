import Foundation
import UIKit


struct AlertGenerator {
   static func OkAlert(title: String, message: String, handler: @escaping ((UIAlertAction) -> Void)) -> UIAlertController {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction.init(title: "Ok", style: .default, handler: handler))
        return alertController
    }
}

