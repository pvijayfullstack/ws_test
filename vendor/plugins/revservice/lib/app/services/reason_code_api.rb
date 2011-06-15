class ReasonCodeApi < ActionWebService::API::Base
  inflect_names true
  api_method :ansi_code_update, :expects => [
      {:key => :string},
      {:items => [ReasonCodeService::AnsiCodeItem]},
  ] , :returns => [ReasonCodeService::AnsiCodeResponse]
  
  api_method :reason_code_update, :expects => [
      {:key => :string},
      {:parameter => ReasonCodeService::ReasonCodeParameter},
  ] , :returns => [ReasonCodeService::ReasonCodeResponse]
  
  api_method :footnote_code_lookup, :expects => [
      {:key => :string},
      {:description => :string},
      {:payer_id  => :string},
      {:gateway => :string},
      {:original_payer => :string},
      {:original_gateway => :string},
  ] , :returns => [ReasonCodeService::FootnoteResponse]
end