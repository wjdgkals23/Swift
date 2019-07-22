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
// MARK: - Categories Table View Controller
//
class CategoriesTableViewController: UITableViewController {
    //
    // MARK: - Variables And Properties
    //
    var selectedCategory: Category!
    var realm: Realm? {
        do {
            let inRealm = try Realm()
            return inRealm
        } catch {
            return nil
        }
    }
    
    lazy var categoryCallFunc: () -> Results<Category>? = {
        [weak self] in
        if let inRealm = self?.realm {
            return { inRealm.objects(Category.self) }()
        } else {
            return nil
        }
    }
    
    var categories:Results<Category>? = nil
    //
    // MARK: - View Controller
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        categories = categoryCallFunc()
        populateDefaultCategories()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print(Realm.Configuration.defaultConfiguration.fileURL!)
    }
    
    private func populateDefaultCategories() {
        if let r_categories = categories { // 1
            print(r_categories.count)
            categories = realm!.objects(Category.self) // 5
        } else {
            do {
                try realm!.write() { // 2
                    print("hi")
                    let defaultCategories =
                        ["Birds", "Mammals", "Flora", "Reptiles", "Arachnids" ] // 3
                    
                    for category in defaultCategories { // 4
                        let newCategory = Category()
                        newCategory.name = category
                        
                        realm!.add(newCategory)
                    }
                }
            } catch {
                print(error)
            }
        }
    }
}

//
// MARK: - Table View Data Source
//
extension CategoriesTableViewController {
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        if let r_categories = categories {
            print("temp")
            cell.textLabel?.text = r_categories[indexPath.row].name
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let r_categories = categories {
            return r_categories.count
        }
        return 0
    }
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if let r_categories = categories {
            selectedCategory = r_categories[indexPath.row]
        }
        return indexPath
    }
}
