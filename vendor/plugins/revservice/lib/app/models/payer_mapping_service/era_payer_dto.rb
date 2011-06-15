module PayerMappingService

  class EraPayerDto  < ActionWebService::Struct

    member :gateway, :string
    member :payer_id, :string
    member :original_gateway, :string
    member :original_payer_id, :string
    member :payer_name, :string
    member :payer_address_info, PayerAddressDTO
    member :administrator_owner, :string
    member :ability_to_split_by_npi, :boolean
    member :id3, :string
    member :payer_lob, :string
    member :payer_model, :string
    member :retriever_id, :string
    member :submitter_id, :string
    member :status, :string
    
  end
end