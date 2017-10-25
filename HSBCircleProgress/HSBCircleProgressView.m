//
//  RedCircleProgressView.m
//  imageNetwork
//
//  Created by hsb9kr on 2017. 8. 28..
//  Copyright © 2017년 hsb9kr. All rights reserved.
//

#import "HSBCircleProgressView.h"

static const CGFloat startAngle = M_PI * 1.5;
static const CGFloat endAngle = startAngle + (M_PI * 2);

@implementation HSBCircleProgressView

#pragma mark <Getter Setter>

- (void)setRate:(CGFloat)rate {
    _rate = rate;
    [self setNeedsDisplay];
}

#pragma mark <Override>

- (instancetype)init {
    self = [super init];
    if (self) {
        [self initialize];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initialize:frame];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self ) {
        [self initialize];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self resetRadius:self.bounds];
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    [self resetRadius:frame];
}

- (void)drawRect:(CGRect)rect {
    UIBezierPath *totalBezierPath = [UIBezierPath bezierPath];
    [totalBezierPath addArcWithCenter:CGPointMake(rect.size.width / 2, rect.size.height / 2) radius:_radius startAngle:startAngle endAngle:endAngle clockwise:YES];
    totalBezierPath.lineWidth = _progressBarWidth;
    [_progressBarColor setStroke];
    [totalBezierPath stroke];
    
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    [bezierPath addArcWithCenter:CGPointMake(rect.size.width / 2, rect.size.height / 2) radius:_radius startAngle:startAngle endAngle:(endAngle - startAngle) * _rate + startAngle clockwise:YES];
    bezierPath.lineWidth = _progressWidth;
    [_progressColor setStroke];
    [bezierPath stroke];
}

#pragma mark <Private>

- (void)initialize:(CGRect)frame {
    [self initialize];
    [self resetRadius:frame];
}

- (void)initialize {
    self.backgroundColor = UIColor.clearColor;
    _progressColor = UIColor.redColor;
    _progressBarColor = UIColor.blackColor;
    [self initTextField];
}

- (void)initTextField {
    _textLabel = [[UILabel alloc] init];
    _textLabel.text = @"0%";
    
    _textLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:_textLabel];
    NSLayoutConstraint *centerXConstraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:_textLabel attribute:NSLayoutAttributeCenterX multiplier:1 constant:0];
    NSLayoutConstraint *centerYConstraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:_textLabel attribute:NSLayoutAttributeCenterY multiplier:1 constant:0];
    [self addConstraints:@[centerXConstraint, centerYConstraint]];
}

- (void)resetRadius:(CGRect)frame {
    self.layer.cornerRadius = frame.size.width / 4.f;
    self.layer.masksToBounds = YES;
    _radius = frame.size.width > frame.size.height ? frame.size.height / 2.5 : frame.size.width / 2.5;
    _progressWidth = _radius / 10.0;
    _progressBarWidth = _progressWidth;
}

@end
