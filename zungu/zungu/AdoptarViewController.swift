//
//  AdoptarViewController.swift
//  zungu
//
//  Created by Giovanni Aranda on 05/09/16.
//  Copyright © 2016 Giovanni Aranda. All rights reserved.
//

import UIKit

class AdoptarViewController: UIViewController {
    var ArrayPatrocinador:[String: String] = [String: String]()
    var total:Int = 0
    var lim:Int = 0
    @IBOutlet weak var imagenPrincipal: UIImageView!
    @IBOutlet weak var tituloMascota: UILabel!
    @IBOutlet weak var sexoubicacionMascota: UILabel!
    @IBOutlet weak var botonAnterior: UIButton!
    @IBOutlet weak var botonSiguiente: UIButton!
    var id_usuario = 0
    
    let preferences = NSUserDefaults.standardUserDefaults()
    
    let currentLevelKey = "arrayUsuario"
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if preferences.objectForKey(currentLevelKey) == nil {
        } else {
            let array_usuario = preferences.objectForKey(currentLevelKey)
            
           id_usuario = (array_usuario!["id_usuario"]!!.integerValue)!
            
            print(id_usuario)
            self.cargarDatos()
        }

        
    }
    
    @IBAction func compartir(sender: UIButton) {
        let link = NSURL(string: "http://hyperion.init-code.com/zungu/app/compartir.php?id=\(ArrayPatrocinador["id_adopta_mascota"]!)")
        let vc = UIActivityViewController(activityItems: ["Compartir Mascota","http://hyperion.init-code.com/zungu/app/compartir.php?id=\(ArrayPatrocinador["id_adopta_mascota"]!)",link!], applicationActivities: nil)
        self.presentViewController(vc, animated: true, completion: nil)
        
        
    }
    
    func cargarDatos(){
        let url = NSURL(string: "http://hyperion.init-code.com/zungu/app/adoptar_mascota.php?lim=\(lim)")
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!) { (data, response, error) in
            if error != nil{
                
                print(error)
                
            }else{
                if let jsonResult = try? NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers){
                    
                    self.ArrayPatrocinador = jsonResult as! NSDictionary as! [String : String]
                    
                    dispatch_async(dispatch_get_main_queue(), {
                        if self.lim == 0{
                            self.total = Int(self.ArrayPatrocinador["total"]!)!
                        }
                        self.tituloMascota.text = self.ArrayPatrocinador["nombre"]
                        self.sexoubicacionMascota.text = self.ArrayPatrocinador["ubicacion"]
                        
                        let imagenPatrocinador = "http://hyperion.init-code.com/zungu/mascotas_subidas/\(self.ArrayPatrocinador["imagen"]!)"
                        
                        if let url = NSURL(string: imagenPatrocinador) {
                            if let data = NSData(contentsOfURL: url) {
                                self.imagenPrincipal.image = UIImage(data: data)
                            }
                        }else{
                            print("no pudo")
                        }
                        
                        //self.imagenPatrocinio.image = UIImage(data: data)
                        return
                    })
                    
                }
            }
        }
        task.resume()
        
    }
   

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func anteriorMascota(sender: UIButton) {
        lim -= 1
        if lim == 0{
            sender.hidden = true
            
        }
        self.botonSiguiente.hidden = false
        cargarDatos()
    }
  
    @IBAction func siguienteMascota(sender: UIButton) {
        lim += 1
        if(lim == (total - 1)){
            sender.hidden = true
        }
        self.botonAnterior.hidden = false
        cargarDatos()
    }
    
    @IBAction func agregarFavorito(sender: UIButton) {
        let url = NSURL(string: "http://hyperion.init-code.com/zungu/app/misFavoritos.php")
        let request = NSMutableURLRequest(URL: url!)
        request.HTTPMethod = "POST"
        let body = "idu=\(id_usuario)&idam=\(self.ArrayPatrocinador["id_adopta_mascota"]!)"
        request.HTTPBody = body.dataUsingEncoding(NSUTF8StringEncoding)
        
        NSURLSession.sharedSession().dataTaskWithRequest(request, completionHandler: { (data, reponse, error) in
            if error == nil{
                
                dispatch_async(dispatch_get_main_queue(), {
                    
                    let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("popUpMeGusta") as! PopupMegusta
                    
                    self.addChildViewController(popOverVC)
                    popOverVC.view.frame = self.view.frame
                    self.view.addSubview(popOverVC.view)
                    popOverVC.didMoveToParentViewController(self)
                })
                
            }else{
                
                print(error)
            }
        }).resume()
    }
    
    

}
