module ControlledReleaseService
  class ProviderAdjustment < ActionWebService::Struct
    member :amount, :double
    member :reason_code, :string
    member :reason_id, :string
  end
end