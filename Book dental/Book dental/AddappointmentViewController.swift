//
//  AddappointmentViewController.swift
//  Book dental
//
//  Created by Devinder Goyal on 12/11/17.
//  Copyright © 2017 Devinder Goyal. All rights reserved.
//

import UIKit

class AddappointmentViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate  {

    @IBOutlet weak var editname: UITextField!

    @IBOutlet weak var btncheck: UIButton!
    
    @IBOutlet weak var datepicker: UIDatePicker!
    var checkimage = UIImage(named :"checked")
    var uncheckimage = UIImage(named :"unchecked")

    // Bool property
    
    var ischecked : Bool!
    
    var string1 : String = "Your Appointment Is booked on"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ischecked = true

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnbookappointmentclicked(_ sender: Any) {
        
        datepicker.datePickerMode = .date
        
        let dateformatter = DateFormatter()
        
        dateformatter.dateFormat =
    "MMM dd,yyyy"
        
        let selectdate = dateformatter.string(from: datepicker.date)
        
        let alert  = UIAlertController(title: "Alert", message: "Thank you! " + editname.text! + string1 + selectdate, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    
    @IBAction func btnclick(_ sender: Any) {
        
        if ischecked == true
        {
            ischecked = false
        }
        else{
            ischecked = true
        }
        
        if ischecked == true
        {
            btncheck.setImage(checkimage, for: UIControlState.normal)
        }
        else
        {
            btncheck.setImage(uncheckimage, for: UIControlState.normal)
        }
    }
    

}
