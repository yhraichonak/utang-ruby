Dir["#{File.dirname(__FILE__)}/../*.rb"].sort.each { |file| require file }

class AMP_Portal
  def initialize(selenium)
    @selenium = selenium
  end

  def title
    @selenium.find_element(:class, 'title')
  end

  def home_screen_selection(option)
    elements = @selenium.find_elements(:tag_name, 'a')
    elements.each do |choice|
      if choice.text == option
        return choice
      end
    end
  end

  def select_user(user)
    user_table = @selenium.find_element(:tag_name, 'table')
    users = user_table.find_elements(:tag_name, 'a')
    users.each do |choice|
      if choice.text == user
        return choice
      end
    end
  end

  def full_name
    user_details = @selenium.find_element(:tag_name, 'table')
    rows = user_details.find_elements(:tag_name, 'tr')
    cells = []
    index = 1
    rows.each do |row|
      cells.push(row.find_elements(:tag_name, 'div'))
    end
    cells.each do
      if cells[index][0].text == 'Full Name'
        return cells[index][1].text
      else
        index += 1
      end
    end
  end

  def site_configuration_checkbox(site, column)
    tables = @selenium.find_elements(:tag_name, 'table')
    site_table = tables[3]
    rows = site_table.find_elements(:tag_name, 'tr')
    column_titles = rows[1].find_elements(:tag_name, 'td')
    index1 = 2
    index2 = 0
    rows.each do
      row_elements = rows[index1].find_elements(:tag_name, 'td')
      if row_elements[0].text.include? site
        break
      else
        index1 += 1
      end
    end
    row_elements = rows[index1].find_elements(:tag_name, 'td')
    column_titles.each do |column_title|
      if column_title.text == column
        break
      else
        index2 += 1
      end
    end
    return row_elements[index2].find_element(:tag_name, 'input')
  end

  def back_list_button
    buttons = @selenium.find_elements(:tag_name, 'p')
    buttons.each do |button|
      if button.text == "Back to List"
        mid_button = button.find_element(:tag_name, 'a')
        return mid_button
      end
    end
  end

end