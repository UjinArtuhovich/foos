//
//  ProfileViewController.swift
//  foos
//
//  Created by Ujin Artuhovich on 4.08.22.
//

import Combine
import ComposableArchitecture
import UIKit

final public class ProfileViewController: UIViewController {
    // MARK: - Private properties
    private let store: Store<ProfileState, ProfileAction>
    private let viewStore: ViewStore<ProfileState, ProfileAction>
    private var cancellables: Set<AnyCancellable> = []
    
    private var mainProfileView: UIView!
    
    // MARK: - Init
    public init(store: Store<ProfileState, ProfileAction>) {
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

private extension ProfileViewController {
    // MARK: - Private methods
    func setupItems() {
        setupUI()
        setupVS()
    }
    
    func setupUI() {
        view.backgroundColor = .Custom.backgroundMain
        
        mainProfileView = .init()
        mainProfileView.backgroundColor = .Custom.backgroundBar
        mainProfileView.layer.cornerRadius = ProfileConstants.mainViewCornerRadius
        
        view.addSubview(mainProfileView)
        
        mainProfileView.snp.makeConstraints { make in
            make.top.centerX.equalToSuperview()
            make.leading.equalToSuperview().offset(10)
            make.height.equalToSuperview().dividedBy(6)
        }
    }
    
    func setupVS() {
    }
}
