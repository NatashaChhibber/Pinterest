//
//  PinterestLayout.swift
//  PinterestLayout_CollectionView
//
//  Created by Appinventiv on 07/03/18.
//  Copyright © 2018 Appinventiv. All rights reserved.
//

import UIKit

protocol PinterestLayoutDelegate {
    // 1. Method to ask the delegate for the height of the image
    func collectionView(_ collectionView:UICollectionView, heightForPhotoAtIndexPath indexPath:IndexPath) -> CGFloat
}


class PinterestLayout: UICollectionViewLayout {
    
    //1 Pinterest Layout  Delegate
    var delegate: PinterestLayoutDelegate!
    
    
    //2 Configure Properties
    var noOfColumns = 2
    var cellPading: CGFloat = 6

    //3 Array to keep cache of Values
    var cache = [UICollectionViewLayoutAttributes]()
    
    //4 Content height and width
    var contentHeight: CGFloat = 0
    var contentWidth: CGFloat {
        guard let collectionView = collectionView else{
            return 0
        }
        let insets = collectionView.contentInset
        return collectionView.bounds.width - (insets.left + insets.right)
    }
    
    override var collectionViewContentSize: CGSize{
        return CGSize(width: contentWidth ,height: contentHeight)
    }
 // call prepare func 
    override func prepare() {
        guard cache.isEmpty == true , let collectionView = collectionView else{
            return
        }
        
        let columnWidth = contentWidth/CGFloat(noOfColumns)
        var xOffset = [CGFloat]()
        for column in 0 ..< noOfColumns
            {
                xOffset.append(CGFloat(column) * columnWidth)
            }
        var column = 0
        var yOffset = [CGFloat](repeating: 0, count: noOfColumns)
        for item in 0 ..< collectionView.numberOfItems(inSection: 0){
            let indexPath = IndexPath(item: item , section: 0)
            
            // get height of photo from delegate
            
            let photoHeight = delegate.collectionView(collectionView, heightForPhotoAtIndexPath: indexPath)
            let height = cellPading * 2 + photoHeight
            let frame = CGRect(x: xOffset[column], y: yOffset[column],width: columnWidth,height: height)
            let insetFrame = frame.insetBy(dx: cellPading, dy: cellPading)
            
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            attributes.frame = insetFrame
            cache.append(attributes)
            
            //Update Collection View Height & width
            contentHeight = max(contentHeight, frame.maxY)
            yOffset[column] = yOffset[column] + height
            
            column = column < (noOfColumns - 1) ? (column + 1) : 0
            
             }
        
        }
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        var visibleLayoutAttributes = [UICollectionViewLayoutAttributes]()
        for attribute in cache{
            if attribute.frame.intersects(rect){
                visibleLayoutAttributes.append(attribute)
            }
        }
        return visibleLayoutAttributes
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return cache[indexPath.item]
    }

    
}
