# Ando, an item (image,json) downloader written in Swift for iOS

Ando is an item download library written in Swift. It allows to item.

```Swift
imageView.ando.url = "image url"
```

### Usage


```Swift
let ando = Ando(type: .json)
ando.callback = { response in
}
ando.url = "item url"
```

Response is AResponse class which is like this ;
```Swift
public struct AResponse {
    public let item: Any?
    public let type: AType
    public let error: NSError?
}
```


* Items are downloaded asynchronously.
* Uses URLSession for networking
* Allows to configure cache size.
* Provides closure properties for error handling.

## Imageview Usage

1. Add `import Aldo` to your source code.

```Swift
imageView.ando.url = "image url"
```


## Canceling download

Ongoing image download for the image view is automatically canceled when:

1. Call `imageView.ando.cancel()` to manually cancel the download.
2. New image download is started: `imageView.ando.url = ...`.

##  Caching
Ando has singleton memory cache and  automatically cache downloaded items. Default cache size is 100. 
Use the `ACache.shared.setMaxLenght(maxLenght: Int)` to change caching settings. 
## Demo app

The demo iOS app shows how to load images in a collection view with Ando.


