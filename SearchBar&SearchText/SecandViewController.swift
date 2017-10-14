//
//  SecandViewController.swift
//  SearchBar&SearchText
//
//  Created by Ragaie Alfy on 10/14/17.
//  Copyright © 2017 Ragaie alfy. All rights reserved.
//

import UIKit

class SecandViewController: UIViewController,SearchBarDelegate,SearchTextDelegate  {

    
    @IBOutlet weak var autoText: AutoCompleteTextField!
    
    
    @IBOutlet weak var autoSerachBar: AutoCompleteSearchBar!
    
    
    
    var items = ["dfdf","ddgdgdg","dfgdg","dfgdfg","dfgdfg","dfgdgerert","dfdf","ddgdgdg","dfgdg","dfgdfg","dfgdfg","dfgdgerert"]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        autoText.delegateAutoCompletText = self
        autoText.dataSourceItem = items
        autoSerachBar.delegateAutoComplete = self
        autoSerachBar.dataSourceItem = items
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    func searchBar(_ searchBar: AutoCompleteSearchBar, didSelectRowAt row: Int) {
        
        
        print(items[row])
        
        
    }
    
    
    
    func searchText(_ searchText: AutoCompleteTextField, didSelectRowAt row: Int) {
        print(items[row])
        
        
    }
}
