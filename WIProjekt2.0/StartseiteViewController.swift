
import UIKit
import FirebaseFirestore

class StartseiteViewController: UIViewController {

    
    
    @IBOutlet weak var arztbild: UIImageView!
    @IBOutlet weak var adresse: UILabel!
    @IBOutlet weak var datum: UILabel!
    @IBOutlet weak var uhrzeit: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var fahrtZiel: UILabel!
    
    
    var db: Firestore!

    
    override func viewDidLoad() {
        self.navigationItem.hidesBackButton = true
        super.viewDidLoad()
        
        db = Firestore.firestore()
        
        let documents = ["arzt", "arzt2", "arzt3", "arzt4", "arzt5"]
        
        func loadDocument(priority: Int) {
            let docRef = db.collection("Ärzte").document(documents[priority])
            
            docRef.getDocument { (document, error) in
                if let document = document, document.exists {
                    let data = document.data()
                    let name = data?["Name"] as? String ?? ""
                    let uhrzeit = data?["uhrzeit"] as? String ?? ""
                    let adresse = data?["adresse"] as? String ?? ""
                    
                    if  shouldLoadNextDocument(name: name, uhrzeit: uhrzeit, adresse: adresse) {
                        let nextPriority = priority + 1
                        if nextPriority < documents.count {
                            loadDocument(priority: nextPriority)
                        } else {
                            clearLabels()
                            print("No documents found")
                        }
                    } else {
                        self.adresse?.text = adresse
                        self.uhrzeit?.text = uhrzeit
                        self.name?.text = name
                        if let imageName = data?["bild"] as? String {
                            let image = UIImage(named: imageName)
                            self.arztbild?.image = image
                        }
                    }
                } else {
                    let nextPriority = priority + 1
                    if nextPriority < documents.count {
                        loadDocument(priority: nextPriority)
                    } else {
                        clearLabels()
                        print("No documents found")
                    }
                }
            }
        }
        
        func shouldLoadNextDocument(name: String, uhrzeit: String, adresse: String) -> Bool {
            return name.isEmpty && uhrzeit.isEmpty && adresse.isEmpty
        }
        
        func clearLabels() {
            self.adresse?.text = ""
            self.uhrzeit?.text = ""
            self.name?.text = ""
            self.arztbild?.image = nil
        }
        
        loadDocument(priority: 0)
        
        
        
        let docRef1 = db.collection("Ärzte").document("Fahrt")
        
        docRef1.getDocument { (document, error) in
            if let document = document, document.exists {
                let data = document.data()
                let fahrtName = data?["Name"] as? String ?? ""
            
                
                
                self.fahrtZiel?.text = fahrtName
            } else {
                print("Dokument nicht gefunden")
            }
        }
    }


}
