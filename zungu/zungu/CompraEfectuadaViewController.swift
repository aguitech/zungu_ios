//
//  CompraEfectuadaViewController.swift
//  zungu
//
//  Created by Giovanni Aranda on 02/10/16.
//  Copyright © 2016 Giovanni Aranda. All rights reserved.
//

import UIKit

class CompraEfectuadaViewController: UIViewController {

    @IBOutlet weak var precioProducto: UILabel!
    @IBOutlet weak var buttonFacturarEstilo: UIButton!
    @IBOutlet weak var buttonPagosEstilo: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        precioProducto.layer.borderWidth = 1
        precioProducto.layer.borderColor = UIColor.whiteColor().CGColor
        precioProducto.layer.cornerRadius = 5
        
        buttonPagosEstilo.layer.borderWidth = 1
        buttonPagosEstilo.layer.borderColor = UIColor.whiteColor().CGColor
        buttonPagosEstilo.layer.cornerRadius = 5
        
        buttonFacturarEstilo.layer.borderWidth = 1
        buttonFacturarEstilo.layer.borderColor = UIColor.whiteColor().CGColor
        buttonFacturarEstilo.layer.cornerRadius = 5
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
