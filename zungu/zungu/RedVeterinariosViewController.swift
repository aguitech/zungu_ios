//
//  RedVeterinariosViewController.swift
//  zungu
//
//  Created by Giovanni Aranda on 26/09/16.
//  Copyright © 2016 Giovanni Aranda. All rights reserved.
//

import UIKit

class RedVeterinariosViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    let veterinaria:Int = 9
    @IBOutlet weak var tableRed: UITableView!
    var ArrayList = [[String: String]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        cargarDatos()
       
    }
    
    func cargarDatos(){
        let url = NSURL(string: "http://hyperion.init-code.com/zungu/app/doctores.php?vet=\(veterinaria)")
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!) { (data, response, error) in
            if error != nil{
                
                print(error)
                
            }else{
                if let jsonResult = try? NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers){

                   
                    if let items = jsonResult as? [[String: String]]{
                    
                        for item in items{
                             self.ArrayList.append((item))
                        }
                        
                    }
                   
                    dispatch_async(dispatch_get_main_queue(), {
                        
                        self.tableRed.reloadData()
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
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int{
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        return self.ArrayList.count
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
    
        let cell = tableView.dequeueReusableCellWithIdentifier("CellRedes", forIndexPath: indexPath) as! RedDoctoresTableViewCell
        
        cell.nombreRed?.text = String(ArrayList[indexPath.row]["nombre"]!)
        cell.correoRed?.text = String(ArrayList[indexPath.row]["correo"]!)
        cell.telefonoRed?.text = String(ArrayList[indexPath.row]["telefono"]!)
        cell.seguidoresRed?.text = "\(ArrayList[indexPath.row]["seguidores"]!) seguidores"
        
        let image = ArrayList[indexPath.row]["imagen"]
        let  imageUrl = NSURL(string: "http://hyperion.init-code.com/zungu/imagen_doctores/\(self.ArrayList[indexPath.row]["imagen"]!)")
       
        
        cell.imagenRed.image = UIImage(named: "facebook.png")
        
        // async image
        if image != nil {
            
            let request: NSURLRequest = NSURLRequest(URL: imageUrl!)
            //print(imageUrl)
            NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: { (response, data, error) in
                if error == nil {
                    
                    let imagen = UIImage(data: data!)
                    dispatch_async(dispatch_get_main_queue(), {
                        cell.imagenRed.image = imagen
                        
                    })
                }
            })
        }

        
        return cell
    
    }

}
