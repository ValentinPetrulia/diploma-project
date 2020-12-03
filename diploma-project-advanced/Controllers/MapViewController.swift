//
//  MapViewController.swift
//  diploma-project-advanced
//
//  Created by Валентин Петруля on 7/23/19.
//  Copyright © 2019 Валентин Петруля. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces

class MapViewController: UIViewController {
    
    var user = User()
    var locationManager = CLLocationManager()
    
    @IBOutlet weak var logoutButton: UIButton!
    @IBOutlet weak var profileButton: UIButton!
    @IBOutlet weak var mapView: GMSMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideNavigationBar()
        logoutButton.layer.cornerRadius = 6
        profileButton.layer.cornerRadius = 6
        setCurrentLocation()
    }

    @IBAction func didTapLogoutButton(_ sender: Any) {
        logout()
    }
    
    @IBAction func didTapProfileButton(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
        vc.user = user
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension MapViewController: CLLocationManagerDelegate, GMSMapViewDelegate {
    func setCurrentLocation() {
        mapView.delegate = self
        mapView.isMyLocationEnabled = true
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
        setMarker()
    }
    
    func setMarker() {
        let marker = GMSMarker()
        let markerImage = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        markerImage.image = UIImage(named: "marker")
        marker.iconView = markerImage
        marker.position = CLLocationCoordinate2D(latitude: user.latitude!, longitude: user.longitude!)
        marker.title = ""
        marker.map = mapView
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let camera = GMSCameraPosition.camera(withLatitude: CLLocationDegrees(user.latitude!), longitude: CLLocationDegrees(user.longitude!), zoom: 11.5)
        self.mapView.animate(to: camera)
        self.locationManager.stopUpdatingLocation()
    }
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        let alert = UIAlertController(title: "Do you want to see the news?", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "NewsViewController") as! NewsViewController
            vc.user = self.user
            self.navigationController?.pushViewController(vc, animated: true)
        }))
        self.present(alert, animated: true)
        return true
    }
}
