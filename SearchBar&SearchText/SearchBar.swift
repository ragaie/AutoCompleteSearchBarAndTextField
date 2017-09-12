//
//  SearchBar.swift
//  SomeWorkTest
//
//  Created by Ragaie alfy on 8/17/17.
//  Copyright © 2017 Ragaie alfy. All rights reserved.
//

import UIKit




// viewcontroller that contain this view
extension UIResponder {
    func owningViewController() -> UIViewController? {
        var nextResponser = self
        while let next = nextResponser.next {
            nextResponser = next
            if let vc = nextResponser as? UIViewController {
                return vc
            }
        }
        return nil
    }
}

protocol SearchBarDelegate {
    
    
    func searchBar(_ searchBar: SearchBar, didSelectRowAt row: Int)
    
    
}




@IBDesignable class SearchBar: UIView ,UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource{

    
    @IBOutlet weak var searchBarText: UISearchBar!
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
            clipsToBounds = true
            
        }
    }
    @IBInspectable var borderWidth: CGFloat = 1.0 {
        didSet {
            searchBarText.layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var borderColor: UIColor = UIColor.blue {
        didSet {
            
            searchBarText.layer.borderColor = borderColor.cgColor
        }
    }
    
    private  var tableData : UITableView!
    private  var showDrop : Bool! = false
    var dataSourceItem : [String]! = []

    var delegate : SearchBarDelegate!

    
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
        
        
        let nib = UINib(nibName: "SearchBar", bundle: bundle)
        
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
        
        
        searchBarText.delegate = self
        
        //searchBarText.showsCancelButton = true
       // actionOfDrop.addTarget(self, action: "showSelection:", for: .touchUpInside)
    }
    
    
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        
        
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        showSelection()
        filterArray()

        
        
    }
   
    
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        
     
        
        
    }
    
 
    
    func showSelection()  {
        
        
        if searchBarText.text?.characters.count == 0 {
        
            tableData.removeFromSuperview()
            showDrop = false
        
        }
//        if showDrop == true {
//            
//         
//        }
        else{
            if tableData == nil {
                //UIScreen.main.bounds.height
                
                tableData  = UITableView.init(frame: CGRect.init(x: frame.minX + 10 , y: frame.minY + frame.height , width: frame.width - 20, height:UIScreen.main.bounds.height / 3 ))
                tableData.dataSource = self
                tableData.delegate = self
                
                tableData.layer.borderWidth = 1
                tableData.layer.borderColor = UIColor.lightGray.cgColor
                
            }
            // get owner that containe this view
            
            self.owningViewController()?.view.addSubview(tableData)
            
            showDrop = true
        }
        //self.addSubview(tableData)
        
        // print("welcome to selction")
    }
    
    func  filterArray()  {
        
   
        let filtered = dataSourceItem.filter {  $0.lowercased().contains(searchBarText.text!.lowercased()) }
     //   print(filtered)
        
        filterDataSource = filtered
        
        tableData.reloadData()
        
        
        
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        //itemLabel.text = "\(dataSourceItem[indexPath.row])"
        
        
        if delegate != nil {
            self.delegate.searchBar(self, didSelectRowAt: indexPath.row)
        }
        
        searchBarText.text = filterDataSource[indexPath.row]
        tableData.removeFromSuperview()
        showDrop = false
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return filterDataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        
        var cell : UITableViewCell! = UITableViewCell.init(frame: CGRect.init(x: frame.minX + 5 , y: frame.minY + frame.height, width: frame.width - 10, height: CGFloat(20 * dataSourceItem.count)))
        
        //        CGRect.init(x: frame.minX + 10   , y: frame.minY + frame.height, width: frame.width - 20, height: CGFloat(20 * dataSourceItem.count)
        //
        //        CGRect.init(x: frame.minX + intentSpace  , y: frame.minY + frame.height, width: frame.width - (intentSpace * 2 ), height: 100)
        
        
        
        let longString = filterDataSource[indexPath.row]
        let longestWord = searchBarText.text!.lowercased()
        print(longString)
        print(searchBarText.text)
        
       // let longestWordRange = (longString as NSString).range(of: longestWord)
        
        //let attributedString = NSMutableAttributedString(string: longString, attributes: [NSFontAttributeName : UIFont.systemFont(ofSize: 14),NSForegroundColorAttributeName : UIColor.lightGray])
        
       // attributedString.setAttributes([NSFontAttributeName : UIFont.boldSystemFont(ofSize: 16), NSForegroundColorAttributeName : UIColor.black], range: longestWordRange)
        
  
        //cell.textLabel?.attributedText = attributedString
        
        let longestWordRange = (longString as NSString).range(of: longestWord)
        
        print(longestWordRange.location)
        print(longestWordRange.length)
        
        
        let attributedString = NSMutableAttributedString(string: longString, attributes: [NSFontAttributeName : UIFont.systemFont(ofSize: 14),NSForegroundColorAttributeName : UIColor.lightGray])
        
        attributedString.setAttributes([NSFontAttributeName : UIFont.boldSystemFont(ofSize: 16), NSForegroundColorAttributeName : UIColor.black], range: longestWordRange)
        
        
//        var myString:NSString = "fhb hfgh hfdhf"
//        var myMutableString = NSMutableAttributedString()
//      
//            
//            myMutableString = NSMutableAttributedString(string: myString as String, attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 20)])
//            myMutableString.addAttribute(NSForegroundColorAttributeName, value: UIColor.red, range: NSRange(location:2,length:4))

        
        
        cell.textLabel?.attributedText = attributedString
        
        //cell.textLabel?.attributedText = attributedString

        //label.attributedText = attributedString
        //
       // cell.textLabel?.text =  "\(filterDataSource[indexPath.row])"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 30
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
        
    }

}
