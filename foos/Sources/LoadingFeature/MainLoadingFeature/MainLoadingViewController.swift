//
//  MainLoadingViewController.swift
//  foos
//
//  Created by Ujin Artuhovich on 2.08.22.
//

import Combine
import ComposableArchitecture
import UIKit

final public class MainLoadingViewController: UIViewController {
    // MARK: - Private properties
    private let store: Store<MainLoadingState, MainLoadingAction>
    private let viewStore: ViewStore<MainLoadingState, MainLoadingAction>
    private var cancellables: Set<AnyCancellable> = []
    
    private var logoView: UIView!
    
    // MARK: - Init
    public init(store: Store<MainLoadingState, MainLoadingAction>) {
        self.store = store
        self.viewStore = .init(store)
        
        super.init(nibName: nil, bundle: nil)
        
        viewStore.send(.didInit)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        setupItems()
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        animateLogoView()
    }
}

private extension MainLoadingViewController {
    // MARK: - Private methods
    func setupItems() {
        setupUI()
        setupVS()
    }
    
    func setupUI() {
        view.backgroundColor = .Custom.accent
    }
    
    func setupVS() {
        logoView = .init()
        logoView.backgroundColor = .Custom.backgroundBar
        
        view.addSubview(logoView)
        
        logoView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.width.height.equalTo(MainLoadingConstants.logoViewSize)
        }
        
        logoView.layer.cornerRadius = MainLoadingConstants.logoViewSize / 2
    }
    
    func animateLogoView() {
        UIView.animateKeyframes(withDuration: MainLoadingConstants.loadingDuration, delay: 0) { [weak self] in
            guard let self = self else { return }
            
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.25) {
                self.logoView.snp.updateConstraints { make in
                    make.centerX.equalToSuperview().offset(30)
                }
                
                self.view.layoutIfNeeded()
            }
            
            UIView.addKeyframe(withRelativeStartTime: 0.25, relativeDuration: 0.25) {
                self.logoView.snp.updateConstraints { make in
                    make.centerX.equalToSuperview()
                }
                
                self.view.layoutIfNeeded()
            }
            
            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.25) {
                self.logoView.snp.updateConstraints { make in
                    make.centerX.equalToSuperview().offset(-30)
                }
                
                self.view.layoutIfNeeded()
            }
            
            UIView.addKeyframe(withRelativeStartTime: 0.75, relativeDuration: 0.25) {
                self.logoView.snp.updateConstraints { make in
                    make.centerX.equalToSuperview()
                }
                
                self.view.layoutIfNeeded()
            }
        }
    }
}

