//
//  ViewController.swift
//  Gabayo
//
//  Created by AH on 4/18/23.
//

import UIKit

class PlayListViewController: UITableViewController {

    var dataModel: datamodel!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataModel.initialize()
        print(dataModel.gabayArray.count)
        
    }

    
    //MARK: - tableview delegates
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataModel.gabayArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let gabay = dataModel.gabayArray[indexPath.row]
        cell.textLabel?.text = gabay.gabayName
        cell.textLabel?.font? = UIFont(name: "helvetica", size: 20)!
        cell.detailTextLabel?.text = gabay.gabyaaName
        cell.detailTextLabel?.font? = UIFont(name: "helvetica", size: 15)!

        cell.imageView?.image = UIImage(named: gabay.imageName)
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        let position = indexPath.row
        dataModel.position = position
        tableView.deselectRow(at: indexPath, animated: true)
        guard let playerVC = storyboard?.instantiateViewController(withIdentifier: "player") as? PlayerViewController else{return}
        playerVC.dataModel = dataModel
        present(playerVC, animated: true)
    }
    
   
    
   
}

