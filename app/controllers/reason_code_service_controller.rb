class ReasonCodeServiceController < ActionController::Base
  web_service_api ReasonCodeApi
  
  def ansi_code_update(key, items)
    
  end
  
  def reason_code_update(key, parameter)
  end
  
  def footnote_code_lookup(key, description, payer_id, gateway, original_payer, original_gateway)
    rsp = ReasonCodeService::FootnoteResponse.new
    rsp.success = true
    rsp
  end
  
end
