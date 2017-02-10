//
//  FadeInAnimator.swift
//  Mockup_Test
//
//  Created by Macintosh on 14/01/17.
//  Copyright © 2017 Solucoes Digitais e Mobile. All rights reserved.
//

import UIKit

class NavigationControllerDelegate: NSObject, UINavigationControllerDelegate {
    
    private let animator = FadeInAnimator()
    
    func navigationController(_ navigationController: UINavigationController,
                              animationControllerFor operation: UINavigationControllerOperation,
                              from fromVC: UIViewController,
                              to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        return animator
    }
}

class FadeInAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        
        return 0.35
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let containerView = transitionContext.containerView
        
        _ = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)
        let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)
        
        // Initial configuration the Destination View Controller
        containerView.addSubview(toVC!.view)
        toVC!.view.alpha = 0.0
        
        let duration = transitionDuration(using: transitionContext)
        
        UIView.animate(withDuration: duration, animations: {
            
            // Final state the Destination View Controller
            toVC!.view.alpha = 1.0
            
        }, completion: { finished in
            
            // Cancelled animation after transition
            let cancelled = transitionContext.transitionWasCancelled
            transitionContext.completeTransition(!cancelled)
            
        })
    }
    
}

/*
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        // push
        if let mainVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from) as? MainViewController,
            let detailVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to) as? DetailViewController {
            moveFromCategories(mainVC: mainVC, detailVC: detailVC, withContext: transitionContext)
        }
            
        // pop
        else if let mainVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to) as? MainViewController,
            let detailVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from) as? DetailViewController {
            moveFromPosts(detailVC: detailVC, mainVC: mainVC, withContext: transitionContext)
        }
    }
    
    
    private var selectedCellFrame: CGRect? = nil
    private var originalTableViewY: CGFloat? = nil
    
    private func moveFromCategories(mainVC: MainViewController, detailVC: DetailViewController, withContext context: UIViewControllerContextTransitioning) {
        
        if let indexPath = mainVC.tableView.indexPathForSelectedRow,
            let selectedCell = mainVC.tableView.cellForRow(at: indexPath) as? MainViewCell {
            
            context.containerView.addSubview(detailVC.view)
            
            // cell background -> hero image view transition
            // (don't want to mess with actual views,
            // so creating a new image view just for transition)
            let imageView = createTransitionImageViewWithFrame(frame: selectedCell.frame)
            imageView.image = selectedCell.imageModel.image
            imageView.alpha = 0.0 // hidden initially
            detailVC.view.addSubview(imageView)
            
            // save table view's original position and selected cell frame
            // (as a property) to move them back during pop transition animation
            selectedCellFrame = selectedCell.frame
            originalTableViewY = mainVC.tableView.frame.origin.y
            
            // figure out by how much need to move content
            let heroFinalHeight = detailVC.imageDetail.image?.size.height
//            let heroFinalHeight = detailVC.HeroViewHeight.Regular.rawValue
            let deltaY = selectedCell.center.y - heroFinalHeight! / 2.0
            
            // adjust text labels inside hero view (so they appear as if they came from selected cell)
            
//            let originalCategoryDescriptionBottomSpacerConstant = detailVC.titleDetailLabel
//            let originalCategoryDescriptionBottomSpacerConstant = detailVC.categoryDescriptionBottomSpacer.constant
//            detailVC.categoryDescriptionBottomSpacer.constant -= deltaY / 2.0
            
            detailVC.hideElementsForPushTransition() // (more about that later)
            
            UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.75, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
                
                // hide "your future pack" label
//                mainVC.titleLabel.alpha = 0.0
                
                // adjust table view frame so it appears like whole content is moving with cell image
                mainVC.tableView.frame.origin.y -= deltaY
                
                // move our transitioning imageView towards hero image position (and grow its size at the same time)
                imageView.frame = CGRect(x: 0.0, y: 0.0, width: imageView.frame.width, height: heroFinalHeight!)
                imageView.alpha = 1.0
                
                detailVC.view.alpha = 1.0
                
            }) { finished in
                
                // now we are ready to show real heroView on top of our imageView
                detailVC.view.sendSubview(toBack: imageView)
                
//                detailVC.categoryDescriptionBottomSpacer.constant = originalCategoryDescriptionBottomSpacerConstant
//                detailVC.prepareToCompletePushTransition() // (more about that later)
                
                // prepare constraints for animation
//                let autoLayoutViews = [detailVC.navigationItem.backBarButtonItem]
//                for view in autoLayoutViews { view.setNeedsUpdateConstraints() }
                
                UIView.animate(withDuration: 0.3, animations: {
                    detailVC.imageDetail.alpha = 1.0
//                    for view in autoLayoutViews { view.layoutIfNeeded() }
                    
                }) { finishedInner in
                    
                    // clean up & revert all the temporary things
                    imageView.removeFromSuperview()
//                    mainVC.titleLabel.alpha = 1.0
                    mainVC.tableView.deselectRow(at: indexPath, animated: false)
                    
                    context.completeTransition(!context.transitionWasCancelled)
                }
            }
        }
    }
    
    private func createTransitionImageViewWithFrame(frame: CGRect) -> UIImageView {
        let imageView = UIImageView(frame: frame)
        imageView.contentMode = .scaleAspectFill
//        imageView.setupDefaultTopInnerShadow()
        imageView.clipsToBounds = true
        return imageView
    }
    
    func disableTransparencyAnimatedForViews(views: [UIView]) {
        if let view = views.first {
            UIView.animate(withDuration: 0.2, animations: { view.alpha = 1.0 }) { _ in
                self.disableTransparencyAnimatedForViews(views: Array(views[1..<views.count]))
            }
        }
    }
    
    
    private func moveFromPosts(detailVC: DetailViewController, mainVC: MainViewController, withContext context: UIViewControllerContextTransitioning) {
        
        context.containerView.addSubview(mainVC.view)
        mainVC.view.alpha = 0.0
        
        let imageView = createTransitionImageViewWithFrame(frame: detailVC.imageDetail.frame)
        imageView.image = detailVC.imageDetail.image
        context.containerView.addSubview(imageView)
        
        UIView.animate(withDuration: 0.4, animations: {
            detailVC.view.alpha = 0.0
            detailVC.view.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            mainVC.view.alpha = 1.0
            mainVC.tableView.frame.origin.y = self.originalTableViewY ?? mainVC.tableView.frame.origin.y
            imageView.alpha = 0.0
            imageView.frame = self.selectedCellFrame ?? imageView.frame
        }) { finished in
            detailVC.view.transform = CGAffineTransform.identity
            imageView.removeFromSuperview()
            context.completeTransition(!context.transitionWasCancelled)
        }
    }
*/
    
    
class ReplaceTopSegue: UIStoryboardSegue {
    override func perform() {
        let fromVC = DetailViewController() as UIViewController
        let toVC = MainViewController() as UIViewController
        
        var vcs = fromVC.navigationController?.viewControllers
        vcs?.removeAll()
        vcs?.append(toVC)
        
        fromVC.navigationController?.setViewControllers(vcs!, animated: true)
    }
}

/*
private extension DetailViewController {
    
    func hideElementsForPushTransition() {
        // hero view appears with slight delay (not in sync)
        // so need to hide it explicitly from container view
        view.alpha = 0.0
        imageDetail.alpha = 0.0
        
        // hide all visible cells
//        for cell in visibleCellViews { cell.alpha = 0.0 }
        
        // move back button arrow beyond screen
//        backButtonHorizontalSpacer.constant = -70.0
    }
    
//    func prepareToCompletePushTransition() {
//        backButtonHorizontalSpacer.constant = 0.0
//        disableTransparencyAnimatedForViews(visibleCellViews)
//    }
    
//    private var visibleCellViews: [UIView] {
//        return (tableView.vis.visibleCells() as! [UITableViewCell]).map { $0.contentView }
//    }
}
*/
