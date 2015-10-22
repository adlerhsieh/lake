module Lake
  class Builder
    def initialize(@file)
      @content  = File.read_lines(@file.to_s)
      @root     = @file.split("/")[0..-2].join("/")
      @filename = @file.split("/")[-1]
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
      cr_build(tasks)
    end

    # Runs crystal build and move it to bin directory
    private def cr_build(tasks)
      tasks.each do |task, content|
        task_name = "#{@root}/tasks/#{task}.cr"
        exe_name  = "#{@root}/bin/#{task}"
        # Build task if task isn't duplicate
        if File.read(task_name) != content
          File.write(task_name, content)
          puts "Building task: #{task}"
          system("crystal build #{task_name} -o #{exe_name}")
        end
      end
    end

  end
end
