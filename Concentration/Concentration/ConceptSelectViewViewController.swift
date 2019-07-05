//
//  ConceptSelectViewViewController.swift
//  Concentration
//
//  Created by 정하민 on 03/07/2019.
//  Copyright © 2019 JHM. All rights reserved.
//

import UIKit

class ConceptSelectViewViewController: UIViewController, UISplitViewControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    let themes = [
        "Sports": "⚽️🏀🏈⚾️🎾🏐🏉🎱🏓⛷🎳⛳️",
        "Animals": "🐶🦆🐹🐸🐘🦍🐓🐩🐦🦋🐙🐏",
        "Faces": "😀😌😎🤓😠😤😭😰😱😳😜😇"
    ]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        splitViewController?.delegate = self
    }
    
    
    
    @IBAction func chooseTheme(_ sender: Any) {
        if let cvc = splitViewDetailConcentrationViewController {
            if let theme = (sender as? UIButton)?.currentTitle, let concept = themes[theme] {
                cvc.theme = concept
            }
        } else if let cvc = lastSeguedToConcentrationViewController {
            if let theme = (sender as? UIButton)?.currentTitle, let concept = themes[theme] {
                cvc.theme = concept
            }
            self.navigationController?.pushViewController(cvc, animated: true)
        }
        else {
            performSegue(withIdentifier: "selectConcept", sender: sender)
        }
    } // 액션에서 조건문을 통해 세그를 할지 포인터를 통해 뷰를 잡고있을지 등 정할 수 있다.
    
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        if let cvc = secondaryViewController as? ConcentrationViewController {
            if (cvc.theme == nil) {
                return true
            }
        }
        return false
    } // 해당 함수를 통해 detail 뷰의 상태에 따라 master 뷰를 띄울지 죽일지 정할 수 있다.
    
    private var lastSeguedToConcentrationViewController: ConcentrationViewController?
    
    private var splitViewDetailConcentrationViewController: ConcentrationViewController? {
        return splitViewController?.viewControllers.last as? ConcentrationViewController
    } // 아이패드에서는 nil 반환 X , 아이폰에서는 nil 반환
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "selectConcept" {
            if let theme = (sender as? UIButton)?.currentTitle, let concept = themes[theme]  {
                if let concentrationView = segue.destination as? ConcentrationViewController {
                    concentrationView.theme = concept
                    lastSeguedToConcentrationViewController = concentrationView
                }
            }
        }
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
