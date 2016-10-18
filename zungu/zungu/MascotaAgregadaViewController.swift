//
//  MascotaAgregadaViewController.swift
//  zungu
//
//  Created by Giovanni Aranda on 13/10/16.
//  Copyright © 2016 Giovanni Aranda. All rights reserved.
//

import UIKit

class MascotaAgregadaViewController: UIViewController {
    var ArrayPatrocinador:[String: String] = [String: String]()

    @IBOutlet weak var imagenPrincipal: UIImageView!
    @IBOutlet weak var tituloMascota: UILabel!
    @IBOutlet weak var sexoubicacionMascota: UILabel!
    @IBOutlet weak var infoContacto: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func cargarDatos(){
    
        let url = NSURL(string: "http://hyperion.init-code.com/zungu/app/adoptar_mascota_ultimo.php")
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!) { (data, response, error) in
            if error != nil{
                
                print(error)
                
            }else{
                if let jsonResult = try? NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers){
                    
                    self.ArrayPatrocinador = jsonResult as! NSDictionary as! [String : String]
                    
                    dispatch_async(dispatch_get_main_queue(), {
                        self.tituloMascota.text = self.ArrayPatrocinador["nombre"]
                        self.sexoubicacionMascota.text = self.ArrayPatrocinador["ubicacion"]
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
