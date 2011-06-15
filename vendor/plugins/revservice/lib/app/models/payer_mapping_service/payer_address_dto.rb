module PayerMappingService

  class PayerAddressDTO < ActionWebService::Struct
    member :address_line_1, :string
    member :address_line_2, :string
    member :address_line_3, :string
    member :city_name, :string
    member :state_code, :string
    member :zip_code, :string
    # member :website, :string
  end

end