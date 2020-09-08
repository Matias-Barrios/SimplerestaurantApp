import UIKit
import CoreLocation

class MainController: UIViewController, Seteable, CLLocationManagerDelegate{
    
    let mainLogo: UIImageView = MakeImageView("app_logo")
    let usernameLabel: UILabel = MakeLabel("Username")
    let userpasswordLabel: UILabel = MakeLabel("Password")
    let usernametextField: UITextField = MakeTextField()
    let userpasswordtextField: UITextField = MakeTextField()
    let button: UIButton = MakeButton("Login")
    let locationManager = CLLocationManager()


    override func viewDidLoad() {
        super.viewDidLoad()
        self.view?.backgroundColor = .white
        setup()
        setupConstraints()
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        button.isEnabled = false
    }
    
    func setup(){
        self.view.addSubview(mainLogo)
        self.view.addSubview(usernameLabel)
        self.view.addSubview(userpasswordLabel)
        self.view.addSubview(userpasswordtextField)
        self.view.addSubview(usernametextField)
        self.view.addSubview(button)
        button.addTarget(self, action: #selector(Login), for: .touchUpInside)
    }
    
    func setupConstraints(){
        mainLogo.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        mainLogo.widthAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.45).isActive = true
        mainLogo.heightAnchor.constraint(equalTo: mainLogo.widthAnchor).isActive = true
        mainLogo.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true

        usernameLabel.centerXAnchor.constraint(equalTo: mainLogo.centerXAnchor).isActive = true
        usernameLabel.topAnchor.constraint(equalTo: mainLogo.bottomAnchor, constant: 9).isActive = true

        usernametextField.centerXAnchor.constraint(equalTo: mainLogo.centerXAnchor).isActive = true
        usernametextField.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 9).isActive = true
        usernametextField.widthAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.45).isActive = true

        userpasswordLabel.centerXAnchor.constraint(equalTo: mainLogo.centerXAnchor).isActive = true
        userpasswordLabel.topAnchor.constraint(equalTo: usernametextField.bottomAnchor, constant: 9).isActive = true
        
        userpasswordtextField.centerXAnchor.constraint(equalTo: mainLogo.centerXAnchor).isActive = true
        userpasswordtextField.topAnchor.constraint(equalTo: userpasswordLabel.bottomAnchor, constant: 9).isActive = true
        userpasswordtextField.widthAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.45).isActive = true
        
        button.centerXAnchor.constraint(equalTo: mainLogo.centerXAnchor).isActive = true
        button.topAnchor.constraint(equalTo: userpasswordtextField.bottomAnchor, constant: 20).isActive = true
        button.widthAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.45).isActive = true
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        Global.location = locValue
        button.isEnabled = true
    }
    
    @objc func Login(sender: UIButton) {
        guard let username = usernametextField.text, let password = userpasswordtextField.text else {
            return
        }
        HttpRequestor.Get(endpoint: "http://stg-api.pedidosya.com/public/v1/tokens?clientId=\(username)&clientSecret=\(password)",
            onComplete: {
                (statuscode: Int, res: Result<TokenResponse?, Error>) in
                if (statuscode as Int >= 202) {
                    DispatchQueue.main.async {
                      self.present(
                        AlertGenerator.OkAlert(
                        title: "Your credentials are not ok buddy",
                        message: "It seems you are trying commit a hack attempt at level 1 : 'Begginner'",
                        handler: {_ in}),
                        animated: true,
                        completion: nil)
                    }
                    return
                }
                switch(res){
                case .success(let data) :
                        Global.access_token = data!.access_token
                        DispatchQueue.main.async {
                            self.navigationController?.pushViewController(ListController(), animated: true)
                        }
                        return
                case .failure(let err):
                        DispatchQueue.main.async {
                          self.present(
                            AlertGenerator.OkAlert(title: "Something went wrong!",
                                                  message: "We are truly sorry. Please try again in some time.",
                                                  handler: {_ in}),
                                                  animated: true,
                                                  completion: nil)
                        }
                        return
                }
                
        })
    }
}

