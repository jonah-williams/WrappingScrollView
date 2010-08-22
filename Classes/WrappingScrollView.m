//
//  WrappingScrollView.m
//  WrappingScrollView
//
//  Created by Jonah Williams on 8/20/10.
//  Copyright 2010 Jonah Williams. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "WrappingScrollView.h"

@implementation WrappingScrollView

@synthesize tileView = tileView_;
@synthesize scrollsVertically = scrollsVertically_;
@synthesize scrollsHorizontally = scrollsHorizontally_;

- (void)dealloc {
	self.tileView = nil;
	[scrollView_ release], scrollView_ = nil;
	[tiles_ release], tiles_ = nil;
    [super dealloc];
}

//Creates a set of UIImageViews to display tiled images of the tileView, sets the frame and content size of the scroll view.
- (void)constructScrollingContent {
	[scrollView_ removeFromSuperview];
	[scrollView_ release];
	scrollView_ = [[UIScrollView alloc] initWithFrame:self.frame];
	scrollView_.delegate = self;
	scrollView_.showsVerticalScrollIndicator = NO;
	scrollView_.showsHorizontalScrollIndicator = NO;
	scrollView_.bounces = NO;
	scrollView_.scrollsToTop = NO;
	[self addSubview:scrollView_];

	scrollsVertically_ = YES;
	scrollsHorizontally_ = YES;
	horizontalTiles_ = 3;
	verticalTiles_ = 3;
	
	[tiles_ release];
	tiles_ = [[NSMutableArray alloc] initWithCapacity:horizontalTiles_ * verticalTiles_ - 1];

	[scrollView_ addSubview:self.tileView];
	self.tileView.frame = CGRectMake(self.tileView.bounds.size.width, self.tileView.bounds.size.height, self.tileView.bounds.size.width, self.tileView.bounds.size.height);
	
	[self updateScrollViewContentSize];
	for (NSUInteger x = 0; x < horizontalTiles_; x++) {
		for (NSUInteger y = 0; y < verticalTiles_; y++) {
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
	scrollView_.frame = CGRectMake(0, 0, self.tileView.bounds.size.width, self.tileView.bounds.size.height);
	[self reloadTiles];
	scrollView_.contentOffset = CGPointMake(self.tileView.bounds.size.width, self.tileView.bounds.size.height);
}

//Updates all the tiles to reflect the current state of the tileView's layer.
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
		//offset tileView to be under point so all touches are sent to the tileView, at the correct position
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
	//call default hitTest behavior
	return [super hitTest:point withEvent:event];
}

- (void) setScrollsVertically:(BOOL) verticalScroll {
	scrollsVertically_ = verticalScroll;
	[self updateScrollViewContentSize];
}

- (void) setScrollsHorizontally:(BOOL) horizontalScroll {
	scrollsHorizontally_ = horizontalScroll;
	[self updateScrollViewContentSize];
}

- (void) setTileView:(UIView *) tileView {
	if (tileView != tileView_) {
		[tileView_ release];
		tileView_ = tileView;
		[tileView_ retain];
		[self constructScrollingContent];
	}
}

- (void)updateScrollViewContentSize {
	scrollView_.contentSize = CGSizeMake(self.tileView.bounds.size.width * (scrollsHorizontally_ ? horizontalTiles_ : 1), self.tileView.bounds.size.height * (scrollsVertically_ ? verticalTiles_ : 1));
}

#pragma mark UIScrollViewDelegate methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
	//if the tileView has been scrolled out of site reposition the content offset to show the tileView rather than one of the image tiles
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
