//
//  MiPerfilViewController.swift
//  zungu
//
//  Created by Giovanni Aranda on 12/09/16.
//  Copyright © 2016 Giovanni Aranda. All rights reserved.
//

import UIKit

class MiPerfilViewController: UIViewController {
    
    var ArrayPerfil:[String: String] = [String: String]()
    
    @IBOutlet weak var telefonoPerfil: UILabel!

    @IBOutlet weak var emailPerfil: UILabel!
    @IBOutlet weak var ciudadPerfil: UILabel!
    @IBOutlet weak var nombrePerfil: UILabel!
    @IBOutlet weak var imagenPerfil: UIImageView!
    
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
        //self.cargarDatos()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func cargarDatos(){
        //let url = NSURL(string: "http://hyperion.init-code.com/zungu/app/adoptar_mascota.php?lim=\(lim)")
        //idu=\(id_usuario)
        //let url = NSURL(string: "http://hyperion.init-code.com/zungu/app/editar_perfil.php?id_usuario=4")
        print("\(id_usuario)")
        let url = NSURL(string: "http://hyperion.init-code.com/zungu/app/editar_perfil.php?id_usuario=\(id_usuario)")
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!) { (data, response, error) in
            if error != nil{
                
                print(error)
                
            }else{
                if let jsonResult = try? NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers){
                    
                    self.ArrayPerfil = jsonResult as! NSDictionary as! [String : String]
                    
                    dispatch_async(dispatch_get_main_queue(), {
                        /*
                        if self.lim == 0{
                            self.total = Int(self.ArrayPerfil["total"]!)!
                        }
                        */
                        self.nombrePerfil.text = self.ArrayPerfil["nombre"]
                        self.emailPerfil.text = self.ArrayPerfil["correo"]
                        
                        /*
                        let imagenPatrocinador = "http://hyperion.init-code.com/zungu/mascotas_subidas/\(self.ArrayPatrocinador["imagen"]!)"
                        
                        if let url = NSURL(string: imagenPatrocinador) {
                            if let data = NSData(contentsOfURL: url) {
                                self.imagenPrincipal.image = UIImage(data: data)
                            }
                        }else{
                            print("no pudo")
                        }
 */
                        
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
