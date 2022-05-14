//
//  HomeTableViewCell.swift
//  Stunect
//
//  Created by Rayco Haex on 04/04/2022.
//

import UIKit

class HomeTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var getInTouch: UIButton!
    
    func setProposal(proposal:Proposal) {
        titleLabel.text = proposal.title
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        //contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 0, bottom: 20, right: 0))
    }
    
    @IBAction func didTapEditButton() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let dateViewController = storyboard.instantiateViewController(withIdentifier: "DateViewController")

        self.window?.rootViewController?.present(dateViewController, animated: true, completion: nil)
    }
    
}
