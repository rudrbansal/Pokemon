//
//  AlertUtility.swift
//  PokeDemo
//
//  Created by Rudr Bansal on 05/07/22.
//

import Foundation
import UIKit


struct AlertUtility {
    
    // MARK: - Properties
    
    // MARK: - Private
    
    private let CancelButtonIndex = -1
    private let ok = "OK"
    private let cancel = "Cancel"
    
    // MARK: - Public

    static let shared = AlertUtility()
    
    // MARK: - Exposed Methods
    
    func showAlert(_ onController:UIViewController!, title:String?, message:String? ) {
        showAlert(onController, title: title, message: message, cancelButton: ok, buttons: nil, actions: nil)
    }
    
    /**
     - parameter title:        title for the alert
     - parameter message:      message for alert
     - parameter cancelButton: title for cancel button
     - parameter buttons:      array of string for title for other buttons
     - parameter actions:      action is the callback which return the action and index of the button which was pressed
     */
    
    
    func showAlert(_ onController:UIViewController!, title:String?,message:String? = nil, cancelButton:String, buttons:[String]? = nil, actions:(( _ alertAction:UIAlertAction, _ index:Int)->())? = nil) {
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
    
    func showAlertWithAction(_ onController:UIViewController!, title:String?, message:String?, buttonTitle: String , actionPerformed: @escaping () -> ()) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: buttonTitle, style: UIAlertAction.Style.default, handler: { action in
            actionPerformed()
        }))
        
        onController.present(alert, animated: true, completion: nil)
    }
    
    func showMessageWithHandler(sender: UIViewController, alertTitle title:String, message:String, btnCancel:String, btnOk:String, cancelAction:@escaping () -> Void, okAction:@escaping () ->Void)
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
    
    func showActionSheet(sender: UIViewController, title: String, message: String, btnTitleFirst: String, btnTitleSecond: String, btnActionFirst: @escaping() -> Void, btnActionSecond: @escaping() -> Void) {
        
        let actionsheet = UIAlertController(title: "", message: message, preferredStyle: .actionSheet)
        
        actionsheet.addAction(UIAlertAction(title: btnTitleFirst, style: .default, handler: { (action:UIAlertAction) in
            btnActionFirst()
        }))
        
        actionsheet.addAction(UIAlertAction(title: btnTitleSecond, style: .default, handler: { (action:UIAlertAction)in
            btnActionSecond()
        }))
        
        actionsheet.addAction(UIAlertAction(title: cancel, style: .cancel, handler: nil))
        sender.present(actionsheet,animated: true, completion: nil)
    }
}
