//
//  ViewController.swift
//  IndoorBeacon
//
//  Created by hsin0202 on 2017/1/4.
//  Copyright © 2017年 hsin0202. All rights reserved.
//

import UIKit

class ViewController: UIViewController, ESTBeaconManagerDelegate {
    
    @IBOutlet weak var MajorLabel: UILabel!
    @IBOutlet weak var MinorLabel: UILabel!
    @IBOutlet weak var RSSILabel: UILabel!
    @IBOutlet weak var AccuracyLabel: UILabel!
    @IBOutlet weak var myImageView: UIImageView!
    @IBOutlet weak var SecImageView: UIImageView!
    
    let beaconManager = ESTBeaconManager()
    let beaconRegion = CLBeaconRegion(proximityUUID: UUID(uuidString: "B9407F30-F5F8-466E-AFF9-25556B57FE6D")!, identifier: "estimote")
    
    func startRangingBeacons() {
        beaconManager.requestWhenInUseAuthorization()
        beaconManager.startRangingBeacons(in: self.beaconRegion)
    }
    
    func beaconManager(_ manager: Any, didRangeBeacons beacons: [CLBeacon],in region: CLBeaconRegion) {
        
        //let sortedBeacons = beacons.filter{ $0.accuracy > 0.0 }.sorted{ $0.accuracy < $1.accuracy }
        let sortedBeacons = beacons.filter(){ $0.accuracy > 0.0 }.sorted(){ $0.accuracy < $1.accuracy }
        if let nearest = sortedBeacons.first {
            
            RSSILabel.text  = "RSSI  = \(nearest.rssi)"
            MajorLabel.text = "Major = \(nearest.major.int32Value)"
            MinorLabel.text = "Minor = \(nearest.minor.int32Value)"
            AccuracyLabel.text = "Accuracy = \(Float(nearest.accuracy)) m"
            
            if nearest.major.int32Value == 58791{
                myImageView.image = #imageLiteral(resourceName: "Dog")
            }else if nearest.major.int32Value == 44057{
                SecImageView.image = #imageLiteral(resourceName: "Fox")
            }else{
                myImageView.image = #imageLiteral(resourceName: "Apple")
                SecImageView.image = #imageLiteral(resourceName: "Apple")
            }
      
        }
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.beaconManager.delegate = self
        self.beaconManager.requestAlwaysAuthorization()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.beaconManager.startRangingBeacons(in: self.beaconRegion)
        //print("will")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.beaconManager.stopRangingBeacons(in: self.beaconRegion)
    }

}

