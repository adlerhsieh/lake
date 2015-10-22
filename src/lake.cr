require "./lake/*"
require "colorize"
require "option_parser"

error  = Lake::Exception.new
finder = Lake::Finder.new
finder.set_dirs
finder.create_tasks

OptionParser.parse! do |parser|
  parser.on("-t TASK", "--task=TASK", "Run a specified task") { |name| 
    error.missing_task(name) unless finder.tasks.includes?(name)
    system finder.find_task(name) 
    abort(nil)
  }
  parser.on("-h", "--help", "Show this message") { puts parser }
  parser.banner = "Basic usage: lake -t [taskname]"
end

puts "Usage: lake -t [taskname]"
puts "Available tasks: #{finder.tasks}"
