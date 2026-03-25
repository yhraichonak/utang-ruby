# frozen_string_literal: true

require 'json'
require 'net/sftp'

class Web_Client
  def set_config(setting, value)
    host = '10.10.160.106'
    user = 'jenkins'
    password = 'XXXXX'
    json = nil

    config_file = "/var/www/html/as1/site34/config-#{BRANCH}.json"
    pm_config = false

    Net::SFTP.start(host, user, password: password) do |sftp|
      file = sftp.file.open(config_file)
      data = file.read
      json = JSON.parse(data)

      ## set config variables
      if json[setting].nil?
        pm_config = true
        puts "Current setting: #{json['pm'][setting]}" if INFO == true
        json['pm'][setting] = value
      else
        pm_config = false
        puts "Current setting: #{json[setting]}" if INFO == true
        json[setting] = value
      end

      # write back to web client config on server
      file = sftp.file.open(config_file, 'w')
      file.write(JSON.pretty_generate(json))

      # recheck config value after write
      file = sftp.file.open(config_file)
      data = file.read
      json = JSON.parse(data)
    end

    if pm_config == true
      puts "Current setting: #{json['pm'][setting]}" if INFO == true
      json['pm'][setting]
    else
      puts "Current setting: #{json[setting]}" if INFO == true
      json[setting]
    end
  end
end
