require "./lake/*"
require "colorize"
require "option_parser"

error  = Lake::Exception.new
finder = Lake::Finder.new
finder.set_dirs

OptionParser.parse! do |parser|
  parser.on("-t TASK", "--task=TASK", "Executes a specified task.") { |name|
    finder.create_tasks
    error.missing_task(name) unless finder.tasks.includes?(name)
    system(finder.find_task(name)) 
    exit 0
  }
  parser.on("-b", "--build", "Build all tasks, ignoring existing tasks.") {
    finder.create_tasks
    exit 0
  }
  parser.on("-r", "--rebuild", "Rebuild all tasks.") {
    finder.recreate_tasks
    exit 0
  }
  parser.on("-h", "--help", "Shows this message.") {
    puts parser 
    exit 0
  }
  # parser.on("-c", "--create", "Generates a scaffold") { 
  #   finder.set_dirs 
  #   abort(nil)
  # }
  parser.on("-p", "--purge", "Remove .lake directory and Lakefile"){
    system("rm -rf .lake")
    system("rm Lakefile")
    exit("Purged.")
  }
  parser.banner = "Basic usage: lake -t [taskname]"
end

error.no_task if finder.tasks.size == 0
puts "Available tasks: #{finder.tasks}"
exit 0
