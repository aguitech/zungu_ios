//
//  DetalleTiendaViewController.swift
//  zungu
//
//  Created by Giovanni Aranda on 09/09/16.
//  Copyright © 2016 Giovanni Aranda. All rights reserved.
//

import UIKit

class DetalleTiendaViewController: UIViewController {
    
    var idt:Int?
    var veterinaria:Int?

    @IBOutlet weak var btnAgregar: UIButton!
    @IBOutlet weak var btnCancelar: UIButton!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tituloVeterinaria: UILabel!
    @IBOutlet weak var imageTienda: UIImageView!
    @IBOutlet weak var nombreTIenda: UILabel!
    @IBOutlet weak var precioTienda: UILabel!
    var Array:[String: String] = [String: String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.backgroundImage = UIImage()
        searchBar.layer.borderWidth = 1
        searchBar.layer.borderColor = UIColor.grayColor().CGColor
        searchBar.layer.cornerRadius = 20
        
        precioTienda.layer.borderColor = UIColor.grayColor().CGColor
        precioTienda.layer.borderWidth = 1
        precioTienda.layer.cornerRadius = 6
        
        btnCancelar.layer.borderColor = UIColor.grayColor().CGColor
        btnCancelar.layer.borderWidth = 1
        btnCancelar.layer.cornerRadius = 6
        
        btnAgregar.layer.cornerRadius = 6
        
        if idt != nil{
            cargarDatos()
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   
    @IBAction func agregarCarrito(sender: UIButton) {
    }
    
    func cargarDatos(){
        let url = NSURL(string: "http://hyperion.init-code.com/zungu/app/tienda.php?idt=\(idt!)")
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!) { (data, response, error) in
            if error != nil{
                
                print(error)
                
            }else{
                if let jsonResult = try? NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers){
                    
                    self.Array = jsonResult as! NSDictionary as! [String : String]
                    
                    dispatch_async(dispatch_get_main_queue(), {
                        
                        self.nombreTIenda.text = self.Array["nombre"]
                        self.precioTienda.text = self.Array["precio"]
                        
                        let imagenPatrocinador = "http://hyperion.init-code.com/zungu/imagen_tienda/\(self.Array["imagen"]!)"
                        
                        if let url = NSURL(string: imagenPatrocinador) {
                            if let data = NSData(contentsOfURL: url) {
                                self.imageTienda.image = UIImage(data: data)
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
