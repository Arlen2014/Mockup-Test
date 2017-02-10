//
//  DetailViewController.swift
//  Mockup_Test
//
//  Created by Macintosh on 07/01/17.
//  Copyright © 2017 Solucoes Digitais e Mobile. All rights reserved.
//

import UIKit
import ZoomTransitioning

class DetailViewController: UIViewController {

    // MARK: - Instance variables
    
    var detailModel: model?
    
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
}

// MARK: - Extensions - ZoomTransitionSourceDelegate

extension DetailViewController: ZoomTransitionDestinationDelegate {
    
    func transitionDestinationImageViewFrame(forward: Bool) -> CGRect {
        if forward {
            let x: CGFloat = 16.0
            let y = topLayoutGuide.length
            let width = view.frame.width - 32
            let height = width * 9.0 / 16.0
            return CGRect(x: x, y: y, width: width, height: height)
        } else {
            return imageDetail.convert(imageDetail.bounds, to: view)
        }
    }
    
    func transitionDestinationWillBegin() {
        imageDetail.isHidden = true
    }
    
    func transitionDestinationDidEnd(transitioningImageView imageView: UIImageView) {
        imageDetail.isHidden = false
        imageDetail.image = imageView.image
    }
    
    func transitionDestinationDidCancel() {
        imageDetail.isHidden = false
    }
}
