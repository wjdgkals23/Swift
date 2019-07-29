/// Copyright (c) 2019 Razeware LLC
/// 
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
/// 
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
/// 
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
/// 
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import Foundation
import RealmSwift

class MyRealm {
    
    static let shared = MyRealm()
    
    var realm: Realm? = nil
    
    init() {
        do {
            print("success")
            let inRealm = try Realm()
            realm = inRealm
            print(Realm.Configuration.defaultConfiguration.fileURL!)
        } catch {
            realm = nil
        }
    }
}

extension MyRealm {
    func callCategoriesItem() -> Results<Category>? {
        if let inRealm = realm {
            return { inRealm.objects(Category.self) }()
        } else {
            return nil
        }
    }
    
    func addDefaultCategoriesItem() {
        let defaultCategories =
            ["Birds", "Mammals", "Flora", "Reptiles", "Arachnids" ]
        if let inRealm = realm {
            for category in defaultCategories {
                let newCategory = Category()
                newCategory.name = category
                print(inRealm)
                do {
                    try inRealm.write{
                        inRealm.add(newCategory)
                    }
                } catch {
                    print(error)
                }
            }
        } else {
            print("Add Error")
        }
    }
}

extension MyRealm {
    func addNewSpecimen(newSpecimen: Specimen) -> Bool {
        if let inRealm = realm {
            do {
                try inRealm.write {
                    inRealm.add(newSpecimen)
                }
            } catch {
                print(error)
                return false
            }
        }
        return true
    }
    
    func callSpecimenItem() -> Results<Specimen>? {
        if let inRealm = realm {
            return { inRealm.objects(Specimen.self) }()
        } else {
            return nil
        }
    }
}
