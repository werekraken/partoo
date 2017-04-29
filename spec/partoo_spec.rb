require "spec_helper"

RSpec.describe Partoo do
  it "has a version number" do
    expect(Partoo::VERSION).not_to be nil
  end

  it "lists files" do
    expect(Partoo.list("some.par2")).to eql("list of files from some.par2")
  end
end
