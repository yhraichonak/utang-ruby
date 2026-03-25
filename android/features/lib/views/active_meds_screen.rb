Dir[File.dirname(__FILE__) + "/../*.rb"].each {|file| require file }

class Active_Meds_screen
  def initialize(selenium, appium)
    @selenium = selenium
    @appium = appium
  end
  
  def med_one_name(drug_name)
    elements = @selenium.find_elements(:class, "android.widget.TextView")
     
    for i in 1..elements.count
      if (elements[i].text == drug_name)
        return elements[i]
      end
    end    
  end
  
  def med_detail_item
    Element.new(@selenium, :id, "#{APP_PACKAGE}:id/med_detail_item1")
  end
  
  def drug_detail_header
    Element.new(@selenium, :id, "#{APP_PACKAGE}:id/med_detail_name")
  end
  
  def drug_details_data(drug_name)      
    elements = @selenium.find_elements(:class, "android.widget.TextView")        
    
    return {               
      "med_name" => elements[6].text,
      "details_label" => elements[7].text,
      "ordered_item_label" => elements[8].text,
      "oredered_item" => elements[9].text,
      "details2_label" => elements[10].text,
      "details_text" => elements[11].text,
      "comments_label" => elements[12].text,
      "comments_text" => elements[13].text
    }  
  end
end