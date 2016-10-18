//
//  RegisterViewController.swift
//  zungu
//
//  Created by Giovanni Aranda on 01/09/16.
//  Copyright © 2016 Giovanni Aranda. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var nombreInput: UITextField!
    @IBOutlet weak var apellidoInput: UITextField!
    @IBOutlet weak var correoInput: UITextField!
    @IBOutlet weak var contrasenaUno: UITextField!
    @IBOutlet weak var contrasenaDos: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()

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
