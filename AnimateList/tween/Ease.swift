//
//  Ease.swift
//  FBSnapshotTestCase
//
//  Created by narongrit kanhanoi on 19/10/2560 BE.
//

public enum Ease:Int{
    case Linear
    case InQuad
    case OutQuad
    case InOutQuad
    case InCubic
    case OutCubic
    case InOutCubic
    case InQuart
    case OutQuart
    case InOutQuart
    case InQuint
    case OutQuint
    case InOutQuint
    case InSine
    case OutSine
    case InOutSine
    case InExpo
    case OutExpo
    case InOutExpo
    case InCirc
    case OutCirc
    case InOutCirc
    case InElastic
    case OutElastic
    case InOutElastic
    case InBack
    case OutBack
    case InOutBack
    case InBounce
    case OutBounce
    case InOutBounce
    
    public static let count: Int = {
        var max: Int = 0
        while let _ = Ease(rawValue: max) { max += 1 }
        return max
    }()
}

