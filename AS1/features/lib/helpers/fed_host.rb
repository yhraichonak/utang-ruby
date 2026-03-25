# frozen_string_literal: true

class Fed_Host
  def update_host_config(key, value)
    # host_key = 'snippet.hl7.format'
    # value = 'tiff'

    file_path = "#{SITE_34_SHARE_DIRECTORY}host.config"
    file = File.open(file_path)
    file_data = file.read

    config = "<add key=\"#{key}\" value=\".*\"/>"
    if file_data =~ (/#{config}/)
      new_file_data = file_data.gsub(/#{config}/, "<add key=\"#{key}\" value=\"#{value}\"/>")
      puts new_file_data
      File.write(file_path, new_file_data)
    else
      puts "key entered - '#{key}', isn't a valid server configuration"
    end
    file.close
  end
end
