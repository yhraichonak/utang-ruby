Dir["#{File.dirname(__FILE__)}/../*.rb"].sort.each { |file| require file }

class LoginPage
  def initialize(selenium)
    @selenium = selenium
  end

  def login_form
    @selenium.find_element(:css,"div[data-testid='login-form']")
  end
  def enter_username(username)
    username_field = @selenium.find_element(:css,"input[data-testid='username']")
    username_field.clear
    username_field.send_keys(username)
  end
  def enter_password(password)
    password_field = @selenium.find_element(:css,"input[data-testid='password']")
    password_field.clear
    password_field.send_keys(password)
  end
  def click_login()
    @selenium.find_element(:xpath,"//button[@data-testid='login-button']").click
  end

  def is_login_disabled()
    flag = nil
    if @selenium.find_element(:xpath,"//button[@data-testid='login-button']").attribute('disabled') != nil
      flag = true
    else
      flag = false
    end
  end
  def login_as(username, password)
    enter_username(username)
    enter_password(password)
    click_login
  end
  def login_error()
    @selenium.find_element(:xpath,"//div[@data-testid='login-panel']/descendant::div[@data-testid='login-error']")
  end

  def clear_login()
    @selenium.find_element(:css,"input[data-testid='username']").clear
    @selenium.find_element(:css,"input[data-testid='password']").clear
  end

end