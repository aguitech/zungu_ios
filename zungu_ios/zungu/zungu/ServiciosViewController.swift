//
//  ServiciosViewController.swift
//  zungu
//
//  Created by Giovanni Aranda on 06/09/16.
//  Copyright © 2016 Giovanni Aranda. All rights reserved.
//

import UIKit

class ServiciosViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    
    @IBOutlet weak var tableHospital: UITableView!
    @IBOutlet weak var tableClinica: UITableView!
    @IBOutlet weak var tableEstetica: UITableView!
    var ArrayHospital = [[String: String]]()
    var ArrayClinica = [[String: String]]()
    var ArrayEstetica = [[String: String]]()
    var ArrayCount:Int = 0
    
    let veterinaria = 9

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableHospital.separatorColor = UIColor.clearColor()
        tableEstetica.separatorColor = UIColor.clearColor()
        tableClinica.separatorColor = UIColor.clearColor()
        
        cargarDatos(1)
        cargarDatos(2)
        cargarDatos(3)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView == tableHospital{
            return ArrayHospital.count
        }else if tableView == tableClinica{
            return ArrayClinica.count
        }else if tableView == tableEstetica{
            return ArrayEstetica.count
        }else{
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        if tableView == tableHospital{
            
            let cell = tableHospital.dequeueReusableCellWithIdentifier("CellHospital", forIndexPath: indexPath)
            cell.textLabel?.text = "- \(ArrayHospital[indexPath.row]["valor"]!)"
            return cell
            
        }else if tableView == tableClinica{
            let cell = tableClinica.dequeueReusableCellWithIdentifier("CellClinica", forIndexPath: indexPath)
            cell.textLabel?.text = "- \(ArrayClinica[indexPath.row]["valor"]!)"
            return cell
            
        }else {
            let cell = tableEstetica.dequeueReusableCellWithIdentifier("CellEstetica", forIndexPath: indexPath)
            cell.textLabel?.text = "- \(ArrayEstetica[indexPath.row]["valor"]!)"
            return cell
        }
    
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int{
        return 1
    }
    
    func cargarDatos(let servicio:Int){
        
        let url = NSURL(string: "http://hyperion.init-code.com/zungu/app/servicios.php?vet=\(veterinaria)&ser=\(servicio)")
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!) { (data, response, error) in
            if error != nil{
                
                print(error)
                
            }else{
                if let jsonResult = try? NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers){
                    
                    if servicio == 1{
                        self.ArrayHospital = [[String: String]]()
                        if let items = jsonResult as? [[String: String]]{
                            
                            for item in items{
                                self.ArrayHospital.append((item))
                            }
                            
                        }
                    }else if servicio == 2{
                        self.ArrayClinica = [[String: String]]()
                        if let items = jsonResult as? [[String: String]]{
                            
                            for item in items{
                                self.ArrayClinica.append((item))
                            }
                            
                        }
                    }else if servicio == 3{
                        self.ArrayEstetica = [[String: String]]()
                        if let items = jsonResult as? [[String: String]]{
                            
                            for item in items{
                                self.ArrayEstetica.append((item))
                            }
                            
                        }
                    }

                    
                    dispatch_async(dispatch_get_main_queue(), {
                        
                        if servicio == 1{
                            self.tableHospital.reloadData()
                        }else if servicio == 2{
                            self.tableClinica.reloadData()
                        }else if servicio == 3{
                            self.tableEstetica.reloadData()
                        }

                        
                        return
                    })
                    
                }
            }
        }
        
        task.resume()
    
    }
    
    
   
}
