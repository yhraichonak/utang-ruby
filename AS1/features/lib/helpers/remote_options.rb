# frozen_string_literal: true

class RemoteOptions
  def preferences(browser)
    case browser
    when 'edge'
      remote_browser = 'MicrosoftEdge'
      selenium_ver = '4.0.0'
    when 'ie'
      remote_browser = 'internet explorer'
      selenium_ver = '3.141.59'
    else
      remote_browser = browser
      selenium_ver = '4.0.0'
    end
    {
      'remote_browser' => remote_browser,
      'selenium_ver' => selenium_ver
    }
  end
end
