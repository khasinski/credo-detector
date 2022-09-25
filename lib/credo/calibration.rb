module Credo
  module Calibration
    def self.calibrate(tests: 300, device_id: 0)
      puts "Calibration..."
      Framegrabber.open(device_id)
      max_values = tests.times.map do |test_number|
        frame = grab_frame
        print "\r Test no.: #{test_number + 1} / #{tests} "
        print "Max: #{frame.max} "
        print "Average: #{"%.4f" % (frame.sum.to_f / frame.size)} "
        print "Exit ctrl+c"
        sleep 1
        frame.max
      end
      puts
      puts "Calibration completed"
      puts "Maximum value: #{max_values.max}"
      puts "Average of maximum values: #{max_values.sum.to_f / max_values.size}"
    ensure
      Framegrabber.release
      "Calibration interrupted"
    end

    def self.grab_frame
      frame = Framegrabber.grab_frame
      frame.shift(10)
      frame.pop(10)
      frame.map! do |row|
        row.shift(10)
        row.pop(10)
        row
      end.flatten
    end
  end
end
