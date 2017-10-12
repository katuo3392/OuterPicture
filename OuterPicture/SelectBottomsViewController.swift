//
//  SelectBottomsViewController.swift
//  OuterPicture
//
//  Created by Student on 2017/09/13.
//  Copyright © 2017年 Student. All rights reserved.
//

import UIKit

class SelectBottomsViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate
{
    var items = [UIImage]()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        let rootPath = NSHomeDirectory() + "/Documents/Bottoms"
        
        let manager = FileManager.default
        if let list = try? manager.contentsOfDirectory(atPath: rootPath)
        {
            for path in list
            {
                if let img = UIImage(contentsOfFile: rootPath + "/" + path)
                {
                    items.append(img)
                }
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int
    {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return self.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        
        let imgView = cell.contentView.viewWithTag(1) as? UIImageView
        imgView?.image = self.items[indexPath.row]
        imgView?.backgroundColor = UIColor.red
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        let cellSize = self.view.frame.size.width/2.0 - 2.0
        print(cellSize)
        return CGSize(width: cellSize, height: cellSize)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        appDelegate?.bottomsImg = self.items[indexPath.row]
        
        self.dismiss(animated: true, completion: nil)
    }
}
