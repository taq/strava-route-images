require 'test_helper'

class Strava::Route::ImagesTest < Minitest::Test
  def setup
    @extractor = Strava::Route::Images.new('https://www.strava.com/routes/16026750')
  end

  def test_that_it_has_a_version_number
    refute_nil ::Strava::Route::Images::VERSION
  end

  def test_if_raises_an_exception_on_invalid_url
    assert_raises ::Strava::Route::InvalidUrl do
      @extractor = Strava::Route::Images.new('https://www.google.com/routes/16026750')
    end
  end

  def test_it_extract_screenshot
    assert_respond_to @extractor, :extract
    info = @extractor.extract
    assert_kind_of Hash, info
    assert info.key?(:base)
    assert info.key?(:route)
    assert info.key?(:altimetry)
    assert File.exist?(info[:base])
    assert File.exist?(info[:route])
    assert File.exist?(info[:altimetry])
  end

  def test_it_extract_screenshots_with_custom_names
    @extractor = Strava::Route::Images.new('https://www.strava.com/routes/16026750', 
                                           base: '/tmp/base.png',
                                           route: '/tmp/route.png',
                                           altimetry: '/tmp/altimetry.png'
                                          )
    %w[base route altimetry].each do |file|
      File.unlink("/tmp/#{file}.png") if File.exist?("/tmp/#{file}.png")
    end

    info = @extractor.extract
    assert_kind_of Hash, info
    assert info.key?(:base)
    assert info.key?(:route)
    assert info.key?(:altimetry)
    assert File.exist?('/tmp/base.png')
    assert File.exist?('/tmp/route.png')
    assert File.exist?('/tmp/altimetry.png')
  end
end
