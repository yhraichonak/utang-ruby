Dir[File.dirname(__FILE__) + "/../*.rb"].each {|file| require file }

class Site_List_screen
  def initialize(selenium, appium)
    @selenium = selenium
    @appium = appium
  end
  
  def as_logo
	Element.new(@selenium, :id, "#{APP_PACKAGE}:id/welcome_logo")
  end
  
  def navigation_bar
    sleep(1)
    nav_bar = @selenium.find_element(:id, "#{APP_PACKAGE}:id/action_bar")
    elements = nav_bar.find_elements(:class, "android.widget.TextView")
    (0..elements.count).each { |i|
      if elements[i].text.include? "Site List"
        return elements[i]
      end
    }
  end
  
  def site_grid
	  @selenium.find_element(:id, 'android:id/list')
  end

  def get_site_list_count
    sites = @selenium.find_elements(:id, "#{APP_PACKAGE}:id/sitelist_site_name")
    return sites.count
  end

  def get_site_tile(site_name)
    (0...2).each do
      site_tiles = @selenium.find_elements(:id, "#{APP_PACKAGE}:id/sitelist_site_name")
      site_tiles.each { |site_tile|
        if site_tile.text == site_name
          # puts site_tile.text
          return site_tile
        end
      }
      Common.swipe_window(@selenium)
    end
    raise("ERROR: Unable to 'swipe to find' site tile with site_name: #{site_name}")
  end

  def data_not_found
    return @selenium.find_element(:id, 'android:id/empty')
  end

  # def site_tile(site_name)
  #   tryCount = 0
  #   found = false
  #   site_needed = nil
  #
  #   while not found and tryCount < 2
  #     e = @selenium.find_element(:id, "#{APP_PACKAGE}:id/content_container")
  #     elements = e.find_elements(:id, "#{APP_PACKAGE}:id/sitelist_site_name")
  #
  #     for i in 0..elements.count
  #     sleep(1)
  #
  #     if $debug_flag == "debug"
  #       puts "#{i} = #{elements[i].text}"
  #     end
  #       if (elements[i].text == site_name)
  #         found = true
  #         site_needed = elements[i]
  #
  #       elsif(i == elements.count - 1 &&  elements[i].text != site_name)
  #         Appium::TouchAction.new.swipe(:start_x => 600, :start_y => 1000, :end_x => 600, :end_y => 200, :duration => 1000).perform
  #         sleep(1)
  #         break
  #       end
  #       if found == true
  #         break
  #       end
  #     end
  #     tryCount += 1
  #     if found == true
  #       break
  #     end
  #   end
  #
  #   return site_needed
  # end
        end
