module Thin
  class Connection < EventMachine::Connection
    thin_receive_data = self.instance_method(:receive_data)
    attr_accessor :uuid
    
    define_method(:receive_data) do |data|
      uuid = data.scan(/\"uuid\"\r\n\r\n(.*)/i)
      @uuid = uuid.first if !@uuid.blank? && !uuid.empty?

      if @uuid        
        @sizee ||= 0
        @sizee += data.size
        puts "#{@sizee}- Max #{@request.content_length}"      

        puts "Progress #{Thin::Server::progress[@uuid]}"
        Thin::Server::progress[@uuid] = 0 unless Thin::Server::progress[@uuid]
        Thin::Server::progress[@uuid] += @sizee
      end
      
      @request.env.merge!('rack.progress' => Thin::Server::progress)
      thin_receive_data.bind(self).call(data)
    end
  end
  
end