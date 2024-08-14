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
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dummyCharacters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let character = dummyCharacters[indexPath.row]
        cell.contentConfiguration = UIHostingConfiguration{
            CharacterSwiftUIView(character: character)
        }
        cell.selectionStyle = .none

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Selected character: \(dummyCharacters[indexPath.row].name)")
    }
}
