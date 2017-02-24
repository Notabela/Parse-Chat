//
//  ChatViewController.swift
//  TeamChat
//
//  Created by daniel on 2/19/17.
//  Copyright © 2017 Notabela. All rights reserved.
//

import UIKit
import Parse

class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource
{

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextField: UITextField!
    
    var messages: [PFObject]?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 20
        tableView.rowHeight = UITableViewAutomaticDimension
        
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(refreshMessages), userInfo: nil, repeats: true)

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return messages?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "messageCell", for: indexPath) as! MessageCell
        let object = messages?[indexPath.row]
        cell.message = object?["text"] as! String?
        
        return cell
    }
    
    func refreshMessages()
    {
        let query = PFQuery(className: "Message")
        query.order(byDescending: "createdAt")
        query.findObjectsInBackground { (objects: [PFObject]?, error: Error?) in
            
            if let error = error?.localizedDescription
            {
                print(error)
            } else {
                
                self.messages = objects!
                self.tableView.reloadData()
            }
            
        }
    }

    @IBAction func onSendMessage(_ sender: UIButton)
    {
        let message = PFObject(className: "Message")
        message["text"] = messageTextField.text
        message.saveInBackground { (success: Bool, error: Error?) in
            if success {
                
                print("Message Saved")
                self.messageTextField.text = ""
            } else {
                
                print(error!.localizedDescription)
            }
        }
    }
    

}
