//
//  RegistrierenViewController.swift
//  WIProjekt2.0
//
//  Created by Cihan Dikme on 10.04.23.
//

import UIKit
import FirebaseAuth

class RegistrierenViewController: UIViewController {
    
    @IBOutlet weak var checkbox: UIButton!
    @IBOutlet weak var geburtstag: UIDatePicker!
    @IBOutlet weak var vorname: UITextField!
    @IBOutlet weak var nachname: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var passwort: UITextField!
    @IBOutlet weak var passwortbestätigen: UITextField!
    @IBOutlet weak var krankenkasse: UITextField!
    @IBOutlet weak var mitgliedsnummer: UITextField!
    
    
    
    @IBAction func registrierenTapped(_ sender: UIButton) {
        
        if let email1 = email.text, let password = passwort.text {
            Auth.auth().createUser(withEmail: email1, password: password) { firebaseResult, error in
                if let e = error {
                    print("error")
                } else {
                    Auth.auth().currentUser?.sendEmailVerification { error in
                        if let e1 = error {
                            print ("error")
                        }
                    }
                }
            }
        }
    }
    
    
            
            @IBAction func checkboxTapped(_ sender: UIButton) {
                if sender.isSelected {
                    sender.isSelected = false
                }else {
                    sender.isSelected = true
                    
                }
                
            }
            
    
    
            
            
            override func viewDidLoad() {
                super.viewDidLoad()
                
                let germanLocale = Locale(identifier: "de_DE")
                geburtstag.locale = germanLocale
                geburtstag.datePickerMode = .date
                
                
                
                vorname.borderStyle = .roundedRect
                nachname.borderStyle = .roundedRect
                email.borderStyle = .roundedRect
                passwort.borderStyle = .roundedRect
                passwortbestätigen.borderStyle = .roundedRect
                krankenkasse.borderStyle = .roundedRect
                mitgliedsnummer.borderStyle = .roundedRect
                
                
                
            }
            
   
    
            
        }
    
