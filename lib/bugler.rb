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
			Dir.mkdir name
		end
	end
end
