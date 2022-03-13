//
//  MapViewController.swift
//  LocalFood
//
//  Created by Eryk Chrustek on 21/11/2021.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MapRoutingLogicDelegate {

    // MARK: Properties
    var interactor: MapBusinessLogic?
    var router: MapRouting?

    // MARK: Subviews
    private var mapView = MKMapView()
    private var popup = UIView()
    private var titleLabel = UILabel()
    private var descriptionLabel = UILabel()
    private var openButton = UIButton()
    private var deliveryStatus = DeliveryStatus()
    
    private var mapPlaces: [MapPlace]?
    private var selectedPlace: MapPlace?
    private var lastPolyline: MKPolyline?
    
    private let locationManager = CLLocationManager()

    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        prepareContent()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        checkOrderStatus()
    }
}

// MARK: MapDisplayLogic
extension MapViewController: MapDisplayLogic {
    func displayContent(viewModel: Map.Content.ViewModel) {
        mapPlaces = viewModel.places
        viewModel.places.forEach {
            titleLabel.text = $0.name
            descriptionLabel.text = $0.category.name
            addAnnotation(latitude: $0.latitude, longitude: $0.longitude)
        }
    }
    
    func displayDeliveryStatus(viewModel: Map.DuringDelivery.ViewModel) {
        popup.alpha = 0
        deliveryStatus.setup(status: viewModel.status, placeName: viewModel.place.name, cost: viewModel.cost, time: viewModel.deliveryTime)
        deliveryStatus.alpha = 1
    }
}

// MARK: MKMapViewDelegate
extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        UIView.animate(withDuration: 0.2) {
            self.popup.alpha = 1
        }
        
        guard let coordinate = view.annotation?.coordinate else { return }
        selectedPlace = mapPlaces?.first(where: { $0.latitude == coordinate.latitude && $0.longitude == coordinate.longitude })
        centerView(with: coordinate)
        Orders.shared.selectedPlace = selectedPlace
        makePolyline()
    }

    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let over = MKPolylineRenderer(overlay: overlay)
        over.strokeColor = UIColor(named: "primary")
        over.lineWidth = 6
        return over
    }
}

// MARK: Actions
private extension MapViewController {
    func prepareContent() {
        interactor?.prepareContent(request: .init())
    }
    
    func checkOrderStatus() {
        interactor?.prepareDeliveryStatus(request: .init())
    }
    
    @objc private func openButtonTapped() {
        router?.routeToPlace()
    }
    
    @objc func appMovedToBackground() {
        checkOrderStatus()
    }
}

// MARK: Private
private extension MapViewController {
    func setup() {
        setupMapView()
        setupPopup()
        setupPopupElements()
        setupHidePopup()
        setupDeliveryStatusView()
        
        setupLocationManager()
        setupBackButton()
        setupAppMovedToBackground()
    }
    
    func setupLocationManager() {
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.startUpdatingLocation()
        
        mapView.showsUserLocation = true
    }

    func setupMapView() {
        view.backgroundColor = UIColor(named: "white")
        view.addSubview(mapView)
        mapView.delegate = self
        mapView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.topAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    func setupPopup() {
        view.addSubview(popup)
        popup.translatesAutoresizingMaskIntoConstraints = false
        popup.backgroundColor = UIColor(named: "white")
        popup.layer.cornerRadius = 15
        popup.layer.shadowColor = UIColor(named: "black")?.cgColor
        popup.layer.shadowOpacity = 0.5
        popup.layer.shadowOffset = .zero
        popup.layer.shadowRadius = 45
        popup.alpha = 0

        NSLayoutConstraint.activate([
            popup.topAnchor.constraint(greaterThanOrEqualTo: view.topAnchor, constant: 16),
            popup.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            popup.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            popup.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    func setupPopupElements() {
        [titleLabel, descriptionLabel, openButton].forEach {
            popup.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }

        setupTitileLabel()
        setupDescriptionLabel()
        setupOpenButton()
    }

    func setupTitileLabel() {
        titleLabel.font = UIFont.systemFont(ofSize: 25.0, weight: .bold)
        titleLabel.textColor = UIColor(named: "black")
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: popup.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: popup.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: popup.trailingAnchor, constant: -16)
        ])
    }

    func setupDescriptionLabel() {
        descriptionLabel.font = UIFont.systemFont(ofSize: 18.0, weight: .semibold)
        descriptionLabel.textColor = UIColor(named: "darkGray")

        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            descriptionLabel.leadingAnchor.constraint(equalTo: popup.leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: popup.trailingAnchor, constant: -16)
        ])
    }

    func setupOpenButton() {
        openButton.setupPrimaryView(with: "Otwórz")
        openButton.addTarget(self, action: #selector(openButtonTapped), for: .touchUpInside)

        NSLayoutConstraint.activate([
            openButton.heightAnchor.constraint(equalToConstant: 50),
            openButton.topAnchor.constraint(greaterThanOrEqualTo: descriptionLabel.bottomAnchor, constant: 16),
            openButton.leadingAnchor.constraint(equalTo: popup.leadingAnchor, constant: 16),
            openButton.trailingAnchor.constraint(equalTo: popup.trailingAnchor, constant: -16),
            openButton.bottomAnchor.constraint(equalTo: popup.bottomAnchor, constant: -40)
        ])
    }
    
    func setupDeliveryStatusView() {
        view.addSubview(deliveryStatus)
        deliveryStatus.translatesAutoresizingMaskIntoConstraints = false
        deliveryStatus.alpha = 0

        NSLayoutConstraint.activate([
            deliveryStatus.heightAnchor.constraint(equalToConstant: 230),
            deliveryStatus.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            deliveryStatus.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            deliveryStatus.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func setupAppMovedToBackground() {
        NotificationCenter.default.addObserver(self, selector: #selector(appMovedToBackground), name: UIApplication.willResignActiveNotification, object: nil)
    }
    
    func setupHidePopup() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hidePopup))
        mapView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc private func hidePopup() {
        UIView.animate(withDuration: 0.2) {
            self.popup.alpha = 0
            guard let lastPolyline = self.lastPolyline else { return }
            self.mapView.removeOverlay(lastPolyline)
        }
    }
}

// MARK: Setup MapView
private extension MapViewController {
    func centerView(with coordinates: CLLocationCoordinate2D) {
        let coordinateRegion = MKCoordinateRegion.init(
            center: coordinates,
            latitudinalMeters: 3000,
            longitudinalMeters: 3000)

        mapView.setRegion(coordinateRegion, animated: true)
    }

    func addAnnotation(latitude: Double, longitude: Double) {
        let coordinates = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let userLocation = UserLocationAnnotation(coordinate: coordinates)
        mapView.addAnnotation(userLocation)
        centerView(with: coordinates)
    }
    
    func makePolyline() {
        let request = MKDirections.Request()
        let sourcePlacemark = MKPlacemark(coordinate: .init(
            latitude: selectedPlace?.latitude ?? 0.0,
            longitude: selectedPlace?.longitude ?? 0.0))
        let destinationPlacemark = MKPlacemark(coordinate: .init(
            latitude: locationManager.location?.coordinate.latitude ?? 0.0,
            longitude: locationManager.location?.coordinate.longitude ?? 0.0))
        
        request.source = MKMapItem(placemark: sourcePlacemark)
        request.destination = MKMapItem(placemark: destinationPlacemark)

        let directions = MKDirections(request: request)
        directions.calculate { response, error in
            if let polyline = response?.routes[0].polyline {
                let coordinateRegion = MKCoordinateRegion.init(
                    center: polyline.coordinate,
                    latitudinalMeters: 3000,
                    longitudinalMeters: 3000)
                self.mapView.addOverlay(polyline)
                self.mapView.setRegion(coordinateRegion, animated: true)
                self.lastPolyline = polyline
                
                let distance = response?.routes[0].distance
                let time = response?.routes[0].expectedTravelTime

                Orders.shared.polyline = polyline
                Orders.shared.distance = distance
                Orders.shared.time = (time ?? 0.0) / 60 + 15
            }
        }
    }
}
