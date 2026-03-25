module QA_Integration_site50
  def patient_sps_500    
    name = 'ESRON, NESBITT'
    gender = '(F)' 
    age =  '13 YEARS'   
    mrn =  '456781239'      
    site =  '50 QA Integration'

    acq_date = "12-07-15 13:42:30"
    diag_state = "Electronic ventricular pacemaker"
    ecg_count = 2
    
    return {
      "name" => name,
      "gender" => gender,
      "age" => age,
      "mrn" => mrn,
      "site" => site,
      "acq_date" => acq_date,
      "diag_state" => diag_state,
      "ecg_count" => ecg_count
    }
  end
  
  def patient_cardio_search
    name = 'ESRON, NESBITT'
    gender = '(F)' 
    age =  '13 YEARS'   
    mrn =  '456781239'      
    site =  '50 QA Integration'

    acq_date = "12-07-15 13:42:30"
    diag_state = "Electronic ventricular pacemaker"
    ecg_count = 2
    
    return {
      "name" => name,
      "gender" => gender,
      "age" => age,
      "mrn" => mrn,
      "site" => site,
      "acq_date" => acq_date,
      "diag_state" => diag_state,
      "ecg_count" => ecg_count
    }
  end
  
  def confirm_other_means
    name = 'Last 04, Last 04'
    
    return {
      "name" => name
    }
  end
  
  def test_not_assigned_inbasket
    name = 'Last 04, Last 04'
    
    return {
      "name" => name
    }
  end
  
  def confirm_ecg
    name = 'Allen, Jessica'
    
    return {
      "name" => name
    }
  end
  
  def locked_test
    name = 'Test, Locked'
    
    return {
      "name" => name
    }
  end
  
  def overwrite_prompt
    name = 'PARKS, NANCY'
    
    return {
      "name" => name
    }
  end
  
  def status_mismatch
    name = 'XXXXXX403, XXXXXX403'
    
    return {
      "name" => name
    }
  end
  
  def no_order_number
    name = 'ER. User, Ord'
    
    return {
      "name" => name
    }
  end
  
  def overread_minMusePrivileges
    name = 'Teague UT, Delvin'
    
    return {
      "name" => name
    }
  end
end