//
//  ConnectionViewController.swift
//  Stunect
//
//  Created by Rayco Haex on 11/04/2022.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseFirestore

class ConnectionViewController: UIViewController {
    
    var connections:[Connection] = []
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        connections = prepareConnectionsArray()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 190
        tableView.rowHeight = 190
        // Do any additional setup after loading the view.
    }
    
    func prepareConnectionsArray() -> [Connection] {
        var output:[Connection] = []
        
        let db = Firestore.firestore()
        
        let userID = Auth.auth().currentUser!.uid
        let docRef = db.collection("connection").document(userID)

        docRef.getDocument { (snapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for row in snapshot!.get("connections") as! NSArray {
                    print(row)
                    let subDocRef = db.collection("profile").document("\(row)")
                    subDocRef.getDocument { (subSnapshot, subErr) in if let subErr = subErr {
                        print("Error getting documents: \(subErr)")
                    } else {
                        print(subSnapshot?.data())
                        let connection = Connection(name: subSnapshot!.get("fullname") as! String, title:subSnapshot!.get("title") as! String, place: subSnapshot!.get("school") as! String)
                        self.connections.append(connection)
                        self.tableView.reloadData()
                    }
                }
            }
        }
        }
        
        return output
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
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


extension ConnectionViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return connections.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let connection = connections[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "ConnectionCell") as! ConnectionTableViewCell
        
        cell.setConnection(connection: connection)
        
        return cell
    }
}
