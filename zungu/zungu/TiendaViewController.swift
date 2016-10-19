//
//  TiendaViewController.swift
//  zungu
//
//  Created by Giovanni Aranda on 06/09/16.
//  Copyright © 2016 Giovanni Aranda. All rights reserved.
//

import UIKit

class TiendaViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionTienda: UICollectionView!
    var ArrayList:[[String: String]] = [[String: String]]()
    let veterinaria:Int = 9
    var idt:Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("popUpPatrocinado") as! PopUpAnuncioViewController
        
        self.addChildViewController(popOverVC)
        popOverVC.view.frame = self.view.frame
        self.view.addSubview(popOverVC.view)
        popOverVC.didMoveToParentViewController(self)
        

        searchBar.backgroundImage = UIImage()
        searchBar.layer.borderWidth = 1
        searchBar.layer.borderColor = UIColor.grayColor().CGColor
        searchBar.layer.cornerRadius = 20
        searchBar.sizeToFit()
        
        cargarDatos()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return ArrayList.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell{
    
        let cell = collectionTienda.dequeueReusableCellWithReuseIdentifier("CollTienda", forIndexPath: indexPath) as! ColTiendaCollectionViewCell
    
        cell.nombreTienda.text = ArrayList[indexPath.row]["nombre"]
        cell.precioTienda.text = ArrayList[indexPath.row]["precio"]
        
        let image = ArrayList[indexPath.row]["imagen"]
        let  imageUrl = NSURL(string: "http://hyperion.init-code.com/zungu/imagen_tienda/\(self.ArrayList[indexPath.row]["imagen"]!)")
        
        
        cell.imagenTienda.image = UIImage(named: "perrito-serviciospaseo.png")
        
        // async image
        if image != nil {
            
            let request: NSURLRequest = NSURLRequest(URL: imageUrl!)
            //print(imageUrl)
            NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: { (response, data, error) in
                if error == nil {
                    
                    let imagen = UIImage(data: data!)
                    dispatch_async(dispatch_get_main_queue(), {
                        cell.imagenTienda.image = imagen
                        
                    })
                }
            })
        }
        
        return cell
        
        
    }
    
    
    func cargarDatos(){
        let url = NSURL(string: "http://hyperion.init-code.com/zungu/app/tienda.php?vet=\(veterinaria)")
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!) { (data, response, error) in
            if error != nil{
                
                print(error)
                
            }else{
                if let jsonResult = try? NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers){
                    
                    self.ArrayList = [[String: String]]()
                    if let items = jsonResult as? [[String: String]]{
                        
                        for item in items{
                            self.ArrayList.append((item))
                        }
                        
                    }
                    
                    dispatch_async(dispatch_get_main_queue(), {
                        
                        self.collectionTienda.reloadData()
                        return
                    })
                    
                }
            }
        }
        
        task.resume()
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath){
        idt = Int(ArrayList[indexPath.row]["id_tienda"]!)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewControllerWithIdentifier("DetalleTienda") as! DetalleTiendaViewController
        viewController.idt = idt
        viewController.veterinaria = veterinaria
        self.presentViewController(viewController, animated: true, completion: nil)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        let screenWidth = CGRectGetWidth(collectionView.bounds)
        let cellWidth = screenWidth/2
        
        return CGSize(width: cellWidth-2, height: 211)
        
    }
    
    func collectionView(collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                               minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 3
    }
    
    func collectionView(collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                               minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 3
    }
    

}
