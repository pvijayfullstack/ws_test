class ControlledReleaseServiceController < ApplicationController
  web_service_api ControlledReleaseApi
  #wsdl_service_name 'ControlledRelease'


  def control_release_update(authorization_key, associate)
    associate.posting_check_number
  end
  
end
