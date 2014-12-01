iOS URX Search SDK
==================

This is the SDK interface for the [URX App Search API](http://developers.urx.com/).


This installation tutorial will show you how to add URXSearch to an existing project, and how to keep it up-to-date.

**You will learn how to:**

- Insert the SDK into your iOS app
- Set your API Key
- Query the URX Search API content


Installation
------------
**Step 1: Add the URXSearch Framework to your Project**:
First, clone this repository. Then, drag and drop the ``URXSearch.xcodeproj`` into the "Frameworks" directory of your project.


**Step 2: Linking to URXSearch Binaries and Headers**:
Make sure that the ``URXSearch.framework`` has been added to your project's binary. In your project settings, select your ``Target`` and select the ``Build Phases`` tab.  In the ``Link Binary With Libraries`` phase you should see ``URXSearch.framework``. If not, hit the + button and select it from the list of options.


**Step 3: Set up the API Key**:
Before you can use the SDK, you must provide your URX API Key. To do this, add a `String` row to your Info.plist file with ``URX API Key`` as the key and your API key as the value. Contact support@urx.com for an API key if you don't already have one.

**Step 4: Set -ObjC linker flag**:
In your project's Build Settings, make sure to add -ObjC in the "Other Linker Flags" setting.


Usage
-----
### Making a search query
```objective-c
[[URXTerm termWithKeywords:@"ellie goulding"] searchWithSuccessHandler:^(URXSearchResponse *response) {
                // Handle Search Results
                // response.results
        } AndFailureHandler:^(URXAPIError *error) {
                // Handle Error
                NSLog(@"%@", error.errorMessage);
}]
```

### Resolving a deeplink
```objective-c
[searchResult resolveWithWebFallbackAndFailureHandler:^(URXAPIError *error) {
                // Handle Error
                NSLog(@"%@", error.errorMessage);
}]
```

See this SDK fully integrated into an [example iOS app](https://github.com/URXtech/urx-sdk-ios-demo).


Contributing
------------
Coming soon...

License
-------
Copyright 2014 URX

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

   http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

Documentation, Features and Examples
------------------------------------
Full details and documentation can be found on the project page here:

http://developers.urx.com/
