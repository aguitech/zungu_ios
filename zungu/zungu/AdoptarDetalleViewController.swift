//
//  AdoptarDetalleViewController.swift
//  zungu
//
//  Created by Giovanni Aranda on 08/09/16.
//  Copyright © 2016 Giovanni Aranda. All rights reserved.
//

import UIKit

class AdoptarDetalleViewController: UIViewController {

    var ArrayPatrocinador:[String: String] = [String: String]()
    @IBOutlet weak var imagenPrincipal: UIImageView!
    @IBOutlet weak var btnVolver: UIButton!
    @IBOutlet weak var nombreEdad: UILabel!
    @IBOutlet weak var ubicacion: UILabel!
    @IBOutlet weak var infoContacto: UILabel!
    var idam:Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.btnVolver.layer.cornerRadius = 5
        self.btnVolver.layer.borderWidth = 1
        // Do any additional setup after loading the view.
        
        print(idam)
        if idam != nil{
        
           cargarDatos()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func cargarDatos(){
        let url = NSURL(string: "http://hyperion.init-code.com/zungu/app/adoptar_mascota_detalle.php?idam=\(idam!)")
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!) { (data, response, error) in
            if error != nil{
                
                print(error)
                
            }else{
                if let jsonResult = try? NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers){
                    
                    self.ArrayPatrocinador = jsonResult as! NSDictionary as! [String : String]
                    
                    dispatch_async(dispatch_get_main_queue(), {
                        self.nombreEdad.text = "\(self.ArrayPatrocinador["nombre"]!), \(self.ArrayPatrocinador["edad"]!)"
                        self.ubicacion.text = self.ArrayPatrocinador["ubicacion"]
                        self.infoContacto.text = "\(self.ArrayPatrocinador["nombre_usuario"]!) / \(self.ArrayPatrocinador["correo_usuario"]!) / \(self.ArrayPatrocinador["numero_usuario"]!)"
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

}
