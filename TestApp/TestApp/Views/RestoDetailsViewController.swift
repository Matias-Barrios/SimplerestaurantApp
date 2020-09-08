import Foundation
import UIKit
import MapKit


class RestoDetailsViewController: UIViewController, Seteable, MKMapViewDelegate {
    var mainView: UIView = MakeEmptyView(true, .niceorange, true)
    var titlelabel: UILabel = MakeLabel("----")
    let mapView: MKMapView = MKMapView()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view?.backgroundColor = .white
        setup()
        setupConstraints()
    }
    
    convenience init(resto: Resto, coordinates: String) {
        self.init(nibName: nil, bundle: nil)
        self.titlelabel.text = resto.name
        self.titlelabel.font = UIFont.preferredFont(forTextStyle: .title3)
        let coords = coordinates.components(separatedBy: ",")
        let center = CLLocationCoordinate2D(latitude: Double(coords[0])! , longitude: Double(coords[1])! )
        let initialLocation = CLLocation(latitude: center.latitude , longitude: center.longitude)
        mapView.centerToLocation(resto: resto, initialLocation)
        setup()
        setupConstraints()
    }
    
    func setup(){
        self.view.addSubview(mainView)
        self.view.addSubview(mapView)
        mainView.addSubview(titlelabel)
        mapView.backgroundColor = .blue
        mapView.delegate = self
        mapView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setupConstraints(){
        mainView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        mainView.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: 10).isActive = true
        mainView.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -10).isActive = true
        mainView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        titlelabel.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 10).isActive = true
        titlelabel.leftAnchor.constraint(equalTo: mainView.leftAnchor, constant: 10).isActive = true
        titlelabel.rightAnchor.constraint(equalTo: mainView.rightAnchor, constant: -10).isActive = true
        
        mapView.topAnchor.constraint(equalTo: mainView.bottomAnchor, constant: 10).isActive = true
        mapView.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: 10).isActive = true
        mapView.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -10).isActive = true
        mapView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -10).isActive = true
    }
}

private extension MKMapView {
    func centerToLocation(resto: Resto,
    _ location: CLLocation,
    regionRadius: CLLocationDistance = 1000
  ) {
    let coordinateRegion = MKCoordinateRegion(
      center: location.coordinate,
      latitudinalMeters: regionRadius,
      longitudinalMeters: regionRadius)
    setRegion(coordinateRegion, animated: true)
    let annotation = MKPointAnnotation()
    annotation.coordinate = location.coordinate
    annotation.title = resto.name
    annotation.subtitle = resto.address
    addAnnotation(annotation)
  }
}

