require 'strava/route/images/version'
require 'tempfile'
require_relative './invalid_url.rb'

require 'selenium-webdriver'
require 'mini_magick'

module Strava
  module Route
    class Images
      attr_reader :url, :base, :route, :altimetry

      def initialize(url, options = {})
        raise ::Strava::Route::InvalidUrl unless url.match?(/strava.com/)

        @url       = url
        @base      = options[:base]      ||= "#{Tempfile.new('strava-base').path}.png"
        @route     = options[:route]     ||= "#{Tempfile.new('strava-route').path}.png"
        @altimetry = options[:altimetry] ||= "#{Tempfile.new('strava-altimetry').path}.png"
      end

      def extract
        {
          base:      extract_screenshot,
          route:     extract_route,
          altimetry: extract_altimetry
        }
      end

      private

      def extract_screenshot
        options = ::Selenium::WebDriver::Chrome::Options.new
        options.add_argument('--headless')
        driver = ::Selenium::WebDriver.for :chrome, options: options

        driver.navigate.to @url
        driver.manage.window.resize_to(1500, 900)
        driver.save_screenshot @base
        @base
      end

      def extract_route
        image = MiniMagick::Image.open(@base)
        image.crop '800x360+132+185'
        image.write @route
        @route
      end

      def extract_altimetry
        image = MiniMagick::Image.open(@base)
        image.crop '800x170+132+550'
        image.write @altimetry
        @altimetry
      end
    end
  end
end
