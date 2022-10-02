//
//  ViewController.swift
//  Template
//
//  Created by Rameez Khan on 12/10/21.
//

import UIKit

class ViewController: UIViewController {
    
    enum Section: Int {
        case top10 = 0
        case main = 1
    }
    //MARK: - Properties
    typealias DataSource = UICollectionViewDiffableDataSource<Section, ItunesResult>
    typealias SnapShot = NSDiffableDataSourceSnapshot<Section,ItunesResult>
    private var dataSource: DataSource?
    
    var showDetail: ((ItunesResult) -> Void)?
    let searchViewModel: SearchViewModel
    
    //MARK: - Views
    private let userWelcomeMessage: UILabel = {
        let welcomeLabel = UILabel()
        welcomeLabel.isAccessibilityElement = true
        welcomeLabel.accessibilityIdentifier = "user-welcome-message-label"
        welcomeLabel.font = FontFamily.Roboto.medium.font(size: 16)
        welcomeLabel.text = L10n.welcome + " Sandesh" //will be having changing username coming from view model
        welcomeLabel.textColor = .white
        welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
        return welcomeLabel
    }()
    
    private let secondaryHeaderLabel: UILabel = {
        let headerLabel = UILabel()
        headerLabel.isAccessibilityElement = true
        headerLabel.accessibilityIdentifier = "secondary-header-label"
        headerLabel.text = L10n.whatWouldYouLikeToHear
        headerLabel.font = FontFamily.Roboto.regular.font(size: 14)
        headerLabel.textColor = .white
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        return headerLabel
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.accessibilityIdentifier = "songs-collection-view"
        collectionView.backgroundColor = Asset.Colors.appBackground.color
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(ListItuneResultCell.self, forCellWithReuseIdentifier: ListItuneResultCell.identifier)
        collectionView.collectionViewLayout = collectionViewLayout()
        return collectionView
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
    
    
    //MARK: - Lifecycle Methods
    init(with viewModel: SearchViewModel) {
        self.searchViewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addHeaderView()
        addCollectionView()
        bindViewModel()
        print("itunes \(Environment.iTunesUrl)")
        view.backgroundColor = Asset.Colors.appBackground.color
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    private func bindViewModel() {
        searchViewModel.reloadData = { [weak self] in
            self?.applySnapShot(withAnimation: true)
        }
        
        searchViewModel.passError = { [weak self] error in
            DispatchQueue.main.async {
                let label = UILabel()
                label.text = "this is an error"
                self?.collectionView.backgroundView = label
            }
        }
        searchViewModel.fetchInitialResults()
    }
    
    //MARK: - Subview Setup
    private func addHeaderView() {
        view.addSubview(headerView)
        NSLayoutConstraint.activate([
            headerView.leftAnchor.constraint(equalTo: view.leftAnchor),
            headerView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            headerView.rightAnchor.constraint(equalTo: view.rightAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 76)
        ])
    }
    
    private func addCollectionView() {
        view.addSubview(collectionView)
        headerView.translatesAutoresizingMaskIntoConstraints =  false
        NSLayoutConstraint.activate([
            // collection constraints
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 4),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        dataSource = collectionViewDataSource()
        collectionView.backgroundColor = .clear
        collectionView.dataSource = dataSource
    }
    
    private func collectionViewLayout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout { section, environment in
            if section == 0 && self.searchViewModel.itunesResult.count > 1 {
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.33), heightDimension: .fractionalHeight(1.0))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = NSDirectionalEdgeInsets(top: 4, leading: 4, bottom: 4, trailing: 4)
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0 ), heightDimension: .absolute(150))
                let group =  NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
                section.orthogonalScrollingBehavior = .continuous
                return section
            }
            
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0 ), heightDimension: .fractionalHeight(1.0))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = NSDirectionalEdgeInsets(top: 4, leading: 0, bottom: 4, trailing: 0)
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0 ), heightDimension: .absolute(60))
            let group =  NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
           
            let section = NSCollectionLayoutSection(group: group)
            return section
        }
    }
    
    private func collectionViewDataSource() -> UICollectionViewDiffableDataSource<Section, ItunesResult> {
        return UICollectionViewDiffableDataSource(collectionView: collectionView) { collectionView, indexPath, item in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ListItuneResultCell.identifier, for: indexPath) as? ListItuneResultCell else {
                return UICollectionViewCell()
            }
            cell.backgroundColor = .clear
            cell.setupSong(with: item, cache: self.searchViewModel.nsCache)
            return cell
        }
    }
    
    func applySnapShot(withAnimation: Bool = true) {
        //TODO: - improve how section and data get liked togather
        var snapShot = SnapShot()
        if searchViewModel.itunesResult.count == 2 {
            snapShot.appendSections([.top10, .main])
            snapShot.appendItems(searchViewModel.itunesResult[Section.top10.rawValue].results, toSection: .top10)
            snapShot.appendItems(searchViewModel.itunesResult[Section.main.rawValue].results, toSection: .main)
        } else {
            snapShot.appendSections([.main])
            snapShot.appendItems(searchViewModel.itunesResult[0].results, toSection: .main)
        }
        guard let dataSource = dataSource else {
            fatalError("Datasource is not set")
        }
        dataSource.apply(snapShot, animatingDifferences: withAnimation)
    }
    
}

//MARK: - UISearchBarDelegate
extension ViewController: UISearchBarDelegate {
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        return true
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchViewModel.searchedText = searchBar.text ?? ""
        if let searchText = searchBar.text, !searchText.isEmpty {
            searchViewModel.getSearchResult(searchText)
        } else {
            searchViewModel.fetchInitialResults()
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.searchTextField.resignFirstResponder()
    }
}
