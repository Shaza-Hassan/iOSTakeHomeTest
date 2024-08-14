//
//  HomeViewController.swift
//  iOSTakeHomeTest
//
//  Created by Shaza Hassan on 13/08/2024.
//

import UIKit
import SwiftUI

class CharatersViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var charactersTableView: UITableView?

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Characters"
        charactersTableView?.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        let filterNib = UINib(nibName: "FilterTableViewCell", bundle: nil)
        charactersTableView?.register(filterNib, forCellReuseIdentifier: "filter")
        
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return dummyCharacters.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "filter", for: indexPath) 
            
            cell.selectionStyle = .none
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            let character = dummyCharacters[indexPath.row]
            cell.contentConfiguration = UIHostingConfiguration{
                CharacterSwiftUIView(character: character)
            }
            cell.selectionStyle = .none
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            print("Selected character: \(dummyCharacters[indexPath.row].name)")
        }
    }
}
