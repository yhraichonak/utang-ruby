module QA_Site_34
  def pm_patient_one
    first_name = "ESRON"
    last_name = "NESBITT"
    full_name = "NESBITT, ESRON"
  end

  def pm_patient_two
    first_name = "MARIA"
    last_name = "HALE"
    full_name = "HALE, MARIA"
  end
  
  def patient_500    
    name = 'test, 500sps'
    gender = '(F)' 
    age =  '13 YEARS'   
    mrn =  '199999'      
    site =  '34 QA Cardio PM'

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

  def patient_sps_500    
    name = 'Nesbitt, Esron'
    gender = '(F)' 
    age =  '13 YEARS'   
    mrn =  '199999'      
    site =  '34 QA Cardio PM'

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
  
  def two_ecg_patient    
    name = 'PARKS, NANCY'
    gender = '(F)' 
    age =  '55 YEARS'   
    mrn =  '914697'      
    site =  '34 QA Cardio PM'

    acq_date = "06-11-16 13:44:30"
    diag_state = ""
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
  
  def second_ecg_patient    
    name = 'Nesbitt, Esron'
    gender = '(F)' 
    age =  '17 YEARS'   
    mrn =  '199999'      
    site =  '34 QA Cardio PM'

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
    name = 'Nesbitt, Esron'
    gender = '(F)' 
    age =  '13 YEARS'   
    mrn =  '199999'      
    site =  '34 QA Cardio PM'

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
    name = 'Jones, Tyler'
    
    return {
      "name" => name
    }
  end
  
  def test_not_assigned_inbasket
    name = 'Johnson, James'
    
    return {
      "name" => name
    }
  end
  
  def undo_edits
    name = 'Johnson, James'
    
    return {
      "name" => name
    }
  end
  
  def confirm_ecg
    name = 'AT_Denver, Johnny'
    
    return {
      "name" => name
    }
  end
  
  def locked_test
    name = 'AC_Cutler, Jay'
    
    return {
      "name" => name
    }
  end
  
  def overwrite_prompt
    #name = 'PARKS, NANCY'
    name = 'Johnson, James'
    ecg_one = "Abnormal ECG"
    ecg_two = "Abnormal ECG"
    ecg_three = "Biatrial enlargement"
    
    return {
      "name" => name,
      "ecg_one" => ecg_one,
      "ecg_two" => ecg_two,
      "ecg_three" => ecg_three
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
    name = 'Johnson, James'    
    return {
      "name" => name
    }
  end
  
  def cardiac_fellow
    name = 'Automation, Four'
    
    return {
      "name" => name
    }
  end
  
  def pm_patient
    #name = 'Nesbitt, Esron'
    name = 'Hale, Maria'
    
    return {
      "name" => name
    }
  end
end