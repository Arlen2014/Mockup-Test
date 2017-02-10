//
//  NavigationController.swift
//  Mockup_Test
//
//  Created by Macintosh on 15/01/17.
//  Copyright © 2017 Solucoes Digitais e Mobile. All rights reserved.
//

import ZoomTransitioning

class NavigationController: UINavigationController {
    
    private let zoomNavigationControllerDelegate = ZoomNavigationControllerDelegate()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        delegate = zoomNavigationControllerDelegate
    }
}
