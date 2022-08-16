//
//  NewsMainTableViewCell.swift
//  foos
//
//  Created by Ujin Artuhovich on 4.08.22.
//

import UIKit
import SnapKit

final class NewsMainTableViewCell: UITableViewCell {
    // MARK: - Private properties
    private var tableView: UITableView!
    
    private lazy var dataSource = makeDataSource()
    
    // MARK: - Internal properties
    var model: [News]? {
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
}

private extension NewsMainTableViewCell {
    // MARK: - Private methods
    func commonInit() {
        backgroundColor = .clear
        
        tableView = .init(frame: .zero, style: .plain)
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.isScrollEnabled = false
        tableView.showsVerticalScrollIndicator = false
        tableView.dataSource = makeDataSource()
        tableView.register(NewsTableViewCell.self, forCellReuseIdentifier: Constants.newsCellReuseId)

        addSubview(tableView)

        tableView.snp.makeConstraints { make in
            make.top.leading.bottom.centerX.equalToSuperview()
            make.height.equalTo((UIScreen.main.bounds.width + 15) * 3)
        }
    }
    
    func makeDataSource() -> UITableViewDiffableDataSource<Section, News> {
        .init(tableView: tableView) { tableView, indexPath, model in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.newsCellReuseId, for: indexPath) as? NewsTableViewCell else {
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
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, News>()

        snapshot.appendSections([.main])
        snapshot.appendItems(model)

        dataSource.apply(snapshot, animatingDifferences: animatingDifferences)
    }
}

private extension NewsMainTableViewCell {
    // MARK: - Enums
    enum Section {
        case main
    }
}

private extension NewsMainTableViewCell {
    struct Constants {
        static let newsCellReuseId = "newsCell"
        static let countOfStories: CGFloat = 4
    }
}
