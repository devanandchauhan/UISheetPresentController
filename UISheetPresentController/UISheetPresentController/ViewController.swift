//
//  ViewController.swift
//  UISheetPresentController
//
//  Created by Devanand Chauhan on 29/03/23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var dbview: DebitView!
    @IBOutlet var button: UIButton!
    @IBOutlet var lockSheetSwitch: UISwitch!
    @IBOutlet var detentSegmentControl: UISegmentedControl!
    @IBOutlet var radiusStepper: UIStepper!
    @IBOutlet var stepperLabel: UILabel!
    @IBOutlet var radiusLabel: UILabel!
    @IBOutlet var handleSwitch: UISwitch!
    @IBOutlet var scrollSwitch: UISwitch!
    @IBOutlet var backgroundInterationSwitch: UISwitch!
    
    var detailVC: DetailViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        radiusStepper.stepValue = 8
        
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        detailVC = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController
        detailVC.closure = {
            
        }
    }

    @IBAction func handleClicked(_ sender: UISwitch) {
        detailVC.sheetPresentationController?.prefersGrabberVisible = handleSwitch.isOn
    }
    
    @IBAction func radiusValueChanged(_ sender: Any) {
        stepperLabel.text = String(Int(radiusStepper.value))
        detailVC.sheetPresentationController?.preferredCornerRadius = radiusStepper.value
    }
    
    @IBAction func mediumClick(_ sender: Any) {
        if let sheet = detailVC.sheetPresentationController {
            sheet.animateChanges {
                sheet.selectedDetentIdentifier = .medium
            }
        }
    }
    
    @IBAction func largeClick(_ sender: Any) {
        if let sheet = detailVC.sheetPresentationController {
            sheet.animateChanges {
                sheet.selectedDetentIdentifier = .large
            }
        }
    }
    
    @IBAction func allowScrollingToExpandSheetChanged(_ sender: UISwitch) {
        detailVC.sheetPresentationController?.prefersScrollingExpandsWhenScrolledToEdge = sender.isOn
    }
    
    @IBAction func allowBackgroundInteractionChanged(_ sender: UISwitch) {
        if backgroundInterationSwitch.isOn {
            let smallId = UISheetPresentationController.Detent.Identifier("small")
            let smallDetent = UISheetPresentationController.Detent.custom(identifier: smallId) { context in
                return 120
            }
            detailVC.sheetPresentationController?.largestUndimmedDetentIdentifier = smallId
        } else {
            detailVC.sheetPresentationController?.largestUndimmedDetentIdentifier = nil
            detailVC.isModalInPresentation = false
            lockSheetSwitch.isOn = false
        }
    }
    
    @IBAction func lockClicked(_ sender: UISwitch) {
        detailVC.isModalInPresentation = lockSheetSwitch.isOn
    }
    
    @IBAction func buttonClick(_ sender: Any) {
        
        if let sheet = detailVC.sheetPresentationController {
            
            sheet.preferredCornerRadius = radiusStepper.value
            sheet.prefersGrabberVisible = handleSwitch.isOn
            sheet.prefersScrollingExpandsWhenScrolledToEdge = scrollSwitch.isOn
            if backgroundInterationSwitch.isOn {
                let smallId = UISheetPresentationController.Detent.Identifier("small")
                let smallDetent = UISheetPresentationController.Detent.custom(identifier: smallId) { context in
                    return 120
                }
                sheet.largestUndimmedDetentIdentifier = smallId
            } else {
                sheet.largestUndimmedDetentIdentifier = nil
            }

            if detentSegmentControl.selectedSegmentIndex == 0 {
                sheet.detents = [.medium()]
            } else if detentSegmentControl.selectedSegmentIndex == 1 {
                sheet.detents = [.large()]
            } else if detentSegmentControl.selectedSegmentIndex == 2 {
                sheet.detents = [.medium(), .large()]
            } else {
                let smallId = UISheetPresentationController.Detent.Identifier("small")
                let smallDetent = UISheetPresentationController.Detent.custom(identifier: smallId) { context in
                    return 120
                }
                sheet.detents = [smallDetent, .large()]
            }
        }
        
        detailVC.isModalInPresentation = lockSheetSwitch.isOn
        present(detailVC, animated: true)
        
//        let nav = UINavigationController(rootViewController: DetailViewController())
//        nav.modalPresentationStyle = .pageSheet
//
//        let smallId = UISheetPresentationController.Detent.Identifier("small")
//        let smallDetent = UISheetPresentationController.Detent.custom(identifier: smallId) { context in
//            return 80
//        }
//
//        if let sheet = nav.sheetPresentationController {
//            //sheet.detents = [.medium(), .large()]
//            sheet.detents = [.medium(), .large(), smallDetent]
//            sheet.prefersGrabberVisible = true
//            sheet.preferredCornerRadius = 16
//        }
//        present(nav, animated: true, completion: nil)
    }
}

