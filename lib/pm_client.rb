
require 'net_http_client_patch'
  
class GreetAPI < ActionWebService::API::Base
  api_method :sayGreetings, :expects =>[{"strName"=>:string}], :returns => [:string]
end

def build_proxy_url
    user_name = "nbsyuyg"
    password = "br549nbs"
    #host = "171.156.66.181"
    host = "127.0.0.1"
    port = "8080"
    
    protocol = "http"
    # http://PROXY_USERNAME:PROXY_PASSW...@proxy.server.com:80
    if host.blank? or protocol.blank?
      raise Exception "Proxy Requires protocol and host"
    end
    proxy = ""
    proxy += "#{protocol}://"
    proxy += "#{user_name}" unless user_name.blank?
    proxy += ":#{password}" unless password.blank?
    proxy += "@" unless user_name.blank?
    proxy += "#{host}"
    proxy += ":#{port}/"unless port.blank?
    proxy
    
end
def service_call
  
  puts "Calling Web Services"
  service_url = "http://localhost:3000/payer_mapping_service/api"
  #proxy_url = build_proxy_url
  opts = {}
  #opts["protocol.http.basic_auth"] = [service_url, user_name, password]
  #opts['protocol.http.proxy'] = proxy_url
  puts "Service URL\n\t#{service_url}"
  #puts "Proxy URL:\n\t#{proxy_url}"
  puts "\n\n"
  soap_client = ActionWebService::Client::Soap.new(PayerMappingApi,
                service_url, :driver_options => opts)
  puts soap_client.update_edc_payer_mapping "Ncc1701", nil
end
  
service_call