//
//  BounceButton.swift
//  kappas_finalproject
//
//  Created by May Chen on 11/25/19.
//  Copyright © 2019 May Chen. All rights reserved.
//

import UIKit

class BounceButton: UIButton {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        UIView.animate(withDuration: 0.8, delay:0, usingSpringWithDamping: 0.5, initialSpringVelocity: 6, options: .allowUserInteraction, animations:
            {
                self.transform = CGAffineTransform.identity }, completion: nil)
        super.touchesBegan(touches, with: event)
    }

}
