//
//  NewsView.swift
//  foos
//
//  Created by Ujin Artuhovich on 3.08.22.
//

import UIKit
import Kingfisher
import SnapKit

final public class NewsView: UIView {
    // MARK: - Private properties
    private var newsImageView: UIView!
    private var titleLabel: UILabel!
    private var descriptionLabel: UILabel!
    
    // MARK: - Public properties
    public var model: News? {
        didSet {
            guard let model = model else {
                return
            }
        }
    }
    
    // MARK: - Init
    public init() {
        super.init(frame: .zero)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension NewsView {
    // MARK: - Private methods
    func commonInit() {
        newsImageView = .init()
        newsImageView.backgroundColor = .Custom.accent
        
        addSubview(newsImageView)
        
        newsImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.top.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-10)
            make.width.equalTo(self.snp.width).dividedBy(1.5)
            make.height.equalTo(self.snp.width)
        }
        
    }
}

private extension NewsView {
    // MARK: - Constants
    struct Constants {
    }
}
