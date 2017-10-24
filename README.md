
## JSMixStarter · Goals
The goal of this project is to build a thin bridge between Javascript and 
native Swift & Android code so that a common javascript codebase can be slowly 
introduced and shared between web, native iOS and native Android applications.

By building a common, testable Javascript library that's shared across mobile
platforms, it allows teams to leverage any in-house Javascript skills in their 
native applications without requiring use of a full-blown hybrid framework like
PhoneGap or Ionic (or React Native).  

# Motivation #
Development speed- Unlike testing in Javascript, iOS & Android must be compiled 
each time tests are run.  Even with the improvements in XCode 9, this is on orders
of magnitude slower than running tests in Javascript.  By developing certain services 
or business logic in Javascript instead of Swift, this can speed up development time,
especially if the code can be shared with Android and/or web applications.

# Getting Started #
This starter project includes a BDD test harness using Quick & Nimble and 
has a mirror javascript project, js-mix-starter, that uses Mocha & Chai.
   
JSMixStarter uses Cocoapods for dependency management, so after cloning
the repo, run `Pod install`.  

# BDD Testing Framework - Quick, Nimble #
To get Quick and Nimble configured, follow these instructions: 
https://github.com/Quick/Quick/blob/master/Documentation/en-us/InstallingQuick.md

# Run the tests #
There are a few starter tests in place that which demonstrate:
    - Invoking a Javascript function from native Swift code
    - Passing a Swift callback to Javascript for asynchronous invocation (example
    from test below)
    
```swift
var bridge:JSBridge! = JSBridge("main.js"); // Instantiate as class variable
// ...

it("should load data from an api"){
waitUntil(timeout: 4){ done in    
        let callback: ApiCompletionBlock = { result in
            print("result from Javascript = \(result)") 
            done()
        }    
    }
}
                        
// Swift callback is passed to Javascript code for invocation
bridge.callJSFunction(callback); 
// ...(wait for asynchronous javascript call to finish)
// result from Javascript = ["foo": "bar"]
```


# Roadmap #
- Add asynchronous JQuery API calls to Wikipedia and invoke them with Swift callbacks
- Conversion of JSON objects to well-formed Swift Dictionaries of type <String, Any>
- add Javascript project w/ webpack to compile js application & copy to iOS project 
