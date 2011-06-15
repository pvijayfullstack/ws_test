module ReasonCodeService
  class CrosswalkItem < ActionWebService::Struct
    member :active, :boolean
    member :ansi_code, :string
    member :claim_status_code, :string
    member :client_system_code, :string
    member :denied_ansi_code, :string
    member :denied_claim_status_code, :string
    member :denied_client_system_code, :string
    member :group_code, :string
    member :site_number, :string
    member :reporting_activity_code, :string
    member :reporting_activity_code2, :string
    member :id, :integer
  end
end