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
    
    private lazy var dataSource = makeDataSource()
    
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
        tableView = .init(frame: .zero, style: .plain)
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.isScrollEnabled = true
        tableView.showsVerticalScrollIndicator = false
        tableView.dataSource = makeDataSource()
        tableView.register(NewsMainTableViewCell.self, forCellReuseIdentifier: NewsConstants.newsMainCellReuseId)
        tableView.register(StoriesTableViewCell.self, forCellReuseIdentifier: NewsConstants.storiesCellReuseId)

        view.addSubview(tableView)

        tableView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(5)
            make.top.bottom.centerX.equalToSuperview()
        }
    }
    
    func setupVS() {
        viewStore.publisher.dataSource
            .sink { [weak self] _ in
                self?.applySnapshot()
            }
            .store(in: &cancellables)
    }
    
    func makeDataSource() -> UITableViewDiffableDataSource<NewsState.Section, AnyHashable> {
        .init(tableView: tableView) { tableView, indexPath, model in
            if let newsData = model as? [News] {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsConstants.newsMainCellReuseId, for: indexPath) as? NewsMainTableViewCell else {
                    return .init()
                }
                
                cell.model = newsData
                
                return cell
                
            } else if let storiesData = model as? [Story] {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsConstants.storiesCellReuseId, for: indexPath) as? StoriesTableViewCell else {
                    return .init()
                }
                
                cell.model = storiesData
                
                return cell
                
            } else {
                return .none
            }
        }
    }
    
    func applySnapshot(animatingDifferences: Bool = false) {
        guard let dataSource = viewStore.dataSource else {
            return
        }
        
        var snapshot = NSDiffableDataSourceSnapshot<NewsState.Section, AnyHashable>()

        snapshot.appendSections([.stories, .news])
        snapshot.appendItems([dataSource.stories], toSection: .stories)
        snapshot.appendItems([dataSource.news], toSection: .news)

        self.dataSource.apply(snapshot, animatingDifferences: animatingDifferences)
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
