// This file contains the fastlane.tools configuration
// You can find the documentation at https://docs.fastlane.tools
//
// For a list of all available actions, check out
//
//     https://docs.fastlane.tools/actions
//

import Foundation

class Fastfile: LaneFile {
  func customLane() {
    desc("Description of what the lane does")
    // add actions here: https://docs.fastlane.tools/actions
  }
  
  func swiftLintLane() {
    desc("Run SwiftLint")
    swiftlint(configFile: ".swiftlint.yml",
              strict: true,
              ignoreExitStatus: false,
              raiseIfSwiftlintError: true,
              executable: "Pods/SwiftLint/swiftlint"
    )
  }
  
  func buildLane() {
    desc("Build for testing")
    scan(workspace: "iOS-Template.xcworkspace",
         derivedDataPath: "derivedData",
         buildForTesting: true,
         xcargs: "CI=true")
  }
  
  func unitTestLane() {
    desc("Run unit tests")
    scan(workspace: "iOS-Template.xcworkspace",
         onlyTesting: ["iOS-TemplateTests"],
         derivedDataPath: "derivedData",
         testWithoutBuilding: true)
  }
  
  func uiTestLane() {
    desc("Run UI tests")
    scan(workspace: "iOS-Template.xcworkspace",
         onlyTesting: "iOS-TemplateUITests",
         derivedDataPath: "derivedData",
         testWithoutBuilding: true)
  }
  
}
