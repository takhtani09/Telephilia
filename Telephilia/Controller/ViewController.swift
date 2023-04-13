//
//  ViewController.swift
//  Telephilia
//
//  Created by IPS-108 on 28/03/23.
//

import UIKit

class ViewController: UIViewController{
    

    @IBOutlet weak var tblView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //tblView.register(UINib(nibName: "TBVCell2", bundle: nil), forCellWithReuseIdentifier: "cell2")
        tblView.register(UINib(nibName: "TBVCell2", bundle: nil), forCellReuseIdentifier: "tbl2")
        tblView.register(UINib(nibName: "TBVCell3", bundle: nil), forCellReuseIdentifier: "tbl3")
        tblView.delegate = self
        tblView.dataSource = self
        //tblView.rowHeight = 450
    }
}

extension ViewController : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0{
            return "Movies in Theatre"
        }
        else if section == 1{
            return "Movies in Genre"
        }
        else if section == 2{
            return "Top High Rated Movies"
        }
        return nil
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0{
            return 450
        }
        else if indexPath.section == 1{
            return 200
        }
        else if indexPath.section == 2{
            return 250
        }
        return 0
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if indexPath.section == 0{
            let cell1 = tblView.dequeueReusableCell(withIdentifier: "tbl1", for: indexPath) as! TBVCell1
            return cell1
        }
        else if indexPath.section == 1{
            let cell2 = tblView.dequeueReusableCell(withIdentifier: "tbl2", for: indexPath) as! TBVCell2
            return cell2
        }
        else if indexPath.section == 2{
            let cell3 = tblView.dequeueReusableCell(withIdentifier: "tbl3", for: indexPath) as! TBVCell3
            return cell3
        }
        return UITableViewCell()
    }

}
