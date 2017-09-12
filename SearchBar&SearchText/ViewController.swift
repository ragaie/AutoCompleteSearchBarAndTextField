//
//  ViewController.swift
//  SearchBar&SearchText
//
//  Created by Ragaie alfy on 8/17/17.
//  Copyright © 2017 Ragaie alfy. All rights reserved.
//

import UIKit

class ViewController: UIViewController,SearchBarDelegate,SearchTextDelegate {

    
    @IBOutlet weak var customSearchBar: SearchBar!
    
    
    
    
    @IBOutlet weak var searchtextCustom: SearchText!
    
    
    var items = ["dfdf","ddgdgdg","dfgdg","dfgdfg","dfgdfg","dfgdgerert","dfdf","ddgdgdg","dfgdg","dfgdfg","dfgdfg","dfgdgerert"]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        searchtextCustom.delegate = self
        searchtextCustom.dataSourceItem = items
        customSearchBar.delegate = self
        customSearchBar.dataSourceItem = items
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
    func searchBar(_ searchBar: SearchBar, didSelectRowAt row: Int) {
        
        
        print(items[row])
        
        
    }
    
    
    
    func searchText(_ searchText: SearchText, didSelectRowAt row: Int) {
        print(items[row])
        
        
    }

}

