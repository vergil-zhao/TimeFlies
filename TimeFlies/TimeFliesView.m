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

@property (nonatomic, strong) NSTextField *customLabel;

@property (nonatomic, strong) NSTextField *percentNumber;
@property (nonatomic, strong) NSTextField *percentLabel;
@property (nonatomic, strong) NSTextField *timeLabel;

@property (nonatomic, strong) NSTextField *hourLabel;
@property (nonatomic, strong) NSTextField *minuteLabel;
@property (nonatomic, strong) NSTextField *secondLabel;

@end

@implementation TimeFliesView

static NSDateFormatter *_formatter = nil;

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

- (CGFloat)fontSizeWith:(CGFloat)factor {
    CGFloat ref = MIN(self.bounds.size.width, self.bounds.size.height);
    CGFloat result = ref * factor;
    return result;
}

- (void)prepareForDisplay {
    _customLabel = [NSTextField labelWithString:@"Vergil @ Flexport"];
    
    _percentNumber = [NSTextField labelWithString:@"Hello World"];
    _percentNumber.textColor = NSColor.whiteColor;
    
    _percentLabel = [NSTextField labelWithString:@"of this year has passed."];
    _percentLabel.textColor = NSColor.whiteColor;
    
    [self addSubview:_percentNumber];
    [self addSubview:_percentLabel];
    
    if (self.bounds.size.width > self.bounds.size.height) {
        [self prepareForHorizontal];
    } else {
        [self prepareForVertical];
    }
    
    [self update];
}

- (void)prepareForVertical {
    _hourLabel = [NSTextField labelWithString:@"00"];
    _hourLabel.textColor = NSColor.whiteColor;
    
    _minuteLabel = [NSTextField labelWithString:@"00"];
    _minuteLabel.textColor = NSColor.whiteColor;
    
    _secondLabel = [NSTextField labelWithString:@"00"];
    _secondLabel.textColor = NSColor.whiteColor;
    
    [self addSubview:_hourLabel];
    [self addSubview:_minuteLabel];
    [self addSubview:_secondLabel];
}

- (void)prepareForHorizontal {
    _timeLabel = [NSTextField labelWithString:@"00:00:00"];
    _timeLabel.textColor = NSColor.whiteColor;
    
    _formatter = [[NSDateFormatter alloc] init];
    [_formatter setDateFormat:@"HH:mm:ss"];
    
    [self addSubview:_timeLabel];
}

- (void)update {
    if (self.bounds.size.width > self.bounds.size.height) {
        [self updateHorizontal];
    } else {
        [self updateVertical];
    }
}

- (void)updateVertical {
    CGFloat x = 0;
    CGFloat y = 0;
    
    NSDate *now = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond fromDate:now];
    
    _hourLabel.stringValue = [NSString stringWithFormat:@"%02ld", (long)[components hour]];
    _hourLabel.font = [NSFont monospacedDigitSystemFontOfSize:[self fontSizeWith:.3] weight:NSFontWeightUltraLight];
    [_hourLabel sizeToFit];
    x = self.bounds.size.width / 2 - _hourLabel.frame.size.width / 2;
    y = self.bounds.size.height - self.bounds.size.height * .36;
    _hourLabel.frame = CGRectMake(x, y, _hourLabel.frame.size.width, _hourLabel.frame.size.height);
    
    _minuteLabel.stringValue = [NSString stringWithFormat:@"%02ld", (long)[components minute]];
    _minuteLabel.font = [NSFont monospacedDigitSystemFontOfSize:[self fontSizeWith:.3] weight:NSFontWeightUltraLight];
    [_minuteLabel sizeToFit];
    x = self.bounds.size.width / 2 - _minuteLabel.frame.size.width / 2;
    y = _hourLabel.frame.origin.y - _minuteLabel.frame.size.height - self.bounds.size.height * .01;
    _minuteLabel.frame = CGRectMake(x, y, _minuteLabel.frame.size.width, _minuteLabel.frame.size.height);
    
    _secondLabel.stringValue = [NSString stringWithFormat:@"%02ld", (long)[components second]];
    _secondLabel.font = [NSFont monospacedDigitSystemFontOfSize:[self fontSizeWith:.3] weight:NSFontWeightUltraLight];
    [_secondLabel sizeToFit];
    x = self.bounds.size.width / 2 - _secondLabel.frame.size.width / 2;
    y = _minuteLabel.frame.origin.y - _secondLabel.frame.size.height - self.bounds.size.height * .01;
    _secondLabel.frame = CGRectMake(x, y, _secondLabel.frame.size.width, _secondLabel.frame.size.height);
    
    _percentLabel.font = [NSFont systemFontOfSize:[self fontSizeWith:.01] weight:NSFontWeightSemibold];
    [_percentLabel sizeToFit];
    x = self.bounds.size.width / 2 - _percentLabel.frame.size.width / 2;
    y = self.bounds.size.height * .05;
    _percentLabel.frame = CGRectMake(x, y, _percentLabel.frame.size.width, _percentLabel.frame.size.height);
    
    _percentNumber.stringValue = [NSString stringWithFormat:@"%.06f %%", [self remainPercentOfYear]];
    _percentNumber.font = [NSFont monospacedDigitSystemFontOfSize:[self fontSizeWith:.05] weight:NSFontWeightUltraLight];
    [_percentNumber sizeToFit];
    x = self.bounds.size.width / 2 - _percentNumber.frame.size.width / 2;
    y = _percentLabel.frame.origin.y + _percentLabel.frame.size.height + self.bounds.size.height * .01;
    _percentNumber.frame = CGRectMake(x, y, _percentNumber.frame.size.width, _percentNumber.frame.size.height);
}

- (void)updateHorizontal {
    CGFloat x = 0;
    CGFloat y = 0;
    
    _percentNumber.stringValue = [NSString stringWithFormat:@"%.6f %%", [self remainPercentOfYear]];
    _percentNumber.font = [NSFont monospacedDigitSystemFontOfSize:[self fontSizeWith:.2] weight:NSFontWeightUltraLight];
    [_percentNumber sizeToFit];
    x = self.bounds.size.width / 2 - _percentNumber.frame.size.width / 2;
    y = self.bounds.size.height / 2 - _percentNumber.frame.size.height / 2;
    _percentNumber.frame = CGRectMake(x, y, _percentNumber.frame.size.width, _percentNumber.frame.size.height);
    
    _percentLabel.font = [NSFont systemFontOfSize:[self fontSizeWith:.02] weight:NSFontWeightSemibold];
    [_percentLabel sizeToFit];
    x = self.bounds.size.width / 2 - _percentLabel.frame.size.width / 2;
    y = _percentNumber.frame.origin.y - _percentLabel.frame.size.height;
    _percentLabel.frame = CGRectMake(x, y, _percentLabel.frame.size.width, _percentLabel.frame.size.height);
    
    _timeLabel.stringValue = [_formatter stringFromDate:[NSDate date]];
    _timeLabel.font = [NSFont monospacedDigitSystemFontOfSize:[self fontSizeWith:.06] weight:NSFontWeightUltraLight];
    [_timeLabel sizeToFit];
    x = self.bounds.size.width / 2 - _timeLabel.frame.size.width / 2;
    y = self.bounds.size.height * 0.1;
    _timeLabel.frame = CGRectMake(x, y, _timeLabel.frame.size.width, _timeLabel.frame.size.height);
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
