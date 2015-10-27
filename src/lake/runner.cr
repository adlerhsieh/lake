module Lake
  class Runner
    getter tasks

    def initialize(args : Array(String), home = false)
      @root = if home
        @root = ENV["HOME"]
      else
        @root = ENV["PWD"]
      end
      @tasks = args.map {|arg| arg.includes?("-") ? nil : arg }.compact
    end

    def run(filename)
      system("#{@root}/.lake/bin/#{filename}")
    end

    def has_task?
      @tasks.size > 0
    end

    def change_root
      @root = ENV["HOME"]
    end
  end
end
