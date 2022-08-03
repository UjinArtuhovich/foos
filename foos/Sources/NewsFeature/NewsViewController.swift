//
//  NewsViewController.swift
//  foos
//
//  Created by Ujin Artuhovich on 2.08.22.
//

import Combine
import ComposableArchitecture
import UIKit

final public class NewsViewController: UIViewController {
    // MARK: - Private properties
    private let store: Store<NewsState, NewsAction>
    private let viewStore: ViewStore<NewsState, NewsAction>
    private var cancellables: Set<AnyCancellable> = []
    
    private var collectionView: UICollectionView!
    private var tableView: UITableView!
    
    // MARK: - Init
    public init(store: Store<NewsState, NewsAction>) {
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

private extension NewsViewController {
    // MARK: - Private methods
    func setupItems() {
        setupUI()
        setupVS()
    }
    
    func setupUI() {
        view.backgroundColor = .Custom.backgroundMain
        
        tableView = .init(frame: .zero, style: .grouped)
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.showsVerticalScrollIndicator = false
        tableView.dataSource = self
        tableView.register(NewsTableViewCell.self, forCellReuseIdentifier: NewsConstants.newsCellReuseId)
        
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(5)
            make.top.centerX.centerY.equalToSuperview()
        }
    }
    
    func setupVS() {
    }
}

// FIX: - Make DataSource()
extension NewsViewController: UITableViewDataSource {
    public func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return 5
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsConstants.newsCellReuseId, for: indexPath) as? NewsTableViewCell else { return .init() }
        cell.model = .init(title: "Fashion", text: "В этокаждого человека без исключения", id: 1, imageUrl: "https://upload.wikimedia.org/wikipedia/commons/9/92/Etalage_van_modewinkel_-_Window_of_a_fashion_boutique_%286808272877%29.jpg", type: "summer")
        return cell
    }
}
