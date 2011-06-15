module FileMergeService
  class CheckDetails < ActionWebService::Struct
    member :check_amount, :double
    member :check_number, :string
    member :file_name, :string
    member :number_of_accounts, :integer
    member :payment_amount, :double
    member :provider_adjustment, :double
    
  end
end
