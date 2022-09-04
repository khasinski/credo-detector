# frozen_string_literal: true

require_relative "detector/version"
require "date"

module Credo
  module Detector
    attr_reader :threshold, :last_ping

    class Error < StandardError; end

    def self.detect(device_id: 0, threshold: 60)
      @last_ping = linux_time
      @last_detection_time = 0

      Framegrabber.open(device_id)

      sample_number = sample_save = 0
      print("Start sampling...")
      sleep(2)
      loop do
        time_dat = DateTime.now.strftime("%Y-%m-%d %H:%M:%S:%f")
        detection_time = linux_time
        sample_number += 1
        grab_frame!
        print("\r Sample: #{sample_number} | Saved #{sample_save} | Press Ctrl + c to exit")
        sleep(0.000001)

        counter = 0
        xy_coordinates = []

        flattened = @frame.flatten
        coords = []
        if flattened.any? { |subpixel| subpixel > threshold }
          @frame.each_with_index do |row, x|
            row.each_with_index do |pixel, y|
              coords << [x, y] if pixel.any? { |subpixel| subpixel > threshold }
            end
          end
        end
      end
    ensure
      Framegrabber.release
    end

    private

    def self.grab_frame!
      @frame = Framegrabber.grab_frame
    end

    def self.linux_time
      DateTime.now.strftime("%Q").to_i
    end
  end
end

require_relative "../framegrabber"
require_relative "calibration"
require "grab_frame_ext"
