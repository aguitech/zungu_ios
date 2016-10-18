//
//  VeterinariasDosViewController.swift
//  zungu
//
//  Created by Giovanni Aranda on 19/09/16.
//  Copyright © 2016 Giovanni Aranda. All rights reserved.
//

import UIKit

var tipo_ = 1

class VeterinariasDosViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var buscador: UISearchBar!
    @IBOutlet weak var nombrePatrocinio: UILabel!
    @IBOutlet weak var imagenPatrocinio: UIImageView!
    @IBOutlet weak var nombreVeterinario: UILabel!
    @IBOutlet weak var correoPatrocinio: UILabel!
    @IBOutlet weak var telefonoPatrocinio: UILabel!
    
    @IBOutlet weak var ratingControl: RatingControl!
    @IBOutlet weak var buttonVerMas: UIButton!
    @IBOutlet weak var viewMapaLista: UIView!
    @IBOutlet weak var buttonADD: UIButton!
    
    @IBOutlet weak var tableVeterinarias: UITableView!
    var ArrayCount:Int = 0
    var ArrayList:[[String: String]] = [[String: String]]()
    var ArrayPatrocinador:[String: String] = [String: String]()
    var susX = 0

    @IBAction func cambiarTipo(sender: UIButton) {
        tipo_ = sender.tag
        
        cargarDatos()
    }
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buscador.backgroundImage = UIImage()
        ratingControl.reloadInputViews()
        viewMapaLista.layer.borderColor =  UIColorFromHex(0x95989A).CGColor
        viewMapaLista.layer.borderWidth = 1
        viewMapaLista.layer.cornerRadius = 1
        buttonVerMas.layer.cornerRadius = 2
        buttonADD.layer.cornerRadius = 2
        buttonADD.layer.borderColor =  UIColorFromHex(0x87C848).CGColor


        cargarDatos()
        cargarPatrocinador()
        
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
    func cargarPatrocinador(){
        let url = NSURL(string: "http://hyperion.init-code.com/zungu/app/veterinarios_mapa.php?patrocinado=1")
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!) { (data, response, error) in
            if error != nil{
                
                print(error)
                
            }else{
                if let jsonResult = try? NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers){
                    
                    self.ArrayPatrocinador = jsonResult as! NSDictionary as! [String : String]
                    
                                dispatch_async(dispatch_get_main_queue(), {
                                    self.susX = 0
                                    self.nombrePatrocinio.text = self.ArrayPatrocinador["nombre"]
                                    self.nombreVeterinario.text = "Nombre del veterinario :D"
                                    self.correoPatrocinio.text = self.ArrayPatrocinador["correo"]
                                    self.telefonoPatrocinio.text = self.ArrayPatrocinador["telefono"]
                                    
                                    let imagenPatrocinador = "http://hyperion.init-code.com/zungu/imagen_subidas/\(self.ArrayPatrocinador["imagen"]!)"
                                   
                                    if let url = NSURL(string: imagenPatrocinador) {
                                        if let data = NSData(contentsOfURL: url) {
                                            self.imagenPatrocinio.image = UIImage(data: data)
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
    
    
    func cargarDatos(){
        let url = NSURL(string: "http://hyperion.init-code.com/zungu/app/veterinarios_mapa.php?tipo=\(tipo_)")
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!) { (data, response, error) in
            if error != nil{
                
                print(error)
                
            }else{
                if let jsonResult = try? NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers){
                    
                    self.ArrayCount = jsonResult.count!
                    self.ArrayList = [[String: String]]()
                    self.susX = 0
                    for x in 0 ..< Int(jsonResult.count){
                        
                        self.ArrayList.append(jsonResult[x] as! NSDictionary as! [String : String])
                        
                        
                    }
                    dispatch_async(dispatch_get_main_queue(), {
                        
                        self.tableVeterinarias.reloadData()
                        return
                    })
                    
                }
            }
        }
        
        task.resume()
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int{
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
    
        return self.ArrayList.count
    
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
    
        let cell = tableVeterinarias.dequeueReusableCellWithIdentifier("CellVeterinarias", forIndexPath: indexPath) as! MealTableViewCell
    
        var titulo:String
        var subtitulo:String
        var km:String
        if ArrayCount == 0{
            titulo = "Sin Nombre"
            subtitulo = "Subtitulo"
            km = "0km"
        }else{
            
                titulo = String(ArrayList[susX]["nombre"]!)
                subtitulo = String(ArrayList[susX]["ubicacion"]!)
                km = "2km"
            
           
        }
        
        cell.titleLabel?.text = titulo
        cell.doctorLabel?.text = subtitulo
        cell.kmLabel?.text = km
        
        susX += 1
        
        if self.susX == self.ArrayList.count
        {
            susX = 0
        }
        
        return cell
    }
    

    @IBAction func goDetalle(sender: UIButton) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        
        let nextViewController = storyBoard.instantiateViewControllerWithIdentifier("DetalleVeterinario") as! VeterinariosDosViewController
        nextViewController.veterinaria = Int(ArrayPatrocinador["id_veterinaria"]!)!
        self.presentViewController(nextViewController, animated:true, completion:nil)
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        
        let nextViewController = storyBoard.instantiateViewControllerWithIdentifier("DetalleVeterinario") as! VeterinariosDosViewController
        nextViewController.veterinaria = Int(ArrayList[indexPath.row]["id_veterinaria"]!)!
        self.presentViewController(nextViewController, animated:true, completion:nil)
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
