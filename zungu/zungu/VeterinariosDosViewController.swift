//
//  VeterinariosDosViewController.swift
//  zungu
//
//  Created by Giovanni Aranda on 06/09/16.
//  Copyright © 2016 Giovanni Aranda. All rights reserved.
//

import UIKit

class VeterinariosDosViewController: UIViewController {
    
    var veterinaria:Int? = nil

    @IBOutlet weak var horarioFindesemana: UILabel!
    @IBOutlet weak var horarioEntresemana: UILabel!
    @IBOutlet weak var nombreVeterinaria: UILabel!
    @IBOutlet weak var calleVeterinaria: UITextView!
    @IBOutlet weak var telefonoVeterinaria: UILabel!
    @IBOutlet weak var imagenVeterinaria: UIImageView!
    var ArrayVeterinaria:[String: String] = [String: String]()
    
    @IBOutlet weak var doctorNombre: UILabel!
    @IBOutlet weak var doctorCorreo: UILabel!
    @IBOutlet weak var telefonoDoctor: UILabel!
    @IBOutlet weak var doctorSeguidores: UILabel!
    @IBOutlet weak var doctorImagen: UIImageView!
    var ArrayPatrocinador:[String: String] = [String: String]()

    @IBOutlet weak var scrollVieww: UIScrollView!
    @IBOutlet weak var viewDoctores: UIView!
    @IBOutlet weak var buttonRedes: UIButton!
    var ArrayCount:Int?
    var ArrayList:[[String: String]] = [[String: String]]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        cargarDoctor()
        cargarVeterinaria()
        cargarDoctores()
    }
    
    func cargarDoctor(){
        
        let url = NSURL(string: "http://hyperion.init-code.com/zungu/app/doctores.php?doc=1&vet=\(veterinaria!)")
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!) { (data, response, error) in
            if error != nil{
                
                print(error)
                
            }else{
                if let jsonResult = try? NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers){
                    
                    self.ArrayPatrocinador = jsonResult as! NSDictionary as! [String : String]
                    
                    dispatch_async(dispatch_get_main_queue(), {
                        self.doctorNombre.text = self.ArrayPatrocinador["nombre"]
                        self.doctorCorreo.text = self.ArrayPatrocinador["correo"]
                        self.telefonoDoctor.text = self.ArrayPatrocinador["telefono"]
                        self.doctorSeguidores.text = "\(self.ArrayPatrocinador["seguidores"]!) seguidores"
                        
                        let imagenPatrocinador = "http://hyperion.init-code.com/zungu/imagen_doctores/\(self.ArrayPatrocinador["imagen"]!)"
                        
                        if let url = NSURL(string: imagenPatrocinador) {
                            if let data = NSData(contentsOfURL: url) {
                                self.doctorImagen.image = UIImage(data: data)
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
    
    func cargarVeterinaria(){
        let url = NSURL(string: "http://hyperion.init-code.com/zungu/app/veterinarios_mapa.php?id_vet=\(veterinaria!)")
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!) { (data, response, error) in
            if error != nil{
                
                print(error)
                
            }else{
                if let jsonResult = try? NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers){
                    
                    self.ArrayVeterinaria = jsonResult as! NSDictionary as! [String : String]
                    
                    dispatch_async(dispatch_get_main_queue(), {
                        self.nombreVeterinaria.text = self.ArrayVeterinaria["nombre"]
                        self.calleVeterinaria.text = self.ArrayVeterinaria["correo"]
                        self.telefonoDoctor.text = "Tels: \(self.ArrayVeterinaria["telefono"]!)"
                        self.horarioEntresemana.text = self.ArrayVeterinaria["horario_entresemana"]
                        self.horarioFindesemana.text = self.ArrayVeterinaria["horario_finsemana"]
                        
                        let imagenPatrocinador = "http://hyperion.init-code.com/zungu/imagen_subidas/\(self.ArrayVeterinaria["imagen"]!)"
                        
                        if let url = NSURL(string: imagenPatrocinador) {
                            if let data = NSData(contentsOfURL: url) {
                                self.imagenVeterinaria.image = UIImage(data: data)
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
    
    func cargarDoctores(){
        let url = NSURL(string: "http://hyperion.init-code.com/zungu/app/doctores.php?vet=\(veterinaria!)")
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!) { (data, response, error) in
            if error != nil{
                
                print(error)
                
            }else{
                if let jsonResult = try? NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers){
                    
                    self.ArrayCount = jsonResult.count!
                    self.ArrayList = [[String: String]]()
                    for x in 0 ..< Int(jsonResult.count){
                        
                        self.ArrayList.append(jsonResult[x] as! NSDictionary as! [String : String])
                        
                        
                    }
                    dispatch_async(dispatch_get_main_queue(), {
                        
                        self.cicloDoctores()
                        
                        return
                    })
                    
                }
            }
        }
        
        task.resume()
    }
    
    func cicloDoctores(){
    
        var z = 0
        for item in self.ArrayList{
            
            let imageName = "http://hyperion.init-code.com/zungu/imagen_doctores/\(item["imagen"]!)"
            
            if let url = NSURL(string: imageName) {
                if let data = NSData(contentsOfURL: url) {
                    let image = UIImage(data: data)
                    let imageView = UIImageView(image: image!)
                    imageView.frame = CGRect(x: z * 100, y: 0, width: 100, height: 80)
                    
                    self.viewDoctores.addSubview(imageView)
                    //self.imagenVeterinaria.image = UIImage(data: data)
                }
            }
            
            z += 1
            
        }
        
        let width:Int = (self.ArrayCount! * 100)
        
        self.viewDoctores.frame.size.width = CGFloat(width)
        self.scrollVieww.frame.size.width = CGFloat(width)
        self.buttonRedes.frame.size.width = CGFloat(width)
    
    }

    @IBAction func goCitas(sender: UIButton) {
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }



}
