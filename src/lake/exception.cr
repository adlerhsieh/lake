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

    private def error
      "Error".colorize(:red)
    end

  end
end
