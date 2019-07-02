//
//  ProductInformationViewController.swift
//  Shopping App
//
//  Created by Mando Quintana on 6/25/19.
//  Copyright © 2019 Mando Quintana. All rights reserved.
//

import UIKit

class ProductInformationViewController: UIViewController {
    
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!
    var productsArray: [Product]?
    var indexPath: IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let product = productsArray?[indexPath!.row]
        productNameLabel.text = product?.name
        productPriceLabel.text = product?.prettyPrice
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
