module WebService
  class Error < ActionWebService::Struct
    member :error_code, :string
    member :message, :string
  end
end
