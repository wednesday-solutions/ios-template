//
//  ViewController.swift
//  Template
//
//  Created by Rameez Khan on 12/10/21.
//

import UIKit

class ViewController: UIViewController {
    var showDetail: ((ItunesResult) -> Void)?
    let searchViewModel: SearchViewModel
    private lazy var songSearchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        // Add localization for this string
        searchController.searchBar.searchTextField.isAccessibilityElement = true
        searchController.searchBar.searchTextField.accessibilityIdentifier = "songs-search-bar"
        searchController.searchBar.placeholder = L10n.searchSongs
        searchController.searchBar.autocapitalizationType = .allCharacters
        return searchController
    }()
    
    let resultsTableView: UITableView = {
        let tableView = UITableView()
        tableView.accessibilityIdentifier = "songs-table-view"
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(NoResultTableViewCell.self, forCellReuseIdentifier: NoResultTableViewCell.description())
        tableView.register(ResultTableViewCell.self, forCellReuseIdentifier: ResultTableViewCell.description())
        return tableView
    }()

    init(with viewModel: SearchViewModel) {
        self.searchViewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        view.addSubview(resultsTableView)
        let margins = view.layoutMarginsGuide
        NSLayoutConstraint.activate([
            // tableview constraints
            resultsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            resultsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            resultsTableView.topAnchor.constraint(equalTo: margins.topAnchor),
            resultsTableView.bottomAnchor.constraint(equalTo: margins.bottomAnchor)
        ])
        addSearchBarToNavBar()
        // add localization for this
        navigationItem.title = L10n.search
        self.navigationController?.navigationBar.prefersLargeTitles = true
        resultsTableView.dataSource = self
        resultsTableView.delegate = self
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navigationController?.navigationBar.accessibilityIdentifier = "songs-navigation-bar"
        searchViewModel.reloadData = { [weak self] in
            self?.resultsTableView.reloadData()
        }
        print("itunes \(Environment.iTunesUrl)")
        searchViewModel.passError = { [weak self] error in
            print("show error")
            DispatchQueue.main.async {
                let label = UILabel()
                label.text = "this is an error"
                self?.resultsTableView.backgroundView = label
            }
            
        }
    }
    
    private func addSearchBarToNavBar() {
        navigationItem.searchController = songSearchController
    }
}

extension ViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        searchViewModel.searchedText = searchController.searchBar.text ?? ""
        if let searchText = searchController.searchBar.text, !searchText.isEmpty {
            searchViewModel.getSearchResult(searchText)
        } else {
            searchViewModel.itunesResult = []
            resultsTableView.reloadData()
        }
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchViewModel.itunesResult.isEmpty ? 1 : searchViewModel.itunesResult.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if searchViewModel.itunesResult.isEmpty {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: NoResultTableViewCell.description())
                    as? NoResultTableViewCell else { return UITableViewCell() }
            let text = searchViewModel.searchedText.isEmpty ? L10n.youHavenTSearchedAnythingYet : L10n.noResultsFound
            cell.setTextForResult(text)
            return cell
        }
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ResultTableViewCell.description())
                as? ResultTableViewCell else { return UITableViewCell() }
        cell.accessibilityIdentifier = "myCell_\(indexPath.row)"
        cell.setupSong(with: searchViewModel.itunesResult[indexPath.row], cache: searchViewModel.nsCache)
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if searchViewModel.itunesResult.isEmpty {
            return tableView.frame.size.height
        }
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let showDetail = showDetail, !searchViewModel.itunesResult.isEmpty {
            let result = searchViewModel.itunesResult[indexPath.row]
            showDetail(result)
        }
    }
}
