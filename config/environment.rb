require_relative 'application'
Rails.application.initialize!
Paperclip.options[:command_path] = "/usr/local/bin/"
