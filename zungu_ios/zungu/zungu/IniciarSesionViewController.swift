//
//  IniciarSesionViewController.swift
//  zungu
//
//  Created by Giovanni Aranda on 05/09/16.
//  Copyright © 2016 Giovanni Aranda. All rights reserved.
//

import UIKit

class IniciarSesionViewController: UIViewController {

    @IBOutlet weak var correoInicio: UITextField!
    @IBOutlet weak var passInicio: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func iniciarSesion(sender: UIButton) {
        print("entro primero")
        if correoInicio.text!.isEmpty || passInicio.text!.isEmpty{
            print("entro aquiq")
            correoInicio.attributedPlaceholder = NSAttributedString(string: "Correo electrónico", attributes: [NSForegroundColorAttributeName: UIColor.redColor()])
            
            passInicio.attributedPlaceholder = NSAttributedString(string: "Contraseña", attributes: [NSForegroundColorAttributeName: UIColor.redColor()])
            
        }else{
            print("entro aqui2")
            let url = NSURL(string: "http://hyperion.init-code.com/zungu/app/iniciarsesion.php")
            let request = NSMutableURLRequest(URL: url!)
            request.HTTPMethod = "POST"
            let body = "correo=\(correoInicio.text!)&pass=\(passInicio.text!)"
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
                            //print(json)
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
                                
                                let alerta = UIAlertController(title: "Datos incorrectos",
                                    message: "Usuario ó Password incorrecto",
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
            
        }

    }


}
