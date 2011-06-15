module ControlledReleaseService  
  class AssociateItem < ActionWebService::Struct
    member :transaction_guid, :string
    member :payment_amount, :double
    member :provider_adjustments, [ProviderAdjustment]
  end
end