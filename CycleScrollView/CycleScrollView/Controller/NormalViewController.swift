//
//  NormalViewController.swift
//  CycleScrollView
//
//  Created by 白野 on 2019/3/9.
//  Copyright © 2019 白野. All rights reserved.
//

import UIKit

class NormalViewController: UIViewController {
    @IBOutlet weak var cycleScrollView: XYCycleScrollView!
    
    var viewModel: NormalViewModel = NormalViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.viewModel.reloadData()
        
        self.cycleScrollView.numberOfImages = {
            return self.viewModel.images.count
        }
        self.cycleScrollView.imageURLString = { (index) in
            return self.viewModel.images[index]["url"]
        }
        self.cycleScrollView.scrollHandler = { (index, auto) in
            print(auto ? "滚动" : "拖动", "至", index)
        }
        self.cycleScrollView.selectHandler = { (index) in
            print("点击第", index, "个Cell", self.cycleScrollView.cell(withIndex: index))
        }
        self.cycleScrollView.reloadData()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
