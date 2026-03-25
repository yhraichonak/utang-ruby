# frozen_string_literal: true

# This screen is the popup you receive after clicking the "Sign On" button from the main page.

Dir["#{File.dirname(__FILE__)}/../*.rb"].sort.each { |file| require file }

class Login_Window
  def initialize(selenium)
    @selenium = selenium
  end

  def username_input
    form = @selenium.find_element(:class, 'login-form')
    input_groups = form.find_elements(:class, 'input-group')
    input_groups[0]
    # @selenium.find_element(:css,"input")
  end

  def password_input
    form = @selenium.find_element(:class, 'login-form')
    input_groups = form.find_elements(:class, 'input-group')
    input_groups[1]
    # @selenium.find_element(:css,"input[type='password'")
  end

  def login_button
    form = @selenium.find_element(:class, 'login-form')
    form.find_element(:css, 'input.button')
  end

  def loginWindowTitle_div
    @selenium.find_element(:class, 'login-form')
  end

  def x_button
    @selenium.find_element(:xpath, '/html/body/div[6]/div[1]/div/a')
  end

  def banner_text
    @selenium.find_element(:xpath, '//*[@id="loginForm"]/div[1]')
  end

  def checkbox
    @selenium.find_element(:id, 'public')
  end

  def checkbox_text
    @selenium.find_element(:xpath, '//*[@id="loginForm"]/div[4]')
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

  def ce_mark_img
    @selenium.find_element(:class, 'ce-mark')
  end

  def alert_window
    @selenium.find_element(:class, 'swal2-header')
  end

  def alert_window_title
    parent = @selenium.find_element(:class, 'swal2-header')
    title = parent.find_element(:class, 'swal2-title')
    return title
  end

  def alert_content
    @selenium.find_element(:class, 'swal2-content')
  end

  def alert_ok_button
    elements=@selenium.find_elements(:class, 'swal2-confirm')
    elements.empty? ? nil:elements.last
  end
end
