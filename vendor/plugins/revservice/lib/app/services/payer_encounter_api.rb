class PayerEncounterApi < ActionWebService::API::Base
  inflect_names false
  api_method :getEDCPayer, :expects => [
      {:authorizationKey => :string}, {:sourceSystemCode => :string},
      {:abaNumber => :string}, {:ddaNumber => :string},
      {:payerName => :string}, {:footnotePayer => :boolean},
      {:payerAddress => PayerMappingService::PayerAddressDTO}], :returns => [
      {:success => :boolean}, {:error_code => :string},
      {:error_message => :string}, {:aba_number => :string},
      {:dda_number => :string},{:payer_name => :string},{:reason_code_set_name => :string},
      {:footnote_payer => :boolean},{:original_payer_id => :string},
      {:original_gateway => :string}, {:payer_id => :string},
      {:gateway => :string}, {:payer_address => PayerMappingService::PayerAddressDTO}]
      
  api_method :get_eft_payer, :expects =>[{:company_id => :string},{:payer_name => :string}]
  
  def self.api_key
    "encounter_url"
  end  
      
end

