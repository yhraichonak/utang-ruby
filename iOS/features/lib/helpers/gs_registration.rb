module GS_Registration
  def site_registration(regCode, siteNumber)
    puts "------"
    puts regCode
    puts siteNumber
    puts "------"
    `curl -vs -k -i --user astglobal:Gl0b@lS3rv\!c3s \
    -H "Content-Type:application/json" -H "User-Agent:iOS" \
    -X POST -d '{"registrationCode":"#{regCode}","siteId":"#{siteNumber}"}' \
    https://astqaas1gs01.utangdevops.com/gs/api/DeviceSite?registrationCode=25107-933463 2> output.txt`
  end
  
  def site_registration_prod(regCode, siteNumber)
    `curl -vs -k -i --user astglobal:Gl0b@lS3rv\!c3s \
    -H "Content-Type:application/json" -H "User-Agent:iOS" \
    -X POST -d '{"registrationCode":"#{regCode}","siteId":"#{siteNumber}"}' \
    https://globalservices.utangtech.com/globalservices.prod/api/DeviceSite?registarationCode=#{regCode} 2> output.txt`
  end
end