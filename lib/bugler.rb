require 'bugler/config'
require 'webrick'
require 'fileutils'

module Bugler
	def self.hi
		"Toot toot! Hello world!"
	end

	module CLI
		def self.exec(argv, working_directory=__dir__)
			if argv.empty?
				print Bugler::Config::HELP_TEXT
			elsif argv[0] == 'init'
				argv.shift
				self.init(argv)
			elsif argv[0] == 'server'
				self.server working_directory
			elsif argv[0] == 'build'
				self.build working_directory
			else
				raise Bugler::Config::ERROR_EXEC_UNRECOGNIZED
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
		def self.server(working_directory, port=Bugler::Config::DEFAULT_PORT)
			raise Bugler::Config::ERROR_SERVER_NOT_A_PROJECT unless File.exists?(".bugler")

			# Build if not already built
			if !File.exists?(File.join(working_directory, "build"))
				self.build(working_directory)
			end

			puts "Starting Bugler test server at http://localhost:%i..." % port

			server = WEBrick::HTTPServer.new :Port => port, :DocumentRoot => File.join(working_directory, 'build')

			trap 'INT' do
				server.shutdown
			end

			server.start
		end
		def self.build(working_directory)
			raise Bugler::Config::ERROR_SERVER_NOT_A_PROJECT unless File.exists?(".bugler")
			Dir.mkdir 'build' unless File.exists?('build')
			# For now, copy over the erbs to htmls
			Dir.foreach File.join(working_directory,'src') do |f|
				next if f == '.' or f == '..'
				FileUtils.cp File.join('src', f), File.join(working_directory, 'build', f.sub!('erb', 'html'))
			end
		end
	end
end
