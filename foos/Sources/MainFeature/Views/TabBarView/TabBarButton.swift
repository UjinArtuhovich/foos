//
//  TabBarButton.swift
//  foos
//
//  Created by Ujin Artuhovich on 2.08.22.
//

import UIKit
import SnapKit

final class TabBarButton: UIButton {
    // MARK: - Private properties
    private var notificationView: UIView?
    
    // MARK: - Internal properties
    var hasNotificationView: Bool? {
        didSet {
            if hasNotificationView == true {
                if notificationView == nil {
                    let notificationView = UIView()
                    notificationView.backgroundColor = .systemRed
                    notificationView.layer.cornerRadius = Constants.notificationCornerRadius
                    
                    addSubview(notificationView)
                    
                    notificationView.snp.makeConstraints { make in
                        make.trailing.equalToSuperview().offset(-5)
                        make.top.equalToSuperview().offset(5)
                        make.height.width.equalTo(10)
                    }
                    
                    self.notificationView = notificationView
                }
            } else {
                notificationView?.removeFromSuperview()
                notificationView = nil
            }
        }
    }
    
    // MARK: - Init
    init() {
        super.init(frame: .zero)
        
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension TabBarButton {
    // MARK: - Private methods
    func commonInit() {
        tintColor = .systemGray
    }
}

private extension TabBarButton {
    // MARK: - Constants
    struct Constants {
        static let notificationCornerRadius = CGFloat(5)
    }
}

