

class ControlledReleaseApi < ActionWebService::API::Base
  inflect_names true
  api_method :control_release_update, :expects => [
      {:key => :string},
      {:associate => ControlledReleaseService::AssociateParameter},
  ] , :returns => [ControlledReleaseService::Response]
end
