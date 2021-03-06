//
//  WrappingScrollViewViewController.m
//  WrappingScrollView
//
//  Created by Jonah Williams on 8/20/10.
//  Copyright 2010 Jonah Williams.
//

#import "WrappingScrollViewViewController.h"

@implementation WrappingScrollViewViewController

@synthesize scrollView = scrollView_;

- (void)dealloc {
	self.scrollView = nil;
    [super dealloc];
}

- (void)viewDidUnload {
	self.scrollView = nil;
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];	
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)action:(id)sender forEvent:(UIEvent *)event {
	[scrollView_ reloadTiles];
}

@end
