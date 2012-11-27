require 'fileutils'

module Summit
  module Misc
    class DirectorySweeper
      def initialize(current_dir, old_dir)
        @current_dir = current_dir
        @old_dir = old_dir
      end

      # Removes all files from old directory, moves all files from current directory to old
      def sweep
        FileUtils.rm all_files(@old_dir)
        FileUtils.mv all_files(@current_dir), @old_dir
      end

      protected

      def all_files(dir)
        Dir.glob(File.join(dir, '*')).select{ |f| File.file?(f) }
      end
    end
  end
end
