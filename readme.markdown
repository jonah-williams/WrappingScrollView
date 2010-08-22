Wrapping scroll views

A WrappingScrollView acts as a container for an arbitrary `tileView` view and renders an apparently infinite UIScrollView containing tiled copies of the tileView. User interaction is supported on any of the tiled views with all touches reaching the original tileView.

The WrappingScrollView will create a UIScrollView subview with bounds equal to the tileView and an origin at (0, 0). The WrappingScrollView is this UIScrollView's delegate and changing the scroll view's bounds or delegate is not supported.  

At this point the WrappingScrollView will not automatically update it's tiled views, `reloadTiles` must be called to trigger the tiles to be redrawn if the original tileView's display changes.