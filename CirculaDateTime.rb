class CirculaDateTime
  include Comparable

  @year = 0
  @month = 0
  @day = 0
  @hour = 0
  @minute = 0
  @second = 0

  MONTHS_PER_YEAR = 13
  DAYS_PER_MONTH = 24
  HOURS_PER_DAY = 2
  MINUTES_PER_HOUR = 60
  SECONDS_PER_MINUTE = 60

  def initialize(year, month, day, hour, minute, second)
    @year = year
    @month = month - 1
    @day = day - 1
    @hour = hour
    @minute = minute
    @second = second
  end

  def self.parse(string)
    date = string.split("T")[0].split("-")
    time = string.split("T")[1].split(":")
    dateTime = CirculaDateTime.new(date[0].to_i, date[1].to_i, date[2].to_i, time[0].to_i, time[1].to_i, time[2].to_i)

    if !dateTime.validate
      raise ArgumentError, "Invalid CirculaDateTime: #{string}"
    end

    return dateTime
  end

  def validate
    @year >= 0 &&
      @month >= 0 && @month < MONTHS_PER_YEAR &&
      @day >= 0 && @day < DAYS_PER_MONTH &&
      @hour >= 0 && @hour < HOURS_PER_DAY &&
      @minute >= 0 && @minute < MINUTES_PER_HOUR &&
      @second >= 0 && @second < SECONDS_PER_MINUTE
  end

  def to_i
    seconds = 0
    seconds += @year * MONTHS_PER_YEAR * DAYS_PER_MONTH * HOURS_PER_DAY * MINUTES_PER_HOUR * SECONDS_PER_MINUTE
    seconds += @month                  * DAYS_PER_MONTH * HOURS_PER_DAY * MINUTES_PER_HOUR * SECONDS_PER_MINUTE
    seconds += @day                                     * HOURS_PER_DAY * MINUTES_PER_HOUR * SECONDS_PER_MINUTE
    seconds += @hour                                                    * MINUTES_PER_HOUR * SECONDS_PER_MINUTE
    seconds += @minute                                                                     * SECONDS_PER_MINUTE
    seconds += @second
  end

  def <=>(another)
    return self.to_i <=> another.to_i
  end

  def year_to_str
    sprintf '%04d', @year
  end

  def month_to_str
    sprintf '%02d', @month + 1
  end

  def day_to_str
    sprintf '%02d', @day + 1
  end

  def date_to_str
    "#{year_to_str}-#{month_to_str}-#{day_to_str}"
  end

  def date_to_human
    "#{@day+1}.#{@month+1}.#{@year}"
  end

  def hour_to_str
    sprintf '%02d', @hour
  end

  def minute_to_str
    sprintf '%02d', @minute
  end

  def second_to_str
    sprintf '%02d', @second
  end

  def time_to_str
    "#{hour_to_str}:#{minute_to_str}:#{second_to_str}"
  end

  def time_to_human
    "#{hour_to_str}:#{minute_to_str}"
  end

  def to_str
    "#{date_to_str}T#{time_to_str}"
  end

  def to_human
    "#{date_to_human}, #{time_to_human}"
  end

  def to_json(*a)
    {
      "year" => @year,
      "month" => @month,
      "day" => @day,
      "hour" => @hour,
      "minute" => @minute,
      "second" => @second
    }.to_json(*a)
  end
end

# a = CirculaDateTime.parse("0000-01-01T00:00:00")
# b = CirculaDateTime.parse("0000-01-01T00:01:00")
# c = CirculaDateTime.parse("0000-00-01T00:01:00")
#
# puts "a.to_i = #{a.to_i}"
# puts "b.to_i = #{b.to_i}"
# puts "a <=> b = #{a <=> b}"
# puts "b <=> a = #{b <=> a}"
# puts "a <=> a = #{a <=> a}"
#
# puts "b.validate #{b.validate}"
# puts "c.validate #{c.validate}"
