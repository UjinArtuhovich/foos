//
//  SettingsViewController.swift
//  foos
//
//  Created by Ujin Artuhovich on 3.08.22.
//

import Combine
import ComposableArchitecture
import UIKit

final public class SettingsViewController: UIViewController {
    // MARK: - Private properties
    private let store: Store<SettingsState, SettingsAction>
    private let viewStore: ViewStore<SettingsState, SettingsAction>
    private var cancellables: Set<AnyCancellable> = []
    
    // MARK: - Init
    public init(store: Store<SettingsState, SettingsAction>) {
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

private extension SettingsViewController {
    // MARK: - Private methods
    func setupItems() {
        setupUI()
        setupVS()
    }
    
    func setupUI() {
        view.backgroundColor = .Custom.backgroundMain
        
        let backBarButtonItem = UIBarButtonItem(image: .init(named: SettingsConstants.backImageName,
                                                             in: .main,
                                                             with: nil),
                                                style: .plain,
                                                target: self,
                                                action: #selector(didTapBackButton))
        navigationItem.leftBarButtonItem = backBarButtonItem
    }
    
    func setupVS() {
    }
    
    @objc func didTapBackButton() {
        viewStore.send(.didTapBackButton)
    }
}
