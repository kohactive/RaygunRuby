require "socket"

module RaygunRuby
  class RaygunMessage
    attr_accessor :occurredOn, :details
    def initialize
      self.occurredOn = Time.now.gmtime.strftime("%Y-%m-%d\T%H:%M:%S")
      self.details = RaygunMessageDetails.new
      self
    end
    def build(exception,env=nil)
      self.details.machineName = Socket.gethostname
      self.details.error = RaygunExceptionMessage.new(exception)
      self.details.request = RaygunRequestMessage.new(env)
      self.details.client = RaygunClientMessage.new
      self
    end
    def to_json
      {
        "Details" => self.details.to_json,
        "OccurredOn" => self.occurredOn
      }.to_json
    end
  end
end