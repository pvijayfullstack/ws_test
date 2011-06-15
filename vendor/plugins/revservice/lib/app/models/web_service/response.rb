module WebService
  class Response < ActionWebService::Struct
    member :error, Error
    member :success, :boolean
  end
end