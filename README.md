# NY Times Most Popular Articles #

iOS Assessment – An app to showcase NY Times Most Popular Articles, that shows details when items on the list are tapped.

##### App Info:

---
- **App Store:** NA
- **Bundle Name:** iOSAssessment
- **Deployment Target** : iOS 10.0
- **Bundle ID:** com.assessment.iOSAssessment

**iOS Database** : NO
**Push notification** : NO
**InApp Purchase** : NO
**CMS** : NO
**Payment Integration** : NO


##### Features
Following are the two main features for this application:
- Display list of articles by NY Times
- Details of article

## Project Structure
- 📁 StoryBoard : StoaryBoards used for the project. Currently we have only one ie. Main.storyBoard
- 📁 ViewControllers    : All UIViewControllers of the project
- 📁 Views : Custom views 
- 📁 Extensions    : All extensions
- 📁 Utility    : General content
- 📁 NetworkManager    : All classes related to Network layer (URLSessions)

##### Dependencies
Make sure you have CocoaPods installed and then run:
pod install

##### Pods used
Third party framewoks and Library are managed using Cocoapods.
- pod 'SwiftyJSON'
- pod 'Alamofire'

### Contribution guidelines ###
* Unit Tests
    - iOSAssessmentTests
    **testNetworkCall** : For Positive use case which fetches results
    **testNetworkCallForIncorrectParams**: Negative usecase, where incorrect info is pass - which should lead to test failure
    

