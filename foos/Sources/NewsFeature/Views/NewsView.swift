//
//  NewsView.swift
//  foos
//
//  Created by Ujin Artuhovich on 3.08.22.
//

import UIKit
import Kingfisher
import SnapKit
import BonMot

final public class NewsView: UIView {
    // MARK: - Private properties
    private var newsImageView: UIImageView!
    private var titleLabel: UILabel!
    private var typeView: UIView!
    private var typeLabel: UILabel!
    private var descriptionLabel: UITextView!
    
    // MARK: - Public properties
    public var model: News? {
        didSet {
            guard let model = model else {
                return
            }
            
            titleLabel.styledText = model.title
            typeLabel.styledText = Constants.hashtag + model.type
            guard let imageUrl = URL(string: model.imageUrl) else { return }
            
            newsImageView?.kf.setImage(with: imageUrl)
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
        newsImageView.clipsToBounds = true
        newsImageView.contentMode = .scaleAspectFill
        
        addSubview(newsImageView)
        
        newsImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.top.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-10)
            make.width.equalTo(self.snp.width).dividedBy(1.5)
            make.height.equalTo(self.snp.width)
        }
        
        titleLabel = .init()
        titleLabel.numberOfLines = 0
        titleLabel.bonMotStyle = Constants.titleTextStyle
        
        addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.leading.equalTo(newsImageView.snp.trailing).offset(10)
            make.trailing.equalToSuperview().offset(-2)
        }
        
        typeLabel = .init()
        typeLabel.bonMotStyle = Constants.typeTextStyle
        
        addSubview(typeLabel)
        
        typeLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.leading.equalTo(newsImageView.snp.trailing).offset(10)
        }
        
        typeView = .init()
        typeView.backgroundColor = .Custom.accent.withAlphaComponent(0.1)
        typeView.layer.cornerRadius = Constants.typeCornerRadius
        
        addSubview(typeView)
        
        typeView.snp.makeConstraints { make in
            make.centerX.centerY.equalTo(typeLabel)
            make.width.height.equalTo(typeLabel).offset(5)
        }
    }
}

private extension NewsView {
    // MARK: - Constants
    struct Constants {
        static let hashtag = "#"
        static let typeCornerRadius: CGFloat = 7
        static let titleTextStyle = StringStyle([
            .font(.systemFont(ofSize: 24, weight: .bold)),
            .color(.black)
        ])
        static let typeTextStyle = StringStyle([
            .font(.systemFont(ofSize: 16, weight: .regular)),
            .color(.black)
        ])
        static let descriptionTextStyle = StringStyle([
            .font(.systemFont(ofSize: 12, weight: .light)),
            .color(.black)
        ])
    }
}
