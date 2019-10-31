//
//  CreateClientsVC.swift
//  PostRequestsWithAirtable
//
//  Created by Radharani Ribas-Valongo on 10/31/19.
//  Copyright © 2019 Benjamin Stone. All rights reserved.
//

import UIKit

class CreateClientsVC: UIViewController {
    // MARK: - IBOutlets
    
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var aboutTextField: UITextField!
    @IBOutlet var createButton: UIButton!
    
    
    // MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - IBActions
    
    @IBAction func createClient(_ sender: UIButton) {
        guard let client = createClientFromFields() else {
            displayInvalidClientAlert()
            return
        }
        
        ClientAPIHelper.shared.post(client){ (result) in
            switch result {
            case .success:
                self.navigationController?.popViewController(animated: true)
            case let .failure(error):
                print(error)
                self.displayPostFailureAlert(with: error)
            }
        }
    }
    
    
    // MARK: - Private Methods
    
    private func displayAlert(title: String, message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
    private func displayPostFailureAlert(with error: Error) {
        displayAlert(title: "Error posting new Client", message: error.localizedDescription)
    }
    
    private func displayInvalidClientAlert() {
        displayAlert(title: "Invalid Post", message: "Ensure you have completed fields")
    }
    
    
    private func createClientFromFields () -> Clients? {
        guard let name = nameTextField.text else {
            return nil
        }
        guard let about = aboutTextField.text else {
            return nil }
        let fields = Fields(name: name, about: about, logo: nil)
        return Clients(fields: fields)
        
    }
}
