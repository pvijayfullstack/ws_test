class PayerMappingServiceController < ApplicationController
  web_service_api PayerMappingApi
  #wsdl_service_name 'PayerMapping'

  def update_edc_payer_mapping(key, mapping)
    rsp = WebService::Response.new
    rsp.success = true
    rsp
  end
  
  def update_eft_payer_mapping(key, mapping)
  end
    
  def update_era_payer_details(key, mapping)
  end

end