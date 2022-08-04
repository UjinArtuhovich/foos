//
//  StoryCollectionViewCell.swift
//  foos
//
//  Created by Ujin Artuhovich on 4.08.22.
//

import Foundation
import UIKit

class StoryCollectionViewCell: UICollectionViewCell {
    // MARK: - Private properties
    private var storyImageView: UIImageView!
    
    // MARK: - Internal properties
    var model: Story? {
        didSet {
            guard let model = model else {
                return
            }
            
            layer.borderColor = model.isWatched ? UIColor.white.cgColor : UIColor.Custom.accent.cgColor
            guard let imageUrl = URL(string: model.imageUrl) else { return }
            
            storyImageView?.kf.setImage(with: imageUrl)
        }
    }
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension StoryCollectionViewCell {
    // MARK: - Private methods
    func commonInit() {
        backgroundColor = .clear
        layer.borderWidth = Constants.borderWidth
        layer.borderColor = UIColor.white.cgColor
        layer.cornerRadius = Constants.cornerRadius
        
        storyImageView = .init()
        storyImageView.clipsToBounds = true
        storyImageView.contentMode = .scaleAspectFill
        storyImageView.layer.cornerRadius = Constants.cornerRadius
        
        addSubview(storyImageView)
        
        storyImageView.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(3)
            make.bottom.trailing.equalToSuperview().offset(-3)
        }
    }
}

private extension StoryCollectionViewCell {
    // MARK: - Constants
    struct Constants {
        static let borderWidth: CGFloat = 2
        static let cornerRadius: CGFloat = 13
    }
}

