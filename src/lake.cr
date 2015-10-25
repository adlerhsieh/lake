require "./lake/*"
require "colorize"
require "option_parser"

error  = Lake::Exception.new
finder = Lake::Finder.new
finder.set_dirs

OptionParser.parse! do |parser|
  parser.on("-t TASK", "--task=TASK", "Executes a specified task") { |name| 
    finder.create_tasks
    error.missing_task(name) unless finder.tasks.includes?(name)
    system(finder.find_task(name)) 
    abort(nil)
  }
  parser.on("-b", "--build", "Build all tasks without running") {
    finder.create_tasks
    abort(nil)
  }
  parser.on("-h", "--help", "Shows this message") {
    puts parser 
    abort(nil)
  }
  # parser.on("-c", "--create", "Generates a scaffold") { 
  #   finder.set_dirs 
  #   abort(nil)
  # }
  parser.on("-p", "--purge", "Remove .lake directory and Lakefile"){
    system("rm -rf .lake")
    system("rm Lakefile")
    abort("Purged.")
  }
  parser.banner = "Basic usage: lake -t [taskname]"
end

error.no_task if finder.tasks.size == 0
puts "Available tasks: #{finder.tasks}"
