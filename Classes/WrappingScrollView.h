//
//  WrappingScrollView.h
//  WrappingScrollView
//
//  Created by Jonah Williams on 8/20/10.
//  Copyright 2010 Jonah Williams. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface WrappingScrollView : UIView <UIScrollViewDelegate> {
	UIScrollView *scrollView_;
	NSMutableArray *tiles_;
	CGPoint lastHitTest_;
	NSUInteger horizontalTiles_;
	NSUInteger verticalTiles_;
}

@property(nonatomic, retain) IBOutlet UIView *tileView;
@property(nonatomic, assign) BOOL scrollsVertically;
@property(nonatomic, assign) BOOL scrollsHorizontally;

- (void)constructScrollingContent;
- (void)reloadTiles;
- (void)updateScrollViewContentSize;

@end
