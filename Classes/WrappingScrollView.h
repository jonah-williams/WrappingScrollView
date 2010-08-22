//
//  WrappingScrollView.h
//  WrappingScrollView
//
//  Created by Jonah Williams on 8/20/10.
//  Copyright 2010 Jonah Williams.
//
//  Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at http://www.apache.org/licenses/LICENSE-2.0
//  Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" 
//  BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language 
//  governing permissions and limitations under the License. 
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
