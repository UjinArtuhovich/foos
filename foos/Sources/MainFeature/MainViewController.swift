//
//  MainViewController.swift
//  foos
//
//  Created by Ujin Artuhovich on 2.08.22.
//

import UIKit
import ComposableArchitecture
import Combine

final public class MainViewController: UIViewController {
    // MARK: - Private properties
    private let store: Store<MainState, MainAction>
    private let viewStore: ViewStore<MainState, MainAction>
    private var cancellables: Set<AnyCancellable> = []
    
    private var containerView: UIView!
    private var sectionsVC: [UIViewController]!
    private var sectionVC: UIViewController?
    private var tabBarView: TabBarView!
    
    // MARK: - Init
    public init(store: Store<MainState, MainAction>) {
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
}

private extension MainViewController {
    // MARK: - Private methods
    func setupItems() {
        setupUI()
        setupVS()
    }
    
    func setupUI() {
        navigationController?.setNavigationBarHidden(false, animated: false)
        
        let settingsBarButtonItem = UIBarButtonItem(image: .init(named: MainConstants.settingsImageName,
                                                                 in: .main,
                                                                 with: nil),
                                                    style: .plain,
                                                    target: self,
                                                    action: #selector(didTapSettingsBarButton))
        
        navigationItem.hidesBackButton = true
        navigationItem.rightBarButtonItem = settingsBarButtonItem
        
        view.backgroundColor = .Custom.backgroundMain
        
        containerView = .init()
        
        view.addSubview(containerView)
        
        containerView.snp.makeConstraints { make in
            make.leading.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide)
        }
        
        sectionsVC = []
        
        for section in MainAction.Section.allCases {
            let vc: UIViewController
            
            switch section {
            case .news:
                let store = store.scope(state: \.newsState, action: MainAction.newsAction)
                vc = NewsViewController(store: store)
                
            case .myLooks:
                let store = store.scope(state: \.newsState, action: MainAction.newsAction)
                vc = NewsViewController(store: store)
                
            case .shop:
                let store = store.scope(state: \.newsState, action: MainAction.newsAction)
                vc = NewsViewController(store: store)
                
            case .profile:
                let store = store.scope(state: \.newsState, action: MainAction.newsAction)
                vc = NewsViewController(store: store)
                 
            case .test:
                let store = store.scope(state: \.newsState, action: MainAction.newsAction)
                vc = NewsViewController(store: store)
            }
            
            sectionsVC.append(vc)
        }
        
        tabBarView = .init(store: store.scope(action: MainAction.tabBar))
        
        view.addSubview(tabBarView)

        tabBarView.snp.makeConstraints { make in
            make.leading.bottom.centerX.equalToSuperview()
            make.top.equalTo(containerView.snp.bottom)
        }
    }
    
    func setupVS() {
        viewStore.publisher.section
            .sink { [weak self] value in
                guard let self = self else {
                    return
                }
                
                while self.navigationController?.viewControllers.last != self {
                    self.navigationController?.popViewController(animated: false)
                }
                
                self.dismiss(animated: false)
                
                let newSectionVC = self.sectionsVC[value.rawValue]
                
                self.changeChildInView(prevVC: self.sectionVC, newVC: newSectionVC, in: self.containerView)
                
                self.sectionVC = newSectionVC
                self.tabBarView.selectedSection = value.rawValue
            }
            .store(in: &self.cancellables)
    }
    
    @objc func didTapSettingsBarButton() {
    }
}

