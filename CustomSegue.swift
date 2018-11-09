import UIKit

class SegueFromRight: UIStoryboardSegue {
    
    override func perform() {
        let src = self.source as UIViewController
        let des = self.destination as UIViewController
        
        src.view.superview?.insertSubview(des.view, aboveSubview: src.view)
        des.view.transform = CGAffineTransform(translationX: src.view.frame.size.width, y: 0)
        
        UIView.animate(withDuration: 0.25, delay: 0.0, options: .curveEaseInOut, animations: {
            // Animate destination view in
            des.view.transform = CGAffineTransform(translationX: 0, y: 0)
        }, completion: { (_) in
            // Show destination view
            src.present(des, animated: false, completion: nil)
        })
    }
    
}

class SegueFromRightUnwind: UIStoryboardSegue {
    
    override func perform() {
        let src = self.source as UIViewController
        let des = self.destination as UIViewController
        
        src.view.superview?.insertSubview(des.view, belowSubview: src.view)
        des.view.transform = CGAffineTransform(translationX: 0, y: 0)
        
        UIView.animate(withDuration: 0.25, delay: 0.0, options: .curveEaseInOut, animations: {
            src.view.transform = CGAffineTransform(translationX: src.view.frame.size.width, y: 0)
        }) { (_) in
            src.dismiss(animated: false, completion: nil)
        }
    }
}

