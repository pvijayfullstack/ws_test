class PayerMappingServiceController < ApplicationController
  web_service_api PayerMappingApi
  #wsdl_service_name 'PayerMapping'

  def update_edc_payer_mapping(key, mapping)
    unless key == "NCC1701D"
    else
      res = WebService::Response.new :success => false,
        :error => WebService::Error.new(:error_code =>"-1", :message => "key not valid")
    end
    return res
  end
  
  def update_eft_payer_mapping(key, mapping)
  end
    
  def update_era_payer_details(key, mapping)
  end

end