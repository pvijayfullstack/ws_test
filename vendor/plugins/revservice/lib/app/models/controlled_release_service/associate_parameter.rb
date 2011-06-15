module ControlledReleaseService
  class AssociateParameter < ActionWebService::Struct
    member :action_type, :string
    member :dollars_available, :boolean
    member :association_id, :double
    member :posting_check_number, :string
    member :posting_site_number, :string
    member :associated_items, [AssociateItem]
  end
end