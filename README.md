# download-daily-podcast.sh

A shell script and launchd plist to check a podcast feed every day and download any MP3s found in the feed.

In response to [this post in the MacPowerUsers G+ group](https://plus.google.com/113607853038920844381/posts/ZiuS2frat8t?cfem=1).


## Download, install, run

1. Download the script [download-daily-podcast.sh](https://raw.githubusercontent.com/tjluoma/download-daily-podcast.sh/master/download-daily-podcast.sh)
2. Save it somewhere such as `/usr/local/bin/download-daily-podcast.sh`
3. Make it executable: `chmod 755 /usr/local/bin/download-daily-podcast.sh`
4. Run the script: `/usr/local/bin/download-daily-podcast.sh` or just `download-daily-podcast.sh`

But then you'd have to remember to do it every day. That's a drag.

Enter automation…


## Use `launchd` to automate the process ## 

[Download the launchd plist](https://raw.githubusercontent.com/tjluoma/download-daily-podcast.sh/master/com.tjluoma.download-daily-podcast.plist) and call it something. For the sake of example I will use `com.tjluoma.download-daily-podcast.plist` but you can name it literally anything you want, as long as it ends with `.plist`.

Here’s what an example plist looks like:

		<?xml version="1.0" encoding="UTF-8"?>
		<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
		<plist version="1.0">
		<dict>
			<key>Label</key>
			<string>com.tjluoma.DownloadADailyPodcast</string>
			<key>Program</key>
			<string>/usr/local/bin/download-daily-podcast.sh</string>
			<key>RunAtLoad</key>
			<true/>
			<key>StandardErrorPath</key>
			<string>/tmp/com.tjluoma.download-daily-podcast.errors.log</string>
			<key>StandardOutPath</key>
			<string>/tmp/com.tjluoma.download-daily-podcast.output.log</string>
			<key>StartInterval</key>
			<integer>86400</integer>
		</dict>
		</plist>

1. The “Label” field can be anything you want.

2. The “Program” field needs to be wherever you saved the [download-daily-podcast.sh](https://raw.githubusercontent.com/tjluoma/download-daily-podcast.sh/master/download-daily-podcast.sh) file. I recommend `/usr/local/bin/` but you can save it anywhere you want, just make sure the `launchd` Program field points to it.

3. Use `RunAtLoad` if you want the shell script to run whenever you log into your account. I recommend this in case your Mac is off for awhile.

4. The `StandardErrorPath` and `StandardOutPath` paths can be whatever you want, but it’s a good idea to put it somewhere in case there are errors. Normally you can ignore these files unless there is a problem.

5. `StartInterval` defines the number of seconds that `launchd` should wait before running the script again. 86400 seconds equals 24 hours, so this should run once a day. If the Mac is off for more than 24 hours, Mac OS X should just run it once.


