module ControlledReleaseService
  class AssociateItemResult < ActionWebService::Struct
    member :transaction_guid, :string
    member :association_id, :double
    member :error_code, :string
    member :error_message, :string
    member :success, :boolean
  end
end

    