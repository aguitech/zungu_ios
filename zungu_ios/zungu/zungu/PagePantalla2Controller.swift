//
//  PagePantalla2Controller.swift
//  zungu
//
//  Created by Giovanni Aranda on 01/09/16.
//  Copyright © 2016 Giovanni Aranda. All rights reserved.
//

import UIKit

class PagePantalla2Controller: UIViewController {
    
    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var textoSlide: UITextView!
    @IBOutlet weak var imageSlider: UIImageView!
    
    var titleIndex: String!
    var imageFIle: String!
    var pageIndex: Int = 0
    var textoSlider: String!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let filePath = NSBundle.mainBundle().pathForResource(imageFIle, ofType: "gif")
        let gif = NSData(contentsOfFile: filePath!)
        self.webView.loadData(gif!, MIMEType: "image/gif", textEncodingName: String(), baseURL: NSURL())
        self.webView.userInteractionEnabled = false
        
        self.textoSlide.text = self.titleIndex
        imageSlider.image = UIImage(named: textoSlider)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
