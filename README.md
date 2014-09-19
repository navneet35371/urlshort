# littleurl

## Dependencies:

**Gems:** sqlite3, sinatra, bundler

## Usage

### Development

cd in to app dirctory

bundle install to install all the required gems

To **start** the web server, run:

    ruby lilurl.rb

to test the server make a request to it

curl -d "url=http://www.codemymobile.com" http://localhost:4567/

returns

{
    "pass" : true,
    "url": "http://your.short/url"
}

visiting the url will redirect to the original url
