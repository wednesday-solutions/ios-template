//
//  HomeVC.swift
//  Template
//
//  Created by Apple on 03/03/22.
//

import UIKit

class HomeVC: UIViewController {
    var showDetail: (() -> Void)?
    lazy var songsSearchController : UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.searchTextField.isAccessibilityElement = true
        searchController.searchBar.searchTextField.accessibilityIdentifier = "songsSearchBar"
        searchController.searchBar.placeholder = "Search Songs"
        searchController.searchResultsUpdater = self
        
        return searchController
    }()
    
    
    var songsTableView: UITableView = {
        let tableView = UITableView()
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.accessibilityIdentifier = "songsTableView"
        tableView.register(NoResultTableCell.self, forCellReuseIdentifier: NoResultTableCell.description())
        tableView.register(ResultTableCell.self, forCellReuseIdentifier: ResultTableCell.description())
        return tableView
    }()
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func loadView() {
        super.loadView()
        
        setupNavigationBar()
        setupTableView()
    }
    
}

//MARK: - UI Methods
extension HomeVC {
    func setupTableView() {
        view.addSubview(songsTableView)
        
        let margings = view.layoutMarginsGuide
        
        NSLayoutConstraint.activate([
            songsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            songsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            songsTableView.topAnchor.constraint(equalTo: margings.topAnchor),
            songsTableView.bottomAnchor.constraint(equalTo: margings.bottomAnchor)
        ])
        
        songsTableView.delegate = self
        songsTableView.dataSource = self
    }
    
    func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.searchController = songsSearchController
        navigationItem.title = "Search"
        
    }
}


extension HomeVC: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        print("Search \(String(describing: songsSearchController.searchBar.text))")
    }
}

extension HomeVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: NoResultTableCell.description(), for: indexPath) as! NoResultTableCell
//        cell.configureCell(text: "No Result")
        
        let cell = tableView.dequeueReusableCell(withIdentifier: ResultTableCell.description(), for: indexPath) as! ResultTableCell
        cell.configureCell(index: indexPath.row)
        
        return cell
    }
}

extension HomeVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableView.automaticDimension
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        showDetail?()
    }
}
