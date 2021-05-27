# iOS Template

### Steps to produce:

A new Xcode project, with name "ios-template"

GitIgnore list:
From gitignore.io, I used configuration Xcode, Cocoapods, Swift and used the gitignore file as created
CLI Tool:

```
function gi() {
  curl -fLw '\n' https://www.gitignore.io/api/"${(j:,:)@}"
}
```

`gi Xcode >> .gitignore`
`gi CocoaPods >> .gitignore`
`gi Swift >> .gitignore`

Cocoapods init using `pod init`

### How to run:


### Architecture:

This iOS template has an MVVM + Coordinator template

All ViewControllers and ViewModels are created from the Coordinator

Closures are used for ViewController + ViewModel bindings

Delegates are used for communicating from ViewController to Coordinator

### File Structure

I have kept all relevant files for a feature together. i.e. A feature screen has a folder with it's ViewController, ViewModel, Coordinator and it's Model data type tied up together.

If possible, a feature's Network requests can be tied together in it's folder as well.

### Resources

Coordinators:

https://www.raywenderlich.com/158-coordinator-tutorial-for-ios-getting-started
https://vimeo.com/144116310
https://academy.realm.io/posts/tryswift-ayaka-nonaka-boundaries-in-practice/
https://www.youtube.com/watch?v=VzbllBC5eec
