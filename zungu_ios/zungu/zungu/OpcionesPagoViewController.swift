//
//  OpcionesPagoViewController.swift
//  zungu
//
//  Created by Giovanni Aranda on 02/10/16.
//  Copyright © 2016 Giovanni Aranda. All rights reserved.
//

import UIKit

class OpcionesPagoViewController: UIViewController {

    @IBOutlet weak var buttonConfirmar: UIButton!
    var metodo:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buttonConfirmar.layer.cornerRadius = 5
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func selectMetodoPago(sender: UIButton) {
        metodo = sender.tag
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
