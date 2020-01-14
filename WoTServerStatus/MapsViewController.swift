//
//  MapsViewController.swift
//  WoTServerStatus
//
//  Created by Wladyslaw Mostowicz on 13/01/2020.
//  Copyright © 2020 Wladyslaw Mostowicz. All rights reserved.
//

import UIKit
import MapKit

class MapsViewController: UIViewController {

    @IBOutlet weak var map: MKMapView!
    
    @IBAction func showWotEu1OnMap(_ sender: Any)
    {
        let location = CLLocationCoordinate2D(latitude: 48.1548256, longitude: 11.4017533)
        let span = MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
        let region = MKCoordinateRegion(center: location, span: span)
        self.map.setRegion(region, animated: true)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate.latitude = location.latitude
        annotation.coordinate.longitude = location.longitude
        annotation.title = "WoT EU1: Munchen, Germany"
        self.map.addAnnotation(annotation)
    }
    
    @IBAction func showWotEu2OnMap(_ sender: Any)
    {
        let location = CLLocationCoordinate2D(latitude: 52.3545362, longitude: 4.7638786)
        let span = MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
        let region = MKCoordinateRegion(center: location, span: span)
        self.map.setRegion(region, animated: true)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate.latitude = location.latitude
        annotation.coordinate.longitude = location.longitude
        annotation.title = "WoT EU2: Amsterdam, Nederlands"
        self.map.addAnnotation(annotation)
    }
    
    @IBAction func showWotbEuOnMap(_ sender: Any)
    {
        let location = CLLocationCoordinate2D(latitude: 49.6075838, longitude: 6.0658306)
        let span = MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
        let region = MKCoordinateRegion(center: location, span: span)
        self.map.setRegion(region, animated: true)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate.latitude = location.latitude
        annotation.coordinate.longitude = location.longitude
        annotation.title = "WoTB EU: Luxembourg"
        self.map.addAnnotation(annotation)
    }
    
    @IBAction func showWowsEuOnMap(_ sender: Any)
    {
        let location = CLLocationCoordinate2D(latitude: 49.6074838, longitude: 6.0658306)
        let span = MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
        let region = MKCoordinateRegion(center: location, span: span)
        self.map.setRegion(region, animated: true)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate.latitude = location.latitude
        annotation.coordinate.longitude = location.longitude
        annotation.title = "WoWS EU: Luxembourg"
        self.map.addAnnotation(annotation)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func getBackAction(_ sender: Any)
    {
        dismiss(animated: true, completion: nil)
    }

}
