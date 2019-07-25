/**
 * Copyright (c) 2018 Razeware LLC
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
 * distribute, sublicense, create a derivative work, and/or sell copies of the
 * Software in any work that is designed, intended, or marketed for pedagogical or
 * instructional purposes related to programming, coding, application development,
 * or information technology.  Permission for such use, copying, modification,
 * merger, publication, distribution, sublicensing, creation of derivative works,
 * or sale is expressly withheld.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

import UIKit
import RealmSwift

//
// MARK: - Add New Entry View Controller
//
class AddNewEntryViewController: UIViewController {
    @IBOutlet weak var categoryTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextView!
    @IBOutlet weak var nameTextField: UITextField!
    
    //
    // MARK: - Variables And Properties
    //
    var selectedAnnotation: SpecimenAnnotation!
    var selectedCategory: Category!
    var specimen: Specimen!
    var myRealm = MyRealm.shared
    //
    // MARK: - IBActions
    //
    @IBAction func unwindFromCategories(segue: UIStoryboardSegue) {
        if(segue.identifier == "CategorySelectedCancel") {
            return
        } else {
            let categoriesController = segue.source as! CategoriesTableViewController
            selectedCategory = categoriesController.selectedCategory
            categoryTextField.text = selectedCategory.name
        }
    }
    
    //
    // MARK: - Private Methods
    //
    func validateFields() -> Bool {
        if nameTextField.text!.isEmpty || descriptionTextField.text!.isEmpty {
            let alertController = UIAlertController(title: "Validation Error",
                                                    message: "All fields must be filled",
                                                    preferredStyle: .alert)
            
            let alertAction = UIAlertAction(title: "OK", style: .destructive) { alert in
                alertController.dismiss(animated: true, completion: nil)
            }
            
            alertController.addAction(alertAction)
            
            present(alertController, animated: true, completion: nil)
            
            return false
        } else {
            return true
        }
    }
    
    func addNewSpecimen() {
        let newSpecimen = Specimen() // 3
        newSpecimen.name = nameTextField.text! // 4
        newSpecimen.category = selectedCategory
        newSpecimen.specimenDescription = descriptionTextField.text
        newSpecimen.latitude = selectedAnnotation.coordinate.latitude
        newSpecimen.longitude = selectedAnnotation.coordinate.longitude
        if (myRealm.addNewSpecimen(newSpecimen: newSpecimen)){
            specimen = newSpecimen
        } else {
            let alert = UIAlertController(title: "추가 실패", message: "추가에 실패하였습니다.", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel) { action in
                alert.dismiss(animated: true, completion: nil)
            }
            alert.addAction(defaultAction)
            present(alert, animated: false, completion: nil)
        }
    }
    
    func updateSpecimen() {
        let realm = try! Realm()
        
        try! realm.write {
            specimen.name = nameTextField.text!
            specimen.category = selectedCategory
            specimen.specimenDescription = descriptionTextField.text
        }
    }
    
    func fillTextFields() {
        nameTextField.text = specimen.name
        categoryTextField.text = specimen.category.name
        descriptionTextField.text = specimen.specimenDescription
        
        selectedCategory = specimen.category
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if (validateFields()) {
            if specimen != nil {
                updateSpecimen()
            } else {
                addNewSpecimen()
            }
            return true
        } else {
            return false
        }
    }
    
    //
    // MARK: - View Controller
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        if let specimen = specimen {
            title = "Edit \(specimen.name)"
            fillTextFields()
        } else {
            title = "Add New Specimen"
        }

    }
}

//
// MARK: - Text Field Delegate
//
extension AddNewEntryViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        performSegue(withIdentifier: "Categories", sender: self)
    }
}
