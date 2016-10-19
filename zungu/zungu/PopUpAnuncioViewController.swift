//
//  PopUpAnuncioViewController.swift
//  zungu
//
//  Created by Giovanni Aranda on 13/10/16.
//  Copyright © 2016 Giovanni Aranda. All rights reserved.
//

import UIKit

class PopUpAnuncioViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.6)
        
        self.showAnimate()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func quitarAnuncio(sender: UIButton) {
        self.removeAnimate()
    }
 
    func showAnimate(){
        
        self.view.transform = CGAffineTransformMakeScale(1.3, 1.3)
        self.view.alpha = 0.0;
        UIView.animateWithDuration(0.25, animations:  {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransformMakeScale(1.0, 1.0)
        })
    }
    
    func removeAnimate(){
        
        UIView.animateWithDuration(0.25, animations:  {
            self.view.transform = CGAffineTransformMakeScale(1.3, 1.3)
            self.view.alpha = 0.0
            },completion: {(finished: Bool) in
                if (finished){
                    self.view.removeFromSuperview()
                }
                
            }
            
        )
        
    }
}
