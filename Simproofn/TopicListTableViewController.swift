//
//  TopicListTableViewController.swift
//  Simproofn
//
//  Created by Hamzhya on 28/01/19.
//  Copyright © 2019 Hamzhya. All rights reserved.
//

import UIKit
import os.log
class TopicListTableViewController: UITableViewController, UINavigationControllerDelegate  {
    
    var message: Messages?
    var messages = [Messages]()
    var isNoSelectMode = true
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let message = message {
            navigationItem.title = message.name
        }
        loadMessages()
        self.navigationItem.rightBarButtonItem = nil
        let longPressGesture:UILongPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(InboxViewController.longPress(_:)))
        longPressGesture.minimumPressDuration = 0.5 // 1 second press
        longPressGesture.delegate = self as? UIGestureRecognizerDelegate
        self.tableView.addGestureRecognizer(longPressGesture)
        

        
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
                let button = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelButton(_:)))
                self.navigationItem.rightBarButtonItem = button
                self.navigationItem.rightBarButtonItem?.tintColor = .white
                
                
            }
            
        }
    }
    
    @objc func cancelButton(_ sender: UIBarButtonItem) {
        if (self.tableView.allowsMultipleSelection == true ||
            self.tableView.allowsMultipleSelectionDuringEditing == true
            ) {
            self.tableView.allowsMultipleSelection = false
            self.tableView.allowsMultipleSelectionDuringEditing = false
            isNoSelectMode = !isNoSelectMode
            self.navigationItem.rightBarButtonItem = nil
        }
    }

    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        return isNoSelectMode
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        super.prepare(for: segue, sender: sender)
            
            
            if (segue.identifier == "chatViewSegue") {
                guard let chatTableViewController = segue.destination as? ChatTableViewController
                    else
                {
                    fatalError("Unexpected destination: \(segue.destination)")
                }
                
                guard let selectedMessageCell = sender as? TopicListTableViewCell else {
                    fatalError("Unexpected sender: \(String(describing: sender))")
                }
                
                guard let indexPath = tableView.indexPath(for: selectedMessageCell) else {
                    fatalError("The selected cell is not being displayed by the table")
                }
                
                let selectedMessage = messages[indexPath.row]
                chatTableViewController.message = selectedMessage
                print(selectedMessage)
            } else {
                fatalError("Unexpected Segue Identifier; \(String(describing: segue.identifier))")
            }
        
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
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
        
        let cellIdentifier = "topiclist"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? TopicListTableViewCell else {
            fatalError("The dequeued cell is not an instance of TopicTableViewCell")
        }
        
        let message = messages[indexPath.row]
        
        cell.AvatarImage.image = message.avatar
        cell.TopicLabel.text = message.subject
        cell.contentLabel.text = message.content
        cell.recievedLabel.text = message.recieved
        
        return cell
    }
    
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
    

    @IBAction func backButtonAction(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
        
        dismiss(animated: true, completion: nil)
    }

    

    /*
     Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
         Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
     Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
             Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
             Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
     Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
     Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
         Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
     MARK: - Navigation

     In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         Get the new view controller using segue.destination.
         Pass the selected object to the new view controller.
    }
    */
    
    func loadMessages() {
        if let message = message {
            let message1 = Messages(name: message.name, avatar: message.avatar, subject: message.subject, recieved: message.recieved, content: message.content)
            
            messages = [message1] as! [Messages]
        }
    }

}
