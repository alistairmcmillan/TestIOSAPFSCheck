## What is this
An experiment, trying to programmatically detect if filesystem is APFS when running on iOS.

Based on https://twitter.com/catnapgames/status/833745955589611520

## How to detect APFS on iOS

- First try: write new file, check difference in free disk space. This tells us the block size. Not sure if useful, but currently getting 8192 on iOS simulator on HFS+ and 4096 on iPhone 5 running 10.3 beta 3. **Turns out this is not significant**

- Second try: file timestamp resolution. Create a series of files, check if timestamps differ by seconds or milliseconds. **Seems like I'm getting sub-second resolution on some devices.**

## Results

So the 2nd attempt seems to have some results. I got sub-second timestamp diff on an iPad Pro running 10.3 beta. iPad Air 2 running iOS 9 gets 1-second resolution. iPhone 5 running iOS 10.3 beta gets 1-second resolution as well - maybe the rumors about APFS running only on 64bit platforms is true?

### iPad Air 2 iOS 9

![iPad Air 2 iOS 9](Screenshots/IMG_0099%20iPad%20Air%202%20ios%209.PNG)

### iPad Pro iOS 10.3 beta

![iPad Pro iOS 10.3 beta](Screenshots/IMG_0916%20ipad%20pro%20ios%2010.3%20beta.PNG)

### iPhone 5 iOS 10.3 beta

![iPhone 5 iOS 10.3 beta](Screenshots/IMG_5809%20iPhone%205%20ios%2010.3%20beta.PNG)
