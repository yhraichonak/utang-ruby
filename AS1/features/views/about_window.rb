# frozen_string_literal: true
Dir["#{File.dirname(__FILE__)}/../*.rb"].sort.each { |file| require file }

class About_Window
  def initialize(selenium)
    @selenium = selenium
  end

  def user_menu_button
    @selenium.find_element(:class, "user-menu-button")
  end

  def about_button
    menu = @selenium.find_element(:class, 'user-menu')
    menu.find_element(:css, 'a.about')
  end

  def logout_button
    menu = @selenium.find_element(:class, 'user-menu')
    menu.find_element(:css, 'button.logout')
  end

  def window_title
    @selenium.find_element(:id, 'about-utang')
  end

  def done_button
    @selenium.find_element(:class, 'swal2-confirm')
  end

  # def signOff_button
  #  @selenium.find_element(:id, 'btnSignOff')
  # end
  #
  # def resetPassword_button
  #  @selenium.find_element(:id, 'btnResetPW')
  # end

  def applicationInfo_title
    @selenium.find_element(:xpath, '//*[@id="about-utang"]/div/h2[1]')
  end

  def deviceInfo_title
    @selenium.find_element(:xpath, '//*[@id="about-utang"]/div/h2[2]')
  end

  def technicalSupport_title
    @selenium.find_element(:xpath, '//*[@id="about-utang"]/div/h2[3]')
  end

  def manufacturedBy_title
    @selenium.find_element(:xpath, '//*[@id="about-utang"]/div/h2[4]')
  end

  def euAuthorizedRepresentative_title
    @selenium.find_element(:xpath, '//*[@id="about-utang"]/div/h2[5]')
  end
  def ukResponsiblePerson_title
    @selenium.find_element(:xpath, '//*[@id="about-utang"]/div/h2[6]')
  end
  def auAuthorizedRepresentative_title
    @selenium.find_element(:xpath, '//*[@id="about-utang"]/div/h2[7]')
  end

  def about_Info
    about = @selenium.find_element(:id, 'about-utang')
    @selenium.execute_script "arguments[0].scrollIntoView();", @selenium.find_element(:css, 'a.eula')
    sleep(1)
    rows = about.find_elements(:class, 'row')
    if (Gem::Platform.local.to_s.include?("linux"))
      {
        'App Name' => rows[0].find_element(:class, 'value'),
        'App Version' => rows[1].find_element(:class, 'value'),
        'Build Number' => rows[2].find_element(:class, 'value'),
        'UDI' => rows[3].find_element(:class, 'value'),
        'Copyright' => rows[4].find_element(:class, 'value'),
        'Patent Number' => rows[5].find_element(:class, 'value'),
        'Device' => rows[6].find_element(:class, 'value'),

        'Operating System Version' => rows[7].find_element(:class, 'value'),
        'Browser Type' => rows[8].find_element(:class, 'value'),
        'Browser Version' => rows[9].find_element(:class, 'value'),
        'Instructions' => rows[10].find_element(:class, 'value'),
        'Phone US' => rows[11].find_element(:class, 'value'),
        'Phone UK' => rows[12].find_element(:class, 'value'),
        'Phone CA' => rows[13].find_element(:class, 'value'),
        'Phone AU' => rows[14].find_element(:class, 'value'),
        'Email Support' => rows[15].find_element(:class, 'value'),
        'utang Address' => rows[16].find_element(:class, 'value'),
        'Build Date' => rows[17].find_element(:class, 'value'),
        'EU Authorized Rep' => rows[18].find_element(:class, 'value'),
        'UK Responsible Person' => rows[19].find_element(:class, 'value'),
        'AU Authorized Rep' => rows[20].find_element(:class, 'value')
      }
    else
      {
        'App Name' => rows[0].find_element(:class, 'value'),
        'App Version' => rows[1].find_element(:class, 'value'),
        'Build Number' => rows[2].find_element(:class, 'value'),
        'UDI' => rows[3].find_element(:class, 'value'),
        'Copyright' => rows[4].find_element(:class, 'value'),
        'Patent Number' => rows[5].find_element(:class, 'value'),
        'Device' => rows[6].find_element(:class, 'value'),

        'Operating System' => rows[7].find_element(:class, 'value'),
        'Operating System Version' => rows[8].find_element(:class, 'value'),
        'Browser Type' => rows[9].find_element(:class, 'value'),
        'Browser Version' => rows[10].find_element(:class, 'value'),
        'Instructions' => rows[11].find_element(:class, 'value'),
        'Phone US' => rows[12].find_element(:class, 'value'),
        'Phone UK' => rows[13].find_element(:class, 'value'),
        'Phone CA' => rows[14].find_element(:class, 'value'),
        'Phone AU' => rows[15].find_element(:class, 'value'),
        'Email Support' => rows[16].find_element(:class, 'value'),
        'utang Address' => rows[17].find_element(:class, 'value'),
        'Build Date' => rows[18].find_element(:class, 'value'),
        'EU Authorized Rep' => rows[19].find_element(:class, 'value'),
        'UK Responsible Person' => rows[20].find_element(:class, 'value'),
        'AU Authorized Rep' => rows[21].find_element(:class, 'value')
      }
    end

  end

  def manufacturedByLogo1_image
    @selenium.find_element(:class, 'icon-factory')
  end

  def manufacturedByLogo2_image
    @selenium.find_element(:class, 'icon-factory2')
  end

  def ecRep_image
    @selenium.find_element(:class, 'icon-ec-rep')
  end

  def onlineUserGuide_link
    @selenium.find_element(:class, 'eula')
  end

  def eula_link
    @selenium.find_element(:class, 'eula')
  end

  def utangLogos_image
    @selenium.find_element(:class, 'logos')
  end

  def logout_prompt
    @selenium.find_element(:class, 'swal2-header')
  end

  def logout_prompt_ok
    content = @selenium.find_element(:class, 'swal2-actions')
    content.find_element(:tag_name, 'button')
  end

  def preferences_button
    menu = @selenium.find_element(:class, 'user-menu')
    menu.find_element(:css, 'button.prefs')
  end

  def preferences_window
    @selenium.find_element(:id, 'prefs')
  end

  def preferences_window_role_section(option)
    option = process_param(option)
    if option == 'see'
      @selenium.find_element(:css, 'label[class="for-select"]')
    else
      puts 'Element is not present'
    end
  end

  def preferences_window_role_type
    @selenium.find_element(:css, 'div[class*="-singleValue"]')
  end

  def preferences_window_select_role_type(roletoSelect)
    roletoSelect=process_param(roletoSelect)
    puts "role to select : #{roletoSelect}"
    @selenium.find_element(:class, 'css-yk16xz-control').click
    puts "element is clicked"
    roles = @selenium.find_elements(:css, 'label[class="for-select"] div[class*="-option"]')
    puts "The Options Count: #{roles.count}"
    (0..(roles.count - 1)).each do |i|
      roleName = roles[i].text
      puts "The Roles Options are: #{roleName}"
      if roleName == roletoSelect
        roles[i].click
        break
      end
    end
  end
end
