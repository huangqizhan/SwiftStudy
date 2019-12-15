//
//  ReplicatorLayer.swift
//  SwiftStudy
//
//  Created by hjb_mac_mini on 2019/12/15.
//  Copyright © 2019 8km. All rights reserved.
//

import UIKit

class ReplicatorLayer: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.createLayer()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func createLayer()  {
        let layer = CALayer.init();
        layer.frame = self.bounds
        layer.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        layer.backgroundColor = UIColor.white.cgColor
        layer.add(self.saclAnimation(), forKey: "scaleAnimation")
        
        
        let replicatiorLayer = CAReplicatorLayer.init()
        replicatiorLayer.instanceCount = 4
        //设置子层相对于前一个层的偏移量
        replicatiorLayer.instanceTransform = CATransform3DMakeScale(5, 0, 0)
        //设置子层相对于前一个层的延迟时间
        replicatiorLayer.instanceDelay = 0.2  //设置层的颜色，(前提是要设置层的背景颜色，如果没有设置背景颜色，默认是透明的，再设置这个属性不会有效果。
        replicatiorLayer.instanceColor = HButtonColor.cgColor
        //需要把子层加入到复制层中，复制层按照前面设置的参数自动复制
        replicatiorLayer.addSublayer(layer)
        self.layer.addSublayer(replicatiorLayer)
    }
}


extension ReplicatorLayer{
   fileprivate func saclAnimation() -> CABasicAnimation {
    let animation = CABasicAnimation.init(keyPath: "transform.scale.y")
    animation.toValue = 0.1
    animation.duration = 0.4
    animation.autoreverses = true
    animation.isRemovedOnCompletion = false
    animation.repeatCount = MAXFLOAT
    return animation
    }
}

