//
//  ViewController.swift
//  Shopping App
//
//  Created by Mando Quintana on 6/17/19.
//  Copyright © 2019 Mando Quintana. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate{
    
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var taxTextField: UITextField!
    @IBOutlet weak var discountTextField: UITextField!
    @IBOutlet weak var totalCostLabel: UILabel!
    @IBOutlet weak var productNameTextField: UITextField!
    @IBOutlet weak var addToListButton: UIButton!
    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var showListButton: UIButton!
    
    var productArray: [Product] = []
    var result: Double = 0.00
    var total = 0.00
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addToolBar()
        self.productNameTextField.delegate = self
    }
    
    
    func addToolBar(){
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let doneItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneDismiss))
        let items = [doneItem]
        toolBar.items = items
        priceTextField.keyboardType = UIKeyboardType.numberPad
        taxTextField.keyboardType = UIKeyboardType.numberPad
        discountTextField.keyboardType = UIKeyboardType.numberPad
        priceTextField.inputAccessoryView = toolBar
        taxTextField.inputAccessoryView = toolBar
        discountTextField.inputAccessoryView = toolBar
    }
    
    @objc func doneDismiss(){
        self.priceTextField.resignFirstResponder()
        self.taxTextField.resignFirstResponder()
        self.discountTextField.resignFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    func calc(){
        
        if let price = Double(priceTextField.text!){ // Price != nil
            totalCostLabel.text = String(price)
            if let tax = Double(taxTextField.text!){ // Price & tax != nil
                if let discount = Double(discountTextField.text!){ //price, tax, and discount != nil so perform full calc
                    result = price * (1 - (discount/100))
                    result *= (1 + (tax/100))
                    result = ((result*100).rounded())/100
                    totalCostLabel.text = String(result)
                }else{ //only price and tax are provided
                    result = price * (1 + (tax/100))
                    result = ((result*100).rounded())/100
                    totalCostLabel.text = String(result)
                }
            }else{ // only Price and discount provided
                if let discount = Double(discountTextField.text!){
                    result = price
                    result *= (1 - (discount/100))
                    result = ((result*100).rounded())/100
                    totalCostLabel.text = String(result)
                }
            }
        }
    }
    
    @IBAction func clearButton(_ sender: Any) {
        buttonAnimation(buttonToAnimate: clearButton)
        clearLabels()
    }
    
    func clearLabels(){
        productNameTextField.text = ""
        priceTextField.text = ""
        taxTextField.text = ""
        discountTextField.text = ""
        totalCostLabel.text = "Total"
    }
    
    @IBAction func addToListButton(_ sender: Any) {
        buttonAnimation(buttonToAnimate: addToListButton)
        
        let price = Double(priceTextField.text!)
        let tax = Double(taxTextField.text!)
        let discount = Double(discountTextField.text!)
        let name = productNameTextField.text
        
        let newProduct = Product(name: name, price: price, tax: tax, discount: discount, finalPrice: result)

        if isValid(newProduct){
            productArray.append(newProduct)
            clearLabels()

        }else{
            let alert = UIAlertController(title: "Complete list", message: "Please enter a value for each box", preferredStyle: .alert)
            
            let action = UIAlertAction(title: "Dismiss", style: .default, handler: nil)
            
            alert.addAction(action)
            present(alert, animated: true)

        }
    }
    
    func isValid(_ product: Product) -> Bool {
        
        if product.price == nil || product.tax == nil || product.discount == nil || product.name == nil {
            return false
        }
        return true
    }
    
    func buttonAnimation(buttonToAnimate: UIButton){
        UIView.animate(withDuration: 0.3, delay: 0.1, animations: {
            buttonToAnimate.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        }, completion: { finished in
            buttonToAnimate.transform = CGAffineTransform(scaleX: 1, y: 1)
        })
    }
    
    @IBAction func priceLiveCalculation(_ sender: Any) {
        calc()
    }
    
    @IBAction func taxLiveCalculation(_ sender: Any) {
        calc()
    }
    @IBAction func discountLiveCalculation(_ sender: Any) {
        calc()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ProductListViewController" {
            
            guard let vc = segue.destination as? ProductListViewController else {
                return
            }
            vc.products = productArray
        }
    }
}
