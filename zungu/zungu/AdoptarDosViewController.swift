//
//  AdoptarDosViewController.swift
//  zungu
//
//  Created by Giovanni Aranda on 08/09/16.
//  Copyright © 2016 Giovanni Aranda. All rights reserved.
//

import UIKit

class AdoptarDosViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate {

    @IBOutlet weak var collectionAdoptar: UICollectionView!
    var ArrayList:[[String: String]] = [[String: String]]()
    var idam = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cargarDatos()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        
        return self.ArrayList.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell{
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cellAdoptarListado", forIndexPath: indexPath) as! ColMascCollectionViewCell
        
        let image = ArrayList[indexPath.row]["imagen"]
        let  imageUrl = NSURL(string: "http://hyperion.init-code.com/zungu/mascotas_subidas/\(self.ArrayList[indexPath.row]["imagen"]!)")
        
        
        cell.imagenMascota.image = UIImage(named: "gato.png")
        
        // async image
        if image != nil {
            
            let request: NSURLRequest = NSURLRequest(URL: imageUrl!)
            //print(imageUrl)
            NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: { (response, data, error) in
                if error == nil {
                    
                    let imagen = UIImage(data: data!)
                    dispatch_async(dispatch_get_main_queue(), {
                        cell.imagenMascota.image = imagen
                        
                    })
                }
            })
        }
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath){
        idam = Int(ArrayList[indexPath.row]["id_adopta_mascota"]!)!
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewControllerWithIdentifier("vistaDetalleAdopta") as! AdoptarDetalleViewController
        
        viewController.idam = idam
        
        self.presentViewController(viewController, animated: true, completion: nil)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
    
    let screenWidth = CGRectGetWidth(collectionView.bounds)
    let cellWidth = screenWidth/3
    
    return CGSize(width: cellWidth-2, height: cellWidth-2)
    
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
    
    func cargarDatos(){
        
        let url = NSURL(string: "http://hyperion.init-code.com/zungu/app/adoptar_mascotados.php")
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!) { (data, response, error) in
            if error != nil{
                
                print(error)
                
            }else{
                if let jsonResult = try? NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers){
                    
                    self.ArrayList = [[String: String]]()
                    for x in 0 ..< Int(jsonResult.count){
                        
                        self.ArrayList.append(jsonResult[x] as! NSDictionary as! [String : String])
                        
                        
                    }
                    dispatch_async(dispatch_get_main_queue(), {
                        
                        self.collectionAdoptar.reloadData()
                        return
                    })
                    
                }
            }
        }
        
        task.resume()
        
    }
}
