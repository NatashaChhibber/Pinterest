//
//  ViewController.swift
//  PinterestLayout_CollectionView
//
//  Created by Appinventiv on 07/03/18.
//  Copyright © 2018 Appinventiv. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
  
   let image = [#imageLiteral(resourceName: "appimg2"),#imageLiteral(resourceName: "appimg3"),#imageLiteral(resourceName: "pimg5"),#imageLiteral(resourceName: "pimg6"),#imageLiteral(resourceName: "pimg7"),#imageLiteral(resourceName: "pimg5"),#imageLiteral(resourceName: "pimg9"),#imageLiteral(resourceName: "pimg8"),#imageLiteral(resourceName: "pimg4"),#imageLiteral(resourceName: "pimg10"),#imageLiteral(resourceName: "pimg11"),#imageLiteral(resourceName: "pimg12")]
    @IBOutlet weak var CollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        CollectionView.dataSource = self
        CollectionView.delegate = self
        
        CollectionView?.backgroundColor = UIColor.black
        CollectionView?.contentInset = UIEdgeInsets(top: 23, left: 10, bottom: 10, right: 10)
        
        // Set the PinterestLayout delegate
        if let layout = CollectionView?.collectionViewLayout as? PinterestLayout {
        layout.delegate = self
                    }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension ViewController{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return image.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath) as! imageCell
        cell.imageVIew.image = image[indexPath.item]
        return cell
    }
    
}

//MARK: - PINTEREST LAYOUT DELEGATE
extension ViewController : PinterestLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath) -> CGFloat {
        return image[indexPath.item].size.height
    }
    

}
