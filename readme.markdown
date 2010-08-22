Wrapping scroll views

A WrappingScrollView acts as a container for an arbitrary `tileView` view and renders an apparently infinite UIScrollView containing tiled copies of the tileView. User interaction is supported on any of the tiled views with all touches reaching the original tileView.

The WrappingScrollView will create a UIScrollView subview with bounds equal to the tileView and an origin at (0, 0). The WrappingScrollView is this UIScrollView's delegate and changing the scroll view's bounds or delegate is not supported. Similarly additional subviews added to this scroll view will not be tiled. You are however free to add subviews to the WrappingScrollView to create overlays on top of the scroll view.

At this point the WrappingScrollView will not automatically update it's tiled views, `-reloadTiles` must be called to trigger the tiles to be redrawn if the original tileView's display changes.

Pending changes:

* Set the bounds of the scroll view to equal the bounds of the WrappingScrollView and add additional tiles as needed to fill the visible region.
* Pad the scroll view with additional tiles to prevent a swipe from reaching the edge of the scroll view's content view while decelerating, currently this can halt deceleration prematurely.
* Add a delegate protocol to report the relative scroll position of the WrappingScrollView

Please submit features requests as github issues, feedback and additional requirements for this view are welcome.