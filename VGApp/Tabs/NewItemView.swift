//
//  NewItem.swift
//  VGApp
//
//  Created by Kiara on 11.02.22.
//

import UIKit

class NewItemView: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var itemNameField: UITextField!
    @IBOutlet weak var number1: UILabel!
    @IBOutlet weak var number2: UILabel!
    @IBOutlet weak var number3: UILabel!
    @IBOutlet weak var number4: UILabel!
    @IBOutlet weak var enterNumberField: UITextField!
    
    var numberFields: [UILabel] = []
    var noTextField = UITextField()
    var activeLabel: UITextField?
    
    override func viewDidLoad() {
        activeLabel = noTextField
        super.viewDidLoad()
        numberFields = [number1,number2,number3,number4]
        
        itemNameField.delegate = self
        enterNumberField.delegate = self
        
        self.navigationItem.leftBarButtonItem =  UIBarButtonItem(title: "Zurück", style: .plain, target: self, action: #selector(backButtonPressed))
        self.navigationItem.title = "Neues Item"
        
        if #available(iOS 15.0, *) {
                 let appearence =  UINavigationBarAppearance()
                 appearence.configureWithDefaultBackground()
                 self.navigationController?.navigationBar.scrollEdgeAppearance = appearence
             }
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard (_:)) )
              self.view.addGestureRecognizer(tapGesture)
        enterNumberField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
    }
    
    @objc func dismissKeyboard (_ sender: UITapGestureRecognizer) {
        activeLabel!.resignFirstResponder()
        activeLabel = noTextField
      }
    
    @objc func backButtonPressed(_ sender: UIButton) {
       self.dismiss(animated: true, completion: nil)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        activeLabel = textField
    }
    
    // manage changed numbers
    @objc func textFieldDidChange(_ sender: UITextField) {
        if(sender != enterNumberField) { return }
        if(sender.text == nil) { return}
        let text = sender.text!

        if(text.count > 4) {
            sender.text = String(text.prefix(4))
        }
        
        let textSplit = sender.text!.map{ String($0)}
    
        for i in 0...3 {
            if(textSplit.count - 1 >= i){
                numberFields[i].text = textSplit[i]
            } else {
                numberFields[i].text = ""
            }
        }
    }
    
}
