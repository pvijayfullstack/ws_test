  class GreetAPI < ActionWebService::API::Base
    api_method :sayGreetings, :expects =>[{"strName"=>:string}], :returns => [:string]
  end
  
  def build_proxy_url
      user_name = "nbsyuyg"
      host = "171.156.66.181"
      port = "8080"
      password = "br549nbs"
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
      proxy += ":#{port}"unless port.blank?
      proxy
      
  end
  def call
    soap_client = ActionWebService::Client::Soap.new(GreetAPI,
                  "https://dev-hlsc.bankofamerica.com/HealthLogicServices/services/SampleWebService",
                  :proxy => build_proxy_url)
    puts soap_client.sayGreetings " Allan"
  end
  