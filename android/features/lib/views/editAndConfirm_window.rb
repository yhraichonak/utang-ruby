Dir[File.dirname(__FILE__) + '/../*.rb'].each {|file| require file }

class EditAndConfirm_window
  def initialize(selenium, appium)
    @selenium = selenium
    @appium = appium
  end

  def home_button
    Element.new(@selenium, :id, 'android:id/home')
  end

  def cancel_button
    Element.new(@selenium, :id, "#{APP_PACKAGE}:id/menu_cardio_cancel")
  end

  def confirm_button
    Element.new(@selenium, :id, "#{APP_PACKAGE}:id/menu_cardio_confirm")
  end

  def getPatientInfoFromHeader
    patientName = Element.new(@selenium, :id, "#{APP_PACKAGE}:id/tv_name").text
    patientSex = Element.new(@selenium, :id, "#{APP_PACKAGE}:id/tv_gender").text
    patientAge = Element.new(@selenium, :id, "#{APP_PACKAGE}:id/tv_age").text
    patientSite = Element.new(@selenium, :id, "#{APP_PACKAGE}:id/tv_site").text
    patientMrn = Element.new(@selenium, :id, "#{APP_PACKAGE}:id/tv_mrn").text
    return {'name' => patientName, 'gender' => patientSex, 'age' => patientAge, 'site' => patientSite, 'mrn' => patientMrn}
  end

  def ecg_details_chevron
    ecg_diagnosis = Element.new(@selenium, :id, "#{APP_PACKAGE}:id/tv_cardio_analysis")
    ecg_time = Element.new(@selenium, :id, "#{APP_PACKAGE}:id/tv_cardio_datetime")

    sex = Element.new(@selenium, :id, "#{APP_PACKAGE}:id/cardio_details_sex")

    vhr = Element.new(@selenium, :id, "#{APP_PACKAGE}:id/cardio_details_vhr")

    ahr = Element.new(@selenium, :id, "#{APP_PACKAGE}:id/cardio_details_ahr")

    dob = Element.new(@selenium, :id, "#{APP_PACKAGE}:id/cardio_details_dob")

    pr = Element.new(@selenium, :id, "#{APP_PACKAGE}:id/cardio_details_pr")

    qt = Element.new(@selenium, :id, "#{APP_PACKAGE}:id/cardio_details_qt")

    age = Element.new(@selenium, :id, "#{APP_PACKAGE}:id/cardio_details_age")

    qrs = Element.new(@selenium, :id, "#{APP_PACKAGE}:id/cardio_details_qrs")

    qtc = Element.new(@selenium, :id, "#{APP_PACKAGE}:id/cardio_details_qtc")

    prt = Element.new(@selenium, :id, "#{APP_PACKAGE}:id/cardio_details_prt")

    return {
      'diagnosis' => ecg_diagnosis.text,
      'time' => ecg_time.text,
      'sex' => sex.text,
      'vhr' => vhr.text,
      'ahr' => ahr.text,
      'dob' => dob.text,
      'pr' => pr.text,
      'qt' => qt.text,
      'age' => age.text,
      'qrs' => qrs.text,
      'qtc' => qtc.text,
      'prt' => prt.text
    }
  end

  def statementMessage_text(rowNumber)
    rowNumber = (rowNumber - 1)
    parent = @selenium.find_element(:id, "#{APP_PACKAGE}:id/cardio_statements")

    e = parent.find_element(:id, "#{APP_PACKAGE}:id/cardio_statement_listview")

    locator = if($DEVICE_BUILD_VERSION == '5.1')
                'android.view.View'
              else
                'android.view.ViewGroup'
              end

    elements = e.find_elements(:class, locator)

    statement = elements[rowNumber].find_element(:id, "#{APP_PACKAGE}:id/text")

    return statement
  end

  def statementDelete_button(rowNumber)
	   rowNumber = (rowNumber - 1)
	   parent = @selenium.find_element(:id, "#{APP_PACKAGE}:id/cardio_statements")
	   e = parent.find_element(:id, "#{APP_PACKAGE}:id/cardio_statement_listview")

	   locator = if($DEVICE_BUILD_VERSION == '5.1')
   		           'android.view.View'
   	          else
   		           'android.view.ViewGroup'
   	          end

	   elements = e.find_elements(:class, locator)
	   deleteObj = elements[rowNumber].find_element(:id, "#{APP_PACKAGE}:id/delete")
	   return deleteObj
  end

  def statementReorder_image(rowNumber)
	   rowNumber = (rowNumber - 1)
	   parent = @selenium.find_element(:id, "#{APP_PACKAGE}:id/cardio_statements")
  	 e =   parent.find_element(:id, "#{APP_PACKAGE}:id/cardio_statement_listview")

  	 locator = if($DEVICE_BUILD_VERSION == '5.1')
 		             'android.view.View'
 	            else
 		             'android.view.ViewGroup'
 	          end

	   elements = e.find_elements(:class, locator)
	   dragView = elements[rowNumber].find_element(:id, "#{APP_PACKAGE}:id/drag_handle")
	   return dragView
  end

  def addStatement_button
    Element.new(@selenium, :id, "#{APP_PACKAGE}:id/cardio_statement_add")
  end

end