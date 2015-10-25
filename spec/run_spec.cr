require "./spec_helper"

describe "Run tasks" do
  it "-t create" do
    system("./lake -t create")
    File.file?("#{ENV["PWD"]}/create.txt").should be_true
  end
end

