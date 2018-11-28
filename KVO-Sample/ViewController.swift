//
//  ViewController.swift
//  KVO-Sample
//
//  Created by TriNgo on 11/27/18.
//  Copyright © 2018 RoverDream. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var lbValidationEmail: UILabel!
    
    let emailViewModel = EmailViewModel(emailModel: EmailModel(value: ""))
    var emailTextObserver: NSObjectProtocol?
    var isValidEmailObserver: NSObjectProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        observeViewModel()
    }
    
    func observeViewModel() {
        self.emailTextObserver = emailViewModel.observe(\EmailViewModel.emailTextValue, options: [.initial, .new], changeHandler: { [weak self] (_, change) in
            self?.tfEmail.text = change.newValue
        })
        
        self.isValidEmailObserver = emailViewModel.observe(\EmailViewModel.isValidValue, options: [.initial, .new], changeHandler: { [weak self] (_, change) in
            guard let strongSelf = self else { return }
            let isValid = change.newValue ?? false
            self?.lbValidationEmail.text = isValid ? "Email is valid" : "Email is invalid"
            self?.lbValidationEmail.textColor = isValid ? strongSelf.view.tintColor : .red
        })
        
        self.tfEmail.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    
    @objc func textFieldDidChange(_ sender: UITextField) {
        self.emailViewModel.updateEmailTextValue(self.tfEmail.text ?? "")
    }
}

