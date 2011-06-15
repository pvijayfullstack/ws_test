class PayerMappingServiceController < ApplicationController
  web_service_api PayerMappingApi
  #wsdl_service_name 'PayerMapping'

  def update_edc_payer_mapping(key, mapping)
    response = WebService::Response.new
    response.success = true
    response
  end
  
  def update_eft_payer_mapping(key, mapping)
  end
    
  def update_era_payer_details(key, mapping)
  end

end