require 'date'

module ElementHasher

  def check_if_date(string)
    begin
      Date.strptime(string, '%Y/%m/%d')
      return true
    rescue
      return false
    end
  end

  def create_element_hash(string_array, headers, exclusions, update_date=false, check_dup=true)
    used_strings = []
    result_hash = {}

    if check_dup
      string_array = string_array.uniq
    end

    if update_date
      string_array = update_date_strings_from_array(string_array, key='Date')
    end

    string_array.each_with_index do |s,i|
      unless exclusions.include?(s) or used_strings.include?(s)
        if headers.include?(s)
          key = s
          value = true
        else
          key = s
          value = string_array[i+1]
          used_strings.append(value)
        end
        # puts "key=" + key
        # puts "value=" + value.to_s
        result_hash.store(key, value)
      end
      headers.each do |hs|
        unless result_hash.include?(hs)
          result_hash.store(hs, false)
        end
      end
    end
    # puts "exclusion_strings: " + exclusions.to_s
    # puts
    # puts "used_strings: " + used_strings.to_s
    # puts
    # puts "result_hash: " + result_hash.to_s
    return result_hash
  end

  def update_date_strings_from_array(string_array, key)
    to_add = []

    string_array.each do |s|
      begin
        Date.strptime(s, '%Y/%m/%d')
        # puts "Deleting: " + s
        string_array.delete(s)
        to_add.append(s)
      rescue ArgumentError
        nil
      end
    end

    to_add.each do |s|
      string_array.append(key)
      string_array.append(s)
    end
    return string_array
  end

end