import UIKit
import Flutter
import CheckoutKit
let publicKey: String = "pk_test_51d2ac65-d5d7-4ed0-b061-225fb2496c76"
@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?
  ) -> Bool {
    let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
    let batteryChannel = FlutterMethodChannel(name: "flutter.experiment",
                                              binaryMessenger: controller)
    batteryChannel.setMethodCallHandler { (call: FlutterMethodCall,  result: @escaping FlutterResult) in
        var ck: CheckoutKit? = nil
        do {
            try ck = CheckoutKit.getInstance(publicKey)
        } catch _ as NSError {
            /* Happens when the public key is not valid, raised during the instanciation of the CheckoutKit object */
            /* Type of the error in the enum CheckoutError. Different types are NoPK (if getInstance is called with no parameters and no public key has been provided before) and InvalidPK (if the public key is invalid) */
        }
        
        
        /* Take the card information where ever you want (form, fields in the application page...) */
        var card: Card? = nil
        do {
             let s = call.arguments as? [String: Any]
             let name = s?["name"] as? String
            let number = s?["number"] as? String
            let expYear = s?["expYear"] as? String
            let expMonth = s?["expMonth"] as? String
            let cvv = s?["cvv"] as? String
            
            
            try card = Card(name: name, number: number ?? "", expYear: expYear ?? "", expMonth: expMonth ?? "", cvv: cvv ?? "", billingDetails: nil)
        } catch let err as CardError {
            print(err)
            
            
            //result(err)
            /* Happens when the card informations entered by the user are not correct */
            /* Type of the error in the enum CardError. Different types are InvalidCVV (if the CVV does not have the correct format), InvalidExpiryDate (if the card is expired), InvalidNumber (if the card's number is wrong). */
        } catch _ as NSError {
            /* If any other exception was thrown */
        }
        
        ck!.createCardToken(card!, completion:{ (resp: Response<CardTokenResponse>) -> Void in
            if (resp.hasError) {
                /* Print error message or handle it */
            } else {
                /* The card object */
                /* The field containing the card token to make a charge */
//                guard call.method == "getMessageFromNativePlatform" else {
//                    result(FlutterMethodNotImplemented)
//                    return
//                }
                 let ct: CardToken = resp.model!.card
                let cardToken: String = resp.model?.cardToken ?? ""
                result(cardToken)
            }
        })
        
    }
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
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
