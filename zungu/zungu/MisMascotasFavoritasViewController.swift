//
//  MisMascotasFavoritasViewController.swift
//  zungu
//
//  Created by Giovanni Aranda on 08/09/16.
//  Copyright © 2016 Giovanni Aranda. All rights reserved.
//

import UIKit

class MisMascotasFavoritasViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {

    @IBOutlet weak var collectionView: UICollectionView!
    let id_usuario = 1
    var ArrayList:[[String: String]] = [[String: String]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let url = NSURL(string: "http://hyperion.init-code.com/zungu/app/adoptar_mascotaImagen.php?idu=\(id_usuario)")
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
                        
                        self.collectionView.reloadData()
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
    
    func cargarDatos(){
        
        
    
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
    
        return self.ArrayList.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell{
    
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("collMini", forIndexPath: indexPath) as! ColMascotasCollectionViewCell
        
        let image = ArrayList[indexPath.row]["imagen"]
        let  imageUrl = NSURL(string: "http://hyperion.init-code.com/zungu/mascotas_subidas/\(self.ArrayList[indexPath.row]["imagen"]!)")
        
        
        cell.imageViewCollection.image = UIImage(named: "gato.png")
        
        // async image
        if image != nil {
            
            let request: NSURLRequest = NSURLRequest(URL: imageUrl!)
            //print(imageUrl)
            NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: { (response, data, error) in
                if error == nil {
                    
                    let imagen = UIImage(data: data!)
                    dispatch_async(dispatch_get_main_queue(), {
                        cell.imageViewCollection.image = imagen
                        
                    })
                }
            })
        }
        
        
        return cell
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
