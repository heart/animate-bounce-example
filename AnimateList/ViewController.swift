//
//  ViewController.swift
//  AnimateList
//
//  Created by narongrit kanhanoi on 5/7/2563 BE.
//  Copyright © 2563 narongrit kanhanoi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var drawArea: UIView!
    @IBOutlet weak var slider: UISlider!
    
    var xPos = 0
    var shapeLayer:CAShapeLayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initShapeLayer()
        drawShape(headPointOffset:0)
        
        slider.minimumValue = -100
        slider.maximumValue = 100
        slider.addTarget(self, action: #selector(onSliderValChanged(slider:event:)), for: .valueChanged)
    }
    
    @objc func onSliderValChanged(slider: UISlider, event: UIEvent) {
        if let touchEvent = event.allTouches?.first {
            switch touchEvent.phase {
            case .began:
                break
            case .moved:
                let val:CGFloat = CGFloat((slider.value / 100.0) * 50)
                headPosition = val
            case .ended:
                let val:CGFloat = CGFloat((slider.value / 100.0) * 50)
                animate(headPointOffset: val)
                break
            default:
                break
            }
        }
    }
    
    func initShapeLayer(){
        shapeLayer = CAShapeLayer()
        shapeLayer?.fillColor = UIColor.orange.cgColor
        if let shapeLayer = shapeLayer {
            drawArea.layer.addSublayer(shapeLayer)
        }
    }

    func animate(headPointOffset: CGFloat){
        let t = SwiftTween()
                
        t.onUpdate = { value,timePassed,finish in
            self.headPosition = CGFloat(value)
        }

        t.tween(startValue: Double(headPointOffset), endValue:0 , timeDuration:1 , ease:Ease.OutElastic )
    }
    
    var _headPosition:CGFloat = 0
    var headPosition: CGFloat{
        get{
            return _headPosition
        }
        set{
            _headPosition = newValue
            slider.value = Float(newValue)
            drawShape(headPointOffset: newValue)
        }
    }
    
    func drawShape(headPointOffset: CGFloat) {
        let canvasArea = drawArea.bounds
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x: canvasArea.maxX, y: 0)) // Right Top
        path.addLine(to: CGPoint(x: canvasArea.maxX, y: canvasArea.maxY)) //Right Bottom
        
        path.addLine(to: CGPoint(x: canvasArea.maxX/2, y: canvasArea.maxY)) //Center Bottom
        path.addLine(to: CGPoint(x: canvasArea.midX+headPointOffset, y: canvasArea.midY)) //Head Of Shape
        
        path.addLine(to: CGPoint(x: canvasArea.midX, y: 0)) //Center Top
        
        shapeLayer?.path = path.cgPath
    }
}
