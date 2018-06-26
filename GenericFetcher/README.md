# GenericFetcher

This is a simple and scalable project to fetch and decode remote data. It comes with an UIImageView extension to download, cache and display images.

# Installation

```swift
import GenericFetcher
```

# Usage

Fetcher
```swift
let fetcher = Fetcher()
fetcher.fetch(with: .json, urlStr: "URL_STRING") { (data: [Object]) in
// Your Code Here
}
```

UIImageview extension
```swift
let imageView = UIImageView()
...
imageView.loadImage(withURL: "URL_STRING")
...
```