//
//  AppViewController.swift
//  foos
//
//  Created by Ujin Artuhovich on 2.08.22.
//

import Combine
import ComposableArchitecture
import UIKit

final public class AppViewController: UINavigationController {
    // MARK: - Private properties
    private let store: Store<AppState, AppAction>
    private let viewStore: ViewStore<AppState, AppAction>
    private var cancellables: Set<AnyCancellable> = []
    
    // MARK: - Init
    public init(store: Store<AppState, AppAction>) {
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

private extension AppViewController {
    // MARK: - Private methods
    func setupItems() {
        setupUI()
        setupVS()
    }
    
    func setupUI() {
        view.backgroundColor = .Custom.backgroundMain
        
        setNavigationBarHidden(true, animated: false)
        
        UINavigationBar.appearance().barTintColor = .Custom.backgroundBar
        UINavigationBar.appearance().tintColor = .systemGray
        UINavigationBar.appearance().titleTextAttributes = [.font: UIFont.systemFont(ofSize: AppConstants.navigationBarTextFontSize,
                                                                                weight: .medium),
                                                            .foregroundColor: UIColor.systemGray]
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().shadowImage = .init()
    }
    
    func setupVS() {
        viewStore.publisher.route
            .sink { [weak self] value in
                guard let self = self else {
                    return
                }
                
                switch value {
                case .mainLoading:
                    self.store.scope(state: \.mainLoadingState, action: AppAction.mainLoading)
                        .ifLet { [weak self] in
                            self?.setViewControllers([MainLoadingViewController(store: $0)], animated: false)
                        }
                        .store(in: &self.cancellables)
                    
                case .main:
                    self.store.scope(state: \.mainState, action: AppAction.main)
                        .ifLet { [weak self] in
                            self?.pushViewController(MainViewController(store: $0), animated: false)
                        }
                        .store(in: &self.cancellables)
                    
                    
                case .none:
                    break
                }
            }
            .store(in: &cancellables)
    }
}
