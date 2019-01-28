//
//  ViewController.swift
//  ibeacon
//
//  Created by ESD 21 on 2018/5/8.
//  Copyright © 2018年 ESD 21. All rights reserved.
//

import UIKit
import CoreLocation
import Surge


class ViewController: UIViewController,CLLocationManagerDelegate {
    
    //let uuid = "E7D2D9FB-9554-4682-AA1B-08A762C1221E"
    let uuid = "8C38EF3C-32D9-4DFD-A86B-865E2C5A192C"
    let identfier = "ED region"
    //let newDate = Date()
    let time = (60/3)*2
    //var rssi_data = [[String:Any]]()
    var i = 0
    var j1 = 0
    var j2 = 0
    var j3 = 0
    var j4 = 0
    var sum_rssi1 = 0
    var sum_rssi2 = 0
    var sum_rssi3 = 0
    var sum_rssi4 = 0
    var mean1 = -40.0
    var mean2 = -40.0
    var mean3 = -40.0
    var mean4 = -40.0
    var mean5 = -40.0
    var mean6 = -40.0
    var mean7 = -40.0
    var mean8 = -40.0

    var D1 = 0.0
    var D2 = 0.0
    var D3 = 0.0
    var D4 = 0.0
    var D5 = 0.0
    var D6 = 0.0
    var D7 = 0.0
    var D8 = 0.0
    
    var length = 8.0
    
    var RSSI0_1 = -53.2     //50
    var RSSI0_2 = -56.6     //55
    var RSSI0_3 = -57.25
    var RSSI0_4 = -59.5
    var RSSI0_5 = -50.28
    var RSSI0_6 = -54.25
    var RSSI0_7 = -57.125
    var RSSI0_8 = -56.6
    var Grm = 2.0
    var Grm_tmp = 1.5
    
    var Q = Matrix<Double>([[0.0, 0.0]])
    var Q_mean = Matrix<Double>([[0.0, 0.0]])
    var LocateD = ""
    var ibeacon1 = [Int]()
    var ibeacon2 = [Int]()
    var ibeacon3 = [Int]()
    var ibeacon4 = [Int]()
    var ibeacon5 = [Int]()
    var ibeacon6 = [Int]()
    var ibeacon7 = [Int]()
    var ibeacon8 = [Int]()
    
    var location1 = [0.0,0.0]
    var location2 = [2.6,2.67]
    var location3 = [6.6,2.67]
    var location4 = [10.5,2.67]
    var location5 = [13.5,2.67]
    var location6 = [15.1,0.0]
    var location7 = [17.5,0.0]
    var location8 = [16.9,3.9]
    
    var SelectedLocate1 = [0.0,0.0]
    var SelectedLocate2 = [10.5,2.67]
    var SelectedLocate3 = [6.6,2.67]
    var SelectedLocate4 = [2.6,2.67]
    var SelectedD1 = 3.0
    var SelectedD2 = 4.0
    var SelectedD3 = 5.0
    var SelectedD4 = 6.0
    
//    let P1
//    let P2
//    let P3
//    let matrixD
//    let matrix_DT
//    let matrix_b
//    let temp1
//    let temp2
//    let temp3
//    let Q
    
    @IBOutlet weak var monitorResultTextView: UITextView!
    @IBOutlet weak var rangingResultTextView: UITextView!
    @IBOutlet weak var rssiResultTextView: UITextView!
    @IBOutlet weak var rssiResultTextView1: UITextView!
    @IBOutlet weak var rssiResultTextView2: UITextView!
    @IBOutlet weak var rssiResultTextView3: UITextView!
    
    @IBOutlet weak var rssi0_1: UITextField!
    @IBOutlet weak var rssi0_2: UITextField!
    @IBOutlet weak var rssi0_3: UITextField!
    @IBOutlet weak var rssi0_4: UITextField!
    @IBOutlet weak var rssi0_5: UITextField!
    @IBOutlet weak var rssi0_6: UITextField!
    @IBOutlet weak var rssi0_7: UITextField!
    @IBOutlet weak var rssi0_8: UITextField!
    
    @IBOutlet weak var rssi0_1LabelView: UILabel!
    @IBOutlet weak var rssi0_2LabelView: UILabel!
    @IBOutlet weak var rssi0_3LabelView: UILabel!
    @IBOutlet weak var rssi0_4LabelView: UILabel!
    
    @IBOutlet weak var SelectedPointLabelView1: UITextField!
    @IBOutlet weak var SelectedPointLabelView2: UITextField!
    @IBOutlet weak var SelectedPointLabelView3: UITextField!
    @IBOutlet weak var SelectedPointLabelView4: UITextField!
    
    @IBAction func SceneButton1(_ sender: Any) {
        SelectedLocate1 = location1
        SelectedD1 = D1
        SelectedLocate2 = location2
        SelectedD2 = D2
        SelectedLocate3 = location3
        SelectedD3 = D3
        SelectedLocate4 = location4
        SelectedD4 = D4
        length = 8.0
        
        Q = computelocation(refx: SelectedLocate1[0], refy: SelectedLocate1[1], refD1: SelectedD1, D1: SelectedD2, D2: SelectedD3, D3: SelectedD4 , x1: SelectedLocate2[0], y1: SelectedLocate2[1], x2: SelectedLocate3[0], y2: SelectedLocate3[1], x3: SelectedLocate4[0], y3: SelectedLocate4[1])
        Q_mean = Q
        rssiResultTextView.text = rssiResultTextView.text + "\n location: " + "\(Q)"
        
        Q = computelocation(refx: SelectedLocate2[0], refy: SelectedLocate2[1], refD1: SelectedD2, D1: SelectedD1, D2: SelectedD3, D3: SelectedD4 , x1: SelectedLocate1[0], y1: SelectedLocate1[1], x2: SelectedLocate3[0], y2: SelectedLocate3[1], x3: SelectedLocate4[0], y3: SelectedLocate4[1])
        Q_mean = Q_mean + Q
        rssiResultTextView1.text = rssiResultTextView1.text + "\n location: " + "\(Q)"
        
        Q = computelocation(refx: SelectedLocate3[0], refy: SelectedLocate3[1], refD1: SelectedD3, D1: SelectedD1, D2: SelectedD2, D3: SelectedD4 , x1: SelectedLocate1[0], y1: SelectedLocate1[1], x2: SelectedLocate2[0], y2: SelectedLocate2[1], x3: SelectedLocate4[0], y3: SelectedLocate4[1])
        Q_mean = Q_mean + Q
        rssiResultTextView2.text = rssiResultTextView2.text + "\n location: " + "\(Q)"
        
        Q = computelocation(refx: SelectedLocate4[0], refy: SelectedLocate4[1], refD1: SelectedD4, D1: SelectedD1, D2: SelectedD2, D3: SelectedD3 , x1: SelectedLocate1[0], y1: SelectedLocate1[1], x2: SelectedLocate2[0], y2: SelectedLocate2[1], x3: SelectedLocate3[0], y3: SelectedLocate3[1])
        Q_mean = Q_mean + Q
        rssiResultTextView3.text = rssiResultTextView3.text + "\n location: " + "\(Q)"
        
        ibeacon1 = [Int]()
        ibeacon2 = [Int]()
        ibeacon3 = [Int]()
        ibeacon4 = [Int]()
        ibeacon5 = [Int]()
        ibeacon6 = [Int]()
        ibeacon7 = [Int]()
        ibeacon8 = [Int]()
        i = 0
        Q_mean = Matrix<Double>([[0.0, 0.0]])
    }
    
    @IBAction func SceneButton2(_ sender: Any) {
        SelectedLocate1 = location3
        SelectedD1 = D3
        SelectedLocate2 = location4
        SelectedD2 = D4
        SelectedLocate3 = location5
        SelectedD3 = D5
        SelectedLocate4 = location6
        SelectedD4 = D6
        length = 5.0
        
        Q = computelocation(refx: SelectedLocate1[0], refy: SelectedLocate1[1], refD1: SelectedD1, D1: SelectedD2, D2: SelectedD3, D3: SelectedD4 , x1: SelectedLocate2[0], y1: SelectedLocate2[1], x2: SelectedLocate3[0], y2: SelectedLocate3[1], x3: SelectedLocate4[0], y3: SelectedLocate4[1])
        Q_mean = Q
        rssiResultTextView.text = rssiResultTextView.text + "\n location: " + "\(Q)"
        
        Q = computelocation(refx: SelectedLocate2[0], refy: SelectedLocate2[1], refD1: SelectedD2, D1: SelectedD1, D2: SelectedD3, D3: SelectedD4 , x1: SelectedLocate1[0], y1: SelectedLocate1[1], x2: SelectedLocate3[0], y2: SelectedLocate3[1], x3: SelectedLocate4[0], y3: SelectedLocate4[1])
        Q_mean = Q_mean + Q
        rssiResultTextView1.text = rssiResultTextView1.text + "\n location: " + "\(Q)"
        
        Q = computelocation(refx: SelectedLocate3[0], refy: SelectedLocate3[1], refD1: SelectedD3, D1: SelectedD1, D2: SelectedD2, D3: SelectedD4 , x1: SelectedLocate1[0], y1: SelectedLocate1[1], x2: SelectedLocate2[0], y2: SelectedLocate2[1], x3: SelectedLocate4[0], y3: SelectedLocate4[1])
        Q_mean = Q_mean + Q
        rssiResultTextView2.text = rssiResultTextView2.text + "\n location: " + "\(Q)"
        
        Q = computelocation(refx: SelectedLocate4[0], refy: SelectedLocate4[1], refD1: SelectedD4, D1: SelectedD1, D2: SelectedD2, D3: SelectedD3 , x1: SelectedLocate1[0], y1: SelectedLocate1[1], x2: SelectedLocate2[0], y2: SelectedLocate2[1], x3: SelectedLocate3[0], y3: SelectedLocate3[1])
        Q_mean = Q_mean + Q
        rssiResultTextView3.text = rssiResultTextView3.text + "\n location: " + "\(Q)"
        
        ibeacon1 = [Int]()
        ibeacon2 = [Int]()
        ibeacon3 = [Int]()
        ibeacon4 = [Int]()
        ibeacon5 = [Int]()
        ibeacon6 = [Int]()
        ibeacon7 = [Int]()
        ibeacon8 = [Int]()
        i = 0
        Q_mean = Matrix<Double>([[0.0, 0.0]])
    }
    
    @IBAction func SceneButton3(_ sender: Any) {
        SelectedLocate1 = location5
        SelectedD1 = D5
        SelectedLocate2 = location6
        SelectedD2 = D6
        SelectedLocate3 = location7
        SelectedD3 = D7
        SelectedLocate4 = location8
        SelectedD4 = D8
        length = 4.0
        
        Q = computelocation(refx: SelectedLocate1[0], refy: SelectedLocate1[1], refD1: SelectedD1, D1: SelectedD2, D2: SelectedD3, D3: SelectedD4 , x1: SelectedLocate2[0], y1: SelectedLocate2[1], x2: SelectedLocate3[0], y2: SelectedLocate3[1], x3: SelectedLocate4[0], y3: SelectedLocate4[1])
        Q_mean = Q
        rssiResultTextView.text = rssiResultTextView.text + "\n location: " + "\(Q)"
        
        Q = computelocation(refx: SelectedLocate2[0], refy: SelectedLocate2[1], refD1: SelectedD2, D1: SelectedD1, D2: SelectedD3, D3: SelectedD4 , x1: SelectedLocate1[0], y1: SelectedLocate1[1], x2: SelectedLocate3[0], y2: SelectedLocate3[1], x3: SelectedLocate4[0], y3: SelectedLocate4[1])
        Q_mean = Q_mean + Q
        rssiResultTextView1.text = rssiResultTextView1.text + "\n location: " + "\(Q)"
        
        Q = computelocation(refx: SelectedLocate3[0], refy: SelectedLocate3[1], refD1: SelectedD3, D1: SelectedD1, D2: SelectedD2, D3: SelectedD4 , x1: SelectedLocate1[0], y1: SelectedLocate1[1], x2: SelectedLocate2[0], y2: SelectedLocate2[1], x3: SelectedLocate4[0], y3: SelectedLocate4[1])
        Q_mean = Q_mean + Q
        rssiResultTextView2.text = rssiResultTextView2.text + "\n location: " + "\(Q)"
        
        Q = computelocation(refx: SelectedLocate4[0], refy: SelectedLocate4[1], refD1: SelectedD4, D1: SelectedD1, D2: SelectedD2, D3: SelectedD3 , x1: SelectedLocate1[0], y1: SelectedLocate1[1], x2: SelectedLocate2[0], y2: SelectedLocate2[1], x3: SelectedLocate3[0], y3: SelectedLocate3[1])
        Q_mean = Q_mean + Q
        rssiResultTextView3.text = rssiResultTextView3.text + "\n location: " + "\(Q)"
        
        ibeacon1 = [Int]()
        ibeacon2 = [Int]()
        ibeacon3 = [Int]()
        ibeacon4 = [Int]()
        ibeacon5 = [Int]()
        ibeacon6 = [Int]()
        ibeacon7 = [Int]()
        ibeacon8 = [Int]()
        i = 0
        Q_mean = Matrix<Double>([[0.0, 0.0]])
    }
    
    @IBAction func SelectedPointsButton(_ sender: Any) {
        switch Int(SelectedPointLabelView1.text!) {
        case 1:
            SelectedLocate1 = location1
            SelectedD1 = D1
        case 2:
            SelectedLocate1 = location2
            SelectedD1 = D2
        case 3:
            SelectedLocate1 = location3
            SelectedD1 = D3
        case 4:
            SelectedLocate1 = location4
            SelectedD1 = D4
        case 5:
            SelectedLocate1 = location5
            SelectedD1 = D5
        case 6:
            SelectedLocate1 = location6
            SelectedD1 = D6
        case 7:
            SelectedLocate1 = location7
            SelectedD1 = D7
        case 8:
            SelectedLocate1 = location8
            SelectedD1 = D8
        default:
            print("error")
        }

        switch Int(SelectedPointLabelView2.text!) {
        case 1:
            SelectedLocate2 = location1
            SelectedD2 = D1
        case 2:
            SelectedLocate2 = location2
            SelectedD2 = D2
        case 3:
            SelectedLocate2 = location3
            SelectedD2 = D3
        case 4:
            SelectedLocate2 = location4
            SelectedD2 = D4
        case 5:
            SelectedLocate2 = location5
            SelectedD2 = D5
        case 6:
            SelectedLocate2 = location6
            SelectedD2 = D6
        case 7:
            SelectedLocate2 = location7
            SelectedD2 = D7
        case 8:
            SelectedLocate2 = location8
            SelectedD2 = D8
        default:
            print("error")
        }

        switch Int(SelectedPointLabelView3.text!) {
        case 1:
            SelectedLocate3 = location1
            SelectedD3 = D1
        case 2:
            SelectedLocate3 = location2
            SelectedD3 = D2
        case 3:
            SelectedLocate3 = location3
            SelectedD3 = D3
        case 4:
            SelectedLocate3 = location4
            SelectedD3 = D4
        case 5:
            SelectedLocate3 = location5
            SelectedD3 = D5
        case 6:
            SelectedLocate3 = location6
            SelectedD3 = D6
        case 7:
            SelectedLocate3 = location7
            SelectedD3 = D7
        case 8:
            SelectedLocate3 = location8
            SelectedD3 = D8
        default:
            print("error")
        }

        switch Int(SelectedPointLabelView4.text!) {
        case 1:
            SelectedLocate4 = location1
            SelectedD4 = D1
        case 2:
            SelectedLocate4 = location2
            SelectedD4 = D2
        case 3:
            SelectedLocate4 = location3
            SelectedD4 = D3
        case 4:
            SelectedLocate4 = location4
            SelectedD4 = D4
        case 5:
            SelectedLocate4 = location5
            SelectedD4 = D5
        case 6:
            SelectedLocate4 = location6
            SelectedD4 = D6
        case 7:
            SelectedLocate4 = location7
            SelectedD4 = D7
        case 8:
            SelectedLocate4 = location8
            SelectedD4 = D8
        default:
            print("error")
        }
        
//        switch Int(SelectedPointLabelView1.text!) {
//        case 1:
//            SelectedLocate1 = location1
//            SelectedD1 = D1
//            SelectedLocate2 = location2
//            SelectedD2 = D2
//            SelectedLocate3 = location3
//            SelectedD3 = D3
//            SelectedLocate4 = location4
//            SelectedD4 = D4
//            length = 8.0
//        case 2:
//            SelectedLocate1 = location3
//            SelectedD1 = D3
//            SelectedLocate2 = location4
//            SelectedD2 = D4
//            SelectedLocate3 = location5
//            SelectedD3 = D5
//            SelectedLocate4 = location6
//            SelectedD4 = D6
//            length = 5.0
//        case 3:
//            SelectedLocate1 = location5
//            SelectedD1 = D5
//            SelectedLocate2 = location6
//            SelectedD2 = D6
//            SelectedLocate3 = location7
//            SelectedD3 = D7
//            SelectedLocate4 = location8
//            SelectedD4 = D8
//            length = 4.0
//        case 4:
//            SelectedLocate1 = location4
//            SelectedD1 = D4
//        case 5:
//            SelectedLocate1 = location5
//            SelectedD1 = D5
//        case 6:
//            SelectedLocate1 = location6
//            SelectedD1 = D6
//        case 7:
//            SelectedLocate1 = location7
//            SelectedD1 = D7
//        case 8:
//            SelectedLocate1 = location8
//            SelectedD1 = D8
//        default:
//            print("error")
//        }

        ibeacon1 = [Int]()
        ibeacon2 = [Int]()
        ibeacon3 = [Int]()
        ibeacon4 = [Int]()
        ibeacon5 = [Int]()
        ibeacon6 = [Int]()
        ibeacon7 = [Int]()
        ibeacon8 = [Int]()
        i = 0
        Q_mean = Matrix<Double>([[0.0, 0.0]])
    }
    

    @IBAction func ButtonPressed(_ sender: Any) {
        
        if ((Double(rssi0_1.text!)!<0) && (Double(rssi0_2.text!)!<0)
            && (Double(rssi0_3.text!)!<0) && (Double(rssi0_4.text!)!<0)){
            rssi0_1LabelView.text = ""
            rssi0_2LabelView.text = ""
            rssi0_3LabelView.text = ""
            rssi0_4LabelView.text = ""
            
            RSSI0_1 = Double(rssi0_1.text!)!
            RSSI0_2 = Double(rssi0_2.text!)!
            RSSI0_3 = Double(rssi0_3.text!)!
            RSSI0_4 = Double(rssi0_4.text!)!
            RSSI0_5 = Double(rssi0_5.text!)!
            RSSI0_6 = Double(rssi0_6.text!)!
            RSSI0_7 = Double(rssi0_7.text!)!
            RSSI0_8 = Double(rssi0_8.text!)!
            
            rssi0_1LabelView.text = "1stRSSI0=" + " \(RSSI0_1)"
            rssi0_2LabelView.text = "2ndRSSI0=" + " \(RSSI0_2)"
            rssi0_3LabelView.text = "3rdRSSI0=" + " \(RSSI0_3)"
            rssi0_4LabelView.text = "4thRSSI0=" + " \(RSSI0_4)"
            
            rssi0_1.text = "\(RSSI0_1)"
            rssi0_2.text = "\(RSSI0_2)"
            rssi0_3.text = "\(RSSI0_3)"
            rssi0_4.text = "\(RSSI0_4)"
            rssi0_5.text = "\(RSSI0_5)"
            rssi0_6.text = "\(RSSI0_6)"
            rssi0_7.text = "\(RSSI0_7)"
            rssi0_8.text = "\(RSSI0_8)"
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didStartMonitoringFor region:
        CLRegion) {
        //      monitor   region   identifier     monitor textview
        monitorResultTextView.text = "did start monitoring \(region.identifier)\n" +
            monitorResultTextView.text
    }
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        //       region        monitor textview
        monitorResultTextView.text = "did enter\n" + monitorResultTextView.text
    }
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        //       region        monitor textview
        monitorResultTextView.text = "did exit\n" + monitorResultTextView.text
    }
    func locationManager(_ manager: CLLocationManager, didDetermineState state:  CLRegionState, for region: CLRegion) {
        switch state {
        case .inside:
            monitorResultTextView.text = "state inside\n" + monitorResultTextView.text
            
            if CLLocationManager.isRangingAvailable(){
                manager.startRangingBeacons(in: region as! CLBeaconRegion)
            }
            
            //      region         monitor textview
            monitorResultTextView.text = "state inside\n" + monitorResultTextView.text
        case .outside:
            //      region         monitor textview
            monitorResultTextView.text = "state outside\n" + monitorResultTextView.text
            manager.stopMonitoring(for: region)
        default:
            break
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //var matrix: Matrix<Double> = Matrix<Double>([[1, 2,], [5, 6]])
        //let matrix2 = Matrix<Double>([[2, 3], [6, 7]])
        //print("\(elmul(matrix, y: matrix2))")
        //print("\(mul(matrix, y: matrix2))")
        //Matrix<Double>([[2, 6, 12, 20], [30, 42, 56, 72], [90, 110, 132, 156]]
        
        rssi0_1.text = "\(RSSI0_1)"
        rssi0_2.text = "\(RSSI0_2)"
        rssi0_3.text = "\(RSSI0_3)"
        rssi0_4.text = "\(RSSI0_4)"
        rssi0_5.text = "\(RSSI0_5)"
        rssi0_6.text = "\(RSSI0_6)"
        rssi0_7.text = "\(RSSI0_7)"
        rssi0_8.text = "\(RSSI0_8)"
        
        rssi0_1LabelView.text = rssi0_1LabelView.text! + "\(RSSI0_1)"
        rssi0_2LabelView.text = rssi0_2LabelView.text! + "\(RSSI0_2)"
        rssi0_3LabelView.text = rssi0_3LabelView.text! + "\(RSSI0_3)"
        rssi0_4LabelView.text = rssi0_4LabelView.text! + "\(RSSI0_4)"
        
        if CLLocationManager.isMonitoringAvailable(for: CLBeaconRegion.self){
            if CLLocationManager.authorizationStatus() !=
                CLAuthorizationStatus.authorizedAlways
            {
                locationManager.requestAlwaysAuthorization()
            }
        }
        let region = CLBeaconRegion(proximityUUID: UUID.init(uuidString:
            uuid)!, identifier: identfier)
        
        //   locaiton manager   delegate
        locationManager.delegate = self
        //  region monitoring
        region.notifyEntryStateOnDisplay = true
        region.notifyOnEntry = true
        region.notifyOnExit = true
        //   monitoring
        locationManager.startMonitoring(for: region)
        
    }
    var locationManager: CLLocationManager = CLLocationManager()
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

//    func computelocation(refx: Double, refy: Double, refD1: Double, D1: Double, D2: Double, D3: Double, D4: Double, D5: Double, D6: Double ,D7: Double ,x1:Double, y1: Double, x2: Double, y2: Double, x3: Double, y3: Double,x4:Double, y4: Double,x5:Double, y5: Double,x6:Double, y6: Double, x7:Double, y7: Double)-> Matrix<Double> {
//
//        let P1 = pow(refx, 2.0)-pow(x1, 2.0)+pow(refy, 2.0)-pow(y1, 2.0)-pow(refD1, 2.0)+pow(D1, 2.0)
//        let P2 = pow(refx, 2.0)-pow(x2, 2.0)+pow(refy, 2.0)-pow(y2, 2.0)-pow(refD1, 2.0)+pow(D2, 2.0)
//        let P3 = pow(refx, 2.0)-pow(x3, 2.0)+pow(refy, 2.0)-pow(y3, 2.0)-pow(refD1, 2.0)+pow(D3, 2.0)
//        let P4 = pow(refx, 2.0)-pow(x4, 2.0)+pow(refy, 2.0)-pow(y4, 2.0)-pow(refD1, 2.0)+pow(D4, 2.0)
//        let P5 = pow(refx, 2.0)-pow(x5, 2.0)+pow(refy, 2.0)-pow(y5, 2.0)-pow(refD1, 2.0)+pow(D5, 2.0)
//        let P6 = pow(refx, 2.0)-pow(x6, 2.0)+pow(refy, 2.0)-pow(y6, 2.0)-pow(refD1, 2.0)+pow(D6, 2.0)
//        let P7 = pow(refx, 2.0)-pow(x7, 2.0)+pow(refy, 2.0)-pow(y7, 2.0)-pow(refD1, 2.0)+pow(D7, 2.0)
//        let matrixD = Matrix<Double>([[ 2*(refx-x1), 2*(refy-y1)],[2*(refx-x2), 2*(refy-y2)],[2*(refx-x3), 2*(refy-y3)],[2*(refx-x4), 2*(refy-y4)],[2*(refx-x5), 2*(refy-y5)],[2*(refx-x6), 2*(refy-y6)],[2*(refx-x7), 2*(refy-y7)]])
//        let matrix_DT = transpose(matrixD)
//        let matrix_b = Matrix<Double>([[P1],[P2],[P3],[P4],[P5],[P6],[P7]])
//        let temp1 = mul(matrix_DT, y: matrixD)
//        let temp2 =  inv(temp1)
//        let temp3 = mul(temp2, y: matrix_DT)
//        let Q = mul(temp3, y: matrix_b)
//        return Q
//    }
    
    func computelocation(refx: Double, refy: Double, refD1: Double, D1: Double, D2: Double, D3: Double,x1:Double, y1: Double, x2: Double, y2: Double, x3: Double, y3: Double)-> Matrix<Double> {
        
        let P1 = pow(refx, 2.0)-pow(x1, 2.0)+pow(refy, 2.0)-pow(y1, 2.0)-pow(refD1, 2.0)+pow(D1, 2.0)
        let P2 = pow(refx, 2.0)-pow(x2, 2.0)+pow(refy, 2.0)-pow(y2, 2.0)-pow(refD1, 2.0)+pow(D2, 2.0)
        let P3 = pow(refx, 2.0)-pow(x3, 2.0)+pow(refy, 2.0)-pow(y3, 2.0)-pow(refD1, 2.0)+pow(D3, 2.0)
        let matrixD = Matrix<Double>([[ 2*(refx-x1), 2*(refy-y1)],[2*(refx-x2), 2*(refy-y2)],[2*(refx-x3), 2*(refy-y3)]])
        let matrix_DT = transpose(matrixD)
        let matrix_b = Matrix<Double>([[P1],[P2],[P3]])
        let temp1 = mul(matrix_DT, y: matrixD)
        let temp2 =  inv(temp1)
        let temp3 = mul(temp2, y: matrix_DT)
        let Q = mul(temp3, y: matrix_b)
        return Q
    }
    
    func DistrictDetection(y: Double) -> String {
        if y < 2.67{
            return("Distric C")
        }
        else if (y > 2.67 && y < 7.21){
            return("Distric B")
        }
        else if (y > 7.21){ //&& y < 11.75){
            return("Distric A")
        }
        else{
            return("Detect Fail")
        }
    }
    
    func total(x: Array<Int>) -> Double {
        var a = 0.0
        for i in x{
            a = a + Double(i)
        }
        return a/Double(x.count)
    }
    
    func locationManager(_ manager: CLLocationManager, didRangeBeacons beacons:
        [CLBeacon], in region: CLBeaconRegion) {
        //ranging textview
        rangingResultTextView.text = ""
        //rssiResultTextView.text = ""
        //let orderdBeaconArray = beacons.sorted(by: { (b1, b2) -> Bool in return b1.minor > b2.minor })
        //iterate       beacon
        //var i = 0
        
        for beacon in beacons {
            //     proximity      proximityString
            //var ibeacon_num = 0
            //switch ibeacon_num{
            //case ibeacon_num = 0:
                
            //case ibeacon_num = 1:
            //case ibeacon_num = 2:
            //}
            
            if (beacon.major == 2){
            var proximityString = ""
            //i = i + 1
            switch beacon.proximity {
            case .far:
                proximityString = "far"
            case .near:
                proximityString = "near"
            case .immediate:
                proximityString = "immediate"
            default :
                proximityString = "unknow"
            }
            //   beacon     ranging textview
            rangingResultTextView.text = rangingResultTextView.text + "Major: \(beacon.major)"
            rangingResultTextView.text = rangingResultTextView.text + ", Minor: \(beacon.minor)"
            rangingResultTextView.text = rangingResultTextView.text + ", RSSI: \(beacon.rssi)"
            rangingResultTextView.text = rangingResultTextView.text + ", Proximity: \(proximityString)"
            rangingResultTextView.text = rangingResultTextView.text + ", Accuracy: \(beacon.accuracy)" + "\n\n";
            
            //rssi_data.append(["\(beacon.minor)": beacon.rssi,"date": newDate])
            
                if (beacon.rssi != 0){
                    switch beacon.minor{
                    case 1:
                        ibeacon1.append(beacon.rssi)
                        sum_rssi1 = sum_rssi1 + (beacon.rssi)
                        //mean1 = Double(beacon.rssi)
                        i = i + 1
                        //j1 = j1 + 1
                    case 2:
                        ibeacon2.append(beacon.rssi)
                        //sum_rssi2 = sum_rssi2 + (beacon.rssi)
                        //mean2 = Double(beacon.rssi)
                        i = i + 1
                        //j2 = j2 + 1
                    case 3:
                        ibeacon3.append(beacon.rssi)
                        //sum_rssi3 = sum_rssi3 + (beacon.rssi)
                        //mean3 = Double(beacon.rssi)
                        i = i + 1
                        //j3 = j3 + 1
                    case 4:
                        ibeacon4.append(beacon.rssi)
                        //sum_rssi4 = sum_rssi4 + (beacon.rssi)
                        //mean4 = Double(beacon.rssi)
                        i = i + 1
                        //j4 = j4 + 1
                    case 5:
                        ibeacon5.append(beacon.rssi)
                        //sum_rssi5 = sum_rssi5 + (beacon.rssi)
                        //mean4 = Double(beacon.rssi)
                        i = i + 1
                        //j5 = j5 + 1
                    case 6:
                        ibeacon6.append(beacon.rssi)
                        //sum_rssi6 = sum_rssi6 + (beacon.rssi)
                        //mean4 = Double(beacon.rssi)
                        i = i + 1
                        //j4 = j4 + 1
                    case 7:
                        ibeacon7.append(beacon.rssi)
                        //sum_rssi7 = sum_rssi7 + (beacon.rssi)
                        //mean4 = Double(beacon.rssi)
                        i = i + 1
                        //j4 = j4 + 1
                    case 8:
                        ibeacon8.append(beacon.rssi)
                        //sum_rssi8 = sum_rssi4 + (beacon.rssi)
                        //mean4 = Double(beacon.rssi)
                        i = i + 1
                        //j4 = j4 + 1
                        
                    default:
                        print("i = ", i)
                        //break
                        //j1 = 1
                        //j2 = 1
                        //j3 = 1
                        //j4 = 1
                    }
                }
            }
        }
        if (i > time){
            monitorResultTextView.text = ""
            rssiResultTextView.text = ""
            rssiResultTextView1.text = ""
            rssiResultTextView2.text = ""
            rssiResultTextView3.text = ""
            
            if (ibeacon1.count > 2){
                var ibeacon1_sorted = ibeacon1.sorted()
                ibeacon1_sorted = Array(ibeacon1_sorted[1...(ibeacon1_sorted.count-2)])
                mean1 = total(x: ibeacon1_sorted)
                monitorResultTextView.text = monitorResultTextView.text + "mean1: " + "\(mean1)"
                D1 = pow(10, ((RSSI0_1-mean1)/(10*Grm)))//10^((RSSI0-mean1)/(10*Grm))
                if (mean1 < -68){
                    D1 = pow(10, ((RSSI0_1-mean1)/(10*Grm_tmp)))
                }
                if (D1 > length){
                    D1 = length
                }
                monitorResultTextView.text = monitorResultTextView.text + ",D1: " + "\(D1)" + "\n"
            }
            if (ibeacon2.count > 2){
                var ibeacon2_sorted = ibeacon2.sorted()
                ibeacon2_sorted = Array(ibeacon2_sorted[1...(ibeacon2_sorted.count-2)])
                mean2 = total(x: ibeacon2_sorted)
                monitorResultTextView.text = monitorResultTextView.text + "mean2: " + "\(mean2)"
                D2 = pow(10, ((RSSI0_2-mean2)/(10*Grm)))//10^((RSSI0-mean1)/(10*Grm))
                if (mean2 < -68){
                    D2 = pow(10, ((RSSI0_2-mean2)/(10*Grm_tmp)))
                }
                if (D2 > length){
                    D2 = length
                }
                monitorResultTextView.text = monitorResultTextView.text + ",D2: " + "\(D2)" + "\n"
            }
            if (ibeacon3.count > 2){
                var ibeacon3_sorted = ibeacon3.sorted()
                ibeacon3_sorted = Array(ibeacon3_sorted[1...(ibeacon3_sorted.count-2)])
                mean3 = total(x: ibeacon3_sorted)
                monitorResultTextView.text = monitorResultTextView.text + "mean3: " + "\(mean3)"
                D3 = pow(10, ((RSSI0_3-mean3)/(10*Grm)))//10^((RSSI0-mean1)/(10*Grm))
                if (mean3 < -68){
                    D3 = pow(10, ((RSSI0_3-mean3)/(10*Grm_tmp)))
                }
                if (D3 > length){
                    D3 = length
                }
                monitorResultTextView.text = monitorResultTextView.text + ",D3: " + "\(D3)" + "\n"
            }
            if (ibeacon4.count > 2){
                var ibeacon4_sorted = ibeacon4.sorted()
                ibeacon4_sorted = Array(ibeacon4_sorted[1...(ibeacon4_sorted.count-2)])
                mean4 = total(x: ibeacon4_sorted)
                monitorResultTextView.text = monitorResultTextView.text + "mean4: " + "\(mean4)"
                D4 = pow(10, ((RSSI0_4-mean4)/(10*Grm)))//10^((RSSI0-mean1)/(10*Grm))
                if (mean4 < -68){
                    D4 = pow(10, ((RSSI0_4-mean4)/(10*Grm_tmp)))
                }
                if (D4 > length){
                    D4 = length
                }
                monitorResultTextView.text = monitorResultTextView.text + ",D4: " + "\(D4)" + "\n"
            }
            if (ibeacon5.count > 2){
                var ibeacon5_sorted = ibeacon5.sorted()
                ibeacon5_sorted = Array(ibeacon5_sorted[1...(ibeacon5_sorted.count-2)])
                mean5 = total(x: ibeacon5_sorted)
                monitorResultTextView.text = monitorResultTextView.text + "mean5: " + "\(mean5)"
                D5 = pow(10, ((RSSI0_5-mean5)/(10*Grm)))//10^((RSSI0-mean1)/(10*Grm))
                if (mean5 < -68){
                    D5 = pow(10, ((RSSI0_5-mean5)/(10*Grm_tmp)))
                }
                if (D5 > length){
                    D5 = length
                }
                monitorResultTextView.text = monitorResultTextView.text + ",D5: " + "\(D5)" + "\n"
            }
            if (ibeacon6.count > 2){
                var ibeacon6_sorted = ibeacon6.sorted()
                ibeacon6_sorted = Array(ibeacon6_sorted[1...(ibeacon6_sorted.count-2)])
                mean6 = total(x: ibeacon6_sorted)
                monitorResultTextView.text = monitorResultTextView.text + "mean6: " + "\(mean6)"
                D6 = pow(10, ((RSSI0_6-mean6)/(10*Grm)))//10^((RSSI0-mean1)/(10*Grm))
                if (mean6 < -68){
                    D6 = pow(10, ((RSSI0_6-mean6)/(10*Grm_tmp)))
                }
                if (D6 > length){
                    D6 = length
                }
                monitorResultTextView.text = monitorResultTextView.text + ",D6: " + "\(D6)" + "\n"
            }
            if (ibeacon7.count > 2){
                var ibeacon7_sorted = ibeacon7.sorted()
                ibeacon7_sorted = Array(ibeacon7_sorted[1...(ibeacon7_sorted.count-2)])
                mean7 = total(x: ibeacon7_sorted)
                monitorResultTextView.text = monitorResultTextView.text + "mean7: " + "\(mean7)"
                D7 = pow(10, ((RSSI0_7-mean7)/(10*Grm)))//10^((RSSI0-mean1)/(10*Grm))
                if (mean7 < -68){
                    D7 = pow(10, ((RSSI0_7-mean7)/(10*Grm_tmp)))
                }
                if (D7 > length){
                    D7 = length
                }
                monitorResultTextView.text = monitorResultTextView.text + ",D7: " + "\(D7)" + "\n"
            }
            if (ibeacon8.count > 2){
                var ibeacon8_sorted = ibeacon8.sorted()
                ibeacon8_sorted = Array(ibeacon8_sorted[1...(ibeacon8_sorted.count-2)])
                mean8 = total(x: ibeacon8_sorted)
                monitorResultTextView.text = monitorResultTextView.text + "mean8: " + "\(mean8)"
                D8 = pow(10, ((RSSI0_8-mean8)/(10*Grm)))//10^((RSSI0-mean1)/(10*Grm))
                if (mean8 < -68){
                    D8 = pow(10, ((RSSI0_8-mean8)/(10*Grm_tmp)))
                }
                if (D8 > length){
                    D8 = length
                }
                monitorResultTextView.text = monitorResultTextView.text + ",D8: " + "\(D8)" + "\n"
            }

//            if (j1 >= 1){
//            rssiResultTextView.text = rssiResultTextView.text + "mean1: " + "\(sum_rssi1/j1)" + "\n\n"
//            mean1 = Double(sum_rssi1/j1)
//            }
//            if (j2 >= 1){
//            rssiResultTextView.text = rssiResultTextView.text + "mean2: " + "\(sum_rssi2/j2)" + "\n\n"
//            mean2 = Double(sum_rssi2/j2)
//            }
//            if (j3 >= 1){
//            rssiResultTextView.text = rssiResultTextView.text + "mean3: " + "\(sum_rssi3/j3)" + "\n\n"
//            mean3 = Double(sum_rssi3/j3)
//            }
//            if (j4 >= 1){
//            rssiResultTextView.text = rssiResultTextView.text + "mean4: " + "\(sum_rssi4/j4)" + "\n\n"
//            mean4 = Double(sum_rssi4/j4)
//            }

            
//            rssiResultTextView.text = rssiResultTextView.text + "distance: " + "\n\(D1)" + "\n\(D2)" + "\n\(D3)" + "\n\(D4)" + "\n\(D5)" + "\n\(D6)" + "\n\(D7)" + "\n\(D8)\n"
            
//            P1 = pow(4.3, 2.0)-pow(2.64, 2.0)+pow(7.8, 2.0)-pow(11.75, 2.0)-pow(D2, 2.0)+pow(D1, 2.0)
//            P2 = pow(4.3, 2.0)-pow(4.3, 2.0)+pow(7.8, 2.0)-pow(5.7, 2.0)-pow(D2, 2.0)+pow(D3, 2.0)
//            P3 = pow(4.3, 2.0)-pow(2.21, 2.0)+pow(7.8, 2.0)-pow(0, 2.0)-pow(D2, 2.0)+pow(D4, 2.0)
//            matrixD = Matrix<Double>([[ 2*(4.3-2.64), 2*(7.8-11.75)],[2*(4.3-4.3), 2*(7.8-5.7)],[2*(4.3-2.21), 2*(7.8-0)]])
//            matrix_DT = transpose(matrixD)
//            matrix_b = Matrix<Double>([[P1],[P2],[P3]])
//            temp1 = mul(matrix_DT, y: matrixD)
//            temp2 =  inv(temp1)
//            temp3 = mul(temp2, y: matrix_DT)
            
//            // beacon 1 be the reference point
//            Q = computelocation(refx: SelectedLocate1[0], refy: SelectedLocate1[1], refD1: SelectedD1, D1: SelectedD2, D2: SelectedD3, D3: SelectedD4 , x1: SelectedLocate2[0], y1: SelectedLocate2[1], x2: SelectedLocate3[0], y2: SelectedLocate3[1], x3: SelectedLocate4[0], y3: SelectedLocate4[1])
//            Q_mean = Q
//            rssiResultTextView.text = rssiResultTextView.text + "\n location: " + "\(Q)"
//            //rssiResultTextView.text = rssiResultTextView.text + DistrictDetection(y: Q[0,1])
//
//            // beacon 2 be...
//            Q = computelocation(refx: SelectedLocate2[0], refy: SelectedLocate2[1], refD1: SelectedD2, D1: SelectedD1, D2: SelectedD3, D3: SelectedD4 , x1: SelectedLocate1[0], y1: SelectedLocate1[1], x2: SelectedLocate3[0], y2: SelectedLocate3[1], x3: SelectedLocate4[0], y3: SelectedLocate4[1])
//            //Q_mean = Q_mean + Q
//            rssiResultTextView1.text = rssiResultTextView1.text + "\n location: " + "\(Q)"
//            //rssiResultTextView1.text = rssiResultTextView1.text + DistrictDetection(y: Q[0,1])
//            // beacon 3 be...
//            Q = computelocation(refx: SelectedLocate3[0], refy: SelectedLocate3[1], refD1: SelectedD3, D1: SelectedD1, D2: SelectedD2, D3: SelectedD4 , x1: SelectedLocate1[0], y1: SelectedLocate1[1], x2: SelectedLocate2[0], y2: SelectedLocate2[1], x3: SelectedLocate4[0], y3: SelectedLocate4[1])
//            //Q_mean = Q_mean + Q
//            rssiResultTextView2.text = rssiResultTextView2.text + "\n location: " + "\(Q)"
//            //rssiResultTextView2.text = rssiResultTextView2.text + DistrictDetection(y: Q[0,1])
//            // beacon 4 be...
//            Q = computelocation(refx: SelectedLocate4[0], refy: SelectedLocate4[1], refD1: SelectedD4, D1: SelectedD1, D2: SelectedD2, D3: SelectedD3 , x1: SelectedLocate1[0], y1: SelectedLocate1[1], x2: SelectedLocate2[0], y2: SelectedLocate2[1], x3: SelectedLocate3[0], y3: SelectedLocate3[1])
//            //Q_mean = Q_mean + Q
//            rssiResultTextView3.text = rssiResultTextView3.text + "\n location: " + "\(Q)"
//            //rssiResultTextView3.text = rssiResultTextView3.text + DistrictDetection(y: Q[0,1])
//            //monitorResultTextView.text = monitorResultTextView.text + "\n\n mean location: " + "\(Q_mean/4)"
            
            if (i > time ){
                i = 0
                ibeacon1 = Array()
                ibeacon2 = Array()
                ibeacon3 = Array()
                ibeacon4 = Array()
                ibeacon5 = Array()
                ibeacon6 = Array()
                ibeacon7 = Array()
                ibeacon8 = Array()
                Q_mean = Matrix<Double>([[0.0, 0.0]])
//                j1 = 0
//                j2 = 0
//                j3 = 0
//                j4 = 0
//                sum_rssi1 = 0
//                sum_rssi2 = 0
//                sum_rssi3 = 0
//                sum_rssi4 = 0
            }
            //mul(mul(inv(mul(matrix_DT, y: matrixD)),matrix_DT),matrix_b)
            //var matrix_Q = Matrix<Double>([])
            //((4.3)^2)-((2.64)^^2)+((7.8)^^2)-((11.75)^^2)-(D2^^2)+(D1^^2)
            //var matrix2 = Matrix<Float>([[ 1,2,3]])
            //rssiResultTextView.text = ""
        }
        
//        if (i > time){
//            rssiResultTextView.text = ""
//            for t in rssi_data{
//                if (Int(beacon.minor) == 0){
//                    rssiResultTextView.text = rssiResultTextView.text + "\(t["\(beacon.minor)"])" + "\n"
//                    var rssi_t = t["\(beacon.minor)"] as? Int
//                    if (rssi_t) == nil{
//                        continue
//                    }
//                    else{
//                        j1 = j1 + 1
//                        sum_rssi1 = sum_rssi1 + (rssi_t)!
//                    }
//                }
//                if (Int(beacon.minor) == 1){
//                    rssiResultTextView.text = rssiResultTextView.text + "\(t["\(beacon.minor)"])" + "\n"
//                    var rssi_t = t["\(beacon.minor)"] as? Int
//                    if (rssi_t) == nil{
//                        continue
//                    }
//                    else{
//                        j2 = j2 + 1
//                        sum_rssi2 = sum_rssi2 + (rssi_t)!
//                    }
//                }
//                if (Int(beacon.minor) == 2){
//                    rssiResultTextView.text = rssiResultTextView.text + "\(t["\(beacon.minor)"])" + "\n"
//                    var rssi_t = t["\(beacon.minor)"] as? Int
//                    if (rssi_t) == nil{
//                        continue
//                    }
//                    else{
//                        j3 = j3 + 1
//                        sum_rssi3 = sum_rssi3 + (rssi_t)!
//                    }
//                }
//            }
//            rssi_data = [[String:Any]]()
//            //i = 0
//        }
//        if (i > time){
//            rssiResultTextView.text = rssiResultTextView.text + "mean1: " + "\(sum_rssi1/j1)" + "\n\n"
//            rssiResultTextView.text = rssiResultTextView.text + "mean2: " + "\(sum_rssi2/j2)" + "\n\n"
//            rssiResultTextView.text = rssiResultTextView.text + "mean3: " + "\(sum_rssi3/j2)" + "\n\n"
//            i = 0
//        }
        //if (Int(beacon.minor) == 1){
            //rssiResultTextView.text = rssiResultTextView.text + "mean2: " + "\(sum_rssi2/j2)" + "\n\n"
        //}
        //if (Int(beacon.minor) == 2){
            //rssiResultTextView.text = rssiResultTextView.text + "mean3: " + "\(sum_rssi3/j3)" + "\n\n"
        //}
    }
    
//    func writeStringToFile(writeString:String, fileName:String) {
//        guard let dir = FileManager.default.urls(for: .documentDirectory,
//                                                 in: .userDomainMask).first else{ return}
//        let fileURL = dir.appendingPathComponent(fileName)
//        do{
//            try writeString.write(to: fileURL, atomically: false, encoding: .utf8)
//        }catch{
//            print("write error")
//        }
//        print("check URL: "+"\(fileURL)")
//    }
//
//    func readFileToString(fileName:String) -> String {
//        guard let dir = FileManager.default.urls(for: .documentDirectory,
//                                                 in: .userDomainMask).first else{
//                                                    return ""
//        }
//        let fileURL = dir.appendingPathComponent(fileName)
//        var readString = ""
//        do{
//            try readString = String.init(contentsOf: fileURL, encoding: .utf8)
//        }catch
//        {
//            print("read error")
//        }
//        return readString
//    }
//
//    func saveDataArray(){
//        var finalString = ""
//        let formatter = DateFormatter()
//        formatter.dateFormat = "yyyy/MM/dd hh:mm:ss"
//        for dictionary in rssi_data {
//            let dateString = formatter.string(from: dictionary["date"] as! Date)
//            finalString += dateString + "," + (dictionary["rssi"] as? String)! +
//                "," + "\n"
//        }
//        writeStringToFile(writeString: finalString, fileName: "data.txt")
//    }
//
//    func loadDataArray() {
//        var finalArray = [[String:Any]]()
//        let csvString = readFileToString(fileName: "data.txt")
//        let lineOfString = csvString.split(separator: "\n")
//        let formatter = DateFormatter()
//        formatter.dateFormat = "yyyy/MM/dd hh:mm:ss"
//        for line in lineOfString {
//            var x = line.split(separator: ",")
//            let date = formatter.date(from: String(x[0]))
//            finalArray.append(["rssi":String(x[1]),"date":date])
//        }
//        rssi_data = finalArray
//        //   tableview
//        //tableView.reloadData()
//    }
    
    
    
    
    
}

