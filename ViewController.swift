
import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    let locationManager = CLLocationManager()
    var initialRegionSet = false

    override func viewDidLoad() {
    super.viewDidLoad()
    locationManager.delegate = self
    locationManager.desiredAccuracy = kCLLocationAccuracyBest
    locationManager.requestWhenInUseAuthorization()
    }

    override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    locationManager.startUpdatingLocation()
    mapView.showsUserLocation = true
    let location1 = CLLocationCoordinate2D(latitude: 12.9507, longitude: 77.5848)  // Lalbagh
    let location2 = CLLocationCoordinate2D(latitude: 12.9579, longitude: 77.5970)  // Shanti Nagar
    let location3 = CLLocationCoordinate2D(latitude: 12.9794, longitude: 77.5901)  // Vidhana Soudha
               
    addAnnotationToMap(location: location1, title: "Shreya")
    addAnnotationToMap(location: location2, title: "Keerthi")
    addAnnotationToMap(location: location3, title: "Payal")
        
    if !initialRegionSet {
    setMapRegion(center: location1, span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
    initialRegionSet = true
    }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
    if status == .authorizedWhenInUse {
    locationManager.startUpdatingLocation()
    mapView.showsUserLocation = true
    } else {
    print("Location authorization denied or restricted.")
    }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    if let location = locations.first {
        render(location.coordinate, title: "Swathi")
    }
    }

    func render(_ location:CLLocationCoordinate2D, title: String) {
    let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    let region = MKCoordinateRegion(center: location, span: span)
    updateVisibleRegion(with: region)

    let pin = MKPointAnnotation()
    pin.coordinate = location
    pin.title = title
    mapView.addAnnotation(pin)
    }
    
    func addAnnotationToMap(location: CLLocationCoordinate2D, title: String) {
    let annotation = MKPointAnnotation()
    annotation.coordinate = location
    annotation.title = title
    mapView.addAnnotation(annotation)
    }
    
    func setMapRegion(center: CLLocationCoordinate2D, span: MKCoordinateSpan) {
    let region = MKCoordinateRegion(center: center, span: span)
    updateVisibleRegion(with: region)
    }
    
    func updateVisibleRegion(with region: MKCoordinateRegion) {
    let currentRegion = mapView.region
    if region.span.latitudeDelta < currentRegion.span.latitudeDelta
               && region.span.longitudeDelta < currentRegion.span.longitudeDelta {
    mapView.setRegion(region, animated: true)
    }
    }
}

