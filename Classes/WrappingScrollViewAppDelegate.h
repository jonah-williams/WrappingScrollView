//
//  WrappingScrollViewAppDelegate.h
//  WrappingScrollView
//
//  Created by Jonah Williams on 8/20/10.
//  Copyright 2010 Jonah Williams. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WrappingScrollViewViewController;

@interface WrappingScrollViewAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    UIViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UIViewController *viewController;

@end

