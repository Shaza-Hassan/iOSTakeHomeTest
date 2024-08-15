//
//  HomeViewController.swift
//  iOSTakeHomeTest
//
//  Created by Shaza Hassan on 13/08/2024.
//

import UIKit
import SwiftUI
import Combine

enum CharaterSections : Int, CaseIterable {
    case filter
    case characters
}

class CharatersViewController: UIViewController {

    @IBOutlet weak var charactersTableView: UITableView?
    @IBOutlet weak var loadingView: UIActivityIndicatorView?
    @IBOutlet weak var errorLabel: UILabel?
    
    let viewModel : CharatersViewModel
    
    private var cancellables = Set<AnyCancellable>()
    
    init(viewModel: CharatersViewModel){
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.fetchCharacters()

        navigationController?.navigationBar.prefersLargeTitles = true

        title = "Characters"
        charactersTableView?.setContentOffset(CGPoint(x: 0, y: -1), animated: false)

        charactersTableView?.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        let filterNib = UINib(nibName: "FilterTableViewCell", bundle: nil)
        charactersTableView?.register(filterNib, forCellReuseIdentifier: "filter")
        
        observeViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    deinit {
        cancellables.forEach { $0.cancel() }
    }
}

// MARK: - Table view delegate
extension CharatersViewController : UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return CharaterSections.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == CharaterSections.filter.rawValue {
            return 1
        } else {
            if viewModel.charactesPagingModel.hasNext {
                return viewModel.characters.count + 1
            } else {
                return viewModel.characters.count
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == CharaterSections.filter.rawValue {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "filter", for: indexPath) as? FilterTableViewCell else {
                return UITableViewCell()
            }
            cell.selectionStyle = .none
            cell.delegate = self
            return cell
        } else {
            if indexPath.row == viewModel.characters.count {
                let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
                cell.textLabel?.text = "Load more"
                cell.selectionStyle = .none
                viewModel.fetchCharacters()
                return cell
            }
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            let character = viewModel.characters[indexPath.row]
            cell.contentConfiguration = UIHostingConfiguration{
                CharacterSwiftUIView(character: character)
            }
            cell.selectionStyle = .none
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == CharaterSections.characters.rawValue {
            let vm = CharacterDetailsViewModel(character: viewModel.characters[indexPath.row])
            let view = CharacterDetailsView(viewModel: vm)
            let hostingController = UIHostingController(rootView: view)
            navigationController?.pushViewController(hostingController, animated: true)
        }
    }
}

// MARK: - Observers
extension CharatersViewController {
    func observeViewModel() {
        viewModel.$charactesPagingModel
            .receive(on: DispatchQueue.main)
            .sink { [weak self] pagingModel in
            guard let self = self else { return }
            switch pagingModel.pagingStatus {
                
            case .idle:
                charactersTableView?.reloadData()
            case .firstPageLoading:
                charactersTableView?.isHidden = false
                loadingView?.startAnimating()
                loadingView?.isHidden = false
            case .loadedData:
                loadingView?.stopAnimating()
                loadingView?.isHidden = true
                charactersTableView?.isHidden = false
                
            case .loadingMore:
                charactersTableView?.reloadData()
            case .firstPageError:
                loadingView?.stopAnimating()
                loadingView?.isHidden = true
                errorLabel?.isHidden = false
                errorLabel?.text = viewModel.error
            case .loadingMoreError: break
            default: break
            }
            charactersTableView?.reloadData()

        }.store(in: &cancellables)
    }
}

// MARK: - On Filter Selected Delegate
extension CharatersViewController : OnFilterSelectedDelegate {
    func onFilterSelected(filter: FilterStatus?) {
        viewModel.setFilterStatus(filterStatus: filter)
    }
}
