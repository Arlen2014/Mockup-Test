//
//  model.swift
//  Mockup_Test
//
//  Created by Macintosh on 07/01/17.
//  Copyright © 2017 Solucoes Digitais e Mobile. All rights reserved.
//

import UIKit

// ?

class model: NSObject {
    
    var idModel: Int?
    var imageModel: String?
    var titleModel: String?
    var subTitleModel: String?
    
    init(id: Int, image: String, title: String, subTitle: String) {
        
        super.init()
        
        self.idModel = id
        self.imageModel = image
        self.titleModel = title
        self.subTitleModel = subTitle

    }
}
