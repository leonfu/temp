//
//  PNLineChart.m
//  PNChartDemo
//
//  Created by kevin on 11/7/13.
//  Copyright (c) 2013年 kevinzhow. All rights reserved.
//

#import "PNLineChart.h"
#import "PNColor.h"
#import "PNChartLabel.h"

@implementation PNLineChart

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor whiteColor];
        self.clipsToBounds = YES;
		_chartLine = [CAShapeLayer layer];
		_chartLine.lineCap = kCALineCapRound;
		_chartLine.lineJoin = kCALineJoinBevel;
		_chartLine.fillColor   = [[UIColor whiteColor] CGColor];
		_chartLine.lineWidth   = 3.0;
		_chartLine.strokeEnd   = 0.0;
		[self.layer addSublayer:_chartLine];
    }
    
    return self;
}

-(void)setYValues:(NSArray *)yValues
{
    _yValues = yValues;
    [self setYLabels:yValues];
}

-(void)setYLabels:(NSArray *)yLabels
{
    NSInteger max = 0;
    for (NSString * valueString in yLabels) {
        NSInteger value = [valueString integerValue];
        if (value > max) {
            max = value;
        }
        
    }
    
    //Min value for Y label
    if (max < 5)
    {
        max = 5;
    }
    
    _yValueMax = (int)(max+0.5);
    
    int level = (int)(_yValueMax /[yLabels count]+0.5);
	
    NSInteger index = 0;
	NSInteger num = [yLabels count] + 1;
    if (num > 9)
    {
        num = 9;
        level = (int)(_yValueMax / (num-1) + 0.5);
    }
    CGFloat chartCavanHeight = self.frame.size.height - chartMargin * 2 - 40.0 ;
	while (num >= 0) {
        float value = level * index / (float)_yValueMax;
		PNChartLabel * label = [[PNChartLabel alloc] initWithFrame:CGRectMake(0.0,chartCavanHeight - value * chartCavanHeight + 20.0-yLabelHeight/2, 20.0, yLabelHeight)];
		[label setTextAlignment:NSTextAlignmentRight];
		label.text = [NSString stringWithFormat:@"%d",level * index];
		[self addSubview:label];
        index +=1 ;
		num -= 1;
	}

}

-(void)setXLabels:(NSArray *)xLabels
{
    _xLabels = xLabels;
    _xLabelWidth = (self.frame.size.width - chartMargin - 30.0)/[xLabels count];
    for (NSString * labelText in xLabels)
    {
        NSInteger index = [xLabels indexOfObject:labelText];
        PNChartLabel * label = [[PNChartLabel alloc] initWithFrame:CGRectMake(index * _xLabelWidth + 30.0, self.frame.size.height - 30.0, _xLabelWidth, 35.0)];
        [label setTextAlignment:NSTextAlignmentCenter];
        label.lineBreakMode = NSLineBreakByWordWrapping;
        if([xLabels count] > 9)
          label.font = [UIFont fontWithName:label.font.familyName size:8.0f];
        label.text = labelText;
        [self addSubview:label];
    }
    
}

-(void)setStrokeColor:(UIColor *)strokeColor
{
	_strokeColor = strokeColor;
	_chartLine.strokeColor = [strokeColor CGColor];
}

-(void)strokeChart
{
    UIGraphicsBeginImageContext(self.frame.size);
    
    UIBezierPath *progressline = [UIBezierPath bezierPath];
    
    CGFloat firstValue = [[_yValues objectAtIndex:0] floatValue];
    
    CGFloat xPosition = _xLabelWidth;
    
    CGFloat chartCavanHeight = self.frame.size.height - chartMargin * 2 - 40.0;
    
    float grade = (float)firstValue / (float)_yValueMax;
    [progressline moveToPoint:CGPointMake( xPosition + _xLabelWidth/2.0, chartCavanHeight - grade * chartCavanHeight + 20.0)];
    [progressline setLineWidth:3.0];
    [progressline setLineCapStyle:kCGLineCapRound];
    [progressline setLineJoinStyle:kCGLineJoinRound];
    NSInteger index = 0;
    for (NSString * valueString in _yValues) {
        NSInteger value = [valueString integerValue];
        
        float grade = (float)value / (float)_yValueMax;
        if (index != 0) {
            
            [progressline addLineToPoint:CGPointMake(index * xPosition  + 30.0+ _xLabelWidth /2.0, chartCavanHeight - grade * chartCavanHeight + 20.0)];
            
            [progressline moveToPoint:CGPointMake(index * xPosition + 30.0 + _xLabelWidth /2.0, chartCavanHeight - grade * chartCavanHeight + 20.0 )];
            
            [progressline stroke];
        }
        
        index += 1;
    }
    
    _chartLine.path = progressline.CGPath;
	if (_strokeColor) {
		_chartLine.strokeColor = [_strokeColor CGColor];
	}else{
		_chartLine.strokeColor = [PNGreen CGColor];
	}
    
    
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnimation.duration = 1.0;
    pathAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    pathAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
    pathAnimation.toValue = [NSNumber numberWithFloat:1.0f];
    pathAnimation.autoreverses = NO;
    [_chartLine addAnimation:pathAnimation forKey:@"strokeEndAnimation"];
    
    _chartLine.strokeEnd = 1.0;
    
    UIGraphicsEndImageContext();
}



@end
