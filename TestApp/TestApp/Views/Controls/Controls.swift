import Foundation
import UIKit



let MakeLabel: (String) -> UILabel = { (txt) in
    let label = UILabel()
    label.numberOfLines = 0
    label.translatesAutoresizingMaskIntoConstraints = false
    label.lineBreakMode = .byWordWrapping
    label.text = txt
    return label
}

let MakeImageView: (String) -> UIImageView = { (assetname) in
    let image = UIImageView()
    image.image = UIImage(named: assetname)
    image.translatesAutoresizingMaskIntoConstraints = false
    image.contentMode = .scaleAspectFit
    return image
}

let MakeTextField: () -> UITextField = {
    let txt = UITextField()
    txt.translatesAutoresizingMaskIntoConstraints = false
    txt.layer.borderColor = UIColor.saphire.cgColor
    txt.layer.borderWidth = 1
    return txt
}

let MakeButton: (String) -> UIButton = { (txt) in
    let button = UIButton()
    button.setTitle(txt, for: .normal)
    button.backgroundColor = .niceorange
    button.layer.borderColor = CGColor(srgbRed: 200, green: 200, blue: 200, alpha: 1)
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
}

let MakeTableView: (_ datasource : UITableViewDataSource?, _ delegate : UITableViewDelegate?, _ style: UITableView.Style) -> UITableView = {
    (_ datasource : UITableViewDataSource?, _ delegate : UITableViewDelegate?, _ style: UITableView.Style) -> UITableView in
    let table = UITableView(frame: .zero, style: style)
    table.dataSource = datasource
    table.delegate = delegate
    table.translatesAutoresizingMaskIntoConstraints = false
    table.allowsSelection = true
    table.separatorStyle = .none
    return table
}

let MakeEmptyView: (Bool, UIColor, Bool) -> UIView = {
    (border: Bool, color: UIColor, borderradius: Bool) in
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    if border {
        view.layer.borderWidth = 1
        view.layer.borderColor = color.cgColor
    }
    if borderradius {
        view.layer.cornerRadius = 10
    }
    view.backgroundColor = .white
    return view
}

let appimages: [UIImage] = [
    UIImage(imageLiteralResourceName: "campana"),
    UIImage(imageLiteralResourceName: "limon"),
    UIImage(imageLiteralResourceName: "sandia"),
    UIImage(imageLiteralResourceName: "naranja"),
    UIImage(imageLiteralResourceName: "ciruela"),
    UIImage(imageLiteralResourceName: "herradura")
]

let MakeRandomThumbnail: () -> UIImage = {
    return appimages.randomElement()!
}


