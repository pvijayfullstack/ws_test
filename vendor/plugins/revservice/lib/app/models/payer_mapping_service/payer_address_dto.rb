module PayerMappingService

  class PayerAddressDTO < ActionWebService::Struct
    member :streetAddressLine1, :string
    member :streetAddressLine2, :string
    member :streetAddressLine3, :string
    member :cityNm, :string
    member :stateCode, :string
    member :zipCode, :string
    # member :website, :string
    
    #alias streetAddressLine1 address_line_1
  end

end