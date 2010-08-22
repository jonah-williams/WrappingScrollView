//
//  ProxyView.m
//  WrappingScrollView
//
//  Created by Jonah Williams on 8/21/10.
//  Copyright 2010 Carbon Five. All rights reserved.
//

#import "ProxyView.h"


@implementation ProxyView

@synthesize destinationView = destinationView_;

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        // Initialization code
    }
    return self;
}

- (UIView *) hitTest:(CGPoint)point withEvent:(UIEvent *)event {
	if ([self pointInside:point withEvent:event]) {
		return self.destinationView;
	}
	return nil;
}

- (void)dealloc {
	self.destinationView = nil;
    [super dealloc];
}


@end
