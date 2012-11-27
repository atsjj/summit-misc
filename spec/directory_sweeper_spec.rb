require 'spec_helper'

describe Summit::Misc::DirectorySweeper do

  describe '#sweep' do
    before(:each) do
      @current_dir = 'current/dir'
      @old_dir = 'old/dir'
      @sweeper = Summit::Misc::DirectorySweeper.new @current_dir, @old_dir
    end

    it 'should remove old files and move current files' do
      current_files = ['a', 'b']
      old_files = ['c', 'd']

      # setup stubs
      File.stub(:file?).and_return true
      Dir.should_receive(:glob).with(File.join(@current_dir, '*')).and_return(current_files)
      Dir.should_receive(:glob).with(File.join(@old_dir, '*')).and_return(old_files)

      # expectations
      FileUtils.should_receive(:rm).with(old_files)
      FileUtils.should_receive(:mv).with(current_files, @old_dir)

      @sweeper.sweep
    end
  end
end
