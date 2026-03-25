module AMP_API  
  def clear_vendor_password
  #  `curl -s -k -H "Content-Type:application/json" -H "X-AUTH-TOKEN:TESTTOKEN"\
  #  -X PUT -d '{"vendorSystem":"MUSE","moduleInstanceId":"103","vendorSystemName":"MUSE",\
  #  "vendorUserId":"1156","vendorGroupId":"999","username":"devadmin","password":"test123"}'\
  #  http://10.10.0.133/amp/api/EnterpriseUserVendorCredential?aduser=jeanettetorres > output.txt`
    
  #'curl -s -k -H "Content-Type:application/json" -H "X-AUTH-TOKEN:TESTTOKEN" -X PUT -d '{"vendorSystem":"MUSE","moduleInstanceId":"106","vendorSystemName":"MUSE", "vendorUserId":"1156", "vendorGroupId":"21000","username":"jeanettetorres","password":"Pass124"}' 'http://10.10.160.133/amp/api/EnterpriseUserVendorCredential?aduser=jeanettetorres'
  
  `curl -s -k -H "Content-Type:application/json" -H "X-AUTH-TOKEN:TESTTOKEN" -X PUT -d '{"vendorSystem":"MUSE","moduleInstanceId":"100","vendorSystemName":"MUSE", "vendorUserId":"20014", "vendorGroupId":"20000","username":"editor","password":"Pass124"}' 'http://10.106.5.18/amp/api/EnterpriseUserVendorCredential?aduser=editor'`
  end
  
  def set_vendor_password
  `curl -s -k -H "Content-Type:application/json" -H "X-AUTH-TOKEN:TESTTOKEN" -X PUT -d '{"vendorSystem":"MUSE","moduleInstanceId":"106","vendorSystemName":"MUSE", "vendorUserId":"20014", "vendorGroupId":"1","username":"editor","password":"XXXXX"}' 'http://10.106.5.18/amp/api/EnterpriseUserVendorCredential?aduser=editor'`
  end  
end