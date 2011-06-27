class PayerEncounterServiceController < ApplicationController
  web_service_api PayerEncounterApi
  #wsdl_service_name 'PayerMapping'

  def getEDCPayer(authorizationKey,systemSourceCode, abaNumber, ddaNumber, payerName, footNotePayerInd, payerAddress )
    results = {}
    unless authorizationKey == 'NCC1701D'
      results['successIndicator'] = true
      results["errorCode"] = 0
      results['errorMessage'] = nil
      results['abaNumber'] = abaNumber
      results['ddaNumber'] = ddaNumber
      results['payerName'] = payerName
      results['originalGateway'] = "HLSC"
      results['originalPayerId'] = "UXZVD"
      results['footNotePayerInd'] = footNotePayerInd
      results['payerAddress'] = payerAddress
      
    end
    return results
    
  end
  
  def get_eft_payer(key, system_source_code, company_id, payer_name )
    
  end
end