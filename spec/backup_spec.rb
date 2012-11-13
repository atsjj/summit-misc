require 'spec_helper'

describe Summit::Misc::Backup do
  before(:each) do
    @backup = Summit::Misc::Backup.new 'name', '/a/dir'
  end

  describe "#name" do
    it 'should set name' do
      @backup.name.should == 'name'
    end
  end

  describe "#backup_dir" do
    it 'should set backup_dir' do
      @backup.backup_dir.should == '/a/dir'
    end
  end

end
