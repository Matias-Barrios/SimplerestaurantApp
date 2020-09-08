import Foundation
import UIKit

class RestaurantTableViewCell:  UITableViewCell, Seteable {
    let mainView: UIView = MakeEmptyView(true, .niceorange, true)
    let titleLabel: UILabel = MakeLabel("--------")
    let addressLabel: UILabel = MakeLabel("--------")
    var thumbnail: UIImageView = MakeImageView("campana")

    
    required init?(coder aDecoder: NSCoder) {
        return nil
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
        setupConstraints()
    }
    
    func setup() {
        self.addSubview(mainView)
        mainView.addSubview(titleLabel)
        mainView.addSubview(addressLabel)
        mainView.addSubview(thumbnail)
        titleLabel.font = UIFont.preferredFont(forTextStyle: .title3)
        addressLabel.font = UIFont.preferredFont(forTextStyle: .footnote)
    }
    
    func setupConstraints() {
        mainView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        mainView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true
        mainView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        mainView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true
        
        titleLabel.centerXAnchor.constraint(equalTo: mainView.centerXAnchor).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: mainView.leftAnchor, constant: 7).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: mainView.rightAnchor, constant: -2).isActive = true

        addressLabel.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: -5).isActive = true
        addressLabel.leftAnchor.constraint(equalTo: mainView.leftAnchor, constant: 7).isActive = true
        addressLabel.rightAnchor.constraint(equalTo: thumbnail.leftAnchor, constant: -2).isActive = true
        
        thumbnail.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: -5).isActive = true
        thumbnail.heightAnchor.constraint(equalTo: mainView.heightAnchor, multiplier: 0.5).isActive = true
        thumbnail.widthAnchor.constraint(equalTo: thumbnail.heightAnchor).isActive = true
        thumbnail.rightAnchor.constraint(equalTo: mainView.rightAnchor, constant: -2).isActive = true
    }
    
    func update(title: String = "", addresslabel: String) {
        titleLabel.text = title
        addressLabel.text = addresslabel
        thumbnail.image = MakeRandomThumbnail()
    }
}
