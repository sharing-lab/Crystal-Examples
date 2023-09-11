require "log"

## to write into log file, the standard way is :
# Log.info { "some information here" }
#
## the result is this line below :
# 2023-09-11T23:35:32.790391Z   INFO - some information here

## timestamp in standard way is in UTC
## so, here is an example to get timestamp in local time
formatter = Log::Formatter.new do |entry, io|
  io << String.build do |str|
    str << entry.timestamp.to_s("%F %T.%L") << entry.severity.label.rjust(6) <<
      "  " << entry.message
  end
end
Log.setup(:debug, Log::IOBackend.new(formatter: formatter))

# then we can start writing log messages as usual
Log.info  { "some information here" }
Log.error { "an error occurred" }

# the output :
# 2023-09-12 06:40:01.023  INFO  some information here
# 2023-09-12 06:40:01.023 ERROR  an error occurred
