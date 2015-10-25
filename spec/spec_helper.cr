require "spec"
# require "../src/lake"

def file_name
  [
    "hello",
    "go"
  ]
end

def task_content
  [
    "Task.hello\n"\
    "puts \"hello world\"\n"\
    "Task.create\n"\
    "system(\"touch create.txt\")",

    "Task.go\n"\
    "puts \"We need to go now.\"\n"
  ]
end


