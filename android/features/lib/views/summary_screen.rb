Dir[File.dirname(__FILE__) + "/../*.rb"].each {|file| require file }

class Patient_Summary_screen
  def initialize(selenium, appium)
    @selenium = selenium
    @appium = appium
  end

  def maternal_vitals_grid
		Element.new(@selenium, :id, "#{APP_PACKAGE}:id/grid_view")
  end

  def expanded_tile
		Element.new(@selenium, :id, "#{APP_PACKAGE}:id/expanded_tile_main_container")
  end

  def expanded_tile_title
		Element.new(@selenium, :id, "#{APP_PACKAGE}:id/summary_header_title")
  end

  def first_patient
    Element.new(@selenium, :id, "#{APP_PACKAGE}:id/patient_listitem_content")
  end

  def notifications_tile
    Element.new(@selenium, :xpath, "android.widget.TextView[@text='NOTIFICATIONS']")
  end

  def demographics_grid
    return Element.new(@selenium, :id, "#{APP_PACKAGE}:id/demographics_grid")
  end

  def demographics_tile
    elements = @selenium.find_elements(:class, "android.widget.TextView")

    for i in 1..elements.count
      ##puts elements[i].text
      if (elements[i].text == "GENERAL INFO")
        return elements[i]
      end
    end
  end

  def gen_info_tile
  	parent = @selenium.find_element(:id, "#{APP_PACKAGE}:id/demographics_grid")
    e = parent.find_element(:id, "#{APP_PACKAGE}:id/summary_header_title")
    return e
  end

  def documents_tile
    elements = @selenium.find_elements(:class, "android.widget.TextView")

    for i in 1..elements.count
      ##puts elements[i].text
      if (elements[i].text == "DOCUMENTS")
        return elements[i]
      end
    end
  end

  def documents_expanded
		Element.new(@selenium, :id, "#{APP_PACKAGE}:id/expand")
  end


  def allergies_tile
    elements = @selenium.find_elements(:class, "android.widget.TextView")

    for i in 1..elements.count

      if (elements[i].text == "ALLERGIES")
        ##puts elements[i].text
        return elements[i]
      end
    end
  end

  def dx_problems_tile
    elements = @selenium.find_elements(:class, "android.widget.TextView")

    for i in 0..elements.count

      if (elements[i].text == "DX/Problems")
        ##puts elements[i].text
        return elements[i]
      end
    end
  end

  def vitals_tile
    elements = @selenium.find_elements(:class, "android.widget.TextView")

    for i in 1..elements.count

      if (elements[i].text == "VITALS")
        ##puts elements[i].text
        return elements[i]
      end
    end
  end

  def active_meds_tile
    elements = @selenium.find_elements(:class, "android.widget.TextView")

    for i in 1..elements.count

      if (elements[i].text == "ACTIVE MEDS")
        ##puts elements[i].text
        return elements[i]
      end
    end
  end

   def labs_tile
    elements = @selenium.find_elements(:class, "android.widget.TextView")

    for i in 1..elements.count

      if (elements[i].text == "LABS")
        ##puts elements[i].text
        return elements[i]
      elsif (elements[i].attribute("text") == "Labs")
        ##puts elements[i].attribute("text")
        return elements[i]
      end
    end
   end

  def careteam_tile
    elements = @selenium.find_elements(:class, "android.widget.TextView")

    for i in 1..elements.count

      if (elements[i].text == "CARE TEAM")
        ##puts elements[i].text
        return elements[i]
      end
    end
  end

  def ecgs_tile
    e = @selenium.find_element(:id, "#{APP_PACKAGE}:id/summary_grid")
    elements = e.find_elements(:class, "android.widget.TextView")

    for i in 0..elements.count

      if (elements[i].text == "ECGs")
        ##puts elements[i].text
        return elements[i]
      end
    end
  end

  def maternal_vitals_tile
    elements = @selenium.find_elements(:class, "android.widget.TextView")

    for i in 1..elements.count

      if (elements[i].text == "MATERNAL VITALS")
        return elements[i]
      end
    end
  end

  def cervical_exams_tile
	summary_grid = @selenium.find_element(:id, "#{APP_PACKAGE}:id/summary_grid")
	summary_tile_roots = summary_grid.find_elements(:id, "#{APP_PACKAGE}:id/summary_tile_root")

	for i in 0..summary_tile_roots.count
		summary_header = summary_tile_roots[i].find_element(:id, "#{APP_PACKAGE}:id/summary_header")
		summary_header_title = summary_header.find_element(:id, "#{APP_PACKAGE}:id/summary_header_title")

		if(summary_header_title.text == "CERVICAL EXAMS")
			break
		end
	end
	return summary_header_title
  end

  def annotations_tile
    elements = @selenium.find_elements(:class, "android.widget.TextView")

    for i in 1..elements.count

      if (elements[i].text == "ANNOTATIONS")
        return elements[i]
      end
    end
  end

  def misc_tile
    elements = @selenium.find_elements(:class, "android.widget.TextView")

    for i in 1..elements.count

      if (elements[i].text == "MISC")
        return elements[i]
      end
    end
  end

  def doc_tile
    elements = @selenium.find_elements(:class, "android.widget.TextView")

    for i in 1..elements.count

      if (elements[i].attribute("text") == "DOCUMENTS")
        return elements[i]
      end
    end
  end

  def depart_document
    elements = @selenium.find_elements(:class, "android.widget.TextView")

    for i in 1..elements.count

      if (elements[i].attribute("text") == "Depart Summary")
        return elements[i]
      end
    end
  end

    def expanded_document
			Element.new(@selenium, :id, "#{APP_PACKAGE}:id/content_container")
		end

  def other_tile
    elements = @selenium.find_elements(:class, "android.widget.TextView")

    for i in 1..elements.count

      if (elements[i].attribute("text") == "OTHER")
        return elements[i]
      end
    end
  end

  def pitocin_tile
    elements = @selenium.find_elements(:class, "android.widget.TextView")

    for i in 1..elements.count

      if (elements[i].attribute("text") == "PITOCIN")
        return elements[i]
      end
    end
  end

  def monitor_tile
    elements = @selenium.find_elements(:class, "android.widget.TextView")

    for i in 0..elements.count

      if (elements[i].text == "MONITOR")
        return elements[i]
      end
    end
  end

  def monitor_tile_no_events
	summary_grid = @selenium.find_element(:id, "#{APP_PACKAGE}:id/summary_grid")
	tile_roots = summary_grid.find_elements(:id, "#{APP_PACKAGE}:id/summary_tile_root")

	for i in 0..tile_roots.count
		tv_values = tile_roots[i].find_elements(:id, "#{APP_PACKAGE}:id/tv_value")
		for x in 0..tv_values.count
			value = tv_values[x].text
			if(value == "No Events")
				return tv_values[x]
			end
		end
	end
  end

  def monitor_tile_info
	title = nil

	card = nil

	summary_grid = @selenium.find_element(:id, "#{APP_PACKAGE}:id/summary_grid")
	card_main_layouts = summary_grid.find_elements(:id, "#{APP_PACKAGE}:id/card_main_content_layout")

	for x in 0..card_main_layouts.count
		summary_header = card_main_layouts[x].find_element(:id, "#{APP_PACKAGE}:id/summary_header")
		title = summary_header.find_element(:id, "#{APP_PACKAGE}:id/summary_header_title")

		if title.text == "MONITOR"
			card = card_main_layouts[x]
		end
	end

	summary = card.find_element(:id, "#{APP_PACKAGE}:id/error_message")

	summary_table = card.find_element(:id, "#{APP_PACKAGE}:id/summary_table")

	title = card.find_element(:id, "#{APP_PACKAGE}:id/summary_header_title")

	sub_title = card.find_element(:id, "#{APP_PACKAGE}:id/summary_header_subtitle")


	rows = summary_table.find_elements(:class, 'android.widget.TableRow')


	row_cont = rows.count

	# old code works if i hard code the card number but when adding tiles to the screen it does not work
	#card = 1
	#summary_grid = @selenium.find_element(:id, "#{APP_PACKAGE}:id/summary_grid")
	#card_main_layouts = summary_grid.find_elements(:id, "#{APP_PACKAGE}:id/card_main_content_layout")
	#summary_header = card_main_layouts[card].find_element(:id, "#{APP_PACKAGE}:id/summary_header")
	#
	#summary = card_main_layouts[card].find_element(:id, "#{APP_PACKAGE}:id/error_message")
	#summary_table = card_main_layouts[card].find_element(:id, "#{APP_PACKAGE}:id/summary_table")
	#
	#title = summary_header.find_element(:id, "#{APP_PACKAGE}:id/summary_header_title")
	#sub_title = summary_header.find_element(:id, "#{APP_PACKAGE}:id/summary_header_subtitle")
	#
	#rows = summary_table.find_elements(:class, 'android.widget.TableRow')
	#row_cont = rows.count

	if(row_cont == 6)
			r1_event_name = rows[0].find_element(:id, "#{APP_PACKAGE}:id/tv_value")
			r1_event_time = rows[0].find_element(:id, "#{APP_PACKAGE}:id/tv_label")

			r2_event_name = rows[1].find_element(:id, "#{APP_PACKAGE}:id/tv_value")
			r2_event_time = rows[1].find_element(:id, "#{APP_PACKAGE}:id/tv_label")

			r3_event_name = rows[2].find_element(:id, "#{APP_PACKAGE}:id/tv_value")
			r3_event_time = rows[2].find_element(:id, "#{APP_PACKAGE}:id/tv_label")

			r4_event_name = rows[3].find_element(:id, "#{APP_PACKAGE}:id/tv_value")
			r4_event_time = rows[3].find_element(:id, "#{APP_PACKAGE}:id/tv_label")

			r5_event_name = rows[4].find_element(:id, "#{APP_PACKAGE}:id/tv_value")
			r5_event_time = rows[4].find_element(:id, "#{APP_PACKAGE}:id/tv_label")

			r6_event_name = rows[5].find_element(:id, "#{APP_PACKAGE}:id/tv_value")
			r6_event_time = rows[5].find_element(:id, "#{APP_PACKAGE}:id/tv_label")

			return {
			"title" => title.text,
			"sub_title" => sub_title.text,
			"summary" => summary.text,
			"r1_event_name" => r1_event_name.text,
			"r1_event_time" => r1_event_time.text,
			"r2_event_name" => r2_event_name.text,
			"r2_event_time" => r2_event_time.text,
			"r3_event_name" => r3_event_name.text,
			"r3_event_time" => r3_event_time.text,
			"r4_event_name" => r4_event_name.text,
			"r4_event_time" => r4_event_time.text,
			"r5_event_name" => r5_event_name.text,
			"r5_event_time" => r5_event_time.text,
			"r6_event_name" => r6_event_name.text,
			"r6_event_time" => r6_event_time.text,
			"row_count" => row_cont
			}
		elsif(row_cont == 5)
			r1_event_name = rows[0].find_element(:id, "#{APP_PACKAGE}:id/tv_value")
			r1_event_time = rows[0].find_element(:id, "#{APP_PACKAGE}:id/tv_label")

			r2_event_name = rows[1].find_element(:id, "#{APP_PACKAGE}:id/tv_value")
			r2_event_time = rows[1].find_element(:id, "#{APP_PACKAGE}:id/tv_label")

			r3_event_name = rows[2].find_element(:id, "#{APP_PACKAGE}:id/tv_value")
			r3_event_time = rows[2].find_element(:id, "#{APP_PACKAGE}:id/tv_label")

			r4_event_name = rows[3].find_element(:id, "#{APP_PACKAGE}:id/tv_value")
			r4_event_time = rows[3].find_element(:id, "#{APP_PACKAGE}:id/tv_label")

			r5_event_name = rows[4].find_element(:id, "#{APP_PACKAGE}:id/tv_value")
			r5_event_time = rows[4].find_element(:id, "#{APP_PACKAGE}:id/tv_label")

			return {
			"title" => title.text,
			"sub_title" => sub_title.text,
			"summary" => summary.text,
			"r1_event_name" => r1_event_name.text,
			"r1_event_time" => r1_event_time.text,
			"r2_event_name" => r2_event_name.text,
			"r2_event_time" => r2_event_time.text,
			"r3_event_name" => r3_event_name.text,
			"r3_event_time" => r3_event_time.text,
			"r4_event_name" => r4_event_name.text,
			"r4_event_time" => r4_event_time.text,
			"r5_event_name" => r5_event_name.text,
			"r5_event_time" => r5_event_time.text,
			"row_count" => row_cont
			}
		elsif(row_cont == 4)

			r1_event_name = rows[0].find_element(:id, "#{APP_PACKAGE}:id/tv_value")
			r1_event_time = rows[0].find_element(:id, "#{APP_PACKAGE}:id/tv_label")

			r2_event_name = rows[1].find_element(:id, "#{APP_PACKAGE}:id/tv_value")
			r2_event_time = rows[1].find_element(:id, "#{APP_PACKAGE}:id/tv_label")

			r3_event_name = rows[2].find_element(:id, "#{APP_PACKAGE}:id/tv_value")
			r3_event_time = rows[2].find_element(:id, "#{APP_PACKAGE}:id/tv_label")

			r4_event_name = rows[3].find_element(:id, "#{APP_PACKAGE}:id/tv_value")
			r4_event_time = rows[3].find_element(:id, "#{APP_PACKAGE}:id/tv_label")

			return {
			"title" => title.text,
			"sub_title" => sub_title.text,
			"summary" => summary.text,
			"r1_event_name" => r1_event_name.text,
			"r1_event_time" => r1_event_time.text,
			"r2_event_name" => r2_event_name.text,
			"r2_event_time" => r2_event_time.text,
			"r3_event_name" => r3_event_name.text,
			"r3_event_time" => r3_event_time.text,
			"r4_event_name" => r4_event_name.text,
			"r4_event_time" => r4_event_time.text,
			"row_count" => row_cont
			}
		elsif(row_cont == 3)
			r1_event_name = rows[0].find_element(:id, "#{APP_PACKAGE}:id/tv_value")
			r1_event_time = rows[0].find_element(:id, "#{APP_PACKAGE}:id/tv_label")

			r2_event_name = rows[1].find_element(:id, "#{APP_PACKAGE}:id/tv_value")
			r2_event_time = rows[1].find_element(:id, "#{APP_PACKAGE}:id/tv_label")

			r3_event_name = rows[2].find_element(:id, "#{APP_PACKAGE}:id/tv_value")
			r3_event_time = rows[2].find_element(:id, "#{APP_PACKAGE}:id/tv_label")

			return {
			"title" => title.text,
			"sub_title" => sub_title.text,
			"summary" => summary.text,
			"r1_event_name" => r1_event_name.text,
			"r1_event_time" => r1_event_time.text,
			"r2_event_name" => r2_event_name.text,
			"r2_event_time" => r2_event_time.text,
			"r3_event_name" => r3_event_name.text,
			"r3_event_time" => r3_event_time.text,
			"row_count" => row_cont
			}
		elsif(row_cont == 2)
			r1_event_name = rows[0].find_element(:id, "#{APP_PACKAGE}:id/tv_value")
			r1_event_time = rows[0].find_element(:id, "#{APP_PACKAGE}:id/tv_label")

			r2_event_name = rows[1].find_element(:id, "#{APP_PACKAGE}:id/tv_value")
			r2_event_time = rows[1].find_element(:id, "#{APP_PACKAGE}:id/tv_label")

			return {
			"title" => title.text,
			"sub_title" => sub_title.text,
			"summary" => summary.text,
			"r1_event_name" => r1_event_name.text,
			"r1_event_time" => r1_event_time.text,
			"r2_event_name" => r2_event_name.text,
			"r2_event_time" => r2_event_time.text,
			"row_count" => row_cont
			}
		elsif(row_cont == 1)
			r1_event_name = rows[0].find_element(:id, "#{APP_PACKAGE}:id/tv_value")
			r1_event_time = rows[0].find_element(:id, "#{APP_PACKAGE}:id/tv_label")

			r2_event_name = rows[1].find_element(:id, "#{APP_PACKAGE}:id/tv_value")
			r2_event_time = rows[1].find_element(:id, "#{APP_PACKAGE}:id/tv_label")

			return {
			"title" => title.text,
			"sub_title" => sub_title.text,
			"summary" => summary.text,
			"r1_event_name" => r1_event_name.text,
			"r1_event_time" => r1_event_time.text,
			"row_count" => row_cont
			}
		end

		puts "just left the view .rb file"
  end

  def ventilator_tile
    summaryheaders = @selenium.find_elements(:id, "#{APP_PACKAGE}:id/summary_header")

    for i in 0..(summaryheaders.count - 1)
      childtextviews = summaryheaders[i].find_elements(:class, "android.widget.TextView")
      for z in 0..(childtextviews.count - 1)
        if(childtextviews[z].text == "VENTILATOR")
          return childtextviews[z]
        end
      end
    end
  end

  def v_tile

    tryCount = 0
    found = false

    while not found and tryCount < 7

      summaryheaders = @selenium.find_elements(:id, "#{APP_PACKAGE}:id/summary_header")

      for i in 0..(summaryheaders.count - 1)
        childtextviews = summaryheaders[i].find_elements(:class, "android.widget.TextView")
        for z in 0..(childtextviews.count - 1)
          if(childtextviews[z].text == "VENTILATOR")
            found = true
            return childtextviews[z]
          end
        end
      end
      tryCount += 1
      Appium::TouchAction.new.swipe(:start_x => 600, :start_y => 1000, :end_x => 600, :end_y => 200, :duration => 1000).perform
    end
  end

  def demographics_tile_emr_data

    elements = @selenium.find_elements(:class, "android.widget.TextView")

    return {
      "weight_label" => elements[46].text,
      "weight_text" => elements[47].text,
      "admit_date_label" => elements[48].text,
      "admit_date_text" => elements[49].text,
      "code_status_label" => elements[50].text,
      "code_status_text" => elements[51].text,
      "location_label" => elements[52].text,
      "location_text" => elements[53].text,
      "isolation_status_label" => elements[54].text,
      "isolation_status_text" => elements[55].text,
      "fin_label" => elements[56].text,
      "fin_text" => elements[57].text,
      "dob_label" => elements[58].text,
      "dob_text" => elements[59].text,
      "religion_label" => elements[60].text,
      "religion_text" => elements[61].text,
      "language_label" => elements[62].text,
      "language_text" => elements[63].text,
      "primary_contact_label" => elements[64].text,
      "primary_contact_text" => elements[65].text,
      "secondary_contact_label" => elements[66].text,
      "secondary_contact_text" => elements[67].text,
      "age_label" => elements[68].text,
      "age_text" => elements[69].text,
      "primary_md_label" => elements[70].text,
      "primary_md_text" => elements[71].text
    }
  end

  def patient_header_emr_data
    elements = @selenium.find_elements(:class, "android.widget.TextView")

    return {
      "patient_name" => elements[0].text,
      "sex" => elements[1].text,
      "age" => elements[2].text,
      "mrn" => elements[5].text,
      "location" => elements[4].text,
      "site" => elements[3].text
    }
  end

  def dx_problems_tile_emr_data
    elements = @selenium.find_elements(:class, "android.widget.TextView")

    return {
      "dignosis_one_label" => elements[17].text,
      "dignosis_one_text" => elements[18].text,
      "diagnosis_two_text" => elements[19].text,
      "problems_label" => elements[20].text,
      "problems_one_text" => elements[21].text,
      "problems_two_text" => elements[22].text
    }
  end

  def allergies_tile_emr_data
    elements = @selenium.find_elements(:class, "android.widget.TextView")

    return {
      "allergy_column_label" => elements[47].text,
      "reaction_column_label" => elements[48].text,
      "allergy_type_one" => elements[49].text,
      "allergy_one_name" => elements[50].text,
      "allergy_one_reaction" => elements[51].text
    }
  end

  def careteam_tile_emr_data
    elements = @selenium.find_elements(:class, "android.widget.TextView")

    return {
      "doctor_one_type" => elements[46].text,
      "doctor_one_name" => elements[47].text
    }
  end

  def vitals_tile_emr_data
    elements = @selenium.find_elements(:class, "android.widget.TextView")

    return {
      "vital_one" => elements[34].text
    }
  end

  def active_meds_tile_emr_data
    elements = @selenium.find_elements(:class, "android.widget.TextView")

    return {
      "med_one" => elements[38].text
    }
  end

  def gen_information_expanded_view
	Element.new(@selenium, :id, "#{APP_PACKAGE}:id/expanded_tile_main_container")
  end

  def general_info_data
	patient_name_label = ""
    patient_name_text = ""
    mrn_label = ""
    mrn_text = ""
    dob_label = ""
    dob_text = ""
    gender_label = ""
    gender_text = ""
    age_label = ""
    age_text = ""
    location_label = ""
    location_text = ""

	e = @selenium.find_element(:id, "#{APP_PACKAGE}:id/expanded_tile_content_scroll")
    elements = e.find_elements(:class, "android.widget.TextView")

	for i in 0..(elements.count - 1)
		if(elements[i].text == "Patient Name:")
			patient_name_label = elements[i].text
			patient_name_text = elements[i + 1].text
		elsif(elements[i].text == "MRN:")
			mrn_label = elements[i].text
			mrn_text = elements[i + 1].text
		elsif(elements[i].text == "DOB:")
			dob_label = elements[i].text
			dob_text = elements[i + 1].text
		elsif(elements[i].text == "Gender:")
			gender_label = elements[i].text
			gender_text = elements[i + 1].text
		elsif(elements[i].text == "Age:")
			age_label = elements[i].text
			age_text = elements[i + 1].text
		  #elsif(elements[i].text == "Location:")
		  #	location_label = elements[i].text
		  #	location_text = elements[i + 1].text
		end
	end

    return {
      "patient_name_label" => patient_name_label,
      "patient_name_text" => patient_name_text,
      "mrn_label" => mrn_label,
      "mrn_text" => mrn_text,
      "dob_label" => dob_label,
      "dob_text" => dob_text,
      "gender_label" => gender_label,
      "gender_text" => gender_text,
      "age_label" => age_label,
      "age_text" => age_text,
      "location_label" => location_label,
      "location_text" => location_text
    }
  end

  def demographics_tile_pm_data2
    elements = @selenium.find_elements(:class, "android.widget.TextView")

    return {
      "patient_name_label" => elements[10].text,
      "patient_name_text" => elements[11].text,
      "mrn_label" => elements[12].text,
      "mrn_text" => elements[13].text,
      "dob_label" => elements[14].text,
      "dob_text" => elements[15].text,
      "gender_label" => elements[16].text,
      "gender_text" => elements[17].text,
      "age_label" => elements[18].text,
      "age_text" => elements[19].text
    }
  end

  def demographics_tile_pm_data
    patient_name_label =   Element.new(@selenium, :xpath, '//android.view.View[1]/android.widget.FrameLayout[1]/android.view.View[1]/android.widget.FrameLayout[1]/android.widget.FrameLayout[1]/android.widget.ScrollView[1]/android.widget.LinearLayout[1]/android.widget.HorizontalScrollView[1]/android.widget.LinearLayout[1]/android.widget.LinearLayout[1]/android.widget.TableLayout[1]/android.widget.TableRow[1]/android.widget.TextView[1]')

    patient_name_text =    Element.new(@selenium, :xpath, '//android.view.View[1]/android.widget.FrameLayout[1]/android.view.View[1]/android.widget.FrameLayout[1]/android.widget.FrameLayout[1]/android.widget.ScrollView[1]/android.widget.LinearLayout[1]/android.widget.HorizontalScrollView[1]/android.widget.LinearLayout[1]/android.widget.LinearLayout[1]/android.widget.TableLayout[1]/android.widget.TableRow[1]/android.widget.TextView[2]')

    mrn_label = Element.new(@selenium, :xpath, '//android.view.View[1]/android.widget.FrameLayout[1]/android.view.View[1]/android.widget.FrameLayout[1]/android.widget.FrameLayout[1]/android.widget.ScrollView[1]/android.widget.LinearLayout[1]/android.widget.HorizontalScrollView[1]/android.widget.LinearLayout[1]/android.widget.LinearLayout[1]/android.widget.TableLayout[1]/android.widget.TableRow[2]/android.widget.TextView[1]')

    mrn_text =  Element.new(@selenium, :xpath, '//android.view.View[1]/android.widget.FrameLayout[1]/android.view.View[1]/android.widget.FrameLayout[1]/android.widget.FrameLayout[1]/android.widget.ScrollView[1]/android.widget.LinearLayout[1]/android.widget.HorizontalScrollView[1]/android.widget.LinearLayout[1]/android.widget.LinearLayout[1]/android.widget.TableLayout[1]/android.widget.TableRow[2]/android.widget.TextView[2]')

    gender_label = Element.new(@selenium, :xpath, '//android.view.View[1]/android.widget.FrameLayout[1]/android.view.View[1]/android.widget.FrameLayout[1]/android.widget.FrameLayout[1]/android.widget.ScrollView[1]/android.widget.LinearLayout[1]/android.widget.HorizontalScrollView[1]/android.widget.LinearLayout[1]/android.widget.LinearLayout[1]/android.widget.TableLayout[1]/android.widget.TableRow[3]/android.widget.TextView[1]')

    gender_text =  Element.new(@selenium, :xpath, '//android.view.View[1]/android.widget.FrameLayout[1]/android.view.View[1]/android.widget.FrameLayout[1]/android.widget.FrameLayout[1]/android.widget.ScrollView[1]/android.widget.LinearLayout[1]/android.widget.HorizontalScrollView[1]/android.widget.LinearLayout[1]/android.widget.LinearLayout[1]/android.widget.TableLayout[1]/android.widget.TableRow[3]/android.widget.TextView[2]')

    dob_label = Element.new(@selenium, :xpath, '//android.view.View[1]/android.widget.FrameLayout[1]/android.view.View[1]/android.widget.FrameLayout[1]/android.widget.FrameLayout[1]/android.widget.ScrollView[1]/android.widget.LinearLayout[1]/android.widget.HorizontalScrollView[1]/android.widget.LinearLayout[1]/android.widget.LinearLayout[1]/android.widget.TableLayout[1]/android.widget.TableRow[3]/android.widget.TextView[1]')

    dob_text =  Element.new(@selenium, :xpath, '//android.view.View[1]/android.widget.FrameLayout[1]/android.view.View[1]/android.widget.FrameLayout[1]/android.widget.FrameLayout[1]/android.widget.ScrollView[1]/android.widget.LinearLayout[1]/android.widget.HorizontalScrollView[1]/android.widget.LinearLayout[1]/android.widget.LinearLayout[1]/android.widget.TableLayout[1]/android.widget.TableRow[4]/android.widget.TextView[2]')

    age_label = Element.new(@selenium, :xpath, '//android.view.View[1]/android.widget.FrameLayout[1]/android.view.View[1]/android.widget.FrameLayout[1]/android.widget.FrameLayout[1]/android.widget.ScrollView[1]/android.widget.LinearLayout[1]/android.widget.HorizontalScrollView[1]/android.widget.LinearLayout[1]/android.widget.LinearLayout[1]/android.widget.TableLayout[1]/android.widget.TableRow[5]/android.widget.TextView[1]')

    age_text =  Element.new(@selenium, :xpath, '//android.view.View[1]/android.widget.FrameLayout[1]/android.view.View[1]/android.widget.FrameLayout[1]/android.widget.FrameLayout[1]/android.widget.ScrollView[1]/android.widget.LinearLayout[1]/android.widget.HorizontalScrollView[1]/android.widget.LinearLayout[1]/android.widget.LinearLayout[1]/android.widget.TableLayout[1]/android.widget.TableRow[5]/android.widget.TextView[2]')

    return {
      "patient_name_label" => patient_name_label.text,
      "patient_name_text" => patient_name_text.text,
      "mrn_label" => mrn_label.text,
      "mrn_text" => mrn_text.text,
      "gender_label" => gender_label.text,
      "gender_text" => gender_text.text,
      "dob_label" => dob_label.text,
      "dob_text" => dob_text.text,
      "age_label" => age_label.text,
      "age_text" => age_text.text
    }
  end

  def demographics_tile_cardio_data
    patient_name_label =   Element.new(@selenium, :xpath, '//android.view.View[1]/android.widget.FrameLayout[1]/android.view.View[1]/android.widget.FrameLayout[1]/android.widget.FrameLayout[1]/android.widget.ScrollView[1]/android.widget.LinearLayout[1]/android.widget.HorizontalScrollView[1]/android.widget.LinearLayout[1]/android.widget.LinearLayout[1]/android.widget.TableLayout[1]/android.widget.TableRow[1]/android.widget.TextView[1]')
    patient_name_text =    Element.new(@selenium, :xpath, '//android.view.View[1]/android.widget.FrameLayout[1]/android.view.View[1]/android.widget.FrameLayout[1]/android.widget.FrameLayout[1]/android.widget.ScrollView[1]/android.widget.LinearLayout[1]/android.widget.HorizontalScrollView[1]/android.widget.LinearLayout[1]/android.widget.LinearLayout[1]/android.widget.TableLayout[1]/android.widget.TableRow[1]/android.widget.TextView[2]')
    mrn_label = Element.new(@selenium, :xpath, '//android.view.View[1]/android.widget.FrameLayout[1]/android.view.View[1]/android.widget.FrameLayout[1]/android.widget.FrameLayout[1]/android.widget.ScrollView[1]/android.widget.LinearLayout[1]/android.widget.HorizontalScrollView[1]/android.widget.LinearLayout[1]/android.widget.LinearLayout[1]/android.widget.TableLayout[1]/android.widget.TableRow[2]/android.widget.TextView[1]')
    mrn_text =  Element.new(@selenium, :xpath, '//android.view.View[1]/android.widget.FrameLayout[1]/android.view.View[1]/android.widget.FrameLayout[1]/android.widget.FrameLayout[1]/android.widget.ScrollView[1]/android.widget.LinearLayout[1]/android.widget.HorizontalScrollView[1]/android.widget.LinearLayout[1]/android.widget.LinearLayout[1]/android.widget.TableLayout[1]/android.widget.TableRow[2]/android.widget.TextView[2]')
    gender_label = Element.new(@selenium, :xpath, '//android.view.View[1]/android.widget.FrameLayout[1]/android.view.View[1]/android.widget.FrameLayout[1]/android.widget.FrameLayout[1]/android.widget.ScrollView[1]/android.widget.LinearLayout[1]/android.widget.HorizontalScrollView[1]/android.widget.LinearLayout[1]/android.widget.LinearLayout[1]/android.widget.TableLayout[1]/android.widget.TableRow[3]/android.widget.TextView[1]')
    gender_text =  Element.new(@selenium, :xpath, '//android.view.View[1]/android.widget.FrameLayout[1]/android.view.View[1]/android.widget.FrameLayout[1]/android.widget.FrameLayout[1]/android.widget.ScrollView[1]/android.widget.LinearLayout[1]/android.widget.HorizontalScrollView[1]/android.widget.LinearLayout[1]/android.widget.LinearLayout[1]/android.widget.TableLayout[1]/android.widget.TableRow[3]/android.widget.TextView[2]')
    race_label = Element.new(@selenium, :xpath, '//android.view.View[1]/android.widget.FrameLayout[1]/android.view.View[1]/android.widget.FrameLayout[1]/android.widget.FrameLayout[1]/android.widget.ScrollView[1]/android.widget.LinearLayout[1]/android.widget.HorizontalScrollView[1]/android.widget.LinearLayout[1]/android.widget.LinearLayout[1]/android.widget.TableLayout[1]/android.widget.TableRow[4]/android.widget.TextView[1]')
    race_text =  Element.new(@selenium, :xpath, '//android.view.View[1]/android.widget.FrameLayout[1]/android.view.View[1]/android.widget.FrameLayout[1]/android.widget.FrameLayout[1]/android.widget.ScrollView[1]/android.widget.LinearLayout[1]/android.widget.HorizontalScrollView[1]/android.widget.LinearLayout[1]/android.widget.LinearLayout[1]/android.widget.TableLayout[1]/android.widget.TableRow[4]/android.widget.TextView[2]')
    dob_label = Element.new(@selenium, :xpath, '//android.view.View[1]/android.widget.FrameLayout[1]/android.view.View[1]/android.widget.FrameLayout[1]/android.widget.FrameLayout[1]/android.widget.ScrollView[1]/android.widget.LinearLayout[1]/android.widget.HorizontalScrollView[1]/android.widget.LinearLayout[1]/android.widget.LinearLayout[1]/android.widget.TableLayout[1]/android.widget.TableRow[5]/android.widget.TextView[1]')
    dob_text =  Element.new(@selenium, :xpath, '//android.view.View[1]/android.widget.FrameLayout[1]/android.view.View[1]/android.widget.FrameLayout[1]/android.widget.FrameLayout[1]/android.widget.ScrollView[1]/android.widget.LinearLayout[1]/android.widget.HorizontalScrollView[1]/android.widget.LinearLayout[1]/android.widget.LinearLayout[1]/android.widget.TableLayout[1]/android.widget.TableRow[5]/android.widget.TextView[2]')
    age_label = Element.new(@selenium, :xpath, '//android.view.View[1]/android.widget.FrameLayout[1]/android.view.View[1]/android.widget.FrameLayout[1]/android.widget.FrameLayout[1]/android.widget.ScrollView[1]/android.widget.LinearLayout[1]/android.widget.HorizontalScrollView[1]/android.widget.LinearLayout[1]/android.widget.LinearLayout[1]/android.widget.TableLayout[1]/android.widget.TableRow[6]/android.widget.TextView[1]')
    age_text =  Element.new(@selenium, :xpath, '//android.view.View[1]/android.widget.FrameLayout[1]/android.view.View[1]/android.widget.FrameLayout[1]/android.widget.FrameLayout[1]/android.widget.ScrollView[1]/android.widget.LinearLayout[1]/android.widget.HorizontalScrollView[1]/android.widget.LinearLayout[1]/android.widget.LinearLayout[1]/android.widget.TableLayout[1]/android.widget.TableRow[6]/android.widget.TextView[2]')

    return {
      "patient_name_label" => patient_name_label.text,
      "patient_name_text" => patient_name_text.text,
      "mrn_label" => mrn_label.text,
      "mrn_text" => mrn_text.text,
      "gender_label" => gender_label.text,
      "gender_text" => gender_text.text,
      "race_label" => race_label.text,
      "race_text" => race_text.text,
      "dob_label" => dob_label.text,
      "dob_text" => dob_text.text,
      "age_label" => age_label.text,
      "age_text" => age_text.text
    }
  end

  def demo_tile
    Element.new(@selenium, :uiautomator, 'new UiSelector().text("DEMOGRAPHICS")')
  end

  def summary_tiles_training(which)
	  collection = @selenium.find_element(:class, 'android.widget.LinearLayout')
	  cells = collection.find_elements(:class, 'XCUIElementTypeCell')

	  found = false

	for i in 0..(cells.count - 1)
		  txts = cells[i].find_elements(:class, 'android.widget.TextView')
		for x in 0..(txts.count - 1)
			#if x == 0
			#puts "txt count = #{txts.count}"
			#end

			#puts " #{i}.#{x} #{txts[x].name}"

			if(txts[x].name.nil?)
			#puts "txt is nil"
			elsif(txts[x].name.include? which)
				found = true
				return cells[i]
			end
		end

		if found
			break
		end
	end
  end

  def get_all_patient_summary_tile_elements
    # summary_tiles = @selenium.find_elements(:id, "#{APP_PACKAGE}:id/summary_header")
    summary_tiles = @selenium.find_elements(:xpath, "//android.widget.LinearLayout[@resource-id=\"com.utang.one.qa:id/summary_header\"]/..")

    tile_keys = ['GENERAL INFO','ECGs','Monitor']
    tile_hash = {}
    summary_tiles.each_with_index do |tiles,index|
      tile_hash.store(tile_keys[index], tiles.size)
    end
    return tile_hash
  end

end
