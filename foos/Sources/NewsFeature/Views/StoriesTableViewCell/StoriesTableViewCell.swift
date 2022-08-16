//
//  StoriesTableViewCell.swift
//  foos
//
//  Created by Ujin Artuhovich on 4.08.22.
//

import UIKit
import SnapKit

final class StoriesTableViewCell: UITableViewCell {
    // MARK: - Private properties
    private var collectionView: UICollectionView!
    
    private lazy var dataSource = makeDataSource()
    
    private var collectionViewFlowLayout: UICollectionViewFlowLayout!
    
    // MARK: - Internal properties
    var model: [Story]? {
        didSet {
            applySnapshot()
        }
    }

    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    
        collectionViewFlowLayout.itemSize = .init(width: UIScreen.main.bounds.width / Constants.countOfStories, height: collectionView.frame.height)
    }
}

private extension StoriesTableViewCell {
    // MARK: - Private methods
    func commonInit() {
        backgroundColor = .clear
        
        collectionViewFlowLayout = .init()
        collectionViewFlowLayout.scrollDirection = .horizontal
        collectionViewFlowLayout.sectionInset = .init(top: 0, left: 15, bottom: 0, right: 15)
        collectionViewFlowLayout.minimumLineSpacing = 15

        collectionView = .init(frame: .zero, collectionViewLayout: collectionViewFlowLayout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.dataSource = makeDataSource()
        collectionView.register(StoryCollectionViewCell.self, forCellWithReuseIdentifier: Constants.storyCellReuseId)

        addSubview(collectionView)
        
        collectionView.snp.makeConstraints { make in
            make.top.bottom.leading.centerX.equalToSuperview()
            make.height.equalTo(UIScreen.main.bounds.height / 6.5)
        }
    }
    
    func makeDataSource() -> UICollectionViewDiffableDataSource<Section, Story> {
        .init(collectionView: collectionView) { collectionView, indexPath, model in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.storyCellReuseId, for: indexPath) as? StoryCollectionViewCell else {
                return .init()
            }

            cell.model = model

            return cell
        }
    }

    func applySnapshot(animatingDifferences: Bool = false) {
        guard let model = model else {
            return
        }
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, Story>()

        snapshot.appendSections([.main])
        snapshot.appendItems(model)

        dataSource.apply(snapshot, animatingDifferences: animatingDifferences)
    }
}

private extension StoriesTableViewCell {
    // MARK: - Enums
    enum Section {
        case main
    }
}

private extension StoriesTableViewCell {
    struct Constants {
        static let storyCellReuseId = "storyCell"
        static let countOfStories: CGFloat = 4
    }
}
