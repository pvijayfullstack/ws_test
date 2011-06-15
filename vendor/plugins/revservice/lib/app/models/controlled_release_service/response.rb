module ControlledReleaseService
  class Response < WebService::Response
    member :association_id, :double
    member :items, [AssociateItemResult]

     
  end
end