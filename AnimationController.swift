class AnimationController: NSObject, UIViewControllerAnimatedTransitioning {
    var operation: UINavigationControllerOperation?

    func transitionDuration(using transitionContext: UIViewControllerAnimatedTransitioning?) -> TimeInterval {
        return 1.0
    }

    func animateTransitioning(using transitionContext: UIViewControllerContextTransitioning) {
        switch operation {
            case .none,
                .some(.none): transitionContext.cancelInteractiveTransition()
            case .some(.pop):
                break
            case . some(.push): push(using: transitionContext)
        } 
    }

    private func push (using transitionContext: UIViewControllerContextTransitionin g) {
        guard let fromVC = transitionContext.viewController(forKey: .from) as ? ImageCollectionViewController ,
        let selectedCell = fromVC.selectedCell ,
        let toVC = transitionContext.viewController(forKey: . to) as ? ImageViewController else {
            return
        }
        let imageView = UIImageView(image: toVC.image)imageView.contentMode =.scaleToFill
        let frame = fromVC.collectionView!.convert(selectedCell.frame, to: fromVC.view)
            imageView.frame = frame
            transitionContext.containerView.addSubview(imageView)
        guard let fromSnapshot = fromVC.view.snapshotView(afterScreenUpdates: true) else {
            return
        }
        fromSnapshot.frame = fromVC.view.frame
        transitionContext.containerView.addSubview(fromSnapshot)
        guard let toSnapshot = toVC.view.snapshotView(afterScreenUpdates: true) else {
            return
        }

        toSnapshot.frame = toVC.view.frame
        transitionContext.containerView.addSubview(toSnapshot)
        toSnapshot.alpha = 0.0 transitionContext.containerView.bringSubview(toFront: fromSnapshot)
        transitionContext.containerView.bringSubview(toFront: imageView)
        var toFrame = toVC.view.frame
        let navigationBarHeight = fromVC.navigationController !.navigationBar.frame.height toFrame.size.height -= navigationBarHeight toFrame.origin.y = navigationBarHeight
        let duration = transitionDuration(using: transitionContext) UIView.animate(withDuration : duration , delay : 0, usingSpringWithDamping: 0.85 , initialSpringVelocity : 0.7, options : . curveEaseOut , animations : 
        {
            toSnapshot . alpha = 1
            imageView . frame = toFrame
        }) { ( finished ) in imageView . removeFromSuperview ()
        fromSnapshot.removeFromSuperview()toSnapshot.removeFromSuperview ()
        if ! transitionContext.transitionWasCancelled {
            transitionContext.containerView.addSubview(toVC.view )
        }
        
        transitionContext.completeTransition(!transitionContext.transitionWasCancelled )
    }
}
