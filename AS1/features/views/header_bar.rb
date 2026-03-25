# frozen_string_literal: true

# This is for a shared header bar amongst the site screens

Dir["#{File.dirname(__FILE__)}/../*.rb"].sort.each { |file| require file }

class Header_Bar
  def initialize(selenium)
    @selenium = selenium
  end

  def userMenu_button
    @selenium.find_element(:class, 'user-menu-button')
  end

  def logout_button
    @selenium.find_element(:class, 'logout')
  end

  def about_button
    @selenium.find_element(:class, 'about')
  end

  def home_button
    @selenium.find_element(:css, 'div.grid-btn')
  end

  def multi_patient_sub_nav
    sub_nav = @selenium.find_element(:class, 'sub-nav')
    subs = sub_nav.find_elements(:css, 'a')

    found = false
    multi_patient = nil

    for i in 0..(subs.count - 1)
      if subs[i].text == 'Multi-Patient View'
        multi_patient = subs[i]
        found = true
        break
      end

      if found == true
        break
      end
    end

    return multi_patient
  end

  def as_one_logo
    home_link = @selenium.find_element(:class, 'home-link')
    logo = home_link.find_element(:class, 'logo')
    return logo
  end

  def as_one_site_name
    home_link = @selenium.find_element(:class, 'home-link')
    return home_link
  end

  def search_field_sub_nav
    n = @selenium.find_element(:class, 'simple-search')
    return n
  end

  def group_sort_sub_nav
    sub_nav = @selenium.find_element(:class, 'sub-nav')
    subs = sub_nav.find_elements(:css, 'a')
    
    found = false
    group_sort = nil

    for i in 0..(subs.count - 1)
      if subs[i].text == 'Group / Sort'
        group_sort = subs[i]
        found = true
        break
      end

      if found == true
        break
      end
    end

    return group_sort
  end

  def filter_unit_sub_nav
    sub_nav = @selenium.find_element(:class, 'sub-nav')
    subs = sub_nav.find_elements(:css, 'a')
    
    found = false
    filter_units = nil

    for i in 0..(subs.count - 1)
      if subs[i].text == 'Filter Units'
        filter_units = subs[i]
        found = true
        break
      end

      if found == true
        break
      end
    end

    return filter_units
  end

end
