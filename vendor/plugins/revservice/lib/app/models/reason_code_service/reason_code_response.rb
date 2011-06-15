module ReasonCodeService
  class ReasonCodeResponse < WebService::Response
    member :reason_code, :string
    member :walk_results, [CrosswalkItemResult]

  end
end