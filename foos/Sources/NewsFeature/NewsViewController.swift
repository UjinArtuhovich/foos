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
    
//    private lazy var tableViewDataSource = makeTableViewDataSource()
//    private lazy var collectionViewDataSource = makeCollectionViewDataSource()
    
    private var collectionViewFlowLayout: UICollectionViewFlowLayout!
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
    
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        collectionViewFlowLayout.itemSize = .init(width: view.frame.width / NewsConstants.countOfStories, height: collectionView.frame.height)
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
        
//        // MARK: - Setup CollectionView
//        collectionViewFlowLayout = .init()
//        collectionViewFlowLayout.scrollDirection = .horizontal
//        collectionViewFlowLayout.sectionInset = .init(top: 0, left: 15, bottom: 0, right: 15)
//        collectionViewFlowLayout.minimumLineSpacing = 15
//
//        collectionView = .init(frame: .zero, collectionViewLayout: collectionViewFlowLayout)
//        collectionView.showsHorizontalScrollIndicator = false
//        collectionView.backgroundColor = .clear
//        collectionView.dataSource = makeCollectionViewDataSource()
//        collectionView.register(StoryCollectionViewCell.self, forCellWithReuseIdentifier: NewsConstants.storyCellReuseId)
//
//        view.addSubview(collectionView)
//
//        collectionView.snp.makeConstraints { make in
//            make.top.centerX.equalToSuperview()
//            make.leading.equalToSuperview().offset(5)
//            make.height.equalToSuperview().dividedBy(5.5)
//        }
//
//        // MARK: - Setup TableView
//        tableView = .init(frame: .zero, style: .plain)
//        tableView.backgroundColor = .clear
//        tableView.separatorStyle = .none
//        tableView.allowsSelection = false
//        tableView.showsVerticalScrollIndicator = false
//        tableView.dataSource = makeTableViewDataSource()
//        tableView.register(NewsTableViewCell.self, forCellReuseIdentifier: NewsConstants.newsCellReuseId)
//
//        view.addSubview(tableView)
//
//        tableView.snp.makeConstraints { make in
//            make.top.equalTo(collectionView.snp.bottom).offset(10)
//            make.leading.equalToSuperview().offset(5)
//            make.centerX.equalToSuperview()
//            make.bottom.equalToSuperview().offset(-5)
//        }
    }
    
    func setupVS() {
//        viewStore.publisher.newsDataSource
//            .sink { [weak self] _ in
//                self?.applyTableViewSnapshot()
//            }
//            .store(in: &cancellables)
//        
//        viewStore.publisher.storiesDataSource
//            .sink { [weak self] _ in
//                self?.applyCollectionViewSnapshot()
//            }
//            .store(in: &cancellables)
    }
}

//private extension NewsViewController {
//    // MARK: - Setup TableView DataSource
//    func makeTableViewDataSource() -> UITableViewDiffableDataSource<NewsState.Section, News> {
//        .init(tableView: tableView) { tableView, indexPath, model in
//            guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsConstants.newsCellReuseId, for: indexPath) as? NewsTableViewCell else {
//                return .init()
//            }
//
//            cell.model = model
//
//            return cell
//        }
//    }
//
//    func applyTableViewSnapshot(animatingDifferences: Bool = false) {
//        var snapshot = NSDiffableDataSourceSnapshot<NewsState.Section, News>()
//
//        snapshot.appendSections([.main])
//        snapshot.appendItems(viewStore.newsDataSource)
//
//        tableViewDataSource.apply(snapshot, animatingDifferences: animatingDifferences)
//    }
//
//    // MARK: - Setup CollectionView DataSource
//    func makeCollectionViewDataSource() -> UICollectionViewDiffableDataSource<NewsState.Section, Story> {
//        .init(collectionView: collectionView) { collectionView, indexPath, model in
//            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NewsConstants.storyCellReuseId, for: indexPath) as? StoryCollectionViewCell else {
//                return .init()
//            }
//
//            cell.model = model
//
//            return cell
//        }
//    }
//
//    func applyCollectionViewSnapshot(animatingDifferences: Bool = false) {
//        var snapshot = NSDiffableDataSourceSnapshot<NewsState.Section, Story>()
//
//        snapshot.appendSections([.main])
//        snapshot.appendItems(viewStore.storiesDataSource)
//
//        collectionViewDataSource.apply(snapshot, animatingDifferences: animatingDifferences)
//    }
//}
