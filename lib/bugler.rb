require 'bugler/config'

module Bugler
	def self.hi
		"Toot toot! Hello world!"
	end

	module CLI
		def self.exec(argv)
			if argv.empty?
				print Bugler::Config::HELP_TEXT
			elsif argv[0] == 'init'
				argv.shift
				self.init(argv)
			end
		end
		def self.init(argv)
			raise Bugler::Config::ERROR_INIT_ARGV unless argv.kind_of?(Array)
			raise Bugler::Config::ERROR_INIT_NO_NAME unless argv.any?
			# Create directory structure
			name = argv.shift
			dirs = [name, File.join(name, Bugler::Config::SOURCE_DIRNAME)]
			files = [File.join(name, ".bugler"), File.join(name, Bugler::Config::SOURCE_DIRNAME, "index.erb")]
			dirs.each do |d|
				Dir.mkdir d unless File.exists?(d)
			end
			files.each do |f|
				File.write(f, "") unless File.exists?(f)
			end
		end
	end
end
