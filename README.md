# Create register picker

[![Build Status](https://travis-ci.org/openregister/create-register-picker.svg?branch=master)](https://travis-ci.org/openregister/create-register-picker)

This is a tool for creating [pickers](https://github.com/alphagov/openregister-location-picker) based on [Registers](https://registers.cloudapps.digital/).

## Prerequisites

This is a Rails 5.1 app with [webpacker](http://github.com/rails/webpacker). Initially developed on the following (but likely works on other versions):

```bash
$ ruby -v
ruby 2.4.0p0 (2016-12-24 revision 57164) [x86_64-darwin15]
$ bundle --version
Bundler version 1.15.2
$ node -v
v8.1.4
$ yarn --version
0.27.5
```

## Installing and running locally

Install the Ruby and node.js dependencies:

```bash
$ bundle
$ yarn
```

Then run a server locally by running the following commands in two shells:

```bash
$ bundle exec rails server
```

```bash
$ ./bin/webpack-dev-server --hot --inline
```

## Deploying

You'll need to have a [GOV.UK PaaS](https://www.cloud.service.gov.uk/) account configured with access to the `openregisters` organisation.

Run:

```bash
cf push create-register-picker
```

## License

[MIT](LICENSE.txt).
