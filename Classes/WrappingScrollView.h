//
//  WrappingScrollView.h
//  WrappingScrollView
//
//  Created by Jonah Williams on 8/20/10.
//  Copyright 2010 Carbon Five. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface WrappingScrollView : UIView <UIScrollViewDelegate> {
	UIScrollView *scrollView_;
	NSMutableArray *tiles_;
	CGPoint lastHitTest_;
}

@property(nonatomic, retain) IBOutlet UIView *tileView;

- (void)constructScrollingContent;
- (void)reloadTiles;

- (IBAction)action:(id)sender forEvent:(UIEvent *)event;

@end
