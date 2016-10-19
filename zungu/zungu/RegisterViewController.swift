//
//  RegisterViewController.swift
//  zungu
//
//  Created by Giovanni Aranda on 01/09/16.
//  Copyright © 2016 Giovanni Aranda. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit

class RegisterViewController: UIViewController, FBSDKLoginButtonDelegate {
    
    @IBOutlet weak var signInFacebook: FBSDKLoginButton!
    @IBOutlet weak var nombreInput: UITextField!
    @IBOutlet weak var apellidoInput: UITextField!
    @IBOutlet weak var correoInput: UITextField!
    @IBOutlet weak var contrasenaUno: UITextField!
    @IBOutlet weak var contrasenaDos: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        print("configure Facebook test")
    }
    func configureFacebook()
    {
        print("configure Facebook")
        
        signInFacebook.readPermissions = ["public_profile", "email", "user_friends"];
        signInFacebook.delegate = self
        
        print("configure Facebook")
        //loginFacebook.readPermissions = ["public_profile", "email", "user_friends"];
        //loginFacebook.delegate = self
    }
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!)
    {
        print("configure Facebook")
        let loginManager: FBSDKLoginManager = FBSDKLoginManager()
        loginManager.logOut()
        print("configure Facebook")
        //ivUserProfileImage.image = nil
        //lblName.text = ""
    }
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!)
    {
        print("configure Facebook")
        
        FBSDKGraphRequest.init(graphPath: "me", parameters: ["fields":"first_name, last_name, picture.type(large)"]).startWithCompletionHandler { (connection, result, error) -> Void in
            
            print("configure Facebook")
            
            let strFirstName: String = (result.objectForKey("first_name") as? String)!
            print(strFirstName)
            let strLastName: String = (result.objectForKey("last_name") as? String)!
            print(strLastName)
            //let strEmail: String = (result.objectForKey("email") as? String)!
            //print(strEmail)
            print(result)
            
            let url = NSURL(string: "http://hyperion.init-code.com/zungu/app/registro_facebook.php")
            let request = NSMutableURLRequest(URL: url!)
            request.HTTPMethod = "POST"
            //let body = "nombre=\(nombreInput.text!)&pass=\(contrasenaUno.text!)&correo=\(correoInput.text!)&apellido=\(apellidoInput.text!)"
            //let body = "nombre=\(strFirstName.text!)&correo=\(strEmail.text!)&apellido=\(strLastName.text!)"
            //let body = "nombre=\(strFirstName)&correo=\(strEmail)&apellido=\(strLastName)"
            print("dentro")
            
            let body = "nombre=hola&correo=test&apellido=test"
            request.HTTPBody = body.dataUsingEncoding(NSUTF8StringEncoding)
            
            NSURLSession.sharedSession().dataTaskWithRequest(request, completionHandler: { (data, reponse, error) in
                if error == nil{
                    
                    dispatch_async(dispatch_get_main_queue(), {
                        do{
                            let json = try NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers) as? NSDictionary
                            
                            guard let parseJson = json else{
                                print("Error parsing")
                                return
                            }
                            
                            let id = parseJson["id_usuario"]
                            
                            if id != nil {
                                let preferences = NSUserDefaults.standardUserDefaults()
                                
                                let arrayUsuarioKey = "arrayUsuario"
                                
                                _ = preferences.setObject(parseJson, forKey: arrayUsuarioKey)
                                
                                _ = preferences.synchronize()
                                
                                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                                
                                let nextViewController = storyBoard.instantiateViewControllerWithIdentifier("HomeView") as! HomeController
                                self.presentViewController(nextViewController, animated:true, completion:nil)
                            }else{
                                let alerta = UIAlertController(title: "Usuario existente",
                                    message: "Este correo ya existe",
                                    preferredStyle: UIAlertControllerStyle.Alert)
                                let accion = UIAlertAction(title: "Cerrar", style: UIAlertActionStyle.Default, handler: { (UIAlertAction) in
                                    alerta.dismissViewControllerAnimated(true, completion: nil)
                                })
                                alerta.addAction(accion)
                                self.presentViewController(alerta, animated: true, completion: nil)
                            }
                            
                            
                        } catch{
                            print(error)
                        }
                    })
                    
                }else{
                    
                    print(error)
                }
            }).resume()
            
            
            //let strPictureURL: String = (result.objectForKey("picture")?.objectForKey("data")?.objectForKey("url") as? String)!
            
            //self.lblName.text = "Welcome, \(strFirstName) \(strLastName)"
            //self.ivUserProfileImage.image = UIImage(data: NSData(contentsOfURL: NSURL(string: strPictureURL)!)!)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func registrar(sender: UIButton) {
        
        if nombreInput.text!.isEmpty || apellidoInput.text!.isEmpty || correoInput.text!.isEmpty || contrasenaUno.text!.isEmpty || contrasenaDos.text!.isEmpty{
            
            nombreInput.attributedPlaceholder = NSAttributedString(string: "Nombre", attributes: [NSForegroundColorAttributeName: UIColor.redColor()])
            
            apellidoInput.attributedPlaceholder = NSAttributedString(string: "Apellido", attributes: [NSForegroundColorAttributeName: UIColor.redColor()])
            
            correoInput.attributedPlaceholder = NSAttributedString(string: "Correo", attributes: [NSForegroundColorAttributeName: UIColor.redColor()])
            
            contrasenaDos.attributedPlaceholder = NSAttributedString(string: "Contraseña 2", attributes: [NSForegroundColorAttributeName: UIColor.redColor()])
            
            contrasenaUno.attributedPlaceholder = NSAttributedString(string: "Contraseña 1", attributes: [NSForegroundColorAttributeName: UIColor.redColor()])
            
            
        }else{
            
            if contrasenaUno.text! == contrasenaDos.text!{
                
                let url = NSURL(string: "http://hyperion.init-code.com/zungu/app/registro.php")
                let request = NSMutableURLRequest(URL: url!)
                request.HTTPMethod = "POST"
                let body = "nombre=\(nombreInput.text!)&pass=\(contrasenaUno.text!)&correo=\(correoInput.text!)&apellido=\(apellidoInput.text!)"
                request.HTTPBody = body.dataUsingEncoding(NSUTF8StringEncoding)
                
                NSURLSession.sharedSession().dataTaskWithRequest(request, completionHandler: { (data, reponse, error) in
                    if error == nil{
                        
                        dispatch_async(dispatch_get_main_queue(), {
                            do{
                                let json = try NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers) as? NSDictionary
                                
                                guard let parseJson = json else{
                                    print("Error parsing")
                                    return
                                }
                                
                                let id = parseJson["id_usuario"]
                                
                                if id != nil {
                                    let preferences = NSUserDefaults.standardUserDefaults()
                                    
                                    let arrayUsuarioKey = "arrayUsuario"
                                    
                                    _ = preferences.setObject(parseJson, forKey: arrayUsuarioKey)
                                    
                                    _ = preferences.synchronize()
                                    
                                    let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                                    
                                    let nextViewController = storyBoard.instantiateViewControllerWithIdentifier("HomeView") as! HomeController
                                    self.presentViewController(nextViewController, animated:true, completion:nil)
                                }else{
                                    let alerta = UIAlertController(title: "Usuario existente",
                                        message: "Este correo ya existe",
                                        preferredStyle: UIAlertControllerStyle.Alert)
                                    let accion = UIAlertAction(title: "Cerrar", style: UIAlertActionStyle.Default, handler: { (UIAlertAction) in
                                        alerta.dismissViewControllerAnimated(true, completion: nil)
                                    })
                                    alerta.addAction(accion)
                                    self.presentViewController(alerta, animated: true, completion: nil)
                                }
                                
                                
                            } catch{
                                print(error)
                            }
                        })
                        
                    }else{
                        
                        print(error)
                    }
                }).resume()
                
                
            }else{
                print("contraseñas mal")
                
            }
            
        }

    }
    

}
