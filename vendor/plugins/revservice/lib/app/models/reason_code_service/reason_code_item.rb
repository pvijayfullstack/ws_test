module ReasonCodeService
  class ReasonCodeItem < ActionWebService::Struct
    member :reason_code, :string
    member :learn_date, :string
    member :description, :string
    member :crosswalk_items, [CrosswalkItem]
    
  end
end
