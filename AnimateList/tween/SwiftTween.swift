//
//  SwiftTween.swift
//  FBSnapshotTestCase
//
//  Created by narongrit kanhanoi on 19/10/2560 BE.
//

import UIKit

public class SwiftTween {
    
    var frameRate:Double! = 60
    private var timer:Timer!
    
    private var startTime:Double!
    private var currentTime:Double!
    
    private var startValue:Double!
    private var endValue:Double!
    private var timeDuration:Double!
    private var ease:Ease!
    
    public typealias OnUpdate = (Double,Double,Bool)->Void
    
    public var onUpdate:OnUpdate? = nil
    
    public func tween(startValue:Double!, endValue:Double!, timeDuration:Double!, ease:Ease! ){
        
        let timeInterval:Double =  1.0 / self.frameRate
        
        self.startValue = startValue
        self.endValue = endValue
        self.timeDuration = timeDuration
        self.ease = ease
        
        self.startTime = Date.timeIntervalSinceReferenceDate
        
        self.timer = Timer.scheduledTimer(timeInterval:timeInterval , target: self, selector: #selector(onTimer), userInfo: nil, repeats: true)
    }
    
    @objc func onTimer(){
        self.currentTime = Date.timeIntervalSinceReferenceDate
        
        let timePassed:Double = Double( self.currentTime - self.startTime )
        var value:Double
        
        if(timePassed < self.timeDuration ){
            value = EasingFunction.getValue(ease: self.ease,
                                            currentTime:timePassed, beginningValue:self.startValue, finalValue: self.endValue, totalDuration:self.timeDuration)
            
            if let onUpdate = self.onUpdate {
                onUpdate(value,timePassed,false)
            }
            
        }else{
            value = EasingFunction.getValue(ease:self.ease, currentTime:timePassed, beginningValue: self.startValue, finalValue:self.endValue, totalDuration:self.timeDuration)
            
            if let onUpdate = self.onUpdate {
                onUpdate(value,timePassed,true)
            }

            self.timer.invalidate()
        }
        
    }
}
