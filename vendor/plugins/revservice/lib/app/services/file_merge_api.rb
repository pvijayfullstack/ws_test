class FileMergeApi < ActionWebService::API::Base
  api_method :send_report_merge_notification, :expects => [
    {:check_details => [FileMergeService::CheckDetails]},
    {:output_file_name => :string},
    {:total_payment_amount => :double},
    {:total_check_amount => :double},
  ]
  
  def api_key
    "file_merge_url"
  end
end