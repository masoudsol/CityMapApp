//
//  FavouriteCollectionViewController.swift
//  CityMapApp
//
//  Created by Masoud Soleimani on 2019-08-05.
//  Copyright © 2019 Mas One. All rights reserved.
//

import UIKit

class CitiesTableViewController: UITableViewController {
    
    private let viewModel = ViewModel.shared
    private var searchController: UISearchController?
    override func viewDidLoad() {
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Cities"

        searchController = UISearchController(searchResultsController: nil)
        searchController?.hidesNavigationBarDuringPresentation = false
        searchController?.dimsBackgroundDuringPresentation = false
        searchController?.searchBar.placeholder = "Filter by Name"
        searchController?.searchBar.delegate = self
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = true

        tableView.tableFooterView = UIView()
    }
}

// TableView DataSource and Delegate
extension CitiesTableViewController {
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let city = viewModel.getCity(at: indexPath.row)
        
        let cell = UITableViewCell()
        cell.textLabel?.text =  city.name + ", " + city.country 
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.cityCount
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.selectedCity = indexPath.row
        
        navigationController?.show(UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CityMapView"), sender: self)
    }
}

// SearchBar Delegate
extension CitiesTableViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        viewModel.searchActive = true;
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        viewModel.searchActive = false;
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        viewModel.searchActive = false;
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        viewModel.searchActive = false;
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.filterCity(key: searchText)
        
        if(searchText.count==0){
            viewModel.searchActive = false;
        } else {
            viewModel.searchActive = true;
        }
        
        self.tableView.reloadData()
    }
}
