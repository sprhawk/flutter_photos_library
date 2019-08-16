ARCHIVED: I'm not working on flutter recently, so this lib will not be updated.

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

## History:

### Version 0.0.4:
1. added @required to width and height parameters

### Version 0.0.3:

1. Breaking API of 0.0.2
2. changed deliverMode to PHImageRequestOptionsDeliveryModeOpportunistic for `[PHImageManager requestImageForAsset:targetSize:contentMode:options:resultHandler:]` message. using PHImageRequestOptionsDeliveryModeFastFormat makes API only return very low resolution image. but using PHImageRequestOptionsDeliveryModeOpportunistic makes multiple calls to get different resolution images, so
3. Because 2. has multiple calls to get images, in 0.0.2, the message handler is set inside Asset instance, but Dart's object doesn't have a deconstructor like method to call unregister message handler, and I move the example's AssetView into lib, and have the unregistering inside deactive of the Widget.


## [License](license.md)

Copyright 2018 Yang Hongbo

Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:

1. Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.

2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
