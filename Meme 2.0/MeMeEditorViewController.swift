//
//  ViewController.swift
//  Meme V2
//
//  Created by Carl Lee on 9/17/16.
//  Copyright © 2016 Carl Lee. All rights reserved.
//

import UIKit

class MeMeEditorViewController: textStyle, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {

    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var images: UIImageView!
    @IBOutlet weak var top: UITextField!
    @IBOutlet weak var bottom: UITextField!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var topBar: UIToolbar!
    @IBOutlet weak var bottomBar: UIToolbar!
    
    
    override func viewDidAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = true
        super.viewWillAppear(animated)
        keyboardSub()
        hidekeySub()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubKeyboard()
        unsubhideKeyboard()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stylizeTextField(textField: top)
        stylizeTextField(textField: bottom)
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        shareButton.isEnabled = false
        top.delegate = self
        bottom.delegate = self
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    
    func shareButtonEnabled(){
        if !(top.text == "TOP") && !(bottom.text == "BOTTOM") && !(images.image == nil){
            shareButton.isEnabled = true
    }
        
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let imagePick = info[UIImagePickerControllerOriginalImage] as? UIImage{
            images.image = imagePick
            images.contentMode = .scaleAspectFit
        }
        shareButtonEnabled()
        dismiss(animated: true, completion: nil)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == top{
            top.text = ""
        } else {
            bottom.text = ""
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        shareButtonEnabled()
        return true
    }
    
        
    func save(){
        let memeImage = generateMeme()
        let meme = Meme(toptext: top.text!, bottomtext: bottom.text!, originalImage: images.image!, memeImage: memeImage)
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        appDelegate.memes.append(meme)
    }
    
    func generateMeme() -> UIImage{
        topBar.isHidden = true
        bottomBar.isHidden = true
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memeImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        topBar.isHidden = false
        bottomBar.isHidden = false
        return memeImage!
    }
    
    
    @IBAction func takePicture(_ sender: AnyObject) {
        pickingPicture(sourceType: UIImagePickerControllerSourceType.camera)
        
    }

    @IBAction func pickPicture(_ sender: AnyObject) {
        pickingPicture(sourceType: UIImagePickerControllerSourceType.photoLibrary)
    }
    
    @IBAction func share(_ sender: AnyObject) {
        let image = generateMeme()
        let controller = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        controller.completionWithItemsHandler = {activity, completed, items, error in
            if completed{
                self.save()
                self.dismiss(animated: true, completion: nil)
            }
        }
        present(controller, animated: true, completion: nil)
    }
    
    @IBAction func restart(_ sender: AnyObject) {
        top.text = "TOP"
        bottom.text = "BOTTOM"
        images.image = nil
        shareButton.isEnabled = false
        dismiss(animated: true, completion: nil)
    }
    
    func pickingPicture(sourceType: UIImagePickerControllerSourceType){
        let image = UIImagePickerController()
        image.sourceType = sourceType
        image.delegate = self
        present(image, animated: true, completion: nil)
    }
    
    func showKeyboard(notification: NSNotification) {
        if bottom.isEditing{
            self.view.frame.origin.y -= getKeyboardHigh(notification: notification)
        }
    }
    
    func hideKeyboard(notification: NSNotification){
        self.view.frame.origin.y = 0
    }
    
    func getKeyboardHigh(notification: NSNotification) -> CGFloat{
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.cgRectValue.height
    }

    func keyboardSub(){
        NotificationCenter.default.addObserver(self, selector: #selector(showKeyboard), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
    }
    
    func unsubKeyboard(){
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
    }
    
    func hidekeySub(){
        NotificationCenter.default.addObserver(self, selector: #selector(hideKeyboard), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    func unsubhideKeyboard(){
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }

}

