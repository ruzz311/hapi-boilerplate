require('coffee-script');
require('handlebars');
require('./app/index');

////////// TESTING
/*
var Hapi = require('hapi');

var options = {
    views: {
        basePath: __dirname,
        path: './templates',
        engine: {
            module: 'handlebars'
        }
    }
};

// Create a server with a host, port, and options
var server = Hapi.createServer('localhost', 8000, options);

// Define the route
var hello = {
    handler: function (request) {

      // Render the view with the custom greeting
        request.reply.view('index.html', { title: "fuckya", message: 'hello world' }).send();
    }
};

// Add the route
server.route({
    method: 'GET',
    path: '/',
    config: hello
});

// Start the server
server.start();
*/