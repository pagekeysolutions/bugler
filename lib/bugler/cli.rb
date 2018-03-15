require 'bugler/config'

class Bugler::CLI

  def self.exec(argv)
    if argv.empty?
      puts Bugler::Config::HELP_TEXT
    elsif argv[0] == 'init'
      self.init(argv.shift)
    end
  end

  def self.init(argv)
    if argv.empty?
      raise Bugler::Config::ERROR_INIT_NO_NAME
    end
    # Create directory structure
    name = argv.shift
    Dir.mkdir name
  end
  
end
