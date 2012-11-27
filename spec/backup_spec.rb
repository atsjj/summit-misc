require 'spec_helper'

class Summit::Misc::Backup
  def execute_command(cmd)
    # override so that cmd isnt executed
    cmd
  end
end

describe Summit::Misc::Backup do
  before(:each) do
    @backup = Summit::Misc::Backup.new 'name', '/a/dir'
  end

  describe '#name' do
    it 'should set name' do
      @backup.name.should == 'name'
    end
  end

  describe '#backup_dir' do
    it 'should set backup_dir' do
      @backup.backup_dir.should == '/a/dir'
    end
  end

  describe '#backup_files' do
    it 'should execute tar' do
      dir = 'some/dir'
      cmd = @backup.backup_files dir
      cmd.split[0].should == '/bin/tar'
    end

    it 'should backup the specified path' do
      dir = 'some/dir'
      cmd = @backup.backup_files dir
      cmd.split[-1].should == dir
    end

    it 'should remove the leading / from the path' do
      dir = 'some/dir'
      cmd = @backup.backup_files '/' + dir
      cmd.split[-1].should == dir
    end

  end
end
