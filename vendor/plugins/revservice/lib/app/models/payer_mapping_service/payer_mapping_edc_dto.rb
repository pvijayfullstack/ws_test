module PayerMappingService

  class PayerMappingEdcDto  < ActionWebService::Struct
    member :aba_number, :string
    member :dda_number, :string
    member :footnote_payer_indicator, :boolean
    member :gateway, :string
    member :payer_id, :string
    member :original_gateway, :string
    member :original_payer_id, :string
    member :payer_name, :string
    member :payer_address_info, PayerAddressDTO
    member :reason_code_set_name, :string
  end
end