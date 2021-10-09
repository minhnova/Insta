//
//  SearchController.swift
//  Insta
//
//  Created by Phai Hoang on 10/2/21.
//

import Foundation

import UIKit


private let reuseIdentifier = "UserCell"
class SearchController: UITableViewController {
    
    // MARK: - Properties
    var users = [User]()
    private let searchController = UISearchController(searchResultsController: nil)
    private var filteredUsers = [User]()
    private var isSearchActive: Bool {
        return searchController.isActive && !searchController.searchBar.text!.isEmpty
    }
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSearchController()
        configure()
        getAllUsers()
    }
    
    // MARK: - API
    
    func getAllUsers() {
        UserService.fetchAllUser { users in
            print("DEBUG - all user \(users) ")
            self.users = users
            self.tableView.reloadData()
        }
    }
    
    // MARK: - Helpers
    func configure() {
        tableView.register(UserCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.rowHeight = 64
    }
    
    func configureSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = searchController
        definesPresentationContext = false
    }
    
    // MARK: - Actions
}

extension SearchController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isSearchActive ? filteredUsers.count : self.users.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell =  tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? UserCell else {
            fatalError()
        }
        
        let user = isSearchActive ? filteredUsers[indexPath.row] : users[indexPath.row]
        
        cell.viewModel = UserCellViewModel(user: user)
        return cell
    }
}

extension SearchController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(users[indexPath.row].username)
        let user = isSearchActive ? filteredUsers[indexPath.row] : users[indexPath.row]
        let propfileVc = ProfileController(user: user)
        navigationController?.pushViewController(propfileVc, animated: true)
    }
}

// MARK: - UISearchController

extension SearchController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text?.lowercased() else { return }
        filteredUsers = users.filter({
            $0.username.contains(searchText) ||
            $0.fullname.contains(searchText)
        })
        tableView.reloadData()
        print("DEBUG - Search controller")
    }
}
