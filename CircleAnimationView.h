//
//  CircleAnimationView.h
//  testanimation
//
//  Created by attaphon on 9/9/2559 BE.
//  Copyright © 2559 attaphon. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol CircleAnimationViewDelegate;
@interface CircleAnimationView : UIView{
    UIImageView *showImageView;
    BOOL waitPrevious;
    BOOL waitNext;
    CABasicAnimation* rotationAnimation;
    float scaleRatio;
    float screenWidth;
    CGRect frame;
}
@property(nonatomic)id<CircleAnimationViewDelegate> delegate;
@property(nonatomic) NSArray *imageArray;
@property(nonatomic)int index;

-(void)nextImage;
-(void)prevImage;
-(void)setAnimation;

@end


@protocol CircleAnimationViewDelegate <NSObject>
@optional
- (void)nextCircleAnimationFinished;
- (void)prevCircleAnimationFinished;
@end

