//
//  ConnectionTableViewCell.swift
//  Stunect
//
//  Created by Plamen Neshev on 11/04/2022.
//

import UIKit

class ConnectionTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var placeLabel: UILabel!
    func setConnection(connection:Connection) {
        nameLabel.text = connection.name
        titleLabel.text = connection.title
        placeLabel.text = connection.place
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        //contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 0, bottom: 20, right: 0))
    }

}
