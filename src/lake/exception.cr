require "colorize"

module Lake
  class Exception
    def initialize
    end

    def missing_lakefile
      abort("#{error}: Couldn't find \"Lakefile\"")
    end

    def missing_task(name)
      abort("#{error}: Couldn't find task \"#{name}\"")
    end

    def no_task
      abort("No task found. Usage:\n1. Create tasks in Lakefile.\n2. Run: lake -t [taskname]")
    end

    private def error
      "Error".colorize(:red)
    end

  end
end
