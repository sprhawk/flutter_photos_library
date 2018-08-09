# photos_library

A simple flutter plugin to demo how to interact to system gallery. Only iOS PhotosKit is supported for now:

1. get authorization status
2. request Photos authorization status
3. fetch assets metadata
4. fetch assets' thumbnail image in binary form, then sent to flutter side
5. (in example) display binary-form image with Image.memory


## Methods

1. PhotosLibrary.authorizeationStatus
2. PhotosLibrary.requestAuthorization
3. PhotosLibrary.fetchMediaWithType
4. PhotosLibrary.requestThumbnail

## Notes

For authorizing to [Photos library](https://developer.apple.com/documentation/photokit), you need to add [NSPhotoLibraryUsageDescription](https://developer.apple.com/library/archive/documentation/General/Reference/InfoPlistKeyReference/Articles/CocoaKeys.html#//apple_ref/doc/plist/info/NSPhotoLibraryUsageDescription) into your info.plist in project
