module ReasonCodeService
  class CrosswalkItemResult < ActionWebService::Struct
    member :success, :boolean
    member :error_code, :string
    member :error_message, :string
    member :source_id, :string
  end
end
