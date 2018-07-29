//
//  ViewController.swift
//  RecipeOne
//
//  Created by Eduardo on 28/7/18.
//  Copyright © 2018 Eduardo Jordan Muñoz. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON


class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating{
    
    var arrayResults = [[String:String]]()
    var filterArray = [[String:String]]()
    
    var searchController : UISearchController!
    var resultController = UITableViewController()
    
    var isSearching = false
    
    @IBOutlet weak var tableJSON: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.resultController.tableView.dataSource = self
        self.resultController.tableView.delegate = self
        
// SearchBar in TableView
        
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = true
        } else {
            // Fallback on earlier versions
        }

        let SearchController = UISearchController(searchResultsController: nil)
        if #available(iOS 11.0, *) {
            navigationItem.searchController = SearchController
        } else {
            // Fallback on earlier versions
        }
        if #available(iOS 11.0, *) {
            navigationItem.hidesSearchBarWhenScrolling = false
        } else {
            // Fallback on earlier versions
        }
        
//---> JSON
        
        Alamofire.request("http://www.recipepuppy.com/api/").responseJSON { (responseData) -> Void in
            if((responseData.result.value) != nil) {
                let swiftyJsonVar = JSON(responseData.result.value!)
                
                if let resData = swiftyJsonVar["results"].arrayObject {
                    self.arrayResults = resData as! [[String:String]]
                }
                if self.arrayResults.count > 0 {
                    self.tableJSON.reloadData()
                }
            }
        }
    }
    
    
//-MARK TableView
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "jsonCell")!
        var dict = arrayResults[(indexPath as NSIndexPath).row]
        cell.textLabel?.text = dict["title"]
        cell.detailTextLabel?.text = dict["ingredients"]
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayResults.count
    }
    
//--> Search Mode

  func updateSearchResults(for searchController: UISearchController) {
    
    }
    
}


