//
//  ViewController.swift
//  SearchBar&SearchText
//
//  Created by Ragaie alfy on 8/17/17.
//  Copyright © 2017 Ragaie alfy. All rights reserved.
//

import UIKit

class ViewController: UITableViewController,SearchBarDelegate,SearchTextDelegate {

    
    @IBOutlet weak var customSearchBar: AutoCompleteSearchBar!
    
    
    
    
    @IBOutlet weak var searchtextCustom: AutoCompleteTextField!
    
    
    var items = ["dfdf","ddgdgdg","dfgdg","dfgdfg","dfgdfg","dfgdgerert","dfdf","ddgdgdg","dfgdg","dfgdfg","dfgdfg","dfgdgerert"]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        searchtextCustom.delegateAutoCompletText = self
        searchtextCustom.dataSourceItem = items
        customSearchBar.delegateAutoComplete = self
        customSearchBar.dataSourceItem = items
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
    func searchBar(_ searchBar: AutoCompleteSearchBar, didSelectRowAt row: Int) {
        
        
        print(items[row])
        
        
    }
    
    
    
    func searchText(_ searchText: AutoCompleteTextField, didSelectRowAt row: Int) {
        print(items[row])
        
        
    }

}

