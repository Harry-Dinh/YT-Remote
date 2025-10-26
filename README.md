# YT Remote & YT Remote Client

## About
__YT Remote__ is a remote app that allows you to control the YouTube TV website from your phone, like an actual TV remote!

It works by communicating with the __Remote Receiver__ (previously YT Remote Client) app on your Mac to simulate a key press that allows it to navigate the YouTube TV website.

## Set Up Instructions

### Remote Receiver
1. Open the Remote Receiver app
2. Click the switch to start listening for the YT Remote app

### YT Remote
1. Look for the IP address display on the Remote Receiver app
2. Navigate to Settings > Edit IP Address then type in the IP address displayed on the Remote Receiver app

You are now ready to control YouTube TV from your iPhone or iPad!

## Some Notes
- Adjusting volumes from the iOS device is not available at the moment so you will need to adjust the volume manually from the Mac's keyboard
- The iPad version is still under development, but it's available for the iPhone now
- This is only a personal project developed for personal use. I don't have any plans to put either apps on the App Store. __If you want to use it, feel free to clone this repository and build it yourself__
- Loading the YouTube TV (youtube.com/tv#) website requires changing the user agent of your browser to a user agent that can use the website (i.e. a PS4 console or something like that) otherwise it will just redirect you to youtube.com (desktop version) instead
	- You can also use this web extension if you're using Firefox, it will make the YouTube TV website load without you having to change the browser's user agent
- Changing browser agent doesn't work for Safari so you'll have to use another web browser