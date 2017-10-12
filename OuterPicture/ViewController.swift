//
//  ViewController.swift
//  OuterPicture
//
//  Created by Student on 2017/09/11.
//  Copyright © 2017年 Student. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var outerBtn: UIButton!
    @IBOutlet weak var bottomsBtn: UIButton!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        
        if let outerImg = appDelegate?.outerImg
        {
            self.outerBtn.setImage(outerImg, for: UIControlState.normal)
        }
        
        if let bottomsImg = appDelegate?.bottomsImg
        {
            self.bottomsBtn.setImage(bottomsImg, for: UIControlState.normal)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

