module ReasonCodeService
  class FootnoteResponse < WebService::Response
    member :footnote, FootnoteCodeDto
  end
end