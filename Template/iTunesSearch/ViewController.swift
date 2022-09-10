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
    
    private let userWelcomeMessage: UILabel = {
        let welcomeLabel = UILabel()
        welcomeLabel.isAccessibilityElement = true
        welcomeLabel.accessibilityIdentifier = "user-welcome-message-label"
        welcomeLabel.text = "Welcome Sandesh!"
        welcomeLabel.textColor = .white
        welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
        return welcomeLabel
    }()
    
    private let secondaryHeaderLabel: UILabel = {
        let headerLabel = UILabel()
        headerLabel.isAccessibilityElement = true
        headerLabel.accessibilityIdentifier = "secondary-header-label"
        headerLabel.text = "What would you like to hear?"
        headerLabel.font = .systemFont(ofSize: 12)
        headerLabel.textColor = .white
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        return headerLabel
    }()
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.delegate = self
        searchBar.searchTextField.isAccessibilityElement = true
        searchBar.searchTextField.accessibilityIdentifier = "songs-search-bar"
        searchBar.placeholder = L10n.searchSongs
        searchBar.autocapitalizationType = .allCharacters
        searchBar.searchTextField.backgroundColor = .white
        searchBar.barTintColor = .clear
        searchBar.backgroundColor = .clear
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()
    
    private lazy var headerView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .fill
        stackView.spacing = 4
        
        stackView.addArrangedSubview(userWelcomeMessage)
        stackView.addArrangedSubview(secondaryHeaderLabel)
        stackView.addArrangedSubview(searchBar)

        NSLayoutConstraint.activate([
            userWelcomeMessage.heightAnchor.constraint(equalToConstant: 18),
            userWelcomeMessage.leftAnchor.constraint(equalTo: stackView.leftAnchor, constant: 8),
            secondaryHeaderLabel.heightAnchor.constraint(equalToConstant: 14),
            secondaryHeaderLabel.leftAnchor.constraint(equalTo: stackView.leftAnchor, constant: 8),
            searchBar.heightAnchor.constraint(equalToConstant: 44),
            searchBar.leftAnchor.constraint(equalTo: stackView.leftAnchor),
            searchBar.rightAnchor.constraint(equalTo: stackView.rightAnchor)
        ])
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let resultsTableView: UITableView = {
        let tableView = UITableView()
        tableView.accessibilityIdentifier = "songs-table-view"
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .appBackgroundColor
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
        // add localization for this
        addHeaderView()
        addTableView()
        navigationItem.title = L10n.search
        self.navigationController?.navigationBar.prefersLargeTitles = true
        resultsTableView.dataSource = self
        resultsTableView.delegate = self
    }
    
    private func addHeaderView() {
        view.addSubview(headerView)
        NSLayoutConstraint.activate([
            headerView.leftAnchor.constraint(equalTo: view.leftAnchor),
            headerView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            headerView.rightAnchor.constraint(equalTo: view.rightAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 76)
        ])
    }
    
    private func addTableView() {
        view.addSubview(resultsTableView)
        headerView.translatesAutoresizingMaskIntoConstraints =  false
        NSLayoutConstraint.activate([
            // tableview constraints
            resultsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            resultsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            resultsTableView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            resultsTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
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
        //hide navigation controller
        self.navigationController?.isNavigationBarHidden = true
        view.backgroundColor = .appBackgroundColor
    }
    
    private func addSearchBarToNavBar() {
        //navigationItem.searchController = songSearchController
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


extension ViewController: UISearchBarDelegate {
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        return true
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchViewModel.searchedText = searchBar.text ?? ""
        if let searchText = searchBar.text, !searchText.isEmpty {
            searchViewModel.getSearchResult(searchText)
        } else {
            searchViewModel.itunesResult = []
            resultsTableView.reloadData()
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.searchTextField.resignFirstResponder()
    }
}
