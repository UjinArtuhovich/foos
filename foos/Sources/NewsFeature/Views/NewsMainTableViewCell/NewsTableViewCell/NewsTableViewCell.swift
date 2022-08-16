//
//  NewsTableViewCell.swift
//  foos
//
//  Created by Ujin Artuhovich on 3.08.22.
//

import UIKit
import SnapKit

final class NewsTableViewCell: UITableViewCell {
    // MARK: - Private properties
    private var newsView: NewsView!
    
    // MARK: - Internal properties
    var model: News? {
        didSet {
            newsView.model = model
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

private extension NewsTableViewCell {
    // MARK: - Private methods
    func commonInit() {
        backgroundColor = .clear
        
        newsView = .init()
        
        contentView.addSubview(newsView)
        
        newsView.snp.makeConstraints { make in
            make.leading.top.bottom.centerX.equalToSuperview()
        }
    }
}
