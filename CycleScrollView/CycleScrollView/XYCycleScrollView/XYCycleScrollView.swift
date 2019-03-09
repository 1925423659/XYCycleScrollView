//
//  MemberCycleScrollView.swift
//  MiguPlay
//
//  Created by 白野 on 2019/2/20.
//  Copyright © 2019 Migu. All rights reserved.
//

import UIKit

class XYCycleScrollView: UIView {
    weak var scrollView: UIScrollView!
    weak var contentView: UIView!
    weak var pageControl: UIPageControl!
    weak var indexLabel: UILabel!
    var cells: [XYCycleScrollViewCell]!

    var numberOfImages: (() -> Int)?
    var imageURLString: ((_ index: Int) ->String?)?
    var scrollHandler: ((_ index: Int, _ auto: Bool) -> Void)?
    var selectHandler: ((_ index: Int) -> Void)?
    
    weak var timer: Timer?
    /// 当前显示位置
    var currentIndex: Int = 0
    /// CurrentIndex指向的数据所在的Cell
    var visitIndex: Int = 1
    
    // MARK: - override
    override func awakeFromNib() {
        super.awakeFromNib()

        self.setupViews()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let view_width = self.frame.size.width
        let view_height = self.frame.size.height
        
        var x: CGFloat = 0
        var y: CGFloat = 0
        var width: CGFloat = view_width
        var height: CGFloat = view_height - 15
        self.scrollView.frame = CGRect(x: x, y: x, width: width, height: height)

        width = view_width * CGFloat(self.cells.count)
        self.scrollView.contentSize = CGSize(width: width, height: height)

        self.contentView.frame = CGRect(x: 0, y: 0, width: width, height: height)
        for (index, cell) in self.cells.enumerated() {
            cell.frame = CGRect(x: view_width * CGFloat(index), y: 0, width: view_width, height: height)
        }
        
        width = 100
        height = 10
        x = (view_width - width) * 0.5
        y = view_height - height
        self.pageControl.frame = CGRect(x: x, y: y, width: width, height: height)
        
        width = 36
        height = 18
        x = view_width - width - 5
        y = self.scrollView.frame.origin.y + self.scrollView.frame.size.height - height - 5
        self.indexLabel.frame = CGRect(x: x, y: y, width: width, height: height)
        
        // 在此滚动一次，防止页面加载时frame未刷新，导致位置错乱
        self.scrollView.contentOffset = CGPoint(x: self.scrollView.frame.size.width, y: 0)
    }
    
    // MARK: - Views
    func setupViews() {
        let scrollView = UIScrollView()
        scrollView.layer.masksToBounds = true
        scrollView.layer.cornerRadius = 5
        scrollView.isPagingEnabled = true
        scrollView.bounces = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.delegate = self
        self.addSubview(scrollView)
        self.scrollView = scrollView
        
        let contentView = UIView()
        scrollView.addSubview(contentView)
        self.contentView = contentView
        
        let pageControl = UIPageControl()
        pageControl.pageIndicatorTintColor = UIColor(displayP3Red: 230.0/255.0, green: 230.0/255.0, blue: 230.0/255.0, alpha: 1)
        pageControl.currentPageIndicatorTintColor = UIColor(displayP3Red: 0, green: 172.0/255.0, blue: 252.0/255.0, alpha: 1)
        self.addSubview(pageControl)
        self.pageControl = pageControl
        
        let indexLabel = UILabel()
        indexLabel.layer.masksToBounds = true
        indexLabel.layer.cornerRadius = 10
        indexLabel.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
        indexLabel.textAlignment = .center
        indexLabel.textColor = UIColor.white
        indexLabel.font = UIFont.systemFont(ofSize: 11)
        self.addSubview(indexLabel)
        self.indexLabel = indexLabel
        
        var cells = [XYCycleScrollViewCell]()
        for _ in 0...2 {
            let cell = XYCycleScrollViewCell()
            contentView.addSubview(cell)
            cells.append(cell)
        }
        self.cells = cells
    }
    
    // MARK: - Data
    func reloadData() {
        if let numberOfImages: Int = self.numberOfImages?() {
            self.pageControl.numberOfPages = numberOfImages
            self.updateData()
            if numberOfImages > 1 {
                self.pageControl.isHidden = false
                self.indexLabel.isHidden = false
                self.scrollView.isScrollEnabled = true
                self.startTimer()
            } else {
                self.pageControl.isHidden = true
                self.indexLabel.isHidden = true
                self.scrollView.isScrollEnabled = false
                self.stopTimer()
            }
        }
    }
    
    func updateData() {
        if let numberOfImages: Int = self.numberOfImages?() {
            // 图片总数小于1，直接返回
            if numberOfImages < 1 {
                return
            }
            
            // 将VisitIndex指向中间的Cell（第二个Cell）
            self.visitIndex = 1
            // 按顺序刷新Cell的内容
            for (index, cell) in self.cells.enumerated() {
                let imageIndex = (self.currentIndex + numberOfImages - (self.visitIndex - index)) % numberOfImages
                cell.set(withImageURLString: self.imageURLString?(imageIndex))
                cell.selectHandler = {
                    self.selectHandler?(imageIndex)
                }
            }
            
            self.scrollView.contentOffset = CGPoint(x: self.scrollView.frame.size.width, y: 0)
        }
    }
    
    func updateCurrentIndex(_ scrollView: UIScrollView) {
        let centerX: CGFloat = scrollView.contentOffset.x + scrollView.frame.size.width * 0.5
        if let numberOfImages: Int = self.numberOfImages?(), let nearestCellIndex = self.nearestCellIndex(withPointX: centerX) {
            if numberOfImages > 0 {
                // CurrentIndex指向当前正在显示的内容
                // VisitIndex指向正在显示内容所在的Cell
                self.currentIndex = (self.currentIndex + numberOfImages + nearestCellIndex - self.visitIndex) % numberOfImages
                self.visitIndex = nearestCellIndex;
                self.pageControl.currentPage = self.currentIndex
                self.indexLabel.text = "\(self.currentIndex + 1)/\(numberOfImages)"
            }
        }
    }
    
    func nearestCellIndex(withPointX x: CGFloat) -> Int? {
        if let firstCell = self.cells.first {
            var nearestOffsetX : CGFloat = x - firstCell.center.x
            var nearestIndex: Int = 0
            for (index, cell) in self.cells.enumerated() {
                let offsetX: CGFloat = x - cell.center.x
                if abs(offsetX) < abs(nearestOffsetX) {
                    nearestOffsetX = offsetX
                    nearestIndex = index
                }
            }
            return nearestIndex
        } else {
            return nil
        }
    }
    
    func cell(withIndex index: Int) -> XYCycleScrollViewCell? {
        let cellIndex = index - self.currentIndex + self.visitIndex
        if cellIndex >= 0 && cellIndex < self.cells.count {
            return self.cells[cellIndex]
        }
        return nil
    }
    
    func scrollToNextPage() {
        let offset = CGPoint(x: self.scrollView.contentOffset.x + self.scrollView.frame.size.width, y: 0)
        self.scrollView.setContentOffset(offset, animated: true)
    }
    
    // MARK: - Timer
    func startTimer() {
        if self.timer == nil {
            let timer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(timeAction), userInfo: nil, repeats: true)
            RunLoop.main.add(timer, forMode: .common)
            self.timer = timer
        }
    }
    
    func stopTimer() {
        if self.timer != nil {
            self.timer?.invalidate()
            self.timer = nil
        }
    }
    
    @objc func timeAction() {
        self.scrollToNextPage()
    }
}

extension XYCycleScrollView: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.updateCurrentIndex(scrollView)
    }
    
    /// 自动滑动停止时，该方法被调用
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        self.updateData()
        self.scrollHandler?(self.currentIndex, true)
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.stopTimer()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        self.startTimer()
    }
    
    /// 拖拽滑动停止时，该方法被调用
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        self.updateData()
        self.scrollHandler?(self.currentIndex, false)
    }
}
