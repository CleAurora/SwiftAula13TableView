//
//  ViewController.swift
//  ListaCompras
//
//  Created by Cleís Aurora Pereira on 16/09/20.
//  Copyright © 2020 Cleís Aurora Pereira. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var product: UITextField!
    @IBOutlet weak var quantity: UITextField!
    @IBOutlet weak var AddButton: UIButton!
    @IBOutlet weak var productStatus: UILabel!
    
    @IBOutlet weak var deleteButton: UIButton!
    var arrayProducts = [Product]()


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.product.delegate = self
        self.quantity.delegate = self
        listProduct()
        deleteButton.setTitleColor(.lightGray, for: .disabled)

        viewTableList.delegate = self
        viewTableList.dataSource = self
    }

    @IBAction func AddButton(_ sender: Any) {
        if verifyDataComplete() {
            if let index = getProductIndexIfExists(nameProduct: product.text!) {
                arrayProducts[index].quantityItems = Int(quantity.text!)!
            }else{
                let prod = Product(nameProduct: product.text!, quantityItems: Int(quantity.text!)!)
                addProduct(product: prod)
            }
        }
        listProduct()
        clearFields()
        view.endEditing(true)
    }
    
    private func verifyDataComplete() -> Bool{
        if product.text == nil || product.text!.isEmpty {
            return false
        }
        
        if quantity.text == nil || quantity.text!.isEmpty{
            return false
        }
        return true
    }
    
    private func addProduct(product: Product){
        arrayProducts.append(product)
    }
    
    private func getProductIndexIfExists(nameProduct: String) -> Int?{
        for item in arrayProducts.enumerated() {
            let productName = item.element.nameProduct.trimmingCharacters(in: .whitespacesAndNewlines).folding(options: .diacriticInsensitive, locale: .current).lowercased()
            let searchName = nameProduct.folding(options: .diacriticInsensitive, locale: .current).lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
            
            if productName == searchName {
                return item.offset
            }
        }
        return nil
    }
    
    @IBOutlet weak var viewTableList: UITableView!

    @IBAction func clearList() {
        clearFields()
        arrayProducts.removeAll()
        listProduct()
        view.endEditing(true)
    }
    private func listProduct(){
        viewTableList.reloadData()
    }
    


    fileprivate func clearFields() {
        product.text = ""
        quantity.text = ""
        productStatus.text = ""
    }
    
    @IBAction func deleteTapped() {
        if let index = getProductIndexIfExists(nameProduct: product.text!){
            arrayProducts.remove(at: index)
        }
        clearFields()
        listProduct()
    }
    
}

extension ViewController: UITableViewDelegate {
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayProducts.count

    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let name = arrayProducts[indexPath.row].nameProduct
        let quantity = arrayProducts[indexPath.row].quantityItems
        cell.textLabel?.text = name + " - " + String(quantity)

        return cell
    }


}

extension ViewController:UITextFieldDelegate{
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if textField == product {
            if let index = getProductIndexIfExists(nameProduct: product.text!) {
                AddButton.setTitle("Salvar edição", for: .normal)
                quantity.text = "\(arrayProducts[index].quantityItems)"
                productStatus.text = "Produto já existente"
                deleteButton.isEnabled = true
            }else{
                productStatus.text = product.text!.isEmpty ? "" : "Produto Novo"
                AddButton.setTitle("Salvar", for: .normal)
                deleteButton.isEnabled = false
            }
        }
    }
}

