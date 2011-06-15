module PayerMappingService

  class PayerMappingEftDto  < ActionWebService::Struct
    member :company_id, :string
    member :gateway, :string
    member :payer_id, :string
    member :original_gateway, :string
    member :original_payer_id, :string
    member :payer_name, :string

  end
end