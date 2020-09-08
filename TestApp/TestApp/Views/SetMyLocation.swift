import Foundation
import UIKit
import MapKit


class SetMyLocation: UIViewController, Seteable, MKMapViewDelegate {
    var mainView: UIView = MakeEmptyView(true, .niceorange, true)
    var titlelabel: UILabel = MakeLabel("----")
    let mapView: MKMapView = MKMapView()
    var delegate: PListController!
    var doneButton: UIButton = MakeButton("Done!")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view?.backgroundColor = .white
        setup()
        setupConstraints()
    }
    
    convenience init(delegate: PListController) {
        self.init(nibName: nil, bundle: nil)
        self.titlelabel.text = "Set your location by using your fingers!\n You can long press in any place of the map to set your location"
        self.titlelabel.font = UIFont.preferredFont(forTextStyle: .title3)
        self.delegate = delegate
        let initialLocation = CLLocation(latitude: Global.location!.latitude , longitude: Global.location!.longitude)
        mapView.centerToLocation(initialLocation)
        setup()
        setupConstraints()
    }
    
    func setup(){
        self.view.addSubview(mainView)
        mainView.addSubview(mapView)
        mainView.addSubview(titlelabel)
        mainView.addSubview(doneButton)
        doneButton.backgroundColor = .systemTeal
        doneButton.layer.borderWidth = 1
        doneButton.layer.borderColor = UIColor.niceorange.cgColor
        mapView.backgroundColor = .blue
        mapView.delegate = self
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.addGestureRecognizer(UILongPressGestureRecognizer(target: self, action: #selector(LongPressOnMap(_:))))
        doneButton.addTarget(self, action: #selector(ResetDelegate), for: .touchUpInside)
        doneButton.isUserInteractionEnabled = true
    }
    
    func setupConstraints(){
        mainView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        mainView.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor).isActive = true
        mainView.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor).isActive = true
        mainView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        titlelabel.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 10).isActive = true
        titlelabel.leftAnchor.constraint(equalTo: mainView.leftAnchor, constant: 10).isActive = true
        titlelabel.rightAnchor.constraint(equalTo: mainView.rightAnchor, constant: -10).isActive = true
        
        mapView.topAnchor.constraint(equalTo: titlelabel.bottomAnchor, constant: 10).isActive = true
        mapView.leftAnchor.constraint(equalTo: mainView.leftAnchor, constant: 10).isActive = true
        mapView.rightAnchor.constraint(equalTo: mainView.rightAnchor, constant: -10).isActive = true
        mapView.bottomAnchor.constraint(equalTo:  doneButton.topAnchor, constant: -15).isActive = true
        
        doneButton.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: -5).isActive = true
        doneButton.leftAnchor.constraint(equalTo: mainView.leftAnchor, constant: 10).isActive = true
        doneButton.rightAnchor.constraint(equalTo: mainView.rightAnchor, constant: -10).isActive = true
        doneButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
    }
    
    @objc func LongPressOnMap(_ recognizer: UIGestureRecognizer) {
        mapView.removeAnnotations(mapView.annotations)
        let touchedAt = recognizer.location(in: self.mapView) // adds the location on the view it was pressed
        let touchedAtCoordinate : CLLocationCoordinate2D = mapView.convert(touchedAt, toCoordinateFrom: self.mapView)
        mapView.centerToLocation( CLLocation(latitude: touchedAtCoordinate.latitude , longitude: touchedAtCoordinate.longitude))
        Global.location = touchedAtCoordinate
    }
    
    @objc func ResetDelegate(sender: UIButton) {
        print("hola!! ")
        delegate.ResetTable()
        self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
    }
}

private extension MKMapView {
    func centerToLocation(_ location: CLLocation, regionRadius: CLLocationDistance = 1000) {
        let coordinateRegion = MKCoordinateRegion(
          center: location.coordinate,
          latitudinalMeters: regionRadius,
          longitudinalMeters: regionRadius)
        setRegion(coordinateRegion, animated: true)
        let annotation = MKPointAnnotation()
        annotation.coordinate = location.coordinate
        annotation.title = "Set me here!"
        addAnnotation(annotation)
    }
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView?
    {
        let annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "annotationView")
        annotationView.canShowCallout = true
        annotationView.rightCalloutAccessoryView = UIButton.init(type: UIButton.ButtonType.detailDisclosure)
        return annotationView
    }
    func mapView(mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        let center = CLLocation(latitude: mapView.centerCoordinate.latitude , longitude: mapView.centerCoordinate.longitude)
        centerToLocation(center)
    }
}

