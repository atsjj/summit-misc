module Summit
  module Misc
    class Backup
      attr_accessor :name, :backup_dir

      def initialize(name, backup_dir)
        self.name = name
        self.backup_dir = backup_dir
      end

      def backup_database(user, host, password, database)
        cmd = cmd_database_dump(user, host, password, database)
        execute_command cmd
      end

      def backup_files(path)
        cmd = cmd_archive_files(path)
        execute_command cmd
      end

      protected

      def execute_command(cmd)
        Kernel.system cmd
      end

      def timestamp
        return Time.now.strftime "%Y-%m-%d-%0k%M"
      end

      def filename(prefix, suffix, extension)
        return File.join backup_dir, "#{prefix}-#{timestamp}-#{suffix}.#{extension}"
      end

      def cmd_database_dump(user, host, password, database)
        file = filename database, "db", "sql.gz"
        return "/usr/bin/mysqldump -u #{user} --password=#{password} -h #{host} #{database} | /bin/gzip > #{file}"
      end

      def relative_to_root(path)
        path[0] == '/' ? path[1..-1] : path
      end

      def cmd_archive_files(path)
        file = filename name, "files", "tgz"
        return "/bin/tar czf #{file} -C / #{relative_to_root(path)}"
      end
    end
  end
end
