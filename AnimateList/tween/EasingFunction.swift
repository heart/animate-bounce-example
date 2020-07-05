//
//  EasingFunction.swift
//  FBSnapshotTestCase
//
//  Created by narongrit kanhanoi on 19/10/2560 BE.
//

import UIKit

public class EasingFunction: NSObject {
    
    public static func getRatio(ease:Ease, timeRatio:Double)->Double{
        
        var n = timeRatio
        
        switch ease {
            case .Linear:
                return n
            case .InQuad:
                return n * n;
            case .OutQuad:
                return n * (2 - n);
            case .InOutQuad:
                n *= 2
                if n < 1{
                    return 0.5 * n * n
                }
                n -= 1
                return -0.5 * ( n * (n - 2) - 1)
            case .InCubic:
                return n * n * n;
            case .OutCubic:
                n -= 1
                return n * n * n + 1;
            case .InOutCubic:
                n *= 2;
                if n < 1 {
                    return 0.5 * n * n * n
                }
                
                n -= 2
                return 0.5 * ( n * n * n + 2)
            case .InQuart:
                return n * n * n * n;
            case .OutQuart:
                n -= 1
                return 1 - (n * n * n * n);
            case .InOutQuart:
                n *= 2;
                if n < 1{
                    return 0.5 * n * n * n * n;
                }
                
                n -= 2
                return -0.5 * (n * n * n * n - 2);
            case .InQuint:
                return n * n * n * n * n;
            case .OutQuint:
                n -= 1
                return n * n * n * n * n + 1;
            case .InOutQuint:
                n *= 2;
                if n < 1{
                    return 0.5 * n * n * n * n * n;
                }
                
                n -= 2
                return 0.5 * (n * n * n * n * n + 2);
            case .InSine:
                return 1 - cos(n * Double.pi / 2 );
            case .OutSine:
                return sin(n * Double.pi / 2);
            case .InOutSine:
                return 0.5 * (1 - cos( Double.pi * n));
            case .InExpo:
                return 0 == n ? 0 : pow(1024, n - 1);
            case .OutExpo:
                return 1 == n ? n : 1 - pow(2, -10 * n);
            case .InOutExpo:
                if 0 == n{
                    return 0;
                }
                if 1 == n{
                    return 1;
                }
                n *= 2
                if n < 1{
                    return 0.5 * pow(1024, n - 1);
                }
                
                return 0.5 * (-pow(2, -10 * (n - 1)) + 2);
            case .InCirc:
                return 1 - sqrt(1 - n * n);
            case .OutCirc:
                n -= 1
                return sqrt(1 - (n * n) );
            case .InOutCirc:
                n *= 2
                if n < 1{
                    return -0.5 * (sqrt(1 - n * n) - 1);
                }
                
                n -= 2
                return 0.5 * (sqrt(1 - n * n) + 1);
            case .InElastic:
                
                var s:Double
                var a = 0.1
                let p = 0.4;
                
                if  n == 0 {
                    return 0;
                }
                
                if  n == 1 {
                    return 1;
                }
                
                if  a < 1 {
                    a = 1;
                    s = p / 4;
                }else{
                    s = p * asin( 1 / a ) / ( 2 * Double.pi );
                }
                
                 n -= 1
                return -( a * pow( 2, 10 * n ) * sin( ( n - s ) * ( 2 * Double.pi ) / p ) );
            
            case .OutElastic:
                var s:Double
                var a = 0.1
                let p = 0.4
                
                if  n == 0 {
                    return 0;
                }
                
                if  n == 1{
                    return 1;
                }
                
                if a < 1 {
                    a = 1;
                    s = p / 4;
                }else{
                    s = p * asin( 1 / a ) / ( 2 * Double.pi );
                }
                
                return ( a * pow( 2, -10 * n) * sin( ( n - s ) * ( 2 * Double.pi ) / p ) + 1 );
            case .InOutElastic:
                var s:Double
                var a = 0.1
                let p = 0.4
                
                if ( n == 0 ){
                    return 0;
                }
                
                if ( n == 1 ){
                    return 1;
                }
                if a < 1 {
                    a = 1; s = p / 4;
                }else{
                    s = p * asin( 1 / a ) / ( 2 * Double.pi );
                }
                
                
                n *= 2
                if ( n < 1 ){
                    
                    n -= 1
                    return -0.5 * ( a * pow( 2, 10 * n ) * sin( ( n - s ) * ( 2 * Double.pi ) / p ) );
                }
                
                
                n -= 1
                return a * pow( 2, -10 * n ) * sin( ( n - s ) * ( 2 * Double.pi ) / p ) * 0.5 + 1;
            
            case .InBack:
                
                let s = 1.70158;
                return n * n * (( s + 1 ) * n - s);
            
            case .OutBack:
                
                let s = 1.70158;
                n -= 1
                return n * n * ((s + 1) * n + s) + 1;
            
            case .InOutBack:
                
                let s = 1.70158 * 1.525;
                
                n *= 2
                if  n < 1 {
                    return 0.5 * ( n * n * ( ( s + 1 ) * n - s ) );
                }
                
                n -= 2
                return 0.5 * ( n * n * ( ( s + 1 ) * n + s ) + 2 );
            case .InBounce:
                return 1 - EasingFunction.getRatio(ease:.OutBounce, timeRatio:1-n )
            case .OutBounce:
                if ( n < ( 1 / 2.75 ) ) {
                    return 7.5625 * n * n;
                } else if ( n < ( 2 / 2.75 ) ) {
                    
                    n -= ( 1.5 / 2.75 )
                    return 7.5625 * n  * n + 0.75;
                } else if ( n < ( 2.5 / 2.75 ) ) {
                    n -= ( 2.25 / 2.75 )
                    return 7.5625 * n * n + 0.9375;
                } else {
                    n -= ( 2.625 / 2.75 )
                    return 7.5625 * n * n + 0.984375;
                }
            case .InOutBounce:
                if (n < 0.5){
                    return EasingFunction.getRatio(ease:.InBounce, timeRatio:n * 2 ) * 0.5;
                }
                
                return EasingFunction.getRatio(ease:.OutBounce, timeRatio:n * 2 - 1 ) * 0.5 + 0.5;
        }
    }
    
    public static func getValue(ease:Ease, currentTime:Double, beginningValue:Double, finalValue:Double, totalDuration:Double)->Double{
        
        let timeRatio = currentTime/totalDuration
        let ratio = EasingFunction.getRatio(ease:ease, timeRatio:timeRatio )
        return beginningValue+( ratio * (finalValue-beginningValue) )
        
    }
}




