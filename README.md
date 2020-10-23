#  JWPlayerAds

## VAST compliant ad implementation

### Overview

This project is an example of a collection view that loads a video and an ad.

If the ad is already playing on another video or if that video has not finished, it won't load on newly played videos.

The cells each have a JWVideoController that is set when the collection view creates each cell using a reusableIdentifier.

Each JWVideoController has the video url, that it gets from the `Items.plist` and an Inline Nonskippable VAST ad that is hardcoded into the player using the following snippet: 
```
let adBreak = JWAdBreak(tag: TAG_URL, offset: "pre")
let adConfig = JWAdConfig()
adConfig.client = .googima
adConfig.schedule = [adBreak]
config.advertising = adConfig // config is the JWConfig that was instantiated to initialize the JWPlayerController
```
### Layout

The layout is a simple CompositionalLayout with paginated orthogonal scrolling. 


### Errors

The title is set as DAI ads, but it doesn't load DAI ads.
Instead it uses a VAST ad from the examples listed here:

[Google Ad VAST examples](https://developers.google.com/interactive-media-ads/docs/sdks/html5/client-side/tags)
