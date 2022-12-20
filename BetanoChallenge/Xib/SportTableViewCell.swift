//
//  SportTableViewCell.swift
//  BetanoChallenge
//
//  Created by Masam Mahmood on 19/12/2022.
//

import UIKit
protocol dataReload: AnyObject {
    func getDataReload(iValue: String)
}

class SportTableViewCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var teamElement: [TeamsElement] = []
    weak var delegate: dataReload?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        collectionView?.register(UINib(nibName: "TeamCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "TeamCollectionViewCell")
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 20)
        collectionView.allowsMultipleSelection = true
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
        
}


extension SportTableViewCell: UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return teamElement.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TeamCollectionViewCell", for: indexPath) as! TeamCollectionViewCell
        let dic = teamElement[indexPath.row]
        cell.teamName.text = dic.d
        let setStartTime = Date(milliseconds: dic.tt)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"
        let dateString = dateFormatter.string(from: setStartTime)
        cell.startTime.text = dateString
        
        if dic.sortType == false {
            cell.favImage.image = UIImage(named: "star")
        } else {
            cell.favImage.image = UIImage(named: "starFilled")
        }
        return cell
        
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       return CGSize(width: 94 , height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let dic = teamElement[indexPath.row]
        self.delegate?.getDataReload(iValue: dic.i)
    }
    
}
