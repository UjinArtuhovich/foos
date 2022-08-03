//
//  UIViewController+Child.swift
//  foos
//
//  Created by Ujin Artuhovich on 2.08.22.
//

import SnapKit
import UIKit

public extension UIViewController {
    func changeChildInView(prevVC: UIViewController?, newVC: UIViewController, in containerView: UIView) {
        if let prevVC = prevVC {
            removeChild(prevVC)
        }
        
        addChildToView(newVC, to: containerView)
    }
    
    func addChildToView(_ vc: UIViewController, to containerView: UIView) {
        addChild(vc)
        containerView.addSubview(vc.view)

        vc.view.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        vc.didMove(toParent: self)
    }
    
    func removeChild(_ vc: UIViewController) {
        vc.willMove(toParent: nil)
        vc.view.removeFromSuperview()
        vc.removeFromParent()
    }
}

