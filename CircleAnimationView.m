//
//  CircleAnimationView.m
//  testanimation
//
//  Created by attaphon on 9/9/2559 BE.
//  Copyright © 2559 attaphon. All rights reserved.
//

#import "CircleAnimationView.h"
#import <QuartzCore/QuartzCore.h>

#define PREV_IMAGE @"prevImage"
#define CURRENT_IMAGE @"prevImage"
#define NEXT_IMAGE @"prevImage"

@implementation CircleAnimationView
-(instancetype)initWithFrame:(CGRect)rect{
    
    if ((self = [super initWithFrame:rect])) {
        CGRect screenRect = [[UIScreen mainScreen] bounds];
        screenWidth = screenRect.size.width;
        scaleRatio = 0.85;
        
        frame = rect;
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, rect.size.width, rect.size.height)];
       
        imageView.layer.cornerRadius = rect.size.width/2;
        [imageView.layer setMasksToBounds:YES];
        
        [imageView setBackgroundColor:[UIColor clearColor]];
        
        showImageView = imageView;
        
        [self addSubview:imageView];
    }
    return self;
    
    
}
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
     [showImageView setImage:[UIImage imageNamed:_imageArray[_index]]];
   
    //[self runSpinAnimationOnView:showImageView duration:1 rotations:0.25 repeat:1000];
    
}

-(void)nextImage{
    
    if(!waitNext){
        if(_imageArray.count > _index+1){
            _index = _index+1;
        }
        else{
            _index = 0;
        }
        waitNext = YES;
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
    [imageView setImage:[UIImage imageNamed:_imageArray[_index]]];
    imageView.layer.cornerRadius = imageView.frame.size.width/2;
    [imageView.layer setMasksToBounds:YES];
    imageView.transform = CGAffineTransformScale(CGAffineTransformIdentity, scaleRatio, scaleRatio);
    [imageView setBackgroundColor:[UIColor clearColor]];
        imageView.alpha = 0;
    __weak UIImageView *temp = showImageView;
    showImageView = imageView;
    
    [self addSubview:imageView];
    
    [self bringSubviewToFront:temp];
    [UIView transitionWithView:self
                      duration:0.5
                       options:UIViewAnimationOptionCurveLinear
                    animations:^{
                        
                        [temp setFrame:CGRectMake(screenWidth, showImageView.frame.origin.y, 200, 200)];
                        [temp setAlpha:0];
               
                        
                    }
                    completion:^(BOOL finished) {
                          [temp.layer removeAnimationForKey:@"rotationAnimation"];
                          waitNext = NO;
                         [temp removeFromSuperview];
                        
                        
                        if ([[self delegate] respondsToSelector:@selector(nextCircleAnimationFinished)]) {
                            [self.delegate nextCircleAnimationFinished];
                        }
                    }];
        
        [UIView transitionWithView:self
                          duration:0.3
                           options:UIViewAnimationOptionCurveLinear
                        animations:^{
                            showImageView.alpha = 1;
                            showImageView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1, 1);
                        }
                        completion:^(BOOL finished) {
                            
                        }];
        
    }
    
}
-(void)setAnimation{
    if(![showImageView.layer animationForKey:@"rotationAnimation"])
        [self runSpinAnimationOnView:showImageView duration:1 rotations:0.25 repeat:1000];
}
-(void)prevImage{
    if(!waitPrevious){
        if(_index - 1 >= 0){
            _index = _index - 1;
        }
        else{
            _index = (int)(_imageArray.count) - 1;
        }
        waitPrevious= YES;
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
    [imageView setImage:[UIImage imageNamed:_imageArray[_index]]];
    imageView.layer.cornerRadius = imageView.frame.size.width/2;
    [imageView.layer setMasksToBounds:YES];
    imageView.transform = CGAffineTransformScale(CGAffineTransformIdentity, scaleRatio, scaleRatio);
    [imageView setBackgroundColor:[UIColor clearColor]];
     imageView.alpha = 0;
    __weak UIImageView *temp = showImageView;
    showImageView = imageView;
    
    [self addSubview:imageView];
    
    [self bringSubviewToFront:temp];
    [UIView transitionWithView:self
                      duration:0.5
                       options:UIViewAnimationOptionCurveLinear
                    animations:^{
                        
                        [temp setFrame:CGRectMake(-screenWidth/2-showImageView.frame.size.width, showImageView.frame.origin.y, 200, 200)];
                        [temp setAlpha:0];
                        
                        
                    }
                    completion:^(BOOL finished) {
                        [temp.layer removeAnimationForKey:@"rotationAnimation"];
                        [temp removeFromSuperview];
                
                        waitPrevious = NO;
                        if ([[self delegate] respondsToSelector:@selector(prevCircleAnimationFinished)]) {
                            [self.delegate prevCircleAnimationFinished];
                        }
                    }];
        
        [UIView transitionWithView:self
                          duration:0.3
                           options:UIViewAnimationOptionCurveLinear
                        animations:^{
                            showImageView.alpha = 1;
                            showImageView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1, 1);
                        }
                        completion:^(BOOL finished) {
                      
                        }];
        
        
    }
    
}
- (void) runSpinAnimationOnView:(UIView*)view duration:(CGFloat)duration rotations:(CGFloat)rotations repeat:(float)repeat;
{
    
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 /* full rotation*/ * rotations * duration ];
    rotationAnimation.duration = duration;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = INFINITY;
    
    [view.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
}

@end
