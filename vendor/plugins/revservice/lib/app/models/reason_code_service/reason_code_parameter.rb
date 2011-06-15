module ReasonCodeService
  class ReasonCodeParameter < ActionWebService::Struct
    member :data, [ReasonCodeItem]
    member :legacy_code_set_name, :string
  end
end