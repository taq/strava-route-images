# Strava::Route::Images

Extract route and altimetry images from a Strava URL.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'strava-route-images'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install strava-route-images

## Usage

Like

```ruby
extractor = Strava::Route::Images.new('https://www.strava.com/routes/16026750')
extractor.extract
```

will return a hash with the images:

```ruby
{
   :base      => "/tmp/strava-base20181210-27554-1lsiexj.png", 
   :route     => "/tmp/strava-route20181210-27554-tjeu61.png", 
   :altimetry => "/tmp/strava-altimetry20181210-27554-1lqirce.png"
}
```

or specifying the file names:

```ruby
extractor = Strava::Route::Images.new('https://www.strava.com/routes/16026750', 
                                      base: '/tmp/base.png',
                                      route: '/tmp/route.png',
                                      altimetry: '/tmp/altimetry.png'
                                     )
```
will return 

```ruby
{
   :base      => "/tmp/base.png", 
   :route     => "/tmp/route.png", 
   :altimetry => "/tmp/altimetry.png"
}
```

It's advised to run this on a background job, because extrating the screenshot
may be a slow and expensive job.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run
`rake test` to run the tests. You can also run `bin/console` for an interactive
prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To
release a new version, update the version number in `version.rb`, and then run
`bundle exec rake release`, which will create a git tag for the version, push
git commits and tags, and push the `.gem` file to
[rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at
https://github.com/[USERNAME]/strava-route-images.
