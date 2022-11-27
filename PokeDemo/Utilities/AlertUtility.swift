//
//  AlertUtility.swift
//  PokeDemo
//
//  Created by Rudr Bansal on 05/07/22.
//

import Foundation
import UIKit


struct AlertUtility {
    
    static let CancelButtonIndex = -1;
    static func showAlert(_ onController:UIViewController!, title:String?, message:String? ) {
        showAlert(onController, title: title, message: message, cancelButton: AlertUtility.AlertActions.ok, buttons: nil, actions: nil)
    }
    
    /**
     - parameter title:        title for the alert
     - parameter message:      message for alert
     - parameter cancelButton: title for cancel button
     - parameter buttons:      array of string for title for other buttons
     - parameter actions:      action is the callback which return the action and index of the button which was pressed
     */
    
    
    static func showAlert(_ onController:UIViewController!, title:String?,message:String? = nil, cancelButton:String = AlertUtility.AlertActions.ok, buttons:[String]? = nil, actions:(( _ alertAction:UIAlertAction, _ index:Int)->())? = nil) {
        // make sure it would be run on  main queue
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let action = UIAlertAction(title: cancelButton, style: UIAlertAction.Style.cancel) { (action) in
            alertController.dismiss(animated: true, completion: nil)
            actions?(action,CancelButtonIndex)
        }
        alertController.addAction(action)
        if let _buttons = buttons {
            for button in _buttons {
                let action = UIAlertAction(title: button, style: .default) { (action) in
                    let index = _buttons.firstIndex(of: action.title!)
                    actions?(action,index!)
                }
                alertController.addAction(action)
            }
        }
        onController.present(alertController, animated: true, completion: nil)
    }
    
    static func showAlertWithAction(_ onController:UIViewController!, title:String?, message:String?, buttonTitle: String , actionPerformed: @escaping () -> ()) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: buttonTitle, style: UIAlertAction.Style.default, handler: { action in
            actionPerformed()
        }))
        
        onController.present(alert, animated: true, completion: nil)
    }
    
    static func showMessageWithHandler(sender: UIViewController, alertTitle title:String, message:String, btnCancel:String, btnOk:String, cancelAction:@escaping () -> Void, okAction:@escaping () ->Void)
    {
        DispatchQueue.main.async() {
            
            let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
            if !(btnCancel.isEmpty )
            {
                alert.addAction(UIAlertAction(title: btnCancel, style: UIAlertAction.Style.default, handler: { action in
                    cancelAction()
                }))
            }
            
            if !(btnOk.isEmpty )
            {
                alert.addAction(UIAlertAction(title: btnOk, style: UIAlertAction.Style.default, handler: { action in
                    alert.dismiss(animated: true, completion: nil)
                    
                    okAction()
                    
                }))
            }
            
            sender.present(alert, animated: true, completion: nil)
        }
    }
    
    static func showActionSheet(sender: UIViewController, title: String, message: String, btnTitleFirst: String, btnTitleSecond: String, btnActionFirst: @escaping() -> Void, btnActionSecond: @escaping() -> Void) {
        
        let actionsheet = UIAlertController(title: "", message: message, preferredStyle: .actionSheet)
        
        actionsheet.addAction(UIAlertAction(title: btnTitleFirst, style: .default, handler: { (action:UIAlertAction) in
            btnActionFirst()
        }))
        
        actionsheet.addAction(UIAlertAction(title: btnTitleSecond, style: .default, handler: { (action:UIAlertAction)in
            btnActionSecond()
        }))
        
        actionsheet.addAction(UIAlertAction(title: AlertUtility.AlertActions.cancel, style: .cancel, handler: nil))
        sender.present(actionsheet,animated: true, completion: nil)
    }
    
    struct AlertTitles {
        static let alert = "Alert!"
        static let success = "Success"
        static let error = "Error"
        static let sessionExpired = "Session Expired"
        static let loading = "Loading..."
        static let logout = "Logout"
    }
    
    struct AlertMessages {
        static let somethingWrong = "Sorry, something went wrong?"
        static let noInternet = "Check your internet connection"
    }
    
    struct AlertActions {
        static let ok = "OK"
        static let cancel = "Cancel"
        static let save = "Save"
    }
}
