module Lake
  class Builder
    def initialize(@file)
      @task     = File.read(@file.to_s)
      @root     = @file.split("/")[0..-2].join("/")
      @filename = @file.split("/")[-1]
    end

    def file(dir)
      case dir
      when :tasks
        "#{@root}/tasks/#{@filename}"
      when :bin
        "#{@root}/bin/#{@filename[0..-4]}"
      end
    end

    # Prepends Lake DSL to a task
    def prepend_dsl
      # WIP
    end

    # Matches task content with source
    def match
      @task == File.read(file(:tasks).to_s)
    end

    def copy
      system("cp #{@file} #{file(:tasks)}")
    end

    # run crystal build and move it to bin directory
    def build
      system("crystal build #{file(:tasks)} -o #{file(:bin)}")
    end

  end
end
