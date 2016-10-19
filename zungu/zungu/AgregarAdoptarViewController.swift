//
//  AgregarAdoptarViewController.swift
//  zungu
//
//  Created by Giovanni Aranda on 08/09/16.
//  Copyright © 2016 Giovanni Aranda. All rights reserved.
//

import UIKit

let id_usuario = "1"

class AgregarAdoptarViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    

    @IBOutlet weak var imageMascota: UIImageView!
    @IBOutlet weak var nombreMascota: UITextField!
    @IBOutlet weak var edadRaza: UITextField!
    @IBOutlet weak var descripcionAdopta1: UITextField!
    @IBOutlet weak var descripcionAdopta2: UITextField!
    @IBOutlet weak var ubicacionMazcota: UITextField!
    
    @IBOutlet weak var nombreContacto: UITextField!
    @IBOutlet weak var numeroContacto: UITextField!
    @IBOutlet weak var correoContacto: UITextField!
    
    @IBOutlet weak var btnConfirmar: UIButton!
    @IBOutlet weak var btnCancelar: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.btnConfirmar.layer.cornerRadius = 5
        self.btnCancelar.layer.cornerRadius = 5
        self.btnCancelar.layer.borderWidth = 1
        self.btnCancelar.layer.borderColor = UIColorFromHex(0x54CB34).CGColor
        
        // Do any additional setup after loading the view.
    }
    
    func UIColorFromHex(rgbValue:UInt32, alpha:Double=1.0)->UIColor {
        let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
        let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
        let blue = CGFloat(rgbValue & 0xFF)/256.0
        
        return UIColor(red:red, green:green, blue:blue, alpha:CGFloat(alpha))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   
    @IBAction func selectPhoto(sender: UIButton) {
        
        var myPickerController = UIImagePickerController()
        myPickerController.delegate = self
        myPickerController.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        
        self.presentViewController(myPickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        self.imageMascota.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    @IBAction func registrarMascota(sender: UIButton) {
        
        if nombreMascota.text!.isEmpty || edadRaza.text!.isEmpty || descripcionAdopta1.text!.isEmpty || ubicacionMazcota.text!.isEmpty || nombreContacto.text!.isEmpty || numeroContacto.text!.isEmpty || correoContacto.text!.isEmpty {
            print("entroerror")
            nombreMascota.attributedPlaceholder = NSAttributedString(string: "Nombre Mascota", attributes: [NSForegroundColorAttributeName: UIColor.redColor()])
            
            edadRaza.attributedPlaceholder = NSAttributedString(string: "Edad o (Raza)", attributes: [NSForegroundColorAttributeName: UIColor.redColor()])
            
            descripcionAdopta1.attributedPlaceholder = NSAttributedString(string: "Descripción", attributes: [NSForegroundColorAttributeName: UIColor.redColor()])
            
            ubicacionMazcota.attributedPlaceholder = NSAttributedString(string: "Ubicación", attributes: [NSForegroundColorAttributeName: UIColor.redColor()])
            
            nombreContacto.attributedPlaceholder = NSAttributedString(string: "Nombre Contacto", attributes: [NSForegroundColorAttributeName: UIColor.redColor()])
            
            numeroContacto.attributedPlaceholder = NSAttributedString(string: "Número Contacto", attributes: [NSForegroundColorAttributeName: UIColor.redColor()])
            
            correoContacto.attributedPlaceholder = NSAttributedString(string: "Correo Contacto", attributes: [NSForegroundColorAttributeName: UIColor.redColor()])
        
        }else{
            print("entro");
            let url = NSURL(string: "http://hyperion.init-code.com/zungu/app/mascota_adoptar.php")
            let request = NSMutableURLRequest(URL: url!)
            request.HTTPMethod = "POST"
            
            var descrip:String = ""
            
            if descripcionAdopta2.text!.isEmpty{
                descrip = descripcionAdopta1.text!
            }else{
            
                descrip = descripcionAdopta1.text! + "%20" + descripcionAdopta2.text!
            }
            
            let body = "nombre=\(nombreMascota.text!)&edad=\(edadRaza.text!)&descripcion=\(descrip)&ubicacion=\(ubicacionMazcota.text!)&id_usuario=\(id_usuario)&nombre_usuario=\(nombreContacto.text!)&numero_usuario=\(numeroContacto.text!)&correo_usuario=\(correoContacto.text!)"
            
            
            
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
                            
                            let id = parseJson["id_adopta_mascota"]
                            
                            if id != nil {
                                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                                
                                let nextViewController = storyBoard.instantiateViewControllerWithIdentifier("MascotaAgregada") as! MascotaAgregadaViewController
                                self.presentViewController(nextViewController, animated:true, completion:nil)
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
