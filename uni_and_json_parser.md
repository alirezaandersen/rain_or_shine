
class Note
  def  initialize(path = nil)
   @uri = URI.parse(“#{Rails.config.notes_xml_service_root}/#{path}”)
end

   def get_response
   http = Net::HTTP.new(@uri.host, @uri.port)
   http.request(request).body
   end

   def request
   Net::HTTP::Get.new(@uri.request_uri)
   end

   end
