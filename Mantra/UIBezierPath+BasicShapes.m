//
//  UIBezierPath+UIBezierPath_BasicShapes.m
//  Example
//
//  Created by Pierre Dulac on 26/02/13.
//  Copyright (c) 2013 Pierre Dulac. All rights reserved.
//

#import "UIBezierPath+BasicShapes.h"

@implementation UIBezierPath (BasicShapes)

+ (CGRect)maximumSquareFrameThatFits:(CGRect)frame;
{
    CGFloat a = MIN(frame.size.width, frame.size.height);
    return CGRectMake(frame.size.width/2 - a/2, frame.size.height/2 - a/2, a, a);
}

+ (UIBezierPath *)heartShape:(CGRect)originalFrame
{
    CGRect frame = [self maximumSquareFrameThatFits:originalFrame];
    
    UIBezierPath* bezier3Path = [UIBezierPath bezierPath];
    
    [bezier3Path moveToPoint: CGPointMake(CGRectGetMinX(frame) + 66.6, CGRectGetMinY(frame) + 52.32)];
    [bezier3Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 77.41, CGRectGetMinY(frame) + 61.96) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 66.6, CGRectGetMinY(frame) + 52.32) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 77.64, CGRectGetMinY(frame) + 62.28)];
    [bezier3Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 93.04, CGRectGetMinY(frame) + 19.78) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 77.19, CGRectGetMinY(frame) + 61.64) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 82.49, CGRectGetMinY(frame) + 8.03)];
    [bezier3Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 119.48, CGRectGetMinY(frame) + 61.96) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 103.59, CGRectGetMinY(frame) + 31.54) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 116.08, CGRectGetMinY(frame) + 36.38)];
    [bezier3Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 119.48, CGRectGetMinY(frame) + 114.99) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 122.87, CGRectGetMinY(frame) + 87.55) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 131.13, CGRectGetMinY(frame) + 111.7)];
    [bezier3Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 77.41, CGRectGetMinY(frame) + 114.99) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 107.83, CGRectGetMinY(frame) + 118.28) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 77.41, CGRectGetMinY(frame) + 125.54)];
    [bezier3Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 77.41, CGRectGetMinY(frame) + 72.81) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 77.41, CGRectGetMinY(frame) + 104.44) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 77.41, CGRectGetMinY(frame) + 73.11)];
    [bezier3Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 62.99, CGRectGetMinY(frame) + 58.33) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 77.41, CGRectGetMinY(frame) + 72.56) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 66.66, CGRectGetMinY(frame) + 61.94)];
    [bezier3Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 48.58, CGRectGetMinY(frame) + 72.81) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 59.33, CGRectGetMinY(frame) + 61.94) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 48.58, CGRectGetMinY(frame) + 72.56)];
    [bezier3Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 48.58, CGRectGetMinY(frame) + 114.99) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 48.58, CGRectGetMinY(frame) + 73.11) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 48.58, CGRectGetMinY(frame) + 104.44)];
    [bezier3Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 6.51, CGRectGetMinY(frame) + 114.99) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 48.58, CGRectGetMinY(frame) + 125.54) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 18.16, CGRectGetMinY(frame) + 118.28)];
    [bezier3Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 6.51, CGRectGetMinY(frame) + 61.96) controlPoint1: CGPointMake(CGRectGetMinX(frame) - 5.14, CGRectGetMinY(frame) + 111.7) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 3.12, CGRectGetMinY(frame) + 87.55)];
    [bezier3Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 32.95, CGRectGetMinY(frame) + 19.78) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 9.9, CGRectGetMinY(frame) + 36.38) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 22.4, CGRectGetMinY(frame) + 31.54)];
    [bezier3Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 48.58, CGRectGetMinY(frame) + 61.96) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 43.5, CGRectGetMinY(frame) + 8.03) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 48.8, CGRectGetMinY(frame) + 61.64)];
    [bezier3Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 59.39, CGRectGetMinY(frame) + 52.32) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 48.35, CGRectGetMinY(frame) + 62.28) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 59.39, CGRectGetMinY(frame) + 52.32)];
    [bezier3Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 59.39, CGRectGetMinY(frame) + 0.5)];
    [bezier3Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 66.6, CGRectGetMinY(frame) + 0.5)];
    [bezier3Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 66.6, CGRectGetMinY(frame) + 52.32)];

    [bezier3Path closePath];
    bezier3Path.miterLimit = 4;
    
    return bezier3Path;
    
}

+ (UIBezierPath *)martiniShape:(CGRect)originalFrame
{
    CGRect frame = [self maximumSquareFrameThatFits:originalFrame];
    
    UIBezierPath* bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.33980 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.99174 * CGRectGetHeight(frame))];
    [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.35471 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.98285 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.34475 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.98872 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.34935 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.98462 * CGRectGetHeight(frame))];
    [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.46691 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.94635 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.39206 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.97052 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.42994 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.95972 * CGRectGetHeight(frame))];
    [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.50127 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.89428 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.50294 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.93333 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.50324 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.93221 * CGRectGetHeight(frame))];
    [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.47934 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.48717 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.49420 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.75856 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.48655 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.62288 * CGRectGetHeight(frame))];
    [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.45734 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.44393 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.47838 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.46920 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.47255 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.45603 * CGRectGetHeight(frame))];
    [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.16428 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.20750 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.35906 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.36587 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.26184 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.28648 * CGRectGetHeight(frame))];
    [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.15320 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.19354 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.16040 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.20436 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.15664 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.20107 * CGRectGetHeight(frame))];
    [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.29889 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.19354 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.20176 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.19354 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.25033 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.19354 * CGRectGetHeight(frame))];
    [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.30104 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.18650 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.29961 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.19119 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.30032 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.18885 * CGRectGetHeight(frame))];
    [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.28597 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.17821 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.29604 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.18361 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.29131 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.17917 * CGRectGetHeight(frame))];
    [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.26643 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.17965 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.27974 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.17710 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.27297 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.17908 * CGRectGetHeight(frame))];
    [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.18842 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.09291 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.21686 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.18396 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.17498 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.13771 * CGRectGetHeight(frame))];
    [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.20113 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.06899 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.19098 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.08438 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.19543 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.07577 * CGRectGetHeight(frame))];
    [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.20197 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.03639 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.21061 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.05770 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.21021 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.04776 * CGRectGetHeight(frame))];
    [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.20014 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.01653 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.19775 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.03056 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.19238 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.02389 * CGRectGetHeight(frame))];
    [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.20622 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.01653 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.20217 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.01653 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.20419 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.01653 * CGRectGetHeight(frame))];
    [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.26086 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.04176 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.21808 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.03887 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.23599 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.04483 * CGRectGetHeight(frame))];
    [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.32572 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.07827 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.28981 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.03818 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.31259 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.05373 * CGRectGetHeight(frame))];
    [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.32127 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.15045 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.33827 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.10174 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.33652 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.12710 * CGRectGetHeight(frame))];
    [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.31470 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.17645 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.31626 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.15812 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.30828 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.16529 * CGRectGetHeight(frame))];
    [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.34288 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.19198 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.32111 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.18760 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.32943 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.19194 * CGRectGetHeight(frame))];
    [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.85274 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.19471 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.51283 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.19249 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.68279 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.19369 * CGRectGetHeight(frame))];
    [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.87303 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.19471 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.85817 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.19474 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.86360 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.19471 * CGRectGetHeight(frame))];
    [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.85907 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.20696 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.86625 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.20068 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.86277 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.20395 * CGRectGetHeight(frame))];
    [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.55737 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.45244 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.75854 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.28883 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.65802 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.37072 * CGRectGetHeight(frame))];
    [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.54495 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.47493 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.54995 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.45846 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.54548 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.46444 * CGRectGetHeight(frame))];
    [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.53465 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.64813 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.54201 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.53269 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.53739 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.59036 * CGRectGetHeight(frame))];
    [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.52367 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.90977 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.53051 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.73532 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.52772 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.82257 * CGRectGetHeight(frame))];
    [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.54174 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.93805 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.52297 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.92467 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.52709 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.93346 * CGRectGetHeight(frame))];
    [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.62181 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.96534 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.56864 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.94648 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.59556 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.95510 * CGRectGetHeight(frame))];
    [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.67679 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.99174 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.64069 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.97271 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.65850 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.98284 * CGRectGetHeight(frame))];
    [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.33980 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.99174 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.56446 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.99174 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.45213 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.99174 * CGRectGetHeight(frame))];
    [bezierPath closePath];
    bezierPath.miterLimit = 4;
    
    return bezierPath;
}

+ (UIBezierPath *)beakerShape:(CGRect)originalFrame
{
    CGRect frame = [self maximumSquareFrameThatFits:originalFrame];
    
    UIBezierPath* bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.89190 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.77619 * CGRectGetHeight(frame))];
    [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.88494 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.77738 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.88969 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.77689 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.88738 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.77738 * CGRectGetHeight(frame))];
    [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.76291 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.77738 * CGRectGetHeight(frame))];
    [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.73976 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.75427 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.75012 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.77738 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.73976 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.76703 * CGRectGetHeight(frame))];
    [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.76291 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.73115 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.73976 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.74150 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.75012 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.73115 * CGRectGetHeight(frame))];
    [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.86154 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.73115 * CGRectGetHeight(frame))];
    [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.80844 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.64991 * CGRectGetHeight(frame))];
    [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.80078 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.65130 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.80603 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.65076 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.80347 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.65130 * CGRectGetHeight(frame))];
    [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.67874 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.65130 * CGRectGetHeight(frame))];
    [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.65560 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.62819 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.66596 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.65130 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.65560 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.64096 * CGRectGetHeight(frame))];
    [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.67874 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.60507 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.65560 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.61542 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.66596 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.60507 * CGRectGetHeight(frame))];
    [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.77914 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.60507 * CGRectGetHeight(frame))];
    [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.72683 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.52505 * CGRectGetHeight(frame))];
    [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.72503 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.52522 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.72623 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.52510 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.72565 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.52522 * CGRectGetHeight(frame))];
    [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.60300 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.52522 * CGRectGetHeight(frame))];
    [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.57985 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.50211 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.59021 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.52522 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.57985 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.51488 * CGRectGetHeight(frame))];
    [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.60300 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.47900 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.57985 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.48934 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.59021 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.47900 * CGRectGetHeight(frame))];
    [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.69674 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.47900 * CGRectGetHeight(frame))];
    [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.63128 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.37884 * CGRectGetHeight(frame))];
    [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.63071 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.35425 * CGRectGetHeight(frame))];
    [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.54619 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.35425 * CGRectGetHeight(frame))];
    [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.52304 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.33114 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.53340 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.35425 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.52304 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.34391 * CGRectGetHeight(frame))];
    [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.54619 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.30803 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.52304 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.31837 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.53340 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.30803 * CGRectGetHeight(frame))];
    [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.62963 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.30803 * CGRectGetHeight(frame))];
    [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.62696 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.19259 * CGRectGetHeight(frame))];
    [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.54619 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.19259 * CGRectGetHeight(frame))];
    [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.52304 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.16947 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.53340 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.19259 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.52304 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.18224 * CGRectGetHeight(frame))];
    [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.54619 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.14636 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.52304 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.15671 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.53340 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.14636 * CGRectGetHeight(frame))];
    [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.62595 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.14636 * CGRectGetHeight(frame))];
    [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.67084 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.01163 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.62461 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.09553 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.62442 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.05885 * CGRectGetHeight(frame))];
    [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.33609 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.01179 * CGRectGetHeight(frame))];
    [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.38337 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.17174 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.39107 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.06571 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.38277 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.10648 * CGRectGetHeight(frame))];
    [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.38526 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.37784 * CGRectGetHeight(frame))];
    [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.11743 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.77851 * CGRectGetHeight(frame))];
    [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.20277 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.98578 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.05262 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.88643 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.09646 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.99201 * CGRectGetHeight(frame))];
    [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.81752 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.98640 * CGRectGetHeight(frame))];
    [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.89190 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.77619 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.92945 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.98593 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.97211 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.88501 * CGRectGetHeight(frame))];
    [bezierPath closePath];
    bezierPath.miterLimit = 4;
    
    return bezierPath;
}

+ (UIBezierPath *)starShape:(CGRect)originalFrame
{
    CGRect frame = [self maximumSquareFrameThatFits:originalFrame];
    
    UIBezierPath* bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.50000 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.05000 * CGRectGetHeight(frame))];
    [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.67634 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.30729 * CGRectGetHeight(frame))];
    [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.97553 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.39549 * CGRectGetHeight(frame))];
    [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.78532 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.64271 * CGRectGetHeight(frame))];
    [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.79389 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.95451 * CGRectGetHeight(frame))];
    [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.50000 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.85000 * CGRectGetHeight(frame))];
    [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.20611 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.95451 * CGRectGetHeight(frame))];
    [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.21468 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.64271 * CGRectGetHeight(frame))];
    [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.02447 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.39549 * CGRectGetHeight(frame))];
    [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.32366 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.30729 * CGRectGetHeight(frame))];
    [bezierPath closePath];
    
    return bezierPath;
}

+ (UIBezierPath *)stars:(NSUInteger)numberOfStars shapeInFrame:(CGRect)originalFrame
{
    // divide the original frame into equally sized frames
    CGFloat w = originalFrame.size.width/numberOfStars;
    CGRect babyFrame = CGRectMake(0, 0, w, originalFrame.size.height);
    UIBezierPath* bezierPath = [UIBezierPath bezierPath];
    
    for (int i=0; i < numberOfStars; i++) {
        // get the star shape
        UIBezierPath* startPath = [UIBezierPath starShape:babyFrame];
        // move it to the desired location
        [startPath applyTransform:CGAffineTransformTranslate(CGAffineTransformIdentity, i*w, 0)];
        // add the path
        [bezierPath appendPath:startPath];
    }
    
    return bezierPath;
}

@end
