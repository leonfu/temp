//
//  VendorCollectionViewCell.m
//  NextIdentity
//
//  Created by Leon on 14-9-4.
//  Copyright (c) 2014年 iShanghai Creative. All rights reserved.
//

#import "VendorCollectionViewCell.h"

@implementation VendorCollectionViewCell

@synthesize vendorIconView, vendorNameLabel, vendorScoreLabel;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
     self.alpha = 1.0;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.alpha = 0.5;
    [self.superview touchesBegan:touches withEvent:event];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    self.alpha = 1.0;
    [self.superview touchesEnded:touches withEvent:event];
}


@end
