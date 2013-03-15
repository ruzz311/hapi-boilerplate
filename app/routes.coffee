path    = require "path"
pkg     = require path.resolve(__dirname, '../', 'package.json')

# Proxy Route Configs
proxy =
    prefix: "/api"
    trello:
        protocol    : "https"
        url         : "api.trello.com"
        version     : 1
        key         : "<key>"
        secret      : "<secret>"
        handler     : (req, callback)->
            t = proxy.trello
            callback null, "#{ t.protocol }://#{ t.url }/#{ t.version }/#{ req.params.path }?key=#{ t.key }"

# App Routes
routes  = [
        method  : 'GET'
        path    : '/info'
        config  :
            handler: (req) -> req.reply pkg
    ,
        method  : 'GET'
        path    : '/api/trello/{path*}'
        handler : 
            proxy:
                mapUri: proxy.trello.handler
]

# Commonly Used Routes
common = [
        method: 'GET'
        path: '/favicon.ico'
        handler:
            file: './public/favicon.ico' 
        config:
            cache: 
                mode: 'client'
                expiresIn: 86400000
                privacy: 'public'
    ,
        method  : 'GET'
        path    : '/{path*}'
        config  :
            handler:
                directory: 
                    path    : './public'
                    listing : true
                    index   : true
]

module.exports = routes.concat common