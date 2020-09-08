import Foundation
import UIKit

class ListController: UIViewController, UITableViewDelegate, UITableViewDataSource, Seteable, UIScrollViewDelegate, PListController{

    var tableView: UITableView!
    var restos: [Resto]? = nil
    let button: UIButton = MakeButton("Change my location")
    var isLoadinginProgress: Bool = false
    let maxPerPage: Int = 20
    var totalCells: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupConstraints()
        LoadData()
    }
    
    func setup(){
        tableView = MakeTableView(self, self, UITableView.Style.plain)
        self.tableView.register(RestaurantTableViewCell.self, forCellReuseIdentifier: String(describing:  RestaurantTableViewCell.self))
        self.view.addSubview(button)
        self.view.addSubview(tableView)
        button.addTarget(self, action: #selector(Navigate(sender:)), for: .touchUpInside)
    }
    
    fileprivate func LoadData() {
        if(isLoadinginProgress && !((restos?.count ?? 0) > totalCells)){
            return
        }
        isLoadinginProgress = true
        HttpRequestor.Get(endpoint: "http://stg-api.pedidosya.com/public/v1/search/restaurants?point=\(Global.location!.latitude),\(Global.location!.longitude)&country=1&max=\(self.maxPerPage)&offset=\(restos?.count ?? 0)",
            headers: ["Authorization" : Global.access_token ?? ""],
            onComplete: {
                (statuscode: Int, res: Result<RestaurantsResponse?, Error>) in
                self.isLoadinginProgress = false
                if (statuscode as Int >= 202) {
                    DispatchQueue.main.async {
                        self.present(
                            AlertGenerator.OkAlert(title: "Something went wrong!",
                                                   message: "We are truly sorry. Please try again in some time.",
                                                   handler: {_ in
                                                    self.navigationController?.popViewController(animated: true)
                            }),
                            animated: true,
                            completion:nil)
                    }
                    return
                }
                switch(res){
                case .success(let data) :
                    DispatchQueue.main.async {
                        if (self.restos != nil){
                            self.restos! += data!.data
                        }
                        else{
                            self.restos = data!.data
                        }
                        self.totalCells = data!.total
                        self.tableView.reloadData()
                    }
                    return
                case .failure(let err):
                    DispatchQueue.main.async {
                        self.present(
                            AlertGenerator.OkAlert(title: "Something went wrong!",
                                                   message: "We are truly sorry. Please try again in some time.",
                                                   handler: {
                                                    _ in
                                                    self.navigationController?.popViewController(animated: true)
                                                    
                            }),
                            animated: true,
                            completion: nil)
                    }
                    return
                }
        })
    }
    func setupConstraints(){
        button.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        button.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor).isActive = true
        button.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor).isActive = true
        button.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        tableView.topAnchor.constraint(equalTo: button.bottomAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restos?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.navigationController?.pushViewController(RestoDetailsViewController(resto: restos![indexPath.row], coordinates: restos![indexPath.row].coordinates), animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: String(describing:  RestaurantTableViewCell.self), for: indexPath) as! RestaurantTableViewCell
        cell.update(title: restos![indexPath.row].name, addresslabel: restos![indexPath.row].address)
        cell.layoutSubviews()
        return cell
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let height =  scrollView.contentSize.height - ( tableView.frame.size.height * 1.10)
        let position = scrollView.contentOffset.y
        if (position > height){
            print("loading! Total : \(restos?.count ?? 0)")
            LoadData()
        }
    }
    
    func ResetTable() {
        if (!isLoadinginProgress){
            restos = nil
            LoadData()
        }
    }
    @objc func Navigate(sender: UIButton) {
        self.navigationController?.pushViewController(SetMyLocation(delegate: self), animated: true)
    }
}

