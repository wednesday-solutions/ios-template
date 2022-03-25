<div>
    <a href="https://www.wednesday.is?utm_source=gthb&utm_medium=repo&utm_campaign=serverless" align="left" style="margin-left: 0;">
        <img src="https://uploads-ssl.webflow.com/5ee36ce1473112550f1e1739/5f5879492fafecdb3e5b0e75_wednesday_logo.svg">
    </a>
</div>
# iOS Template

An enterprise iOS template application showcasing - App architecture pattern(MVVM-Coordinator-RxSwift), Testing stratergies, CI/CD pipeline using GitAction and fastlane, Localization, Code generation, Linting, Networking

### Requirements
* [Cocoapods](https://cocoapods.org/)
* [Fastlane](https://fastlane.tools/)
* [SwiftLinit](https://github.com/realm/SwiftLint)
### Getting started
* Clone Repo
* Checkout `develop` brach
* Install pods using `pod install`


### MVVM-Coordinator-RxSwift Architecture
#### Resources
* [Coordinator pattern](hackingwithswift.com/articles/71/how-to-use-the-coordinator-pattern-in-ios-apps)
* [MVVM-Coordinator-RxSwift](https://medium.com/hackernoon/how-to-use-mvvm-coordinators-and-rxswift-7364370b7b95)
* [RxSwift](hackingwithswift.com/articles/71/how-to-use-the-coordinator-pattern-in-ios-apps)

This architecture is combination of best practices, which help to write code that is easier to read, reactive, testable and scalable.

### Code Tools
#### [Sourcery](https://github.com/krzysztofzablocki/Sourcery)
Sourcery is a code generator for Swift language, built on top of Apple's own SwiftSyntax. It extends the language abstractions to allow you to generate boilerplate code automatically.
Here we have used this tool to safeguard the app secrets, by adding them to the project at build time. 
To run the project you will have to create and shell script with name `secrets-vars.sh` and add below content to it. Once added place the move this file to root of project directory.
//Add Image Here
In build phases you can see 
#### [SwiftGen](https://github.com/SwiftGen/SwiftGen)
SwiftGen is a tool to automatically generate Swift code for resources of your projects (like images, localised strings, etc), to make them type-safe to use.
There are multiple benefits in using this:
* Avoid any risk of typo when using a String
* Free auto-completion
* Avoid the risk of using a non-existing asset name
* All this will be ensured by the compiler and thus avoid the risk of crashing at runtime

You can see the `swiftgen.yml` file at the root of project directory, this files defines the inputs from where the resourced liks fonts, strings, images to pick from and output files where the swift code to be added for there resourceds to be accessed in type safe manner. You can read more about how to configure, and various configuration optiones [here](https://github.com/SwiftGen/SwiftGen/blob/stable/Documentation/ConfigFile.md). 
#### [SwiftLint](https://github.com/realm/SwiftLint)
A tool to enforce Swift style and conventions, that helps to maintain the uniform code structure and style, you can read more about the standard rules [here](https://github.com/raywenderlich/swift-style-guide). This rules can be tweaked as needed by editing `.swiftlint.yml` files that gets generated when installling swiftlint. You also need to run a script that maked sures all the rules and followed, if not it will show warning or errors based on rules specified in `swiftlint.yml.` You can find the script for swiftlint in `Build Phases`