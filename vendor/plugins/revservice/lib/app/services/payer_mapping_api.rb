class PayerMappingApi < ActionWebService::API::Base
  inflect_names true
  api_method :update_edc_payer_mapping, :expects => [
    {:key => :string },
    {:mapping => PayerMappingService::PayerMappingEdcDto },
    ], :returns =>[WebService::Response]
  
  api_method :update_eft_payer_mapping, :expects => [
    {:key => :string },
    {:mapping => PayerMappingService::PayerMappingEftDto },
    ], :returns =>[WebService::Response]
    
  api_method :update_era_payer_details, :expects => [
    {:key => :string },
    {:mapping => PayerMappingService::EraPayerDto },
    ], :returns =>[WebService::Response]
end