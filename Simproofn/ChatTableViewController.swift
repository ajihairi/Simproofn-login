//
//  ChatTableViewController.swift
//  Simproofn
//
//  Created by Hamzhya on 30/01/19.
//  Copyright © 2019 Hamzhya. All rights reserved.
//

import UIKit
import EzPopup
import IHKeyboardAvoiding

class ChatTableViewController: UITableViewController {
    
    var message: Messages?
    var messages = [Messages]()
    
    let PopUpVC = PopUpViewController.instantiate()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let message = message {
            navigationItem.title = message.name
        }

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        let button = UIBarButtonItem(title: "back", style: .plain, target: self, action: #selector(backButtonAction(_:)))
        self.navigationItem.leftBarButtonItem = button
        self.navigationItem.leftBarButtonItem?.tintColor = .white
    }
    
    @objc func backButtonAction(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
        
        dismiss(animated: true, completion: nil)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }
    
    func callBottomSheet(){
        let BottomSheetView = BottomSheetViewController()
        
        self.addChild(BottomSheetView)
        self.view.addSubview(BottomSheetView.view)
        BottomSheetView.didMove(toParent: self)
        
        let height = view.frame.height
        let width  = view.frame.width
        
        BottomSheetView.view.frame = CGRect(x: 0, y: self.view.frame.maxY, width: width, height: height)
        
    }

    @IBAction func popUpButton(_ sender: Any) {
        guard  let PopUpVC = PopUpVC else { return }
        
        PopUpVC.titleString = "ini judul"
        PopUpVC.messageString = "ini message wkwkw"
        let frame = self.view.frame
        let popupModal = PopupViewController(contentController: PopUpVC, position: .bottom(0), popupWidth: frame.width, popupHeight: 200)
        popupModal.canTapOutsideToDismiss = false
        
        present(popupModal, animated: true, completion: nil)
        KeyboardAvoiding.avoidingView = popupModal.view
        
        
        
    }
    @IBAction func moreButton(_ sender: Any) {
        callBottomSheet()
    }
}
