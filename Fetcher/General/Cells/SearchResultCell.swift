//
//  SearchResultCell.swift
//  Fetcher
//
//  Created by Shalom Friss on 10/31/21.
//

import Foundation
import UIKit

class SearchResultCell: UITableViewCell {
    public var token:UUID?
    private var viewConstraints: [NSLayoutConstraint] = []
    
    var posterImage: UIImageView = {
        let posterImage = UIImageView()
        posterImage.translatesAutoresizingMaskIntoConstraints = false
        posterImage.contentMode = .scaleAspectFit
        posterImage.layer.cornerRadius = 5
        posterImage.clipsToBounds = true
        return posterImage
    }()
    
    var titleLabel: UILabel = {
        let titleLabel = UILabel(frame: .zero)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20.0)
        titleLabel.textColor = UIColor.darkGray
        titleLabel.numberOfLines = 0
        titleLabel.adjustsFontForContentSizeCategory = true

        return titleLabel
    }()
    
    var overviewLabel:UILabel = {
        let overviewLabel = UILabel(frame: .zero)
        overviewLabel.translatesAutoresizingMaskIntoConstraints = false
        overviewLabel.font = UIFont.systemFont(ofSize: 12.0)
        overviewLabel.textColor = UIColor.gray
        overviewLabel.numberOfLines = 0
        return overviewLabel
    }()
    
    let favoriteButton :UIButton = {
        let favoriteButton = UIButton()
        favoriteButton.translatesAutoresizingMaskIntoConstraints = false
        favoriteButton.setImage(UIImage(imageLiteralResourceName: "star"), for: .normal)
        favoriteButton.setImage(UIImage(imageLiteralResourceName: "star_filled"), for: .selected)
        favoriteButton.backgroundColor = UIColor.white
        favoriteButton.layer.cornerRadius = 20
        favoriteButton.contentEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        return favoriteButton
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        self.layer.cornerRadius = 5
        self.clipsToBounds = true
        
        contentView.addSubview(posterImage)
        contentView.addSubview(titleLabel)
        contentView.addSubview(overviewLabel)
        contentView.addSubview(favoriteButton)
        
        contentView.layer.cornerRadius = 5
        contentView.backgroundColor = UIColor.systemGray5
        contentView.clipsToBounds = true
        
        viewConstraints = [
            favoriteButton.widthAnchor.constraint(equalToConstant: 30),
            favoriteButton.heightAnchor.constraint(equalToConstant: 30),
            favoriteButton.bottomAnchor.constraint(equalTo: contentView.topAnchor, constant: 40),
            favoriteButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            
            posterImage.topAnchor.constraint(equalTo: favoriteButton.topAnchor, constant: 40),
            posterImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            posterImage.heightAnchor.constraint(equalToConstant: 200),
            posterImage.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: posterImage.bottomAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: posterImage.leadingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: posterImage.trailingAnchor, constant: -10),
            
            overviewLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            overviewLabel.leadingAnchor.constraint(equalTo: posterImage.leadingAnchor, constant: 10),
            overviewLabel.trailingAnchor.constraint(equalTo: posterImage.trailingAnchor, constant: -10),
        ]
        
        NSLayoutConstraint.activate(viewConstraints)
    }
    
    public func config(result:ResultVO) {
        
        titleLabel.text = result.title
        overviewLabel.text = result.overview
        
        let urlString = String(format: Paths.poster.rawValue, result.posterPath ?? "")
        print(urlString)
        
        guard let posterUrl = URL(string: urlString) else {
            print("ERROR BAD URL")
            return
        }
        
        self.token = ImageCache.shared.loadImage(posterUrl) { [weak self] result in
            switch(result) {
            case .success(let image):
                DispatchQueue.main.async {
                    self?.posterImage.image = image
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        posterImage.image = nil
        titleLabel.text = nil
        overviewLabel.text = nil
        if let token = token {
            ImageCache.shared.cancelLoad(token)
        }
    }
    
}