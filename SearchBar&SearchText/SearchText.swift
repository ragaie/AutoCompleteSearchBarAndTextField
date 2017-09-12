//
//  SearchText.swift
//  SomeWorkTest
//
//  Created by Ragaie alfy on 8/17/17.
//  Copyright © 2017 Ragaie alfy. All rights reserved.
//

import UIKit
protocol SearchTextDelegate {
    
    
    func searchText(_ searchText: SearchText, didSelectRowAt row: Int)
    
    
}

@IBDesignable class SearchText: UIView ,UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource{

  
    @IBOutlet weak var searchText: UITextField!

    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            searchText.layer.cornerRadius = cornerRadius
            clipsToBounds = true
            
        }
    }
    
    
    @IBInspectable var borderWidth: CGFloat = 1.0 {
        didSet {
            searchText.layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var borderColor: UIColor = UIColor.blue {
        didSet {
            
            searchText.layer.borderColor = borderColor.cgColor
        }
    }
    
 
 

    
    
    
    
    private  var tableData : UITableView!
    private  var showDrop : Bool! = false
    var dataSourceItem : [String]! = []
    
    var delegate : SearchTextDelegate!
    
    
    var filterDataSource : [String]! = []
    //MARK: Initializers
    override init(frame : CGRect) {
        super.init(frame : frame)
        initSubviews()
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initSubviews()
        initActionAndDelegete()
        
    }
    //////
    
    
    func initSubviews() {
        
        let bundle = Bundle(for: type(of: self))
        
        
        let nib = UINib(nibName: "SearchText", bundle: bundle)
        
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        
        // to make view fit view in design you welcome.
        view.frame = self.bounds
        // Make the view stretch with containing view
        // to fit like you want in storyboard
        view.autoresizingMask = [UIViewAutoresizing.flexibleWidth, UIViewAutoresizing.flexibleHeight]
        // nib.contentView.frame = bounds
        addSubview(view)
        
        // custom initialization logic
        
    }
    
    
    
    
    // add action of dropDown
    func initActionAndDelegete()  {
        
        
        searchText.delegate = self
        searchText.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
        
    }
    
    

  
    func textFieldDidChange(textField: UITextField){
        
        showSelection()
        filterArray()
        
    }
    
    
  

    
    
 
    func showSelection()  {
        
        
        if searchText.text?.characters.count == 0 {
            
            tableData.removeFromSuperview()
            showDrop = false
            
        }
            
        else{
            if tableData == nil {
                //UIScreen.main.bounds.height
                
                tableData  = UITableView.init(frame: CGRect.init(x: frame.minX + 5 , y: frame.minY + frame.height, width: frame.width - 10, height:UIScreen.main.bounds.height / 3  ))
                tableData.dataSource = self
                tableData.delegate = self
                
                tableData.layer.borderWidth = 1
                tableData.layer.borderColor = UIColor.lightGray.cgColor
                
            }
            // get owner that containe this view
            
            self.owningViewController()?.view.addSubview(tableData)
            
            showDrop = true
        }
        
    }
    
    func  filterArray()  {
        
        
        let filtered = dataSourceItem.filter {  $0.lowercased().contains(searchText.text!.lowercased()) }
        
        filterDataSource = filtered
        
        tableData.reloadData()
        
        
        
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        
        
        if delegate != nil {
            self.delegate.searchText(self, didSelectRowAt: indexPath.row)
        }
        
        searchText.text = filterDataSource[indexPath.row]
        tableData.removeFromSuperview()
        showDrop = false
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return filterDataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        
        var cell : UITableViewCell! = UITableViewCell.init(frame: CGRect.init(x: frame.minX + 5 , y: frame.minY + frame.height, width: frame.width - 10, height:10))
        
       
        
        
        let longString = filterDataSource[indexPath.row]
        let longestWord = searchText.text!
        
        let longestWordRange = (longString as NSString).range(of: longestWord)
        
        
   
        let attributedString = NSMutableAttributedString(string: longString, attributes: [NSFontAttributeName : UIFont.systemFont(ofSize: 14),NSForegroundColorAttributeName : UIColor.lightGray])
        
        attributedString.setAttributes([NSFontAttributeName : UIFont.boldSystemFont(ofSize: 16), NSForegroundColorAttributeName : UIColor.black], range: longestWordRange)
       
        
        
        
        cell.textLabel?.attributedText = attributedString//"\(filterDataSource[indexPath.row])"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 30
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
        
    }

    
}
