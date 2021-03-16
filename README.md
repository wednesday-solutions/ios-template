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
