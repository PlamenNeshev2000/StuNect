//
//  ViewController.swift
//  Stunect
//
//  Created by Rayco Haex on 05/04/2022.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseFirestore

class ProfileViewController: UIViewController {
    
    
    @IBOutlet weak var profileName: UILabel!
    @IBOutlet weak var profileTitle: UILabel!
    @IBOutlet weak var viewBackground: UIView!
    @IBOutlet weak var viewBorderBackground: UIView!
    @IBOutlet weak var phoneButton: UIButton!
    @IBOutlet weak var emailButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let db = Firestore.firestore()
        
        let userID = Auth.auth().currentUser!.uid
        let docRef = db.collection("profile").document(userID)

        docRef.getDocument { (snapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                print(snapshot!.data())
                let docId = snapshot!.documentID
                let fullname = snapshot!.get("fullname") as! String
                let title = snapshot!.get("title") as! String
                let style = snapshot!.get("card") as! NSDictionary
                let contactPhone = snapshot?.get("contactPhone") as! String
                let contactEmail = snapshot?.get("contactEmail") as! String
                print(style["primary"])
                if(style["primary"] != nil) {
                    self.viewBackground.backgroundColor = self.hexStringToUIColor(hex: style["primary"] as! String)
                    self.viewBorderBackground.backgroundColor = self.hexStringToUIColor(hex: style["primary"] as! String)
                }
                if(style["text"] != nil) {
                    self.profileName.textColor = self.hexStringToUIColor(hex: style["text"] as! String)
                    self.profileTitle.textColor = self.hexStringToUIColor(hex: style["text"] as! String)
                }
                if(style["secondary"] != nil) {
                    self.phoneButton.tintColor = self.hexStringToUIColor(hex: style["secondary"] as! String)
                    self.emailButton.tintColor = self.hexStringToUIColor(hex: style["text"] as! String)
                }
                self.profileName.text = fullname
                self.profileTitle.text = title
                if(contactPhone != "" || contactPhone != nil) {
                    self.phoneButton.setTitle(contactPhone, for: .normal)
                } else {
                    self.phoneButton.isHidden = true
                }
                
                if(contactEmail != "" || contactEmail != nil){
                    self.emailButton.setTitle(contactEmail, for: .normal)
                } else {
                    self.emailButton.isHidden = true
                }
                
            }
        }

    }
    
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }

        if ((cString.count) != 6) {
            return UIColor.gray
        }

        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)

        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    @IBAction func didTapEditButton() {
        let vc = UIViewController()
        vc.view.backgroundColor = .systemPink

        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func share(){
        //Set the default sharing message.
        let userID = Auth.auth().currentUser!.uid
        let itemSource = AirDropOnlyActivityItemSource(url: "http://145.93.36.34:5500/?user="+userID)

        let activityVc = UIActivityViewController(activityItems: [itemSource], applicationActivities: nil)

        self.present(activityVc, animated: true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

class AirDropOnlyActivityItemSource: NSObject, UIActivityItemSource {
    ///The item you want to send via AirDrop.
    let url: Any

    init(url: Any) {
        self.url = url
    }

    func activityViewControllerPlaceholderItem(_ activityViewController: UIActivityViewController) -> Any {
        //using NSURL here, since URL with an empty string would crash
        return NSURL(string: "")!
    }

    func activityViewController(_ activityViewController: UIActivityViewController, itemForActivityType activityType: UIActivity.ActivityType?) -> Any? {
        return url
    }
}
