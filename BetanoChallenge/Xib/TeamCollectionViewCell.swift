//
//  TeamCollectionViewCell.swift
//  BetanoChallenge
//
//  Created by Masam Mahmood on 19/12/2022.
//

import UIKit

class TeamCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var startTime: UILabel!
    @IBOutlet weak var favImage: UIImageView!
    @IBOutlet weak var teamName: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        startTime.layer.borderWidth = 2.0
        startTime.layer.cornerRadius = 8
        startTime.layer.borderColor = UIColor.systemGray5.cgColor
        startTime.layer.masksToBounds = true
    }

}
