//
//  ViewController.swift
//  MKMapViewSample
//
//  Created by RyutaMiyamoto on 2018/06/22.
//  Copyright © 2018 RyutaMiyamoto. All rights reserved.
//

import UIKit

import MapKit

class ViewController: UIViewController, MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    
    let coordinate = CLLocationCoordinate2D(latitude: 35.685175, longitude: 139.7528)
    let locationTitle = "The Imperial Palace"
    
    @IBAction func TapPinButton(_ sender: UIButton) {
        let region = MKCoordinateRegion(center: coordinate,
                                        span: MKCoordinateSpan(latitudeDelta: 0.004, longitudeDelta: 0.004))
        mapView.setRegion(region, animated: true)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        mapView.addAnnotations([annotation])
    }
    
    // MARK: - MKMapViewDelegate
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        ///地図のアノテーション
        let annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "")
        let label = UILabel()
        label.text = locationTitle
        annotationView.detailCalloutAccessoryView = label
        annotationView.canShowCallout = true
        return annotationView
    }
    
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        print("Pin Tap")
    }
}
