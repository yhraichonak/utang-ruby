Dir[File.dirname(__FILE__) + "/../*.rb"].each {|file| require file }

class C3PO_page
  LEBLED_INPUT_TEMPLATE=".//label[.='%s']/following-sibling::input"
  LEBLED_LINK_TEMPLATE=".//li[contains(.,'%s')]/following-sibling::ul/li/a"
  def initialize(browser)
    @c3po_browser = browser
  end

  def fill_c3po_params(site_url, partner, target, site_id, ad_name, query, shared_key )
    fill_labeled_input("Site URL", site_url.gsub("#/",""))
    fill_labeled_input("Partner", partner)
    fill_labeled_input("Target", target)
    fill_labeled_input("Site ID", site_id)
    fill_labeled_input("AD Name", ad_name)
    fill_labeled_input("Query", query)
    fill_labeled_input("Shared Key",shared_key)
  end

  def get_as1_link()
    @c3po_browser.find_element(:xpath, LEBLED_LINK_TEMPLATE % ["Encrypted - Web"]).text
  end

  def get_mobile_link()
    @c3po_browser.find_element(:xpath, LEBLED_LINK_TEMPLATE % ["Encrypted - Mobile"]).text
  end


  def fill_labeled_input(label, value)
    target_element= @c3po_browser.find_element(:xpath, LEBLED_INPUT_TEMPLATE % [label])
    target_element.clear
    target_element.send_keys(value)
  end

  def get_labeled_value(label, value)
    target_element= @c3po_browser.find_element(:xpath, LEBLED_INPUT_TEMPLATE % [label])
    expect(target_element.value == value)
  end
end