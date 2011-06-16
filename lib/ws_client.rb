require 'net/http'


module SOAP


class NetHttpClient
  
  

  def start(url)
    http = create_connection(url)
    response = nil
    http.start { |worker|
      response = yield(worker)
      worker.finish
    }
    @debug_dev << response.body if @debug_dev
    response
  end

  def create_connection(url)
    proxy_host = proxy_port = nil
    proxy_user = proxy_pass = nil
    proxy_auth = false
    unless no_proxy?(url)
      proxy_host = @proxy.host
      proxy_port = @proxy.port
      unless @proxy.userinfo.nil? or @proxy.userinfo == ""
        proxy_auth = true
        proxy_user = @proxy.userinfo.split(":")[0]
        proxy_pass = @proxy.userinfo.split(":")[1] 
      end
    end
    puts proxy_user
    if proxy_auth
      http = Net::HTTP::Proxy(proxy_host, proxy_port, proxy_user, proxy_pass).new(url.host, url.port)
    else
      http = Net::HTTP::Proxy(proxy_host, proxy_port).new(url.host, url.port)
    end
    
    if http.respond_to?(:set_debug_output)
      http.set_debug_output(@debug_dev)
    end
    http.open_timeout = @connect_timeout if @connect_timeout
    http.read_timeout = @receive_timeout if @receive_timeout
    case url
    when URI::HTTPS
      if SSLEnabled
	http.use_ssl = true
      else
	raise RuntimeError.new("Cannot connect to #{url} (OpenSSL is not installed.)")
      end
    when URI::HTTP
      # OK
    else
      raise RuntimeError.new("Cannot connect to #{url} (Not HTTP.)")
    end
    http
  end

end
end
  
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
  service_url = "https://dev-hlsc.bankofamerica.com/HealthLogicServices/services/SampleWebService"
  proxy_url = build_proxy_url
  opts = {}
  #opts["protocol.http.basic_auth"] = [service_url, user_name, password]
  opts['protocol.http.proxy'] = proxy_url
  puts "Service URL\n\t#{service_url}"
  puts "Proxy URL:\n\t#{proxy_url}"
  puts "\n\n"
  soap_client = ActionWebService::Client::Soap.new(GreetAPI,
                service_url, :driver_options => opts)
  puts soap_client.sayGreetings " Allan"
end
  
service_call