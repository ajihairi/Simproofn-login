//
//  InboxViewController.swift
//  Simproofn
//
//  Created by Hamzhya on 24/01/19.
//  Copyright © 2019 Hamzhya. All rights reserved.
//

import UIKit

class InboxViewController: UITableViewController {

    
    var messages = [Messages]()
    var isNoSelectMode = true
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadSampleMessages()
        
        let longPressGesture:UILongPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(InboxViewController.longPress(_:)))
        longPressGesture.minimumPressDuration = 0.5 // 1 second press
        longPressGesture.delegate = self as? UIGestureRecognizerDelegate
        self.tableView.addGestureRecognizer(longPressGesture)
        
            let button = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logoutButton(_:)))
            self.navigationItem.rightBarButtonItem = button
            self.navigationItem.rightBarButtonItem?.tintColor = .white
    }
    
    @objc func longPress(_ longPressGestureRecognizer: UILongPressGestureRecognizer) {
        
        if longPressGestureRecognizer.state == UIGestureRecognizer.State.began {
            let touchPoint = longPressGestureRecognizer.location(in: self.tableView)
            if let indexPath = tableView.indexPathForRow(at: touchPoint) {
                let messages = self.messages[indexPath.row]
                print("\(messages.content)")
                self.tableView.allowsMultipleSelection = true
                self.tableView.allowsMultipleSelectionDuringEditing = true
//                composeButton.isEnabled = true
                isNoSelectMode = false
                let button = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(composeButton(_:)))
                self.navigationItem.rightBarButtonItem = button
                self.navigationItem.rightBarButtonItem?.tintColor = .white
                
                
            }
            
        }
    }
    

    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        return isNoSelectMode
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        super.prepare(for: segue, sender: sender)
        
        if (self.tableView.allowsMultipleSelection == false) {
            
            
            if (segue.identifier == "TopicListSegue") {
                guard let topicListsTableViewController = segue.destination as? TopicListTableViewController
                    else
                {
                    fatalError("Unexpected destination: \(segue.destination)")
                }
                
                guard let selectedMessageCell = sender as? InboxTableViewCell else {
                    fatalError("Unexpected sender: \(String(describing: sender))")
                }
                
                guard let indexPath = tableView.indexPath(for: selectedMessageCell) else {
                    fatalError("The selected cell is not being displayed by the table")
                }
                
                let selectedMessage = messages[indexPath.row]
                topicListsTableViewController.message = selectedMessage
                print(selectedMessage)
            } else {
                fatalError("Unexpected Segue Identifier; \(String(describing: segue.identifier))")
            }
            
        }
        
    }



    @objc func composeButton(_ sender: UIBarButtonItem) {
        if (self.tableView.allowsMultipleSelection == true ||
            self.tableView.allowsMultipleSelectionDuringEditing == true
            ) {
            self.tableView.allowsMultipleSelection = false
            self.tableView.allowsMultipleSelectionDuringEditing = false
            isNoSelectMode = !isNoSelectMode
            
            let button = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logoutButton(_:)))
            self.navigationItem.rightBarButtonItem = button
            self.navigationItem.rightBarButtonItem?.tintColor = .white
        }
    }
    
    
//    @IBOutlet weak var composeButton: UIBarButtonItem!
    @objc func logoutButton(_ sender: UIBarButtonItem) {
        
        if navigationItem.rightBarButtonItem?.title != "cancel" {
            var isLoggedIn = false;
            let datas = UserDefaults.standard;
            isLoggedIn = false
            datas.set(isLoggedIn, forKey: "isLoggedIn")
            
            let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let loginViewController: UIViewController = storyboard.instantiateViewController(withIdentifier: "loginView") as UIViewController
            UIApplication.shared.keyWindow?.rootViewController = loginViewController
            
        }
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var cellHeight:CGFloat = CGFloat()
        
        if indexPath.row % 2 == 0 {
            cellHeight = 70
        }
        else if indexPath.row % 2 != 0 {
            cellHeight = 70
        }
        return cellHeight
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "InboxTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? InboxTableViewCell else {
            fatalError("The dequeued cell is not an instance of InboxTableViewCell")
        }
        
        let message = messages[indexPath.row]
        
        cell.nameLabel.text = message.name
        cell.avatarImageView.image = message.avatar
        cell.topicLabel.text = message.subject
        cell.recievedLabel.text = message.recieved
        cell.contentLabel.text = message.content
        
        return cell
    }
    
    //editing
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            messages.remove(at: indexPath.row)
            //saveMessages()
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    
    private func loadSampleMessages() {
        let avatar1 = UIImage(named: "avatars")
        
        
        guard let messages1 = Messages(name: "ujang", avatar: avatar1, subject: "ini Subject", recieved: "Today", content: "ini Content") else {
            fatalError("unable to instantiate Message1")
        }
        guard let messages2 = Messages(name: "Maman", avatar: avatar1, subject: "ini Subject", recieved: "Today", content: "ini content asdasdas da sdasda sdasd") else {
            fatalError("unable to instantiate Message1")
        }
        guard let messages3 = Messages(name: "Asep", avatar: avatar1, subject: "ini Subject", recieved: "Today", content: "ini content asdasdas da sdasda sdasd") else {
            fatalError("unable to instantiate Message1")
        }
        
        messages += [messages1, messages2, messages3,messages1, messages2, messages3, messages1, messages2, messages3]
    }
}
