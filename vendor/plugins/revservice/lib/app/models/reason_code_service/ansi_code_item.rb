module ReasonCodeService
  class AnsiCodeItem < ActionWebService::Struct
    member :action, :string
    member :ansi_code, :string
    member :description, :string
    member :id, :integer
    
  end
end