module AMP_API  
  def clear_vendor_password_old
    `curl -k -H "Content-Type:application/json" -H "X-AUTH-TOKEN:TESTTOKEN"\
    -X PUT -d '{"vendorSystem":"MUSE","moduleInstanceId":"103","vendorSystemName":"MUSE",\
    "vendorUserId":"jeanettetorres","vendorGroupId":"1156","username":"devadmin","password":"test123"}'\
    http://10.10.160.133/amp/api/EnterpriseUserVendorCredential?aduser=jeanettetorres`
  end
  
  def clear_vendor_password
    #`curl -s -k -H "Content-Type:application/json" -H "X-AUTH-TOKEN:TESTTOKEN"\
    #-X PUT -d '{"vendorSystem":"MUSE","moduleInstanceId":"103","vendorSystemName":"MUSE",\
    #"vendorUserId":"jeanettetorres","vendorGroupId":"1156","username":"devadmin","password":"test123"}'\
    #http://10.10.160.133/amp/api/EnterpriseUserVendorCredential?aduser=jeanettetorres > output.txt`
    
    `curl -s -k -H "Content-Type:application/json" -H "X-AUTH-TOKEN:TESTTOKEN" -X PUT -d '{"vendorSystem":"MUSE","moduleInstanceId":"106","vendorSystemName":"MUSE", "vendorUserId":"1156", "vendorGroupId":"21000","username":"jeanettetorres","password":"Pass124"}' 'http://10.10.160.133/amp/api/EnterpriseUserVendorCredential?aduser=jeanettetorres'`

  end  
end