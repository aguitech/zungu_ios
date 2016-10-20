//
//  PagoTDCViewController.swift
//  zungu
//
//  Created by Hector Aguilar on 19/10/16.
//  Copyright © 2016 Giovanni Aranda. All rights reserved.
//

import UIKit



class PagoTDCViewController: UIViewController, UINavigationControllerDelegate {
    @IBOutlet weak var nombreTarjeta: UITextField!
    @IBOutlet weak var numeroTarjeta: UITextField!
    @IBOutlet weak var cantidadPago: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var cvvTarjeta: UITextField!
    @IBOutlet weak var mesTarjeta: UITextField!
    @IBOutlet weak var anioTarjeta: UITextField!
    @IBOutlet weak var pais: UITextField!
    @IBOutlet weak var estado: UITextField!
    @IBOutlet weak var codigoPostal: UITextField!
    let id_usuario = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func guardarTarjeta(sender: UIButton) {
        if( nombreTarjeta.text!.isEmpty || numeroTarjeta.text!.isEmpty || cantidadPago.text!.isEmpty || email.text!.isEmpty || cvvTarjeta.text!.isEmpty || mesTarjeta.text!.isEmpty || anioTarjeta.text!.isEmpty || pais.text!.isEmpty || estado.text!.isEmpty || codigoPostal.text!.isEmpty) {
            print("entroerror")
            nombreTarjeta.attributedPlaceholder = NSAttributedString(string: "Nombre en la tarjeta", attributes: [NSForegroundColorAttributeName: UIColor.redColor()])
            
            numeroTarjeta.attributedPlaceholder = NSAttributedString(string: "Numero en la Tarjeta", attributes: [NSForegroundColorAttributeName: UIColor.redColor()])
            
            cantidadPago.attributedPlaceholder = NSAttributedString(string: "Cantidad de Pago", attributes: [NSForegroundColorAttributeName: UIColor.redColor()])
            
            email.attributedPlaceholder = NSAttributedString(string: "E-MAIL", attributes: [NSForegroundColorAttributeName: UIColor.redColor()])
            
            cvvTarjeta.attributedPlaceholder = NSAttributedString(string: "CVV", attributes: [NSForegroundColorAttributeName: UIColor.redColor()])
            
            mesTarjeta.attributedPlaceholder = NSAttributedString(string: "MM", attributes: [NSForegroundColorAttributeName: UIColor.redColor()])
            
            anioTarjeta.attributedPlaceholder = NSAttributedString(string: "AAAA", attributes: [NSForegroundColorAttributeName: UIColor.redColor()])
            
            pais.attributedPlaceholder = NSAttributedString(string: "PAIS", attributes: [NSForegroundColorAttributeName: UIColor.redColor()])
            
            estado.attributedPlaceholder = NSAttributedString(string: "EStADO", attributes: [NSForegroundColorAttributeName: UIColor.redColor()])
            
            codigoPostal.attributedPlaceholder = NSAttributedString(string: "CP", attributes: [NSForegroundColorAttributeName: UIColor.redColor()])
            
        }else{
            print("entro");
            let url = NSURL(string: "http://hyperion.init-code.com/zungu/app/agregar_tarjeta.php")
            let request = NSMutableURLRequest(URL: url!)
            request.HTTPMethod = "POST"
            
            /*
             var descrip:String = ""
             
             if descripcionAdopta2.text!.isEmpty{
             descrip = descripcionAdopta1.text!
             }else{
             
             descrip = descripcionAdopta1.text! + "%20" + descripcionAdopta2.text!
             }
             */
            
            let body = "nombreTarjeta=\(nombreTarjeta.text!)&numeroTarjeta=\(numeroTarjeta.text!)&cantidadPago=\(cantidadPago.text!)&email=\(email.text!)&id_usuario=\(id_usuario)&cvvTarjeta=\(cvvTarjeta.text!)&mesTarjeta=\(mesTarjeta.text!)&anioTarjeta=\(anioTarjeta.text!)&pais=\(pais.text!)&estado=\(estado.text!)&codigoPostal=\(codigoPostal.text!)"
            
            
            
            request.HTTPBody = body.dataUsingEncoding(NSUTF8StringEncoding)
            
            NSURLSession.sharedSession().dataTaskWithRequest(request, completionHandler: { (data, reponse, error) in
                if error == nil{
                    print("dentro")
                    dispatch_async(dispatch_get_main_queue(), {
                        do{
                            let json = try NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers) as? NSDictionary
                            
                            guard let parseJson = json else{
                                print("Error parsing")
                                return
                            }
                            print(parseJson)
                            
                            print("ok")
                            /*
                            let id = parseJson["id_adopta_mascota"]
                            
                            if id != nil {
                                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                                
                                let nextViewController = storyBoard.instantiateViewControllerWithIdentifier("MascotaAgregada") as! MascotaAgregadaViewController
                                self.presentViewController(nextViewController, animated:true, completion:nil)
                            }
                            */
                            
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
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
