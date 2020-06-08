//
//  SecondViewController.swift
//  stateczki
//
//  Created by Kulas on 05/06/2020.
//  Copyright © 2020 Kulas. All rights reserved.
//

import UIKit

var color = "White"
var name = "Random"
class SecondViewController: UIViewController {
    var button = dropDownBtn()
    
    @IBOutlet weak var outlet: UITextField!
    @IBAction func action(_ sender: Any) {
        if (outlet.text != ""){
        name = outlet.text!
            print(name)
        }
    }
    
    
    
    override func viewDidLoad() {
        print(color)
        super.viewDidLoad()
        
        button = dropDownBtn.init(frame:CGRect(x:0, y: 0, width: 0, height: 0))
        button.setTitle("Color", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(button)
        button.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        button.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        button.widthAnchor.constraint(equalToConstant: 150).isActive = true
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        
        button.dropView.dropDownOptions = ["Black","Green","Yellow","Red","White"]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
protocol dropDownProtocol {
    func dropDownPressed(string: String)
    
}

class dropDownBtn : UIButton,dropDownProtocol{
    func dropDownPressed(string: String) {
        self.setTitle(string, for: .normal)
        self.dismissDropDown()
    }
    
    var dropView = dropDownView()
    var height = NSLayoutConstraint()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.darkGray
        
        dropView = dropDownView.init(frame:CGRect(x:0, y: 0, width: 0, height: 0))
        dropView.delegate = self
        dropView.translatesAutoresizingMaskIntoConstraints = false
        
        
        
    }
    override func didMoveToSuperview() {
        
        self.superview?.addSubview(dropView)
        self.superview?.bringSubview(toFront: dropView)
        
        dropView.topAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        dropView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        dropView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        height = dropView.heightAnchor.constraint(equalToConstant: 0)
    }
    var isOpen = false
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if isOpen == false{
            isOpen = true
            
            NSLayoutConstraint.deactivate([self.height])
            if self.dropView.tableView.contentSize.height > 150{
                self.height.constant = 150
                
            }else{
                self.height.constant = self.dropView.tableView.contentSize.height
            }
            self.height.constant = 150
            NSLayoutConstraint.activate([self.height])
            
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut, animations: {
                self.dropView.layoutIfNeeded()
                self.dropView.center.y += self.dropView.frame.height/2
            }, completion: nil)
        }else{
            isOpen = false
            
            NSLayoutConstraint.deactivate([self.height])
            self.height.constant = 0
            NSLayoutConstraint.activate([self.height])
            
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut, animations: {
                self.dropView.center.y += self.dropView.frame.height/2
                self.dropView.layoutIfNeeded()
                
            }, completion: nil)
        }
    }
    
    
    func dismissDropDown(){
        isOpen = false
        
        NSLayoutConstraint.deactivate([self.height])
        self.height.constant = 0
        NSLayoutConstraint.activate([self.height])
        
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut, animations: {
            self.dropView.center.y += self.dropView.frame.height/2
            self.dropView.layoutIfNeeded()
            
        }, completion: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class dropDownView: UIView, UITableViewDelegate, UITableViewDataSource{
    var dropDownOptions = [String]()
    
    var tableView = UITableView()
    
    var delegate :dropDownProtocol!
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        cell.textLabel?.text = dropDownOptions[indexPath.row]
        cell.backgroundColor = UIColor.darkGray
        return cell
        
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        tableView.backgroundColor = UIColor.darkGray
        self.backgroundColor = UIColor.darkGray
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(tableView)
        
        tableView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dropDownOptions.count
    }
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.delegate.dropDownPressed(string: dropDownOptions[indexPath.row])
        color =  dropDownOptions[indexPath.row]
        print(color)
        
    }
    
    
}

