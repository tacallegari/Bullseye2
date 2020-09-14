//
//  EditHighScoreViewController.swift
//  Bullseye2
//
//  Created by Tahlia Callegari on 9/12/20.
//  Copyright © 2020 Tahlia Callegari. All rights reserved.
//

import UIKit

protocol EditHighScoreViewControllerDelegate: class {
    func editHighScoreViewControllerDidCancel( _ controller: EditHighScoreViewController)
    func editHighScoreViewController(
        _controller: EditHighScoreViewController,didFinishEditing item: HighScoreItem)
}

class EditHighScoreViewController: UITableViewController, UITextFieldDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.text = highScoreItem.name
    }
    
    @IBOutlet weak var doneBarButton: UIBarButtonItem!
    @IBOutlet weak var textField: UITextField!
   
    weak var delegate: EditHighScoreViewControllerDelegate?
    var highScoreItem: HighScoreItem!
    
   //Mark:- Actions
    @IBAction func cancel(){
        delegate?.editHighScoreViewControllerDidCancel(self)
    }
    @IBAction func done(){
        highScoreItem.name = textField.text!
        
        delegate?.editHighScoreViewController(_controller: self, didFinishEditing: highScoreItem)
    }
    //Mark:- Table View Delegates
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath?{
        return nil
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        textField.becomeFirstResponder()
    }
    //Mark:- Text Field Delegates
    func textField(_ textField: UITextField, shouldChangeCharatersIn range: NSRange, replacementString string: String) -> Bool{
        
        let oldText = textField.text!
        let stringRange = Range(range, in: oldText)!
        let newText = oldText.replacingCharacters(in: stringRange, with: string)
        
        if newText.isEmpty{
            doneBarButton.isEnabled = false
        }else{
            doneBarButton.isEnabled = true
        }
        return true
    }
    
}
