//
//  WrappingScrollView.m
//  WrappingScrollView
//
//  Created by Jonah Williams on 8/20/10.
//  Copyright 2010 Carbon Five. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "WrappingScrollView.h"
#import "ProxyView.h"

@implementation WrappingScrollView

@synthesize tileView = tileView_;

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
    }
    return self;
}

- (void)dealloc {
	self.tileView = nil;
	[scrollView_ release], scrollView_ = nil;
	[tiles_ release], tiles_ = nil;
    [super dealloc];
}

- (void)constructScrollingContent {
	//TODO: construct in awakeFromNib or initWithFrame instead
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
				UIImageView *tile = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.tileView.bounds.size.width, self.tileView.bounds.size.height)];
				[tiles_ addObject:tile];
				ProxyView *proxy = [[ProxyView alloc] initWithFrame:rect];
				[proxy addSubview:tile];
				proxy.destinationView = self.tileView;
				[scrollView_ addSubview:proxy];
				[proxy release];
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

- (void)action:(id)sender forEvent:(UIEvent *)event {
	[self reloadTiles];
}

@end
