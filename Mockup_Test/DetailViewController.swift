//
//  DetailViewController.swift
//  Mockup_Test
//
//  Created by Macintosh on 07/01/17.
//  Copyright © 2017 Solucoes Digitais e Mobile. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    // MARK: - Instance variables
    
    var detailModel: model?
//    {
//        didSet {
//            
//            print("DETAIL SEGUE: \(detailModel)")
//        }
//    }
    
    // MARK: - Interface
    
    @IBOutlet weak var imageDetail: UIImageView!
    @IBOutlet weak var titleDetailLabel: UILabel!
    @IBOutlet weak var subTitleDetailLabel: UITextView!
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let image = detailModel?.imageModel {
            
            imageDetail.image = UIImage(named: image)
        }
        
        if let titleDetail = detailModel?.titleModel {
            
            titleDetailLabel.text = titleDetail
        }
        
        if let subTitleDetail = detailModel?.subTitleModel {
            
            subTitleDetailLabel.text = subTitleDetail
        }
        
    }
    
    // MARK: - Custom Functions
    
    // MARK: - Custom Buttons
    
}

// MARK: - Extensions

// MARK: - Cell Class

// MARK: - Interface Cell

// MARK: - Life Cycle Cell

// MARK: - Custom Functions Cell

// MARK: - Instance variables Cell

