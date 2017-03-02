module Display

  module InstanceMethods
    # extend ActiveSupport::Concern

    def wordify
      self.class.name.downcase
    end

  end
end
