//
//  VeterinariasViewController.swift
//  zungu
//
//  Created by Giovanni Aranda on 06/09/16.
//  Copyright © 2016 Giovanni Aranda. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

var tipo:Int = 1

class VeterinariasViewController: UIViewController,MKMapViewDelegate,CLLocationManagerDelegate,UISearchBarDelegate {
    
    @IBOutlet weak var buscador: UISearchBar!
    @IBOutlet weak var viewMapaLista: UIView!
    @IBOutlet weak var map: MKMapView!
    let locationManager = CLLocationManager()
    var buscar:String?
    
    @IBAction func cambiarTipo(sender: UIButton) {
        tipo = sender.tag
        
        cargarDatosMapa()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        buscador.backgroundImage = UIImage()
        buscador.delegate = self
        viewMapaLista.layer.borderColor =  UIColorFromHex(0x95989A).CGColor
        viewMapaLista.layer.borderWidth = 1
        viewMapaLista.layer.cornerRadius = 2
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        cargarDatosMapa()

        // Do any additional setup after loading the view.
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        
        buscar = searchBar.text
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func UIColorFromHex(rgbValue:UInt32, alpha:Double=1.0)->UIColor {
        let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
        let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
        let blue = CGFloat(rgbValue & 0xFF)/256.0
        
        return UIColor(red:red, green:green, blue:blue, alpha:CGFloat(alpha))
    }
    
    func cargarDatosMapaBuscar(){
        
        if(self.buscar != nil){
            let url = NSURL(string: "http://hyperion.init-code.com/zungu/app/veterinarios_mapa_buscar.php?buscar=\(buscar!)")
            let task = NSURLSession.sharedSession().dataTaskWithURL(url!) { (data, response, error) in
                if error != nil{
                
                    print(error)
                
                }else{
                    if let jsonResult = try? NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers){
                    
                        for x in 0 ..< Int(jsonResult.count){
                        
                        let array = jsonResult[x] as! NSDictionary
                        let latitud:CLLocationDegrees = Double("\(array["latitud"]!)")!
                        let longitud:CLLocationDegrees = Double("\(array["longitud"]!)")!
                        let latDelta:CLLocationDegrees = 0.01
                        let lonDelta:CLLocationDegrees = 0.01
                        
                        let span:MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: lonDelta)
                        
                        let location:CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: latitud, longitude: longitud)
                        
                        let region: MKCoordinateRegion = MKCoordinateRegionMake(location, span)
                        
                        self.map.setRegion(region, animated: true)
                        
                        let anotation = MKPointAnnotation()
                        
                        anotation.coordinate = location
                        anotation.title = "\(array["nombre"]!)"
                        anotation.subtitle = "\(array["ubicacion"]!)"
                        
                        self.map.addAnnotation(anotation)
                        }
                    
                    
                    }
                }
            }
        
            task.resume()
        }
    }
    
    func cargarDatosMapa(){
        
        let url = NSURL(string: "http://hyperion.init-code.com/zungu/app/veterinarios_mapa.php?tipo=\(tipo)")
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!) { (data, response, error) in
            if error != nil{
                
                print(error)
                
            }else{
                if let jsonResult = try? NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers){
                    
                    for x in 0 ..< Int(jsonResult.count){
                        
                        let array = jsonResult[x] as! NSDictionary
                        let latitud:CLLocationDegrees = Double("\(array["latitud"]!)")!
                        let longitud:CLLocationDegrees = Double("\(array["longitud"]!)")!
                        let latDelta:CLLocationDegrees = 0.01
                        let lonDelta:CLLocationDegrees = 0.01
                        
                        let span:MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: lonDelta)
                        
                        let location:CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: latitud, longitude: longitud)
                        
                        let region: MKCoordinateRegion = MKCoordinateRegionMake(location, span)
                        
                        self.map.setRegion(region, animated: true)
                        
                        let anotation = MKPointAnnotation()
                        
                        anotation.coordinate = location
                        anotation.title = "\(array["nombre"]!)"
                        anotation.subtitle = "\(array["ubicacion"]!)"
                        
                        self.map.addAnnotation(anotation)
                    }
                    
                    
                }
            }
        }
        
        task.resume()
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation = locations.first!
        
        let latitude = userLocation.coordinate.latitude
        let longitud = userLocation.coordinate.longitude
        
        let latDelta:CLLocationDegrees = 0.01
        let lonDelta:CLLocationDegrees = 0.01
        
        let span:MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: lonDelta)
        
        let location:CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: latitude, longitude: longitud)
        
        let region: MKCoordinateRegion = MKCoordinateRegionMake(location, span)
        
        map.setRegion(region, animated: true)
        
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
