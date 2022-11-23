//
//  ViewController.swift
//  ApiApp3
//
//  Created by David Taddese on 22/11/2022.
//

import UIKit

class AmiiboListVC : UIViewController {
    
    let tableView = UITableView()
    var safeArea : UILayoutGuide!
    
    var amiiboList = [Amiibo]()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        safeArea = view.layoutMarginsGuide
        setupView()
        
        let annoymousFunction = { (fetchedAmiiboList :  [Amiibo]) in
            DispatchQueue.main.async {
                self.amiiboList = fetchedAmiiboList
                self.tableView.reloadData()
                
            }
        
        }
        AmiiboApi.shared.fetchAmiiboList(onCompletion: annoymousFunction)
    
    }
    
    func setupView(){
        view.addSubview(tableView)
        
        tableView.dataSource = self
        tableView.register(UITableViewCell.self , forCellReuseIdentifier: "cellid")
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
    }

}

extension AmiiboListVC : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return amiiboList.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellid", for:indexPath)
        let amiibo = amiiboList[indexPath.row]
        
        cell.textLabel?.text = amiibo.name
        return cell
    }
    
    
    
}

