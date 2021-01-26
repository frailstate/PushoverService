# PushoverService 🔔
A Luau module for sending over push notifications to any of your devices, using the Pushover API.

## ⚙️ | Setup
This module uses [HttpService](https://developer.roblox.com/en-us/api-reference/class/HttpService) internally - so its best home is under `ServerStorage`. The module can be found [here](https://github.com/frailstate/PushoverService/blob/main/src/PushoverService.lua), no dependencies in sight!

You'll now need to [make a Pushover account](https://pushover.net/). This is relatively easy and only takes a few minutes. After you've done that, go ahead and download the Pushover app on the [platform of your choice](https://pushover.net/clients). When you've set that up, you should get a Device Key. Keep that handy!
One last step! Since the internet is full of bots, you'll need to prove to Pushover that you're legitimate and you're doing this for a harm-free cause. Lucky for you, that's also [very easy](https://pushover.net/apps/build)!

## 🥳 | The Fun Part
Now we've got the gruesome part out of the way. it's time we actually send some notifications. Because we're sending web requests, we'll need to do this on the server. Go ahead and insert a `Script` into `ServerScriptService`. Everytime you want to send a notification, it needs to be handled and send on the server. No client should touch this logic!

Before we use the module, we'll need to require it and then make an authenticated singleton.
```lua
-- Require the module for use
local PushoverService = require(game:GetService('ServerStorage').PushoverService)

-- Authenticate ourselves. AUTH_TOKEN is your APP TOKEN, USER_KEY should be displayed on the landing page.
local session = PushoverService.Authenticate( --[[ AUTH_TOKEN, USER_KEY ]] )
```

Now to send notifications, we use the `session:Notify(deviceKey: string, message: string [, options: {optName: optValue}])` method. Here's a few examples:
```lua
session:Notify(deviceKey, 'Hello from Roblox!')
```
```lua
game:GetService('Players').PlayerAdded:Connect(function(newPlayer)
    session:Notify(deviceKey, newPlayer.Name .. ' just joined the game!')
end)
```
The options table relates to a range of options Pushover has to offer. Check the options out [here](https://pushover.net/api#:~:text=Some%20optional%20parameters%20may%20be%20included). Keep in mind this module fills out the required fields for you.

# ⚠️ | Ending Notes
Pushover is **NOT a free service**. When your trial ends, you pay a one-time fee and then it is free forever. This fee is one per device. 
**THIS IS NOT AN OFFICIAL PUSHOVER MODULE**. This is an open-source utility module not endorsed by Pushover. Do not contact Pushover Support for any problems with this module UNLESS that problem is to do with official Pushover products (the app, the website, etc...). 

If there are any problems with this documentation [missing steps, unclear] feel free to let me know. I'm writing this documentation a few months after I originally created it.
