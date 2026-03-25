module URI

  def initialize(platform, key, encryption=false)
    $PLATFORM = platform
    $KEY = key
    $ENCRYPTION = encryption
    $mode_id = "ascom"
  end

  def ascom_uri(base_uri, facility_id, unit, bed, iso_time, target='pm-mon')
    return "#{base_uri}/ascom/#{target}?time=#{iso_time}&bed=#{bed}&unit=#{unit}&facility_id=#{facility_id}"
  end

  def ascom_events_uri(base_uri, site_id, unit, bed, target='pm-evt')
    return "#{base_uri}/ascom/#{target}?bed=#{bed}&unit=#{unit}&siteid=#{site_id}"
  end

  def engage_uri(base_uri, site_id, unit, bed, iso_time, target='pm-mon')
    return "#{base_uri}/engage/#{target}?time=#{iso_time}&bed=#{bed}&unit=#{unit}&siteid=#{site_id}"
  end

  def engage_events_uri(base_uri, site_id, unit, bed, target='pm-evt')
    return "#{base_uri}/engage/#{target}?bed=#{bed}&unit=#{unit}&siteid=#{site_id}"
  end


  def get_uri_by_mode(base_uri, site_id, unit, bed, iso_time, target='pm-mon')
    case mode
    when 1;


    end
  end

end
