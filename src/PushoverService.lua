local PushoverService = {}
PushoverService.__index = PushoverService
PushoverService.aliases = {}

local BASE_URL = 'https://api.pushover.net/1/%s'
local HTTP_SERVICE = game:GetService('HttpService')

function PushoverService.Authenticate ( AUTH_TOKEN, USER_KEY )
    local session = {
        AUTH_TOKEN = AUTH_TOKEN or error('Authentication: No AUTH_TOKEN supplied.'),
        USER_KEY = USER_KEY or error('Authentication: No USER_KEY supplied.')
    }

    return setmetatable(session, PushoverService)
end

function PushoverService.RegisterDeviceAliases ( ALIASES )
    for alias, real in pairs( ALIASES ) do
        PushoverService.aliases[alias] = real
    end
end

function PushoverService:Notify ( DEVICE, MESSAGE, OPTIONS )
    OPTIONS = OPTIONS or {}
    OPTIONS.token = self.AUTH_TOKEN
    OPTIONS.user = self.USER_KEY
    OPTIONS.message = MESSAGE
    OPTIONS.device = PushoverService.aliases[DEVICE] or DEVICE

    local success, response = pcall(
        HTTP_SERVICE.RequestAsync,
        HTTP_SERVICE,
        {
            ['Url'] = BASE_URL:format( 'messages.json' ),
            ['Method'] = 'POST', 
            ['Headers'] = {
                ['Content-Type'] = 'application/json'
            }, 
            ['Body'] = HTTP_SERVICE:JSONEncode(OPTIONS)
        }
    )

    return success, response
end

return PushoverService