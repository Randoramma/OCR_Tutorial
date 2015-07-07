//
//  ViewController.swift
//  LoveInASnap
//
//  Created by Lyndsey Scott on 1/11/15
//  for http://www.raywenderlich.com/
//  Copyright (c) 2015 Lyndsey Scott. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController, UITextViewDelegate, UINavigationControllerDelegate {
  
  @IBOutlet weak var textView: UITextView!
  @IBOutlet weak var findTextField: UITextField!
  @IBOutlet weak var replaceTextField: UITextField!
  @IBOutlet weak var topMarginConstraint: NSLayoutConstraint!
  
  var activityIndicator:UIActivityIndicatorView!
  var originalTopMargin:CGFloat!
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)
    
    originalTopMargin = topMarginConstraint.constant
  }
  
  @IBAction func takePhoto(sender: AnyObject) {
    view.endEditing(true)
    moveViewDown()
    
    let imagePickerActionSheet = UIAlertController (title: "Upload Photo", message: nil, preferredStyle: .ActionSheet)
    
    if UIImagePickerController .isSourceTypeAvailable(.Camera) {
      let cameraButton = UIAlertAction(title: "Take Photo", style: .Default) { (alert) -> Void in
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .Camera
        self.presentViewController(imagePicker, animated: true, completion: nil)
      }
      imagePickerActionSheet.addAction(cameraButton)
    }
    
    let libraryButton = UIAlertAction(title: "Choose Existing", style: .Default) { (alert) -> Void in
      let imagePicker = UIImagePickerController()
      imagePicker.delegate = self
      imagePicker.sourceType = .PhotoLibrary
      self.presentViewController(imagePicker, animated: true, completion: nil)
    }
    imagePickerActionSheet.addAction(libraryButton)
    
    let cancelButton = UIAlertAction (title: "Cancel", style: .Cancel) { (alert) -> Void in
    }
    imagePickerActionSheet.addAction(cancelButton)
    
    presentViewController(imagePickerActionSheet, animated: true, completion: nil)
    
    
  } // takePhoto
  
  @IBAction func swapText(sender: AnyObject) {
    
  }
  
  @IBAction func sharePoem(sender: AnyObject) {
    
  }
  
  
  // Activity Indicator methods
  
  func addActivityIndicator() {
    activityIndicator = UIActivityIndicatorView(frame: view.bounds)
    activityIndicator.activityIndicatorViewStyle = .WhiteLarge
    activityIndicator.backgroundColor = UIColor(white: 0, alpha: 0.25)
    activityIndicator.startAnimating()
    view.addSubview(activityIndicator)
  }
  
  func removeActivityIndicator() {
    activityIndicator.removeFromSuperview()
    activityIndicator = nil
  }
  
  
  // The remaining methods handle the keyboard resignation/
  // move the view so that the first responders aren't hidden
  
  func moveViewUp() {
    if topMarginConstraint.constant != originalTopMargin {
      return
    }
    
    topMarginConstraint.constant -= 135
    UIView.animateWithDuration(0.3, animations: { () -> Void in
      self.view.layoutIfNeeded()
    })
  }
  
  func moveViewDown() {
    if topMarginConstraint.constant == originalTopMargin {
      return
    }

    topMarginConstraint.constant = originalTopMargin
    UIView.animateWithDuration(0.3, animations: { () -> Void in
      self.view.layoutIfNeeded()
    })

  }
  
  @IBAction func backgroundTapped(sender: AnyObject) {
    view.endEditing(true)
    moveViewDown()
  }
}

extension ViewController: UITextFieldDelegate {
  func textFieldDidBeginEditing(textField: UITextField) {
    moveViewUp()
  }
  
  @IBAction func textFieldEndEditing(sender: AnyObject) {
    view.endEditing(true)
    moveViewDown()
  }
  
  func textViewDidBeginEditing(textView: UITextView) {
    moveViewDown()
  }
}

extension ViewController: UIImagePickerControllerDelegate {

}
