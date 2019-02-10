//
//  PopUpViewController.swift
//  Simproofn
//
//  Created by Hamzhya on 11/02/19.
//  Copyright © 2019 Hamzhya. All rights reserved.
//

import UIKit

class PopUpViewController: UIViewController {
    @IBOutlet weak var TitleLabel: UILabel!
    
    @IBOutlet weak var MessageLabel: UILabel!
    
    var titleString: String?
    var messageString: String?
//    popUpModal
    
    static func instantiate() -> PopUpViewController? {
        return UIStoryboard(name: "Components", bundle: nil).instantiateViewController(withIdentifier: "popUpModal") as? PopUpViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.layer.backgroundColor = UIColor.white.cgColor
        view.roundCorners(topLeft: 25, topRight: 25, bottomLeft: 0, bottomRight: 0)
        let borderLayer = CAShapeLayer()
        borderLayer.path = (view.layer.mask! as! CAShapeLayer).path! // Reuse the Bezier path
        borderLayer.strokeColor = UIColor.orange.cgColor
        borderLayer.fillColor = UIColor.clear.cgColor
        borderLayer.lineWidth = 5
        borderLayer.frame = view.bounds
        view.layer.addSublayer(borderLayer)
        
        TitleLabel.text = titleString
        MessageLabel.text = messageString
    }
    
    @IBAction func OkayButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
