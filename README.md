# ScrollableTable

Scrollable table app is an app which serves the following purpose:

1- Fluid and Seamless up and down scrolling on a table view.<br />
2- Display the top 10 songs fetched from iTunes feed and can support more data if limit is changed in feed URL - https://itunes.apple.com/us/rss/topsongs/limit=10/xml<br />
3- At launch, the app is in Minimised state - Only three lines of text is visible.<br />
4- On tap the selected row expands and displays the whole text.<br />
5- While expanding the constraints are preserved, and constraints can be changed at compile time by changing the values of top, bottom, leading and trailing constants.<br />
    • long labelTopConstraintValue = 32;<br />
    • long labelBottomConstraintValue = 32;<br />
    • long labelLeadingConstraintValue = 16;<br />
    • long labelTrailingConstraintValue = 16;<br />
6- App supports portrait as well as landscape mode.<br />
7- App has feasibility to expand and supports future changes like displaying image along with label but sampling adding a outlet in Custom cell class and adding supporting code in controller class.<br />

• Potrait view minimized state:<br />
<img src="https://github.com/joshihitesh/ScrollableTable/blob/master/AppImages/potrait.png" width="300"><br />
• Potrait view, expanded row with large Text:<br />
<img src="https://github.com/joshihitesh/ScrollableTable/blob/master/AppImages/potrait_row_tapped.png" width="300"><br />
• Potrait view, expanded row with less Text:<br />
<img src="https://github.com/joshihitesh/ScrollableTable/blob/master/AppImages/potrait_row_tapped_mindata.png" width="300"><br />
• Landscape view<br />
<img src="https://github.com/joshihitesh/ScrollableTable/blob/master/AppImages/landscape.png" width="300"><br />

# Steps to run project.<br />
•	Download or clone the project from Github<br />
•	Navigate to project directory and run the “pod install” command<br />
(I assume you have cocoapods installed in the machine )<br />
•	Open the “ScrollableTable.xcworkspace”, build and run the project.<br />

# Technical Details: <br />
• Xcode : 8.3<br />
• Language: Objective-C (As mentioned in requirement doc.)<br />
• Third Party frameworks: AFNetworking and XMLDictionary.<br />
• Code Coverage
![alt tag](https://github.com/joshihitesh/ScrollableTable/blob/master/AppImages/code_coverage.png)
