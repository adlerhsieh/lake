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
  parser.on("-c", "--create", "Generate a scaffold for lake") { 
    finder.set_dirs 
    puts "#{"Created".colorize(:green)}: #{finder.root}/Lakefile"
    puts "#{"Created".colorize(:green)}: #{finder.root}/.lake"
    puts "#{"Created".colorize(:green)}: #{finder.root}/.lake/bin"
    puts "#{"Created".colorize(:green)}: #{finder.root}/.lake/tasks"
    abort(nil)
  }
  parser.banner = "Basic usage: lake -t [taskname]"
end

# puts "Usage: lake -t [taskname]"
puts "Available tasks: #{finder.tasks}"
