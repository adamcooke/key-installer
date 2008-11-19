$:.unshift File.dirname(__FILE__)

module KeyInstaller
  
  ## A very simple script to push an SSH key to a remote host via. SSH.
  
  extend self
  
  attr_reader :options
  
  def run(args)
    install_key(args.shift, args)
  end
  
  private
  
  def install_key(host, args)

    if host.nil?
      puts " ** Hostname was not provided (e.g. install-key dave@myserver.com)"
      return
    end
    
    args_to_options(args)
    if options.keys.include?('key')
      if File.exist?(options['key'])
        public_key = File.read(options['key'])
      else
        puts " ** Key not found in '#{options['key']}'"
      end
      
    else  
      ## Find a key from the .ssh folder
      for possible_key in %w{id_rsa.pub id_dsa.pub}
        path_to_key = File.join(ENV['HOME'], '.ssh', possible_key)
        if File.exist?(path_to_key)
          public_key = File.read(path_to_key)
          break
        end
      end
    end
    
    ## Set the command to run on the remote server:
    ssh_command    = %Q{echo '#{public_key}' | ssh #{host} -p #{ssh_port} "mkdir -p .ssh && cat - >> .ssh/authorized_keys"}

    if %x[ #{ssh_command} ] == ''
      puts " ** Key installed to '#{host}' successfully."
    else
      puts " ** Sorry, something went wrong and the world will now end."
    end
    
  end
  
  def ssh_port
    @options['port'] || @options['p'] || 22
  end
  
  def args_to_options(args)
    @options = {} unless @options
    c = 0
    for arg in args
      value = args[c + 1] || ""
      value = nil if value.include?("-")
      @options[arg.gsub(/-/, "")] = value if arg.include?("-")
      c += 1
    end
    size = @options.size * 2
    args.slice!(0 - size, size)
  end
  
  
end
