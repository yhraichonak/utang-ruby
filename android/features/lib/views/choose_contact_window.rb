Dir[File.dirname(__FILE__) + '/../*.rb'].each { |file| require file }

class ChooseContact_window
  def initialize(selenium, appium)
    @selenium = selenium
    @appium = appium
  end

  def title
    (0..2).each { |a|
      begin
        elements = @selenium.find_elements(:class, 'android.widget.EditText')
        (0..elements.count).each do |i|
          return elements[i] if elements[i].text == 'Choose Contact'
        end
      rescue
        puts "[WARN] Failed to find title='Choose Contact' on attempt '%s'" % (a + 1).to_s
        elements.each { |el|
          puts el.text
        }
      end
        sleep(1)
    }
  end

  def choose_contact_edit_text
    @selenium.find_element(:class, 'android.widget.EditText')
  end

  def contact_list(name)
    e = @selenium.find_element(:id, 'android:id/select_dialog_listview')
    elements = e.find_elements(:class, 'android.widget.TextView')

    (0..elements.count).each do |i|
      return elements[i] if elements[i].text == name
    end
  end

  def contact_list_by(index=0)
    return @selenium.find_elements(:id, 'android:id/text1')[index]
  end

  def cancel_button
    elements = @selenium.find_elements(:class, 'android.widget.Button')

    (0..elements.count).each do |i|
      return elements[i] if elements[i].text == 'Cancel'
    end
  end
end
