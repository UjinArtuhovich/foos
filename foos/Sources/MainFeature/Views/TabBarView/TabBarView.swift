//
//  TabBarView.swift
//  foos
//
//  Created by Ujin Artuhovich on 2.08.22.
//

import Foundation
import ComposableArchitecture
import UIKit

final public class TabBarView: UIView {
    // MARK: - Private properties
    private let viewStore: ViewStore<Void, Action>
    
    private var blurGradient: CAGradientLayer!
    private var stackView: UIStackView!
    private var sectionButton: TabBarButton!
    
    // MARK: - Internal properties
    var notificatonIndex: Int? {
        didSet {
            guard let value = notificatonIndex else {
                return
            }
            
            let notificationButton = self.viewWithTag(value) as? TabBarButton
            notificationButton?.hasNotificationView = true
        }
    }
    
    // MARK: - Internal properties
    var selectedSection: Int? {
        didSet {
            guard let selectedSection = selectedSection else {
                return
            }
            
            for subview in stackView.arrangedSubviews {
                subview.backgroundColor = .clear
                subview.tintColor = .systemGray
            }
            
            let selectedButton = stackView.arrangedSubviews[selectedSection]
            
            selectedButton.backgroundColor = Constants.sectionColor
            selectedButton.tintColor = .Custom.backgroundBar
            (selectedButton as? TabBarButton)?.hasNotificationView = false
        }
    }
    
    // MARK: - Init
    init(store: Store<Void, Action>) {
        self.viewStore = .init(store)
        
        super.init(frame: .zero)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        blurGradient.frame = .init(x: 0, y: -30, width: bounds.width, height: 30)
        
        let numSubviews = CGFloat(stackView.arrangedSubviews.count)
        let width = stackView.bounds.width - stackView.spacing * (numSubviews - 1)
        let buttonWidth = width / numSubviews
        
        stackView.arrangedSubviews.forEach { $0.layer.cornerRadius = buttonWidth / 2 }
    }
    
    // MARK: - Lifecycle
    public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        if traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
            blurGradient.colors = [
                UIColor.Custom.backgroundMain.withAlphaComponent(0).cgColor,
                UIColor.Custom.backgroundMain.withAlphaComponent(0.5).cgColor
            ]
        }
    }
}

private extension TabBarView {
    // MARK: - Private methods
    func commonInit() {
        backgroundColor = .Custom.backgroundBar
        
        blurGradient = .init()
        blurGradient.colors = [
            UIColor.Custom.backgroundMain.withAlphaComponent(0).cgColor,
            UIColor.Custom.backgroundMain.withAlphaComponent(0.5).cgColor
        ]
        
        layer.addSublayer(blurGradient)
        
        stackView = .init()
        stackView.distribution = .fillEqually
        stackView.spacing = 20
        
        addSubview(stackView)
        
        stackView.snp.makeConstraints { make in
            make.leading.top.equalToSuperview().offset(15)
            make.bottom.equalTo(safeAreaLayoutGuide)
            make.centerX.equalToSuperview()
        }
        
        for index in 0..<Constants.sectionImageNames.count {
            sectionButton = .init()
            // FIX: - Change TabBarImage
            //sectionButton.setImage(.init(named: Constants.sectionImageNames[index], in: Styleguide.module, with: nil), for: .normal)
            sectionButton.tag = index
            sectionButton.addTarget(self, action: #selector(didTapSectionButton), for: .touchUpInside)
            
            stackView.addArrangedSubview(sectionButton)
            
            sectionButton.snp.makeConstraints { make in
                make.height.equalTo(sectionButton.snp.width)
            }
        }
    }
    
    @objc func didTapSectionButton(_ sender: UIButton) {
        selectedSection = sender.tag
        
        viewStore.send(.didTapSectionButton(sender.tag))
    }
}

public extension TabBarView {
    // MARK: - Actions
    enum Action: Equatable {
        case didTapSectionButton(Int)
    }
}

private extension TabBarView {
    // MARK: - Constants
    struct Constants {
        static let sectionColor = UIColor.Custom.accent
        
        // FIX: - Change TabBarImage
        static let sectionImageNames = ["feed", "collection", "heart", "shop", "user"]
    }
}
