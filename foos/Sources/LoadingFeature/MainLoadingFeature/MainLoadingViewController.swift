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
    }
}

