//
//  CycleScrollCollectionReusableView.swift
//  CycleScrollView
//
//  Created by 白野 on 2019/3/9.
//  Copyright © 2019 白野. All rights reserved.
//

import UIKit

class CycleScrollCollectionReusableView: UICollectionReusableView {
    @IBOutlet weak var cycleScrollView: XYCycleScrollView!
    
    func set(withHeader header: [String]?) {
        self.cycleScrollView.numberOfImages = {
            return header?.count ?? 0
        }
        self.cycleScrollView.imageURLString = { (index) in
            return header?[index]
        }
        self.cycleScrollView.scrollHandler = { (index, auto) in
            print(auto ? "滚动" : "拖动", "至", index)
        }
        self.cycleScrollView.selectHandler = { (index) in
            print("点击", index, "cell", self.cycleScrollView.cell(withIndex: index))
        }
        self.cycleScrollView.reloadData()
    }
}
