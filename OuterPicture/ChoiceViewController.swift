//
//  ChoiceViewController.swift
//  OuterPicture
//
//  Created by Student on 2017/09/11.
//  Copyright © 2017年 Student. All rights reserved.
//

import UIKit

class ChoiceViewController: UIViewController {

    override func viewDidLoad()
    {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func returnBtnAction(_ sender: Any)
    {
        self.dismiss(animated: true, completion: nil)
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        let viewController = segue.destination as? CameraViewController
        let btn = sender as? UIButton
        
        viewController?.tag = btn?.tag
    }

}
