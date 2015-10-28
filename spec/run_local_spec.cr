require "./spec_helper"

describe "Run tasks" do
  it "create" do
    system("./lake create")
    File.file?("#{ENV["PWD"]}/create.txt").should be_true
  end
end
