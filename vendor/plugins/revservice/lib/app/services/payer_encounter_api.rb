class PayerEncounterApi < ActionWebService::API::Base
  api_method :get_edc_payer, :expects => [
      {:key => :string}, {:system_source => :string},
      {:aba_number => :string}, {:dda_number => :string},
      {:payer_name => :string}, {:footnote_payer => :boolean},
      {:payer_address => PayerMappingService::PayerAddressDTO}], :returns => [
      {:success => :boolean}, {:error_code => :string},
      {:error_message => :string}, {:aba_number => :string},
      {:dda_number => :string},{:payer_name => :string},
      {:footnote_payer => :boolean},{:original_payer_id => :string},
      {:original_gateway => :string}, {:payer_id => :string},
      {:gateway => :string}, {:payer_address => PayerMappingService::PayerAddressDTO}]
      
  api_method :get_eft_payer, :expects =>[{:company_id => :string},{:payer_name => :string}]
  
  def api_key
    "encounter_url"
  end  
      
end

