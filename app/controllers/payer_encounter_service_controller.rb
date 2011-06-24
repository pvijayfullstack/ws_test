class PayerEncounterServiceController < ApplicationController
  web_service_api PayerEncounterApi
  #wsdl_service_name 'PayerMapping'

  def getEDCPayer(key,system_source_code, aba_number, dda_number, payer_name, footnote_payer, payer_address )
  end
  
  def get_eft_payer(key, system_source_code, company_id, payer_name )
    
  end
end