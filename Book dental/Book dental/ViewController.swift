//
//  ViewController.swift
//  Book dental
//
//  Created by Devinder Goyal on 12/11/17.
//  Copyright © 2017 Devinder Goyal. All rights reserved.
//

import UIKit
import MapKit
class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource, UIPickerViewDelegate, UIPickerViewDataSource,UITextFieldDelegate {
   
    @IBOutlet weak var txtsearch: UITextField!
   
    let annotation = MKPointAnnotation()
    var maindata:NSArray = NSArray()
    var selectedindex:Int = -1
    @IBOutlet weak var tableviewoutlet: UITableView!
    @IBOutlet weak var mapV: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        maindata = NSArray.init(objects: ["dr_img":"gal-gadot.jpg","dr_name":"Dr. Gal Gadot","dr_address":"#782 Wonder Women","dr_postal":"m1g2c8","lattitude":"43.659039","longitude":"-79.742725"]
            ,["dr_img":"scarlett.jpg","dr_name":"Dr. Scarlett Johansson","dr_address":"#120 Avengers Suite","dr_postal":"m1g2c9","lattitude":"43.786258","longitude":"79.278444"],["dr_img":"robert.jpg","dr_name":"Dr. Robert Downey jr","dr_address":"#Jarvis Iron Man's Den","dr_postal":"m1g2c7","lattitude":"43.807135","longitude":"79.218480"],
             ["dr_img":"johnny.jpg","dr_name":"Dr. Johnny Depp","dr_address":"#44 Captain Jack Sparrow Ship","dr_postal":"m1g2c6","lattitude":"43.608004","longitude":"79.601083"])
        mapV.mapType = MKMapType.standard
        mapV.addAnnotation(annotation)
        setlocation(location: CLLocationCoordinate2D(latitude: 43.7732574,longitude: -79.338088))
        tableviewoutlet.reloadData()
        // Do any additional setup after loading the view, typically from a nib.
    }
    func setlocation(location:CLLocationCoordinate2D) {
        let span = MKCoordinateSpanMake(0.05, 0.05)
        let region = MKCoordinateRegion(center: location, span: span)
        mapV.setRegion(region, animated: true)
        
        // 4)
        annotation.coordinate = location
  
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if selectedindex != -1 {
            return 1
        }
        else
        {
            return 0
        }
    }
    
    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // create a new cell if needed or reuse an old one
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "reuse", for: indexPath )
        
        let img1:UIImageView = cell.viewWithTag(1) as! UIImageView
        let l1:UILabel = cell.viewWithTag(2) as! UILabel
        let l2:UILabel = cell.viewWithTag(3) as! UILabel

        if selectedindex != -1 {
            img1.image = UIImage.init(named: (maindata.object(at: selectedindex) as! NSDictionary).value(forKey: "dr_img") as! String)
            l1.text =  (maindata.object(at: selectedindex) as! NSDictionary).value(forKey: "dr_address") as? String
            l2.text =  (maindata.object(at: selectedindex) as! NSDictionary).value(forKey: "dr_name") as? String
        }
        
        return cell
    }
    
    // method to run when table view cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let objVC: AddappointmentViewController = storyboard?.instantiateViewController(withIdentifier: "AddappointmentViewController") as! AddappointmentViewController
self.navigationController?.pushViewController(objVC, animated: true)
        print("You tapped cell number \(indexPath.row).")
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // The number of rows of data
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return maindata.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
   
        return (maindata.object(at: row) as! NSDictionary).value(forKey: "dr_postal") as? String
    }
    @IBAction func btnsearchclicked(_ sender: Any) {
        selectedindex = -1
        for i in 0..<maindata.count {
            if ((maindata.object(at: i) as! NSDictionary).value(forKey: "dr_postal") as? String)?.uppercased() == txtsearch.text?.uppercased() {
                selectedindex = i
            }
        }
        if selectedindex != -1 {
            
        tableviewoutlet.reloadData()
        setlocation(location: CLLocationCoordinate2D(latitude:Double( ((maindata.object(at: selectedindex) as! NSDictionary).value(forKey: "lattitude") as? String)!)!,longitude: Double( ((maindata.object(at: selectedindex) as! NSDictionary).value(forKey: "longitude") as? String)!)!))
        }

    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

}

