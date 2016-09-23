//
//  MemeDetailViewController.swift
//  Meme 2.0
//
//  Created by Carl Lee on 9/22/16.
//  Copyright © 2016 Carl Lee. All rights reserved.
//

import UIKit

class MemeDetailViewController: textStyle {
    
    var meme: Meme!

    
    @IBOutlet weak var top1: UITextField!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var bottom1: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        top1.text = meme.toptext
        bottom1.text = meme.bottomtext
        image.image = meme.originalImage
        stylizeTextField(textField: top1)
        stylizeTextField(textField: bottom1)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
