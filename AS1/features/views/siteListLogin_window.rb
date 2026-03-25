# frozen_string_literal: true

# This screen is the popup you receive after clicking on a site and are required to puts in

Dir["#{File.dirname(__FILE__)}/../*.rb"].sort.each { |file| require file }

class SiteListLogin_Window
  def initialize(selenium)
    @selenium = selenium
  end

  def siteTitle
    @selenium.find_element(:id, 'utangSignIn_wnd_title')
  end

  def banner_text
    @selenium.find_element(:xpath, '//*[@id="loginForm"]/div[1]')
  end

  def x_button
    @selenium.find_element(:xpath, '/html/body/div[7]/div[1]/div/a/span')
  end

  def login_window
    @selenium.find_element(:id, 'loginForm')
  end

  def username_input
    @selenium.find_element(:id, 'userName')
  end

  def password_input
    @selenium.find_element(:id, 'pw')
  end

  def login_button
    @selenium.find_element(:id, 'btnSubmitLogin')
  end

  def cancel_button
    @selenium.find_element(:id, 'btnCancel')
  end

  def signOnFailed_text
    @selenium.find_element(:id, 'errorWrap')
  end

  def noUserName_text
    @selenium.find_element(:id, 'userName_validationMessage')
  end

  def noPassword_text
    @selenium.find_element(:id, 'pw_validationMessage')
  end
end
