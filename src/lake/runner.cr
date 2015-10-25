module Lake
  class Runner
    getter tasks

    def initialize(args : Array(String))
      @root  = ENV["PWD"]
      @tasks = args.map {|arg| arg.includes?("-") ? nil : arg }.compact
    end

    def run(filename)
      system("#{@root}/.lake/bin/#{filename}")
    end

    def has_task?
      @tasks.size > 0
    end
  end
end
