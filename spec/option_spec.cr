require "./spec_helper"

describe "options" do
  it "--help" do
    system("./lake -h").should be_true
  end
  it "--version" do
    system("./lake -v").should be_true
  end
end
