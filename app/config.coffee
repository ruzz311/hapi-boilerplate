path     = require 'path'
basePath = path.resolve( __dirname+"", "../" )
console.log basePath

module.exports = 
    views:
        basePath : basePath
        path     : './templates'
        engine:
            module: 'handlebars'
            extension: '.html'
