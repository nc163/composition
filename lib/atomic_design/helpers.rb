# frozen_string_literal: true

module AtomicDesign
  # = AtomicDesign Helpers
  module Helpers
    extend ActiveSupport::Autoload

    autoload :Components

    # def self.eager_load!
    #   super
    #   Components.eager_load!
    # end
     
    extend ActiveSupport::Concern
    include ComponentHelper
    include 
    
  end
end