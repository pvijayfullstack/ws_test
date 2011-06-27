require 'payer_mapping_service/payer_address_dto'

class PayerEncounterApi < ActionWebService::API::Base
  inflect_names false
  api_method :getEDCPayer, :expects => [
      {:authorizationKey => :string}, {:sourceSystemCode => :string},
      {:abaNumber => :string}, {:ddaNumber => :string},
      {:payerName => :string}, {:footNoteBasedInd => :boolean},
      {:payerAddress => PayerMappingService::PayerAddressDTO}], :returns => [Hash]
      #:returns => [
      #{:successIndicator => :boolean}, {:errorCode => :string},
      #{:errorMessage => :string}, {:abaNumber => :string},
      #{:ddaNumber => :string},{:payerName => :string},{:reasonCodeSetName => :string},
      #{:footNoteBasedInd => :boolean},{:originalPayerId => :string},
      #{:originalGateway => :string}, {:payerId => :string},
      #{:gateway => :string}, {:payerAddress => PayerMappingService::PayerAddressDTO}]
      
  api_method :get_eft_payer, :expects =>[{:company_id => :string},{:payer_name => :string}]
  
  def self.api_key
    "encounter_url"
  end  
      
end

