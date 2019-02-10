//
//  BottomSheetViewController.swift
//  Simproofn
//
//  Created by Hamzhya on 11/02/19.
//  Copyright © 2019 Hamzhya. All rights reserved.
//

import UIKit
import IHKeyboardAvoiding

class BottomSheetViewController: UIViewController {

    @IBOutlet weak var left: UIButton!
    @IBOutlet weak var right: UIButton!
    
    var partialView: CGFloat {
        return UIScreen.main.bounds.height - (left.frame.maxY + UIApplication.shared.statusBarFrame.height + 100)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        KeyboardAvoiding.avoidingView = self.view
        
        let gesture = UIPanGestureRecognizer.init(target: self, action: #selector(BottomSheetViewController.panGesture))
        view.addGestureRecognizer(gesture)
        roundViews()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        prepareBackgroundView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)
        
        UIView.animate(withDuration: 0.6, animations: { [weak self] in
            let frame = self?.view.frame
            let yComponent = self?.partialView
            self?.view.frame = CGRect(x: 0, y: yComponent!, width: frame!.width, height: frame!.height)
            
        })
        
    }
    
    @IBAction func RightButton(_ sender: Any) {
        
        print("right button clicked")
    }
    
    @IBAction func LeftButton(_ sender: Any) {
        print("left button Clicked")
    }
    
    @IBAction func cancelButton(_ sender: Any) {
        
        UIView.animate(withDuration: 0.3, animations: {
            let frame = self.view.frame
            self.view.frame = CGRect(x: 0, y: frame.height, width: frame.width, height: frame.height)
        }, completion: {(value: Bool ) in self.view.removeFromSuperview()})
        
    }
    
    @objc func panGesture(_ recognizer: UIPanGestureRecognizer) {
        
        let translation = recognizer.translation(in: self.view)
        let velocity = recognizer.velocity(in: self.view)
        let y = self.view.frame.minY
        if ( y + translation.y >= partialView) && (y + translation.y <= partialView ) {
            self.view.frame = CGRect(x: 0, y: y + translation.y, width: view.frame.width, height: view.frame.height)
            recognizer.setTranslation(CGPoint.zero, in: self.view)
        }
        
        if recognizer.state == .ended {
            var duration =  velocity.y < 0 ? Double((y - partialView) / -velocity.y) : Double((partialView - y) / velocity.y )
            
            duration = duration > 1.3 ? 1 : duration
            
            UIView.animate(withDuration: duration, delay: 0.0, options: [.allowUserInteraction], animations: {
                if  velocity.y >= 0 {
                    self.view.frame = CGRect(x: 0, y: self.partialView, width: self.view.frame.width, height: self.view.frame.height)
                }
                
            }, completion: nil)
        }
    }
    
    func roundViews() {
        left.layer.cornerRadius = 10
        right.layer.cornerRadius = 10
        left.layer.borderColor = UIColor.orange.cgColor
        left.layer.borderWidth = 1
        view.clipsToBounds = true
    }
    
    func prepareBackgroundView(){
        view.layer.cornerRadius = 25
        view.layer.borderColor = UIColor.orange.cgColor
        view.layer.borderWidth = 2
        view.isUserInteractionEnabled = true
//        view?.backgroundColor = UIColor(white: 1, alpha: 0.5)
        
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
