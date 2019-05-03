//
//  ViewController.swift
//  CardiodDraw
//
//  Created by Yassir RAMDANI on 5/3/19.
//  Copyright © 2019 Yassir RAMDANI. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let cardioid = CAShapeLayer()
    let dots = CAShapeLayer()
    let lines = CAShapeLayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        drawCardioid(100)
        view.addSubview(slider)
        slider.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -48).isActive = true
        slider.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 22).isActive = true
        slider.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -22).isActive = true
        slider.value = 100
    }
    
    let slider : UISlider = {
        let sl = UISlider()
        sl.translatesAutoresizingMaskIntoConstraints = false
        sl.maximumValue = 1000
        sl.minimumValue = 0
        sl.addTarget(self, action: #selector(didSlide(_:)), for: .valueChanged)
        return sl
    }()
    
    @objc func didSlide(_ sender: Any) {
        drawCardioid(Int(slider.value))
    }

    func drawCardioid(_ n: Int) {
        
        let pi2 = CGFloat.pi * 2
        
        let r = view.frame.width / 2 - 40
        let center = view.center
        
        
        
        lines.strokeColor = UIColor.blue.cgColor
        let linesPath = UIBezierPath()
        
        let dotsPath = UIBezierPath()
        
        dots.strokeColor = UIColor.red.cgColor
        
        cardioid.fillColor = UIColor.lightGray.cgColor
        cardioid.strokeColor = UIColor.red.cgColor
        let bezP = UIBezierPath(arcCenter: center, radius: r,
                                startAngle: 0,
                                endAngle: pi2,
                                clockwise: true)
        
        for i in 0 ..< n {
            let alpha = CGFloat(i) * (pi2 / CGFloat(n))
            var pt = center
            pt.x += r * cos(alpha)
            pt.y += r * sin(alpha)
            
            let dot = UIBezierPath(arcCenter:  pt, radius: 2, startAngle: 0, endAngle: pi2, clockwise: true)
            dotsPath.append(dot)
            
            let line = UIBezierPath()
            line.move(to: pt)
            
            let beta = CGFloat((2*i) % n) * (pi2 / CGFloat(n))
            var to = center
            to.x += r * cos(beta)
            to.y += r * sin(beta)
            line.addLine(to: to)
            
            linesPath.append(line)
        }
        
        cardioid.path = bezP.cgPath
        dots.path = dotsPath.cgPath
        lines.path = linesPath.cgPath
        
        view.layer.addSublayer(cardioid)
        view.layer.addSublayer(dots)
        view.layer.addSublayer(lines)
    }

}

