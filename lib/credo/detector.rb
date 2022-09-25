# frozen_string_literal: true

require_relative "detector/version"
require_relative "../framegrabber"
require "grab_frame_ext"
require "date"
require "rmagick"
require "pry"

module Credo
  module Detector
    attr_reader :threshold, :last_ping

    class Error < StandardError; end

    def self.detect(device_id: 0, threshold: 60)
      Framegrabber.open(device_id)

      detections = 0

      loop do
        grab_frame!
        sleep(0.000001)
        subpixels = @frame.flatten

        next print "\rToo much light detected, please cover your camera" if too_bright?(subpixels, threshold)
        print "\rBrightest subpixel: #{subpixels.max}"
        next if subpixels.max < threshold

        detections += 1

        multi_detections = 0
        @frame.each.with_index do |row, x|
          row.each.with_index do |pixel, y|
            next if pixel.max < threshold

            multi_detections += 1

            cropped = crop(x, y)
            filename = "detections/Sample no. #{detections}:#{multi_detections}.png"

            save_hit(cropped, filename)
            puts "\n#{filename} saved"
          end
        end
      end
    ensure
      Framegrabber.release
      puts "Camera disabled"
    end

    private

    def self.save_hit(cropped, filename)
      image = Magick::Image.constitute(cropped.first.size, cropped.size, "I", bgr_to_gray(cropped))
      image.write(filename) do |img|
        img.depth = 8
        img.format = "png"
      end
    end

    def self.crop(x, y)
      @frame.slice(x-10, 10).map { |row| row.slice(y-10, 10) }
    end

    def self.bgr_to_gray(image)
      # https://docs.opencv.org/3.4/de/d25/imgproc_color_conversions.html#color_convert_rgb_gray
      image.flatten(1).map { |bgr| (0.299 * bgr[2] + 0.587 * bgr[1] + 0.114 * bgr[0])/255.0 }
    end

    def self.too_bright?(subpixels, threshold)
      subpixels.sum.fdiv(subpixels.size) >= threshold
    end

    def self.grab_frame!
      @frame = Framegrabber.grab_frame
    end

    def self.linux_time
      DateTime.now.strftime("%Q").to_i
    end
  end
end


# time.sleep(0.000001)
# counter = 0
# xy_coordinates = []
# if np.max(data) >= int(threshold):
#
#   all_ziped = list(zip(list(np.where(data >= int(threshold))[1]), list(np.where(data >= int(threshold))[0])))
#   all_ziped.sort()
#
# while counter < len(all_ziped):
#   if len(all_ziped) == 1:
#     xy_coordinates.append(all_ziped[0])
#   break
#   elif counter == 0:
#     xy_coordinates.append(all_ziped[counter])
#   counter += 1
#   elif all_ziped[counter][0] - 10 < all_ziped[counter - 1][0]:
#     counter += 1
#   else:
#     xy_coordinates.append(all_ziped[counter])
#   counter += 1
#   multi_detection = 0
#   for x, y in xy_coordinates:
#     if x >= 11 and y >= 11:
#       img_crop = data[y-10:y + 10,
#       x-10:x + 10]
#     r = 50.0 / img_crop.shape[1]
#     dim = (50, int(img_crop.shape[0] * r))
#     sample_save = sample_save + 1
#     if img_crop is None:
#                      pass
#       else:
#         print(time_dat, sample_number, x, y,
#               round(np.average(data), 4), np.max(data),
#               sep=',', file=open(str(path) + "/Report.txt", "a"))
#       img_zoom = cv2.resize(img_crop, dim, interpolation=cv2.INTER_AREA)
#       gray_img_zoom = cv2.cvtColor(img_zoom, cv2.COLOR_BGR2GRAY)
#       cv2.imwrite(str(path) + "/" + str(time_dat) +
#                     " Sample no. %i:%i.png" % (sample_number,multi_detection), gray_img_zoom)
#       picture = open(str(path) + "/" + str(time_dat) +" Sample no. %i:%i.png"
#       % (sample_number,multi_detection), 'rb')
#       picture_read = picture.read()
#       base64_picture = str(base64.b64encode(picture_read))[2:]
#       multi_detection += 1


