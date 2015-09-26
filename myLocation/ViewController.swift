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
            if (placemarks.count>0){
                let pm = placemarks[0] as! CLPlacemark
                self.displayLocationInfo(pm)
            }else{
                print("problems with geocoder data", terminator: "")
            }
            
        })
        
        
    }
    
    func displayLocationInfo(placemark: CLPlacemark){
        
        //停止地理信息更新以节省电池
        locationManager.stopUpdatingLocation()
        print(placemark.locality, terminator: "")
        print(placemark.postalCode, terminator: "")
        print(placemark.administrativeArea, terminator: "")
        print(placemark.country, terminator: "")
        print(placemark.addressDictionary, terminator: "")
        
    }
    
    func locationManager(manager: CLLocationManager, didFinishDeferredUpdatesWithError error: NSError?) {
        print(error!.localizedDescription, terminator: "")
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

