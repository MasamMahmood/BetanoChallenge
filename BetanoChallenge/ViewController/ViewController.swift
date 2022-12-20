//
//  ViewController.swift
//  BetanoChallenge
//
//  Created by Masam Mahmood on 14/12/2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var codigoViewModel = SportViewModel()
    let activityIndicator = UIActivityIndicatorView.init(style: .large)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        let nib = UINib.init(nibName: "SportTableViewCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "SportTableViewCell")
        self.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)
        self.activityIndicator.startAnimating()
        self.tableView.backgroundView = self.activityIndicator
        
        DispatchQueue.main.asyncAfter(deadline: .now()+1.0) {
            self.fetchData()
        }
    }

    //MARK:- Fetch data
    func fetchData() {
        self.codigoViewModel.getDataTask { [weak self] in
            self?.tableView.reloadData()
            self?.activityIndicator.stopAnimating()
            
        }
    }

}



//MARK:- TableView delegate & data-sources
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
            return 40
        }
        

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let viewHeader = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 40))
        viewHeader.backgroundColor = UIColor.darkGray
        let button = UIButton(type: .custom)
        button.frame = viewHeader.bounds
        button.tag = section
        button.addTarget(self, action: #selector(tapSection(sender:)), for: .touchUpInside)
        let dic = codigoViewModel.arrCodigo[section]
        let imgName = setBtnImage(img: dic.d)
        let image = UIImage(named: imgName) as UIImage?
        button.setImage(image, for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)  // in ios 15 we have to set configuration for it. 
        button.contentHorizontalAlignment = .left
        button.setTitle("    \(dic.d)", for: .normal)
        viewHeader.addSubview(button)
        return viewHeader
    }
        

    func numberOfSections(in tableView: UITableView) -> Int {
        return codigoViewModel.arrCodigo.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.codigoViewModel.arrCodigo[section].isExpand == 0) ? 0 : 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SportTableViewCell", for: indexPath) as! SportTableViewCell
        let dic = codigoViewModel.arrCodigo[indexPath.section]
        cell.teamElement = dic.e
        cell.delegate = self
        cell.collectionView.reloadData()
        return cell
    }
    
    @objc func tapSection(sender: UIButton) {
        print(sender.tag)
        self.codigoViewModel.arrCodigo[sender.tag].isExpand = (self.codigoViewModel.arrCodigo[sender.tag].isExpand == 0) ? 1 : 0
        self.tableView.reloadSections([sender.tag], with: .fade)
        
    }
    
    func setBtnImage (img: String) -> String {
        switch img {
        case "SOCCER":
            return "soccerball"
        case "BASKETBALL":
            return "basketball"
        case "TENNIS":
            return "tennis"
        case "TABLE TENNIS":
            return "tabletennis"
        case "VOLLEYBALL":
            return "volleyball"
        case "ESPORTS":
            return "esports"
        case "ICE HOCKEY":
            return "icehockey"
        case "HANDBALL":
            return "handball"
        case "SNOOKER":
            return "snooker"
        case "BADMINTON":
            return "badminton"
        default:
            return "esports"
        }
    }
}

extension ViewController: dataReload {
    
    func getDataReload(iValue: String) {
        codigoViewModel.sortData(sortValue: iValue)
        self.tableView.reloadData()
    }
    
}
