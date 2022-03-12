//
//  ReceiptViewController.swift
//  LocalFood
//
//  Created by Eryk Chrustek on 12/12/2021.
//

import UIKit
import MapKit

final class ReceiptViewController: UIViewController, ReceiptRoutingLogicDelegate {

    // MARK: Properties
    var interactor: ReceiptBusinessLogic?
    var router: ReceiptRouting?

    // MARK: Subviews
    private var titleLabel = UILabel()
    private var descriptionLabel = UILabel()
    private var mapView = MKMapView()
    private var tableView = UITableView()

    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        prepareContent()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setDarkBarStyle()
    }
}

// MARK: Private
private extension ReceiptViewController {
    private func setup() {
        view.backgroundColor = UIColor(named: "white")
        setupTitleLabel()
        setupTableView()
    }
    
    private func setupMapView() {
        view.addSubview(mapView)
        mapView.delegate = self
        mapView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.topAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }

    private func setupTitleLabel() {
        view.addSubview(titleLabel)
        titleLabel.text = "Shoppig Cart"
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont.systemFont(ofSize: 25.0, weight: .bold)

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
        ])
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func centerView(with coordinates: CLLocationCoordinate2D) {
        let coordinateRegion = MKCoordinateRegion.init(
            center: coordinates,
            latitudinalMeters: 1000000,
            longitudinalMeters: 1000000)

        mapView.setRegion(coordinateRegion, animated: true)
    }

    private func addAnnotation(latitude: Double, longitude: Double) {
        let coordinates = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let userLocation = UserLocationAnnotation(coordinate: coordinates)
        mapView.addAnnotation(userLocation)
        centerView(with: coordinates)
    }

    private func prepareContent() {
        let request = Receipt.Content.Request()
        interactor?.prepareContent(request: request)
    }
}

// MARK: ReceiptDisplayLogic
extension ReceiptViewController: ReceiptDisplayLogic {
    func displayContent(viewModel: Receipt.Content.ViewModel) {
        DispatchQueue.main.async {

        }
    }
}

// MARK: MKMapViewDelegate
extension ReceiptViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
//        popup.isHidden = false
        
//        self.selectedAnnotation = view.annotation as? MKPointAnnotation


//        self.parent.name = view.annotation?.title! ?? "No name"
//        let z = realm.objects(Shop.self).filter(("name CONTAINS[cd] %@"), self.parent.name)
//        self.parent.parentOrder = z[0]


//        self.parent.destination = (selectedAnnotation?.coordinate)!

//        let decoder = CLGeocoder()
//        decoder.reverseGeocodeLocation(CLLocation(latitude: self.parent.source.latitude, longitude: self.parent.source.longitude)) { (places, err) in
//
//            if err != nil {
//
//                print((err?.localizedDescription)!)
//                return
//            }
//
//            self.parent.show = true
//            self.parent.userAddress = String("\((places?.first?.areasOfInterest)!)")
//
//
//        }

//        let req = MKDirections.Request()
//        req.source = MKMapItem(placemark: MKPlacemark(coordinate: self.parent.source))
//        req.destination = MKMapItem(placemark: MKPlacemark(coordinate: (selectedAnnotation?.coordinate)!))

//        let directions = MKDirections(request: req)
//        directions.calculate { (dir, err) in
//
//            if err != nil {
//
//                print((err?.localizedDescription)!)
//                return
//            }
//
//            let polyline = dir?.routes[0].polyline
//
//            let dis = Double((dir?.routes[0].distance)!)
//            self.parent.distance = String(format: "%.2f", dis / 1000)
//
//            let time = Double((dir?.routes[0].expectedTravelTime)!)
//            self.parent.time = String(format: "%.0f", time / 60)
//
//            self.parent.map.removeOverlays(self.parent.map.overlays)
//            self.parent.map.addOverlay(polyline!)
//            self.parent.map.setRegion(MKCoordinateRegion(polyline!.boundingMapRect), animated: true)
//
//        }
    }

    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let over = MKPolylineRenderer(overlay: overlay)
        over.strokeColor = UIColor(named: "primary")
        over.lineWidth = 6
        return over
    }

//    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
//        guard let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "AnnotationIdentifier") else {
//            return MKAnnotationView(annotation: annotation, reuseIdentifier: "AnnotationIdentifier")
//        }
//
//        annotationView.annotation = annotation
//        annotationView.image = UIImage(systemName: "mappin.and.ellipse")
//        return annotationView
//    }
}


// MARK: UITableViewDelegate
extension ReceiptViewController: UITableViewDelegate {

}

// MARK: UITableViewDataSource
extension ReceiptViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
