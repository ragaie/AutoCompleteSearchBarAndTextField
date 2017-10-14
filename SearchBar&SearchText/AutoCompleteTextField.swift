//
//  SearchText.swift
//  SomeWorkTest
//
//  Created by Ragaie alfy on 8/17/17.
//  Copyright © 2017 Ragaie alfy. All rights reserved.
//

import UIKit



//Swift 3
extension UIResponder {
    func getParentViewController() -> UIViewController? {
        if self.next is UIViewController {
            return self.next as? UIViewController
        } else {
            if self.next != nil {
                return (self.next!).getParentViewController()
            }
            else {return nil}
        }
    }
}
protocol SearchTextDelegate {
    
    
    func searchText(_ searchText: AutoCompleteTextField, didSelectRowAt row: Int)
    
    
}

@IBDesignable class AutoCompleteTextField: UITextField ,UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource{

  

 
 

    
    
    
    
    private  var tableData : UITableView!
    private  var showDrop : Bool! = false
    var dataSourceItem : [String]! = []
    
    var delegateAutoCompletText : SearchTextDelegate!
    
    
    var filterDataSource : [String]! = []
    //MARK: Initializers
    override init(frame : CGRect) {
        super.init(frame : frame)
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initActionAndDelegete()
        

    
    }
    
    
    // add action of dropDown
    func initActionAndDelegete()  {
        
        
        self.delegate = self
        self.restorationIdentifier = "ragaieText"
        self.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
        
    }
    
    

  
    func textFieldDidChange(textField: UITextField){
        
        showSelection()
        filterArray()
        
    }
    
    
  

    
    
 
    func showSelection()  {
        
        
        if self.text?.characters.count == 0 {
            
            tableData.removeFromSuperview()
            showDrop = false
            self.owningViewController()?.view.endEditing(true)

        }
            
        else{
            if tableData == nil {
                //UIScreen.main.bounds.height
               // yourViewName.superview?.convert(yourViewName.frame, to: nil)
               
             //   var frame1 : CGPoint! =  self.getParentViewController()!.view.convert(self.frame.origin, to: UIApplication.shared.keyWindow)
                print("---- text field")
                print(self.frame.origin)
                
                
                  var point1 : CGPoint!  = self.getParentViewController()?.view.convert(self.frame.origin, to: nil)
                
                var point2 : CGPoint!  = self.getParentViewController()?.view.convert(self.superview!.frame.origin, to: nil)
                
             
                
                var point3 :CGPoint! = CGPoint.init(x: point1.x + point2.x , y: point2.y + point1.y )
           
                
                tableData  = UITableView.init(frame: CGRect.init(x: (point3.x) + 10 , y: (point3.y)  + (frame.height ), width: frame.width - 20, height:UIScreen.main.bounds.height / 3 ))
                
                
           
                tableData.dataSource = self
                tableData.delegate = self
                
                tableData.layer.borderWidth = 1
                tableData.layer.borderColor = UIColor.lightGray.cgColor
                
            }
        
            
            
            self.owningViewController()?.view.addSubview(tableData)
            
            showDrop = true
        }
        
    }
    

    
    func  filterArray()  {
        
        
        let filtered = dataSourceItem.filter {  $0.lowercased().contains(self.text!.lowercased()) }
        
        filterDataSource = filtered
        
        tableData.reloadData()
        
        
        
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        
        
        if delegate != nil {
            self.delegateAutoCompletText.searchText(self, didSelectRowAt: indexPath.row)
        }
        self.owningViewController()?.view.endEditing(true)

        self.text = filterDataSource[indexPath.row]
        tableData.removeFromSuperview()
        showDrop = false
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return filterDataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        
        var cell : UITableViewCell! = UITableViewCell.init(frame: CGRect.init(x: frame.minX + 5 , y: frame.minY + frame.height, width: frame.width - 10, height:10))
        
       
        
        
        let longString = filterDataSource[indexPath.row]
        let longestWord = self.text!
        
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
