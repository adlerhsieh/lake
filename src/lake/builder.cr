module Lake
  class Builder
    def initialize(@file)
      @content  = File.read_lines(@file.to_s)
      @filename = @file.split("/")[-1]
      @root     = @file.split("/")[0..-2].join("/")
      @root     += "/.lake" if @filename == "Lakefile"
    end

    # Prepends Lake DSL to a task
    def prepend_dsl
      # WIP
    end

    # Matches task content with source
    def up_to_date?
      if File.file?(file(:tasks).to_s)
        @task == File.read(file(:tasks).to_s)
      else
        false
      end
    end

    def build_tasks
      tasks = {} of String? => MemoryIO | String?
      title = ""
      desc  = [] of String
      @content.each_with_index do |line, index|
        if /^Task\./ =~ line
          title = line.match(/^Task\.(\w+)/) {|md| md[1] }
        else
          desc << line
        end
        if index + 1 == @content.size || /^Task\./ =~ @content[index + 1]
          unless title == ""
            tasks[title] = desc.join("")
          end
          title = ""
          desc = [] of String
        end
      end
      crystal_build(tasks)
    end

    # Runs crystal build and output to the bin directory
    private def crystal_build(tasks)
      tasks.each do |task, content|
        task_name = "#{@root}/tasks/#{task}.cr"
        exe_name  = "#{@root}/bin/#{task}"
        # Build task if the task isn't duplicate
        next if File.exists?(task_name) && File.read(task_name) == content
        File.write(task_name, content)
        system("crystal build #{task_name} -o #{exe_name}")
        if File.exists?(exe_name)
          puts "#{"Task built".colorize(:green)}: #{task}"
        else
          File.delete(task_name)
          puts "#{"Task ignored".colorize(:red)}: #{task}"
        end
      end
    end

  end
end
