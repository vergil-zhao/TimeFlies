//
//  TimeFliesView.m
//  TimeFlies
//
//  Created by Vergil Choi on 2018/4/9.
//  Copyright © 2018 Vergil Choi. All rights reserved.
//

#import "TimeFliesView.h"

@import AppKit;

@interface TimeFliesView()

@property (nonatomic, strong) NSTextField *percentNumber;
@property (nonatomic, strong) NSTextField *percentLabel;

@end

@implementation TimeFliesView

- (instancetype)initWithFrame:(NSRect)frame isPreview:(BOOL)isPreview {
    self = [super initWithFrame:frame isPreview:isPreview];
    
    [self setAnimationTimeInterval: 1 / 20.0];
    
    [self prepareForDisplay];
    
    return self;
}

- (void)drawRect:(NSRect)rect {
    [super drawRect:rect];
    
    [[NSColor blackColor] setFill];
    NSRectFill(rect);
}

- (void)animateOneFrame {
    [self update];
}

- (void)prepareForDisplay {
    
    _percentNumber = [NSTextField labelWithString:@"Hello World"];
    _percentNumber.textColor = NSColor.whiteColor;
    
    _percentLabel = [NSTextField labelWithString:@"of this year has passed."];
    _percentLabel.textColor = NSColor.whiteColor;
    
    [self addSubview:_percentNumber];
    [self addSubview:_percentLabel];
    
    [self update];
    
}

- (void)update {
    
    _percentNumber.stringValue = [NSString stringWithFormat:@"%.6f %%", [self remainPercentOfYear]];
    
    _percentNumber.font = [NSFont monospacedDigitSystemFontOfSize:self.bounds.size.height * 0.2 weight:NSFontWeightUltraLight];
    [_percentNumber sizeToFit];
    CGFloat x = self.bounds.size.width / 2 - _percentNumber.frame.size.width / 2;
    CGFloat y = self.bounds.size.height / 2 - _percentNumber.frame.size.height / 2;
    
    _percentNumber.frame = CGRectMake(x, y, _percentNumber.frame.size.width, _percentNumber.frame.size.height);
    
    _percentLabel.font = [NSFont systemFontOfSize:self.bounds.size.height * 0.02 weight:NSFontWeightSemibold];
    [_percentLabel sizeToFit];
    x = self.bounds.size.width / 2 - _percentLabel.frame.size.width / 2;
    y = _percentNumber.frame.origin.y - _percentLabel.frame.size.height;
    
    _percentLabel.frame = CGRectMake(x, y, _percentLabel.frame.size.width, _percentLabel.frame.size.height);
    
}

- (double)remainPercentOfYear {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *now = [NSDate date];
    NSDateComponents *yearComponent = [calendar components:NSCalendarUnitYear fromDate:now];
    NSDate *thisYear = [calendar dateFromComponents:yearComponent];
    
    double passed = fabs([thisYear timeIntervalSinceNow]);
    
    NSDateComponents *otherCompoent = [[NSDateComponents alloc] init];
    otherCompoent.calendar = calendar;
    otherCompoent.year = yearComponent.year + 1;
    
    double remainOfThisYear = [[calendar dateFromComponents:otherCompoent] timeIntervalSinceNow];
    
    return passed / (remainOfThisYear + passed) * 100;
}

@end
