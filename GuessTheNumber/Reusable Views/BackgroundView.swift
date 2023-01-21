//
//  BackgroundView.swift
//  GuessTheNumber
//
//  Created by Artem Kvashnin on 21.01.2023.
//

import UIKit

class BackgroundView: UIView {
    
    var lightColor: UIColor = UIColor(rgb: 0xFFFDF5)
    var darkColor: UIColor = UIColor(rgb: 0xF4F2E7)
    var patternSize: CGFloat = 12

    override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else {
            fatalError("\(#function): \(#line) Failed to get current context")
        }
        
        context.setFillColor(darkColor.cgColor)
//        context.fill(rect)
        
        let drawSize = CGSize(width: patternSize, height: patternSize)
        
        UIGraphicsBeginImageContextWithOptions(drawSize, true, 0.0)
        
        guard let drawingContext = UIGraphicsGetCurrentContext() else {
            fatalError("\(#function): \(#line) Failed to get current context")
        }
        
        darkColor.setFill()
        drawingContext.fill(CGRect(x: 0, y: 0, width: drawSize.width, height: drawSize.height))
        
        drawTrianglePath(in: drawSize, color: lightColor)
        
        guard let image = UIGraphicsGetImageFromCurrentImageContext() else {
            fatalError("""
              \(#function): \(#line) Failed to \
              get an image from current context.
              """)
        }
        
        UIGraphicsEndImageContext()
        
        UIColor(patternImage: image).setFill()
        context.fill(rect)
        
    }
    
    func drawTrianglePath(in drawSize: CGSize, color: UIColor) {
        let trianglePath  = UIBezierPath()
        
        trianglePath.move(to: CGPoint(x: drawSize.width / 2, y: 0))
        trianglePath.addLine(to: CGPoint(x: 0, y: drawSize.height / 2))
        trianglePath.addLine(to: CGPoint(x: drawSize.width, y: drawSize.height / 2))
        trianglePath.addLine(to: CGPoint(x: drawSize.width / 2, y: 0))
        
        trianglePath.move(to: CGPoint(x: 0, y: drawSize.height / 2))
        trianglePath.addLine(to: CGPoint(x: 0, y: drawSize.height))
        trianglePath.addLine(to: CGPoint(x: drawSize.width / 2 , y: drawSize.height))
        trianglePath.addLine(to: CGPoint(x: 0, y: drawSize.height / 2))
        
        trianglePath.move(to: CGPoint(x: drawSize.width, y: drawSize.height / 2))
        trianglePath.addLine(to: CGPoint(x: drawSize.width / 2, y: drawSize.height))
        trianglePath.addLine(to: CGPoint(x: drawSize.width, y: drawSize.height))
        trianglePath.addLine(to: CGPoint(x: drawSize.width, y: drawSize.height / 2))
        
        color.setFill()
        trianglePath.fill()
    }
}
