//
//  HomeViewController.swift
//  Stunect
//
//  Created by Rayco Haex on 31/03/2022.
//

import UIKit

class HomeViewController: UIViewController {
    
    var proposals:[Proposal] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        proposals = prepareProposalArray()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 600
    }
    
    func prepareProposalArray() -> [Proposal] {
        var output:[Proposal] = []
        
        let proposal1 = Proposal(title: "Bike rental project")
        let proposal2 = Proposal(title: "Dog dating app")
        let proposal3 = Proposal(title: "Tourist scam warning map")
        
        output.append(proposal1)
        output.append(proposal2)
        output.append(proposal3)
        
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

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return proposals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let proposal = proposals[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProposalCell") as! HomeTableViewCell
        
        cell.setProposal(proposal: proposal)
        
        return cell
    }
}
