# Overview
A simple Rails app tutorial using the Zillow API to help you estimate how expensive a house you can afford based on your salary and cash on-hand for a down payment. It has a standard web interface as well as a RESTful API endpoint for a future client/server model (e.g. having an Ember app as frontend). It demonstrates integration and unit testing using Cucumber and Rspec, respectively, as well as API documentation using Swagger. In the interest of time, communication with Zillow API was done in a custom class rather than extending the rubillow gem (which has been languishing for the last two years). The styling is Twitter bootstrap and the flow is pretty simple but I think it can be pretty useful.

# Deployment
An instance of this app is hosted at http://morty.mankindforward.com/ using Heroku

# API Documentation
Checkout swagger.yml directly if you're using the [Chrome extension](http://chefarchitect.github.io/swagger.ed/features/a-simple-chrome-extension/) or a [screenshot from Swagger Editor](https://www.evernote.com/shard/s49/sh/b7932766-f3f4-4e5e-b1ad-439890070d36/c2d8da6ba5fd9f5a67b6b0152d7d1b27)

# Tests
There are basic cucumber integration tests covering the web interface as well as the RESTful API and rspec unit tests.

Run all tests:

        bundle exec rake

Run integration tests:

        bundle exec cucumber

Run unit tests

        bundle exec rspec

# Hosting your own instance
If you want to run your own instance of this app, you'll need to create a Zillow account, request an API key and set ZILLOW_ZWSID in your environment(s).
