require "spec_helper"

RSpec.describe Partoo do
  it "has a version number" do
    expect(Partoo::VERSION).not_to be nil
  end

  it "can list files" do
    expect(Partoo.list('spec/fixtures/files/testdata.par2').to_s).to match(/test-0.data/)
  end

  it "can dump packets" do
    expect(Partoo.dump('spec/fixtures/files/testdata.par2').to_s).to match(/PAR2.*PKT/)
  end

  it "can get creator" do
    expect(Partoo.creator('spec/fixtures/files/testdata.par2')).to eql("Created by QuickPar 0.4")
  end

  it "can get recovery set file count" do
    expect(Partoo.recovery_set_file_count('spec/fixtures/files/testdata.par2')).to eql(10)
  end

  it "can get recovery set id" do
    expect(Partoo.recovery_set_id('spec/fixtures/files/testdata.par2')).to eql(172626095358484736903154840814915262152)
  end

  it "can get slice size" do
    expect(Partoo.slice_size('spec/fixtures/files/testdata.par2')).to eql(5376)
  end
end
