//
//  CycleScrollCollectionViewCell.swift
//  CycleScrollView
//
//  Created by 白野 on 2019/3/9.
//  Copyright © 2019 白野. All rights reserved.
//

import UIKit

class CycleScrollCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var cycleScrollView: XYCycleScrollView!
    
    func set(withCollection collection: [[String: String]]?) {
        cycleScrollView.numberOfImages = {
            return collection?.count ?? 0
        };
        cycleScrollView.imageURLString = { (index) in
            return collection?[index]["url"]
        };
        cycleScrollView.scrollHandler = { (index, auto) in
            print(auto ? "滚动" : "拖动", "至", index)
        }
        cycleScrollView.selectHandler = { (index) in
            print("点击", index, "cell", self.cycleScrollView.cell(withIndex: index))
        }
        cycleScrollView.reloadData()
    }
}
