# Credo Detector










[Credo](https://credo.science/) detector for Ruby!

This allows you to both calibrate your sensor and run detection on multiple cameras.

## Installation

### Prerequirements

#### macOS

Install OpenCV4 with:

    $ brew install opencv

Install imagemagick with:
   
    $ brew install pkg-config imagemagick

#### Ubuntu/Debian

Install OpenCV4 with:

    $ sudo apt install libopencv-dev

Install imagemagick with:

    $ sudo apt install libmagickwand-dev

### Other systems

We require pkg-config for native library compilation, a C++ compiler, ImageMagick and OpenCV4.

### I have met all the requirements

Install this gem with:

    $ gem install credo detector

You can also use it in your app, in which case add

    gem "credo-detector"

to your Gemfile.

## Usage

### CLI

We do not support sending results to Credo since we're still haven't validated the detection, but you can calibrate your cameras and run the code locally with:

    $ credo calibrate

and run the detection with

    $ credo detect

You can choose camera with `--camera={camera_id}`. Cameras are numbered starting from 0.

If you want to run multiple cameras run the application multiple times with different camera ids.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/khasinski/credo-detector. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/credo-detector/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Credo Detector project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/khasinski/credo-detector/blob/master/CODE_OF_CONDUCT.md).
