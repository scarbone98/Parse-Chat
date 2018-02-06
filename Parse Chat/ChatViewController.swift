//
//  ChatViewController.swift
//  Parse Chat
//
//  Created by Samuel Carbone on 1/29/18.
//  Copyright © 2018 Samuel Carbone. All rights reserved.
//

import UIKit
import Parse
import AlamofireImage
class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var messageText: UITextField!
    @IBOutlet weak var tableView: UITableView!
    var messages: [PFObject] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 50
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.pullMessages), userInfo: nil, repeats: true)

        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatCell", for: indexPath) as! ChatCell
        cell.selectionStyle = .none
        let post = messages[indexPath.row]
        cell.messageLabel.text = post["text"] as? String
        if let user = post["user"] as? PFUser {
            let myUrl = URL(string: "http://api.adorable.io/avatar/" + user.username!)
            cell.avatarImageView.af_setImage(withURL:myUrl!)
        } else {
            let myUrl = URL(string: "http://api.adorable.io/avatar/🤖")
            cell.avatarImageView.af_setImage(withURL:myUrl!)
        }
        return cell
    }
    @IBAction func sendMessage(_ sender: Any) {
        let chatMessage = PFObject(className: "Message")
        chatMessage["text"] = messageText.text ?? ""
        chatMessage["user"] = PFUser.current()
        chatMessage.saveInBackground { (success, error) in
            if success {
                print("The message was saved!")
                self.messageText.text = ""
            } else if let error = error {
                print("Problem saving message: \(error.localizedDescription)")
            }
        }
    }
    @objc func pullMessages(){
        let messageQuery = PFQuery(className: "Message")
        messageQuery.includeKey("user")
        messageQuery.findObjectsInBackground { (posts, error) -> Void in
            if posts != nil{
                self.messages = posts!
                self.tableView.reloadData()
            }
            else{
                print(error!.localizedDescription)
            }
        }
    }
    
}
