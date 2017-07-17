# ScrollableTable

Scrollable table app is an app which serves the following purpose:

1- Fluid and Seamless up and down scrolling on a table view.
2- Display the top 10 songs fetched from iTunes feed and can support more data if limit is changed in feed URL - https://itunes.apple.com/us/rss/topsongs/limit=10/xml
2- At launch, the app is in Minimised state - Only three lines of text is visible.
3- On tap the selected row expands and displays the whole text.
4- While expanding the constraints are preserved, and constraints can be changed at compile time by changing the values of top, bottom, leading and trailing constants.
    • long labelTopConstraintValue = 32;
    • long labelBottomConstraintValue = 32;
    • long labelLeadingConstraintValue = 16;
    • long labelTrailingConstraintValue = 16;
5- App supports portrait as well as landscape mode.
6- App has feasibility to expand and supports future changes like displaying image along with label but sampling adding a outlet in Custom cell class and adding supporting code in controller class.

• Potrait view minimized state:
![alt tag](https://github.com/joshihitesh/ScrollableTable/blob/master/AppImages/potrait.png)

• Potrait view, row with large Text:
![alt tag](https://github.com/joshihitesh/ScrollableTable/blob/master/AppImages/potrait_row_tapped.png)

• Potrait view, row with less Text:
![alt tag](https://github.com/joshihitesh/ScrollableTable/blob/master/AppImages/potrait_row_tapped_mindata.png)

• Landscape view
![alt tag](https://github.com/joshihitesh/ScrollableTable/blob/master/AppImages/landscape.png)

Steps to run project.
•	Download or clone the project from Github
•	Navigate to project directory and run the “pod install” command
(I assume you have cocoapods installed in the machine )
•	Open the “ScrollableTable.xcworkspace”, build and run the project.

Technical Details: 
• Xcode : 8.3
• Language: Objective-C (As mentioned in requirement doc.)
• Third Party frameworks: AFNetworking and XMLDictionary.
• Code Coverage
![alt tag](https://github.com/joshihitesh/ScrollableTable/blob/master/AppImages/code_coverage.png)
