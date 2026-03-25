module Global_Services
  def site_registrationold(regCode, siteNumber)
    puts "Registering Device with regCode: '#{regCode}' to siteNumber: '#{siteNumber}'"
    `curl -vs -k -i --user astglobal:Gl0b@lS3rv\!c3s \
    -H "Content-Type:application/json" -H "User-Agent:iOS" \
    -X POST -d '{"registrationCode":"#{regCode}","siteId":"#{siteNumber}"}' \
    https://10.10.160.230/GS/api/DeviceSite?registrationCode=#{regCode} 2> output.txt`
  end
  
  def site_registration(regCode, siteNumber)
    puts "Registering Device with regCode: '#{regCode}' to siteNumber: '#{siteNumber}'"
    `curl -vs -k -i --user astglobal:Gl0b@lS3rv\!c3s \
    -H "Content-Type:application/json" -H "User-Agent:iOS" \
    -X POST -d '{"registrationCode":"#{regCode}","siteId":"#{siteNumber}"}' \
    https://astqaas1gs01.utangdevops.com/gs/api/DeviceSite?registrationCode=#{regCode} 2> output.txt`
  end
    
  def site_registration_prod(regCode, siteNumber)
    puts "Registering Device with regCode: '#{regCode}' to siteNumber: '#{siteNumber}'"
    `curl -vs -k -i --user astglobal:Gl0b@lS3rv\!c3s \
    -H "Content-Type:application/json" -H "User-Agent:iOS" \
    -X POST -d '{"registrationCode":"#{regCode}","siteId":"#{siteNumber}"}' \
    https://globalservices.utangtech.com/globalservices.prod/api/DeviceSite?registarationCode=#{regCode} 2> output.txt`
  end
end