//
//  GuageView.m
//  WrappingScrollView
//
//  Created by Jonah Williams on 8/22/10.
//  Copyright 2010 Carbon Five. All rights reserved.
//

#import "GuageView.h"


@implementation GuageView


- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        // Initialization code
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    CGContextRef ctx = UIGraphicsGetCurrentContext();
	
	//draw the tick marks
	CGContextSaveGState(ctx);
	CGContextSetStrokeColorWithColor(ctx, [UIColor grayColor].CGColor);
	int ticks = (int)self.bounds.size.width / 10;
	for (int i = 0; i < ticks; i++) {
		if (i % 50 == 0) {
			CGContextMoveToPoint(ctx, i * 10, self.bounds.size.height / 2);
			CGContextSetLineWidth(ctx, 2.0);
		}
		else {
			CGContextMoveToPoint(ctx, i * 10, 0);
			CGContextSetLineWidth(ctx, 1.0);
		}
		CGContextAddLineToPoint(ctx, i * 10, self.bounds.size.height);
		CGContextStrokePath(ctx);
	}
	CGContextRestoreGState(ctx);
}

- (void)dealloc {
    [super dealloc];
}


@end
