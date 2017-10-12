//
//  CameraViewController.swift
//  OuterPicture
//
//  Created by Student on 2017/09/11.
//  Copyright © 2017年 Student. All rights reserved.
//

import UIKit
import Photos

class CameraViewController: UIViewController
{
    var camera:CamCapture = CamCapture()
    var previewLayer:CALayer?
    
    var resultImg:UIImageView?
    var returnBtn:UIButton?
    
    var isProcessing = false
    var isResult = false
    
    var request: PHCollectionListChangeRequest!
    
    var tag:Int?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.resultImg = UIImageView()
        self.resultImg?.frame = self.view.frame
        self.resultImg?.alpha = 0.0
        self.view.addSubview(self.resultImg!)
        
        // カメラをセットアップする
        self.setupCamera(cameraSize: self.view.frame.size)
    }

    /* -------------------------------------------------
     * カメラをセットアップする
     ------------------------------------------------- */
    private func setupCamera(cameraSize:CGSize)
    {
        self.previewLayer = self.camera.previewLayerWithFrame(
            frame: CGRect(
                x: self.view.frame.size.width/2.0 - cameraSize.width/2.0,
                y: self.view.frame.size.height/2.0 - cameraSize.height/2.0,
                width: cameraSize.width,
                height: cameraSize.height))
        
        if let previewLayer = self.previewLayer
        {
            self.view.layer.addSublayer(previewLayer)
        }
    }
    
    /* -------------------------------------------------
     * 撮影する
     ------------------------------------------------- */
    private func shoot()
    {
        if (self.isProcessing)
        {
            return
        }
        
        // キャプチャ
        self.camera.capture { (img) in
            self.isProcessing = true
            
            if let resultImg = self.resultImg
            {
                resultImg.image = img
                resultImg.alpha = 1.0
                self.view.bringSubview(toFront: resultImg)
                
                self.isResult = true
            }
            
            self.isProcessing = false
        }
    }
    
    /* -------------------------------------------------
     * タップして指を離したときに呼び出される
     ------------------------------------------------- */
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        if (self.isResult)
        {
            if let resultImg = self.resultImg
            {
                let alert = UIAlertController(title: "確認", message: "保存しますか？", preferredStyle: UIAlertControllerStyle.alert)
                
                // はいを押したとき
                let alertActionYes = UIAlertAction(title: "はい", style: UIAlertActionStyle.default, handler: { (action) in
                    resultImg.alpha = 0.0
                    self.view.sendSubview(toBack: resultImg)
                    self.isResult = false
                    
                    // 写真を保存する
                    if let img = resultImg.image
                    {
                        self.savePhoto(img: img)
                    }
                    self.dismiss(animated: true, completion: nil)
                })
                
                // いいえを押したとき
                let alertActionNo = UIAlertAction(title: "いいえ", style: UIAlertActionStyle.cancel, handler: { (action) in
                    self.resultImg?.alpha = 0.0
                    self.view.sendSubview(toBack: self.resultImg!)
                    self.isResult = false
                    self.dismiss(animated: true, completion: nil)
                })
                alert.addAction(alertActionYes)
                alert.addAction(alertActionNo)
                self.present(alert, animated: true, completion: nil)
            }
        }
        else
        {
            // 撮影する
            self.shoot()
        }
    }

    //------------------------------------------------------------------------------
    // 写真を保存する
    //------------------------------------------------------------------------------
    func savePhoto(img:UIImage)
    {
        var folderName = ""
        
        if let tag = self.tag
        {
            switch tag
            {
            case 1:
                folderName = "Outer"
            case 2:
                folderName = "Outer"
            case 3:
                folderName = "Outer"
            case 4:
                folderName = "Bottoms"
            case 5:
                folderName = "Bottoms"
            default: break
            }
        }

        let dateFormatter =  DateFormatter()
        dateFormatter.dateFormat = "yyyyMMddHHmmss"
        
        let path = NSHomeDirectory() + "/Documents/" + folderName + "/" + dateFormatter.string(from: Date()) + ".png"
        
        try? UIImageJPEGRepresentation(img, 0.6)?.write(to: URL(fileURLWithPath: path))
    }
    
    override func didReceiveMemoryWarning()
    {
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
