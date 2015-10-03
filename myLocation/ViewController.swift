//
//  ViewController.swift
//  myLocation
//
//  Created by 张子名 on 9/17/15.
//  Copyright (c) 2015 tingdao. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController,CLLocationManagerDelegate {

    @IBOutlet weak var myLocation: UITextField!
    @IBOutlet weak var locatonButton: UIButton!
    @IBOutlet weak var location1: UITextField!
    @IBOutlet weak var location2: UITextField!
    @IBOutlet weak var location3: UITextField!
    

    
    let locationManager:CLLocationManager = CLLocationManager()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    @IBAction func getMyLocation(sender: AnyObject) {
        //将class设置为locationManager的代理、细化定位精确度、开始接受来自corelocation的数据更新
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
   

    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        CLGeocoder().reverseGeocodeLocation(manager.location!, completionHandler: {(placemarks, error)->Void in
            if (error != nil) {
                print(error, terminator: "")
                return
            }
            if let pm = placemarks?.first {
                self.displayLocationInfo(pm)
            }else{
                print("problems with geocoder data", terminator: "")
            }
            
        })
        
        
    }
    
    func displayLocationInfo(placemark: CLPlacemark){
        
        //停止地理信息更新以节省电池
        let containsPlacemark = placemark
        locationManager.stopUpdatingLocation()
        let locality = (containsPlacemark.locality != nil) ? containsPlacemark.locality : ""
        let postalCode = (containsPlacemark.postalCode != nil) ? containsPlacemark.postalCode : ""
        let administrativeArea = (containsPlacemark.administrativeArea != nil) ? containsPlacemark.administrativeArea : ""
        let country = (containsPlacemark.country != nil) ? containsPlacemark.country : ""
        myLocation.text = administrativeArea
        location1.text = locality
        location2.text = postalCode
        location3.text = country
        
    }
    
    func locationManager(manager: CLLocationManager, didFinishDeferredUpdatesWithError error: NSError?) {
        print(error!.localizedDescription, terminator: "")
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

