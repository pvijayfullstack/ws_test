module ReasonCodeService
  class FootnoteCodeDto < ActionWebService::Struct
    member :code, :string
    member :description, :string

  end
end