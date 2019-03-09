//
//  MemberCycleScrollViewCell.swift
//  MiguPlay
//
//  Created by 白野 on 2019/2/20.
//  Copyright © 2019 Migu. All rights reserved.
//

import UIKit

class XYCycleScrollViewCell: UIView {
    weak var imageView: UIImageView!
    weak var button: UIButton!

    var selectHandler: (() -> Void)?
    
    // MARK: - override
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.imageView.frame = self.bounds
        self.button.frame = self.bounds
    }
    
    // MARK: - Views
    func setupViews() {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        self.addSubview(imageView)
        self.imageView = imageView
        
        let button = UIButton(type: .custom)
        button.addTarget(self, action: #selector(buttonTouchUpInside), for: .touchUpInside)
        self.addSubview(button)
        self.button = button
    }
    
    @objc func buttonTouchUpInside() {
        self.selectHandler?()
    }
    
    // MARK: - Setter
    func set(withImageURLString imageURLString: String?) {
        if let imageURLString = imageURLString {
            self.imageView.sd_setImage(with: URL(string: imageURLString), completed: nil)
        } else {
            self.imageView.image = nil
        }
    }
}
