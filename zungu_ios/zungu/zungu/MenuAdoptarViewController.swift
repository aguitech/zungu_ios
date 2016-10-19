//
//  MenuAdoptarViewController.swift
//  zungu
//
//  Created by Giovanni Aranda on 08/09/16.
//  Copyright © 2016 Giovanni Aranda. All rights reserved.
//

import UIKit

class MenuAdoptarViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cerrarSesion(sender: UIButton) {
        let preferences = NSUserDefaults.standardUserDefaults()
        
        let arrayUsuarioKey = "arrayUsuario"
        
        _ = preferences.setObject(nil, forKey: arrayUsuarioKey)
        
        _ = preferences.synchronize()
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        
        let nextViewController = storyBoard.instantiateViewControllerWithIdentifier("iniciarSesion") as! IniciarSesionViewController
        self.presentViewController(nextViewController, animated:true, completion:nil)
    }
    

}
