module Revservice
  class PayerEncounterHelper < Base
    
    # This is a temporary code which needs to be replaced with original code of WS later. Now to simulate, we return static values.
    def self.get_edc_payer(aba_number, dda_number, payer_name, footnote_payer, payer_address)
      encounter = PayerEncounterHelper.new PayerEncounterApi
      encounter.key = "AP-WEBSERVICE-V01.00"
      
      encounter.call "getEDCPayer", aba_number, dda_number, payer_name, footnote_payer, payer_address
    end
    
    def self.get_eft_payer(company_id, payer_name)
      encounter = PayerEncounterHelper.new PayerEncounterApi
      params = []
      params << company_id
      params << payer_name
      encounter.call "get_eft_payer", params
    end
  
  end
end
