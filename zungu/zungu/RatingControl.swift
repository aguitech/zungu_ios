//
//  RatingControl.swift
//  zungu
//
//  Created by Giovanni Aranda on 28/09/16.
//  Copyright © 2016 Giovanni Aranda. All rights reserved.
//

import UIKit

class RatingControl: UIView {
    
    var rating:Int = 3
    var ratingButtons = [UIImageView]()
    let spacing = 5
    let startCount = 5
    

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        let filledStarImage = UIImage(named: "yellow_star.png")
        let emptyStarImage = UIImage(named: "star.png")
        
        for z in 0..<startCount{
            let image = UIImageView(frame: CGRect(x: 0, y: 0, width: 12, height: 12))
            
            if z < rating{
                image.image = filledStarImage
            }else{
                image.image = emptyStarImage
            }
            ratingButtons += [image]
            addSubview(image)
            
        }
        
    }
    
    override func layoutSubviews() {
        let buttonSize = Int(frame.size.height)
        var imageFram = CGRect(x: 0, y: 0, width: 12, height: 12)
        
        for (index,imagen) in ratingButtons.enumerate(){
            imageFram.origin.x = CGFloat(index * (12 + spacing))
            imagen.frame = imageFram
        }
    }
    

}
