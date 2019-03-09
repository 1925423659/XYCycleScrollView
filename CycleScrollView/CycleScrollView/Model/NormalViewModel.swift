//
//  NormalViewModel.swift
//  CycleScrollView
//
//  Created by 白野 on 2019/3/9.
//  Copyright © 2019 白野. All rights reserved.
//

import UIKit

class NormalViewModel: NSObject {
    var images: [[String: String]]!
    
    func reloadData() {
        self.images = [["url": "http://img3.imgtn.bdimg.com/it/u=1677053002,1070893931&fm=26&gp=0.jpg"],
                       ["url": "http://img4.imgtn.bdimg.com/it/u=1843568763,107432329&fm=26&gp=0.jpg"],
                       ["url": "http://img1.imgtn.bdimg.com/it/u=2525218791,1960486034&fm=26&gp=0.jpg"],
                       ["url": "http://img4.imgtn.bdimg.com/it/u=3528623204,755864954&fm=26&gp=0.jpg"],
                       ["url": "http://img1.imgtn.bdimg.com/it/u=2385559734,1542652885&fm=26&gp=0.jpg"],
                       ["url": "http://img5.imgtn.bdimg.com/it/u=3116845678,3544143401&fm=26&gp=0.jpg"]]
    }
}
