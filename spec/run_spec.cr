require "./spec_helper"

describe "Run tasks" do
  it "create" do
    system("./lake create")
    File.file?("#{ENV["PWD"]}/create.txt").should be_true
  end
end

describe "-g" do
  it "creates tasks in HOME" do
    system("mv -f ~/.lake ~/.lake-backup")    if Dir.exists?("#{ENV["HOME"]}/.lake") 
    system("mv ~/Lakefile ~/Lakefile-backup") if File.exists?("#{ENV["HOME"]}/Lakefile")
    system("mkdir ~/.lake")
    File.write("#{ENV["HOME"]}/.lake/#{file_name[0]}.cr", task_content[0])
    Dir.exists?("#{ENV["HOME"]}/.lake").should be_true
    File.exists?("#{ENV["HOME"]}/.lake/#{file_name[0]}.cr").should be_true
  end

  it "run tasks from HOME" do
    system("ls ~/.lake")
    system("./lake -g hello").should be_true
  end

  it "remove testing files" do
    system("rm -rf ~/.lake")
    system("rm ~/Lakefile")
    system("mv -f ~/.lake-backup ~/.lake")    if Dir.exists?("#{ENV["HOME"]}/.lake-backup") 
    system("mv ~/Lakefile-backup ~/Lakefile") if File.exists?("#{ENV["HOME"]}/Lakefile-backup")
    Dir.exists?("#{ENV["HOME"]}/.lake-backup").should be_false
    File.exists?("#{ENV["HOME"]}/.Lakefile-backup").should be_false
  end
end
