Based on https://twitter.com/catnapgames/status/833745955589611520

trying to check programmatically if filesystem is APFS or not.

First try: write new file, check difference in free disk space. This tells us the block size. Not sure if useful, but currently getting 8192 on iOS simulator on HFS+ and 4096 on iPhone 5 running 10.3 beta 3. Need more datapoints, will try tomorrow on some more recent device(s).
