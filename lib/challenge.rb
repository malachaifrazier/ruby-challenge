require "time"
# NOTE: https://apidock.com/ruby/v2_6_3/Time/xmlschema
# NOTE: https://ruby-doc.org/core-3.0.0/Time.html

# Parse the file located at @file_path and set three attributes:
#
# earliest_time: the earliest time contained within the data set
# latest_time: the latest time contained within the data set
# peak_year: the year with the most number of timestamps contained within the data set

class Challenge
  attr_reader :earliest_time, :latest_time, :peak_year

  def initialize(file_path)
    @file_path = File.expand_path(file_path)
  end

  def parse
    earliest_time = Time.now.to_i 
    latest_time   = 0
    peak_year     = {}

    File.open(@file_path, "r") do |file| 
      file.each_line do |line|
        # Earliest Time:
        if Time.parse(line).to_i < earliest_time
          earliest_time = Time.parse(line).to_i
        end

        # Latest Time:
        if Time.parse(line).to_i > latest_time
          latest_time = Time.parse(line).to_i
        end

        # Peak Year:
        if peak_year.key?(Time.parse(line).year) == true 
          peak_year[Time.parse(line).year] += 1
        else
          peak_year[Time.parse(line).year] = 1
        end 
      end
    end
    
    @earliest_time = Time.at(earliest_time)
    @latest_time   = Time.at(latest_time)
    @peak_year     = peak_year.key(peak_year.values.max)
  end
end
