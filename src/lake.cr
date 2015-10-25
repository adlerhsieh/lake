require "./lake/*"
require "colorize"
require "option_parser"

error  = Lake::Exception.new
finder = Lake::Finder.new
finder.prepare

OptionParser.parse! do |parser|
  parser.on("[taskname]", "Run a specified task.") {}
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
  parser.on("-p", "--purge", "Removes .lake directory and Lakefile."){
    system("rm -rf .lake")
    system("rm lake")
    system("rm Lakefile")
    puts "Purged."
    exit 0
  }
  # parser.banner = "Basic usage: lake [taskname]"
end

if ARGV
  runner = Lake::Runner.new(ARGV)
  if runner.has_task?
    finder.create_tasks 
    runner.tasks.each do |name|
      error.missing_task(name) unless finder.tasks.includes?(name)
      runner.run(name)
    end
    exit 0
  else
    error.no_task
  end
end

puts "Available tasks: #{finder.tasks}"
exit 0
