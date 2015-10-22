require "./lake/*"
require "colorize"
require "option_parser"

error  = Lake::Exception.new
finder = Lake::Finder.new

OptionParser.parse! do |parser|
  parser.on("-t TASK", "--task=TASK", "Executes a specified task") { |name| 
    finder.set_dirs
    finder.create_tasks
    error.missing_task(name) unless finder.tasks.includes?(name)
    system(finder.find_task(name)) 
    abort(nil)
  }
  parser.on("-h", "--help", "Shows this message") {
    puts parser 
    abort(nil)
  }
  parser.on("-c", "--create", "Generates a scaffold") { 
    finder.set_dirs 
    abort(nil)
  }
  parser.banner = "Basic usage: lake -t [taskname]"
end

# puts "Usage: lake -t [taskname]"
puts "Available tasks: #{finder.tasks}"
