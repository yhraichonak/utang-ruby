# frozen_string_literal: true

Dir["#{File.dirname(__FILE__)}/../*.rb"].sort.each { |file| require file }

class SiteList_Screen
  def initialize(selenium)
    @selenium = selenium
  end

  def siteList_div
    @selenium.find_element(:id, 'mainDiv')
  end

  def sites_title
    @selenium.find_element(:xpath, '//*[@id="body"]/section/div[1]/div[1]/a[1]')
  end

  def whereAreMySites_link
    @selenium.find_element(:xpath, '//*[@id="body"]/section/div[1]/div[1]/a[3]')
  end

  def whereAreMySitesPopup_text
    @selenium.find_element(:xpath, 'popupNotification')
  end

  def refresh_link
    @selenium.find_element(:id, 'refresh-a')
  end

  def main_div
    @selenium.find_element(:id, 'mainDiv123')
  end

  def site_button(site_id)
    @selenium.find_element(:id, site_id)
  end
end
