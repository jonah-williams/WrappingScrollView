//
//  WrappingScrollView.m
//  WrappingScrollView
//
//  Created by Jonah Williams on 8/20/10.
//  Copyright 2010 Carbon Five. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "WrappingScrollView.h"

@implementation WrappingScrollView

@synthesize tileView = tileView_;

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
		[self constructScrollingContent];
    }
    return self;
}

- (void) awakeFromNib {
	[self constructScrollingContent];
}

- (void)dealloc {
	self.tileView = nil;
	[scrollView_ release], scrollView_ = nil;
	[tiles_ release], tiles_ = nil;
    [super dealloc];
}

- (void)constructScrollingContent {
	[scrollView_ removeFromSuperview];
	[scrollView_ release];
	scrollView_ = [[UIScrollView alloc] initWithFrame:self.frame];
	scrollView_.delegate = self;
	scrollView_.showsVerticalScrollIndicator = NO;
	scrollView_.showsHorizontalScrollIndicator = NO;
	scrollView_.bounces = NO;
	[self addSubview:scrollView_];

	
	NSUInteger horizontalTiles = 3;
	NSUInteger verticalTiles = 3;
	
	[tiles_ release];
	tiles_ = [[NSMutableArray alloc] initWithCapacity:horizontalTiles * verticalTiles - 1];

	[scrollView_ addSubview:self.tileView];
	self.tileView.frame = CGRectMake(self.tileView.bounds.size.width, self.tileView.bounds.size.height, self.tileView.bounds.size.width, self.tileView.bounds.size.height);
	
	scrollView_.contentSize = CGSizeMake(self.tileView.bounds.size.width * horizontalTiles, self.tileView.bounds.size.height * verticalTiles);
	for (NSUInteger x = 0; x < horizontalTiles; x++) {
		for (NSUInteger y = 0; y < verticalTiles; y++) {
			if (x == 1 && y == 1) {
				//do nothing, the tileView fills this tile
			}
			else {
				CGRect rect = CGRectMake(self.tileView.bounds.size.width * x, self.tileView.bounds.size.height * y, self.tileView.bounds.size.width, self.tileView.bounds.size.height);
				UIImageView *tile = [[UIImageView alloc] initWithFrame:rect];
				[tiles_ addObject:tile];
				[scrollView_ addSubview:tile];
				[tile release];
			}
		}
	}
	scrollView_.frame = CGRectMake(self.bounds.size.width / 2 - self.tileView.bounds.size.width / 2,
								   self.bounds.size.height / 2 - self.tileView.bounds.size.height / 2,
								   self.tileView.bounds.size.width, self.tileView.bounds.size.height);
	[self reloadTiles];
	scrollView_.contentOffset = CGPointMake(self.tileView.bounds.size.width, self.tileView.bounds.size.height);
}

- (void)reloadTiles {
	UIGraphicsBeginImageContext(self.tileView.bounds.size);
	[self.tileView.layer renderInContext:UIGraphicsGetCurrentContext()];
	UIImage *tileImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();

	for (UIImageView *tile in tiles_) {
		tile.image = tileImage;
	}
}

- (UIView *) hitTest:(CGPoint)point withEvent:(UIEvent *)event {
	//multiple hitTest calls may be issuesd for a single point, only reposition the contentOffset once
	if (false == CGPointEqualToPoint(point, lastHitTest_)) {
		lastHitTest_ = point;
		//offset tileView to be under point
		CGPoint currentPosition = scrollView_.contentOffset;
		CGPoint origin = CGPointMake(tileView_.frame.origin.x, tileView_.frame.origin.y);
		CGPoint newPosition = currentPosition;
		CGPoint hitPoint = CGPointMake(currentPosition.x + point.x - scrollView_.frame.origin.x, currentPosition.y + point.y - scrollView_.frame.origin.y);
		if (hitPoint.x < origin.x) {
			newPosition.x = origin.x + currentPosition.x;
		}
		else if (hitPoint.x > origin.x + tileView_.bounds.size.width) {
			newPosition.x = currentPosition.x - origin.x;
		}
		if (hitPoint.y < origin.y) {
			newPosition.y = origin.y + currentPosition.y;
		}
		else if (hitPoint.y > origin.y + tileView_.bounds.size.height) {
			newPosition.y = currentPosition.y - origin.y;
		}
		scrollView_.contentOffset = newPosition;
	}
	//call default hitTest
	return [super hitTest:point withEvent:event];
}

#pragma mark UIScrollViewDelegate methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
	CGPoint offset = scrollView.contentOffset;
	if (offset.x >= self.tileView.bounds.size.width * 2 || offset.x <= 0) {
		offset.x = self.tileView.bounds.size.width;
	}
	if (offset.y >= self.tileView.bounds.size.height * 2 || offset.y <= 0) {
		offset.y = self.tileView.bounds.size.height;
	}
	[scrollView setContentOffset:offset];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
	
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
	
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
	
}

@end
