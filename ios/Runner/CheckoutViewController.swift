//
//  CheckoutViewController.swift
//  Runner
//
//  Created by AWOK on 1/24/19.
//  Copyright © 2019 The Chromium Authors. All rights reserved.
//

import UIKit
import CheckoutKit
class CheckoutViewController: UIViewController {
let publicKey: String = "pk_16f657f4-65db-406a-81b6-2cd708581c6e"
    override func viewDidLoad() {
        super.viewDidLoad()

//        var ck: CheckoutKit? = nil
//        do {
//            try ck = CheckoutKit.getInstance(publicKey)
//        } catch _ as NSError {
//            /* Happens when the public key is not valid, raised during the instanciation of the CheckoutKit object */
//            /* Type of the error in the enum CheckoutError. Different types are NoPK (if getInstance is called with no parameters and no public key has been provided before) and InvalidPK (if the public key is invalid) */
//        }
//        
//        
//        /* Take the card information where ever you want (form, fields in the application page...) */
//        var card: Card? = nil
//        do {
//            try card = Card(name: "nameField.text!", number: "numberField.text!", expYear: "year", expMonth: "month", cvv: "cvvField.text!", billingDetails: nil)
//        } catch let err as CardError {
//            /* Happens when the card informations entered by the user are not correct */
//            /* Type of the error in the enum CardError. Different types are InvalidCVV (if the CVV does not have the correct format), InvalidExpiryDate (if the card is expired), InvalidNumber (if the card's number is wrong). */
//        } catch _ as NSError {
//            /* If any other exception was thrown */
//        }
//        
//        ck!.createCardToken(card!, completion:{ (resp: Response<CardTokenResponse>) -> Void in
//            if (resp.hasError) {
//                /* Print error message or handle it */
//            } else {
//                /* The card object */
//                /* The field containing the card token to make a charge */
//                
//                
////                let batteryChannel = FlutterMethodChannel(name: "flutter.experiment",
////                                                          binaryMessenger: FlutterViewController)
////                let cardToken: String = resp.model?.cardToken ?? ""
//            }
//        })
    }
    
func getCardToken() {
    
    var ck: CheckoutKit? = nil
   
    
    do {
        try ck = CheckoutKit.getInstance("pk_test_XXXXXXXXX",
                                         env: Environment.SANDBOX)
    } catch _ as NSError {
        
    }
    
    if ck != nil {
        if (CardValidator.validateCardNumber("4242424242424242")) {
            
            var card: Card? = nil
            do {
                try card = Card(name: "test name",
                                number: "4242424242424242",
                                expYear: "2018",
                                expMonth: "06",
                                cvv: "100",
                                billingDetails: nil)
                
            } catch _ as CardError {
                
            } catch _ as NSError {
                
            }
            if card != nil {
                ck!.createCardToken(card!, completion:{ (resp: Response<CardTokenResponse>) -> Void in
                    if (resp.hasError) {
                        
                    } else {
                        print (resp.model?.cardToken)
                    }
                })
            }
        }
    }
}
}
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


