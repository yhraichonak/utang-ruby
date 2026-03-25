
require 'inifile'
require 'active_support/time'
require 'pp'
require 'logger'
require 'date'

$testdatafile = 'common/testdata.ini'

def get_param(property_name)
  common_testdata = IniFile.load($testdatafile)
  testdata=$testdata.nil? ? common_testdata : common_testdata.merge!($testdata)
  section, attribute = property_name.split('_', 2)
  return ENV[property_name].blank? ? testdata[section][attribute] : ENV[property_name]
end

def set_test_variable(var_name, var_value)
  $TEST_DATA_MAP['var_name']=var_value
end

def get_test_variable(var_name)
  return $TEST_DATA_MAP[var_name]
end

def process_hash_params(input_hash)
  input_hash.each { |k, v| input_hash[k] = process_param(v) }
  input_hash
end

def process_param(input_param)
  common_testdata = IniFile.load($testdatafile)
  testdata=$testdata.nil? ? common_testdata: common_testdata.merge!($testdata)
  input_param=input_param.to_s
  input_param = ENV[input_param.sub('[env.', '').sub(']', '')] if input_param.start_with?('[env.')
  if input_param.include?('[props.')
    begin
      while input_param.include?('[props.')
        matches = input_param.match('.*\\[props.(.*?)\\].*').captures
        if matches.size > 0
          section, attribute = matches[0].split('_', 2)
          if attribute.nil?
            input_param = testdata[section]
            break
          end
          new_value = ENV[matches[0]].blank? ? testdata[section][attribute] : ENV[matches[0]]
          if new_value.instance_of? String
            new_value=new_value.gsub("__","#")
          end
          raise 'Unable to find property ' + matches[0] if new_value.nil?

          input_param = input_param.gsub('[props.' + matches[0] + ']', new_value.to_s)
        else
          break
        end
      end
    rescue => e
      raise 'Exception occurs on attempt to substitute params ' + input_param +". #{e}. TESTDATA:\n#{testdata}"
    end
  end

  if input_param.include?('[td.')
    begin
      while input_param.include?('[td.')
        matches = input_param.match('.*\\[td.(.*)\\].*').captures
        if matches.size > 0
          input_param = input_param.gsub('[td.' + matches[0] + ']',  $TEST_DATA_MAP[matches[0]])
        else
          break
        end
      end
    rescue
      raise 'Exception occurs on attempt to substitute params from TEST_DATA_MAP ' + input_param
    end
  end

  if input_param.instance_of?(String) && input_param.match('\\[(.*?)\\*(.*?)\\]')
    begin
      matches = input_param.match('\\[(.*?)\\*(.*?)\\]').captures
      input_param = input_param.gsub(/\[.*\]/,  matches[0]*(matches[1].to_i))
    rescue
      raise 'Exception occurs on attempt to substitute params from TEST_DATA_MAP ' + input_param
    end
  end

  if input_param.kind_of?(String)
    if input_param.include?('[HOUR_AGO]')
      input_param = input_param.gsub('[HOUR_AGO]', (Time.now - 3600).strftime('%Y-%m-%dT%H:%M:%S.%L%z'))
    end
    if input_param.include?('[UNIQUE]')
      input_param = input_param.gsub('[UNIQUE]', DateTime.now.strftime('%Q'))
    end
    m = input_param.match(/\[YESTERDAY\.(.*?)\]/)
    if m
      date_value = (Time.now - 86400).strftime(m[1])
      input_param = input_param.gsub("[YESTERDAY.#{m[1]}]", date_value)
    end
    m = input_param.match(/\[NOW\.(.*?)\]/)
    if m
      date_value = Time.now.strftime(m[1])
      input_param = input_param.gsub("[NOW.#{m[1]}]", date_value)
    end
  end
  return input_param

end

