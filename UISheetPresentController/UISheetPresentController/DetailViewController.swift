//
//  DetailViewController.swift
//  UISheetPresentController
//
//  Created by Devanand Chauhan on 29/03/23.
//

import UIKit

class DetailViewController: UIViewController {

//    var button: UIButton = {
//        $0.setTitle("Button", for: .normal)
//        $0.backgroundColor = .green
//        return $0
//    }(UIButton())
    
    @IBOutlet var button: UIButton!
    @IBOutlet var tableView: UITableView!
    
    var array = ["Apple","Mango","Strawberrry","Blueberrry","Banana","Apricot","Cherry","Orange","Grapes","WaterMelon","Muskmelon","Pear", "Apple","Mango","Strawberrry","Blueberrry","Banana","Apricot","Cherry","Orange","Grapes","WaterMelon","Muskmelon","Pear"]
    var closure: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    @IBAction func buttonAction(_ sender: UIButton) {
        closure?()
    }
}

extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = array[indexPath.row]
        return cell
    }
    
    
}
