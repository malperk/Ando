//
//  CustomTransition.swift
//  Example
//
//  Created by Alper KARATAS on 5/24/17.
//  Copyright © 2017 Alper KARATAŞ. All rights reserved.
//

import UIKit
//
//final class CustomTransition: NSObject, UIViewControllerAnimatedTransitioning {
//    var originFrame = CGRect.zero
//    let duration = 2.0
//
//    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
//        return duration
//    }
//
//    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
//        guard let sourceView = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to),
//            let destinationView = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from) else {
//            return
//        }
//
//        // 2
//        let initialFrame = originFrame
//        let finalFrame = transitionContext.finalFrame(for: destinationView)
//
//        // 3
//        let snapshot = sourceView.view.snapshotView(afterScreenUpdates: true)
//        snapshot?.frame = initialFrame
//        snapshot?.layer.cornerRadius = 25
//        snapshot?.layer.masksToBounds = true
//        
//        
//        transitionContext.containerView.addSubview(sourceView.view)
//        transitionContext.containerView.addSubview(snapshot!)
//        sourceView.view.isHidden = true
//        
//        AnimationHelper.perspectiveTransformForContainerView(containerView)
//        snapshot.layer.transform = AnimationHelper.yRotation(M_PI_2)
//    }
//}
