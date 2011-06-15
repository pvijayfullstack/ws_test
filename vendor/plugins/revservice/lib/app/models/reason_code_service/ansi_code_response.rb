module ReasonCodeService
  class AnsiCodeResponse < WebService::Response
    member :results, [AnsiCodeItemResult]
  end
end