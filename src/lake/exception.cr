require "colorize"

module Lake
  class Exception
    def initialize
    end

    def taskname_incorrect
      puts "\"-\" in a task name is not allowed."
    end

    def missing_lakefile
      abort("#{error}: Couldn't find \"Lakefile\"")
    end

    def missing_task(name)
      abort("#{error}: Couldn't find task \"#{name}\"")
    end

    def no_task
      abort("No task found.")
    end

    private def error
      "Error".colorize(:red)
    end

  end
end
