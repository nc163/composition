# frozen_string_literal: true

require "active_support/concern"
require "active_support/dependencies/autoload"
require_relative "property/version"

module Property # :nodoc:
  extend ActiveSupport::Autoload

  eager_autoload do
    # Class
    autoload :Function
    autoload :Register
    autoload :Dispacher
    autoload :Resolver
    autoload :Handler
    # Module
    autoload :Functions
    # autoload :Helpers
  end


  extend ActiveSupport::Concern
  include Functions

  included do
    prepend InstanceMethods

    # unless instance_variable_defined?(:@property_helper_included)
    #   instance_variable_set(:@property_helper_included, true)
    #   self.prepend(AtomicDesign::Extensions::Property::Helpers.initializer)
    # end
    class << self
      def inherited(klass)
        klass.prepend(Property::InstanceMethods)
        super
      end
    end
  end

  module ClassMethods
    # def inherited(klass)
    #   super
    #   klass.prepend(AtomicDesign::Extensions::Property::Helpers::InstanceMethods)
    # end
  end

  module InstanceMethods
    def initialize(*args, **kwargs, &block)
      if respond_to?(:property_register)
        @property_resolver  = Property::Resolver.new(register: property_register)
        @property_dispacher = Property::Dispacher.new(register: property_register)
        @property_handler   = Property::Handler.new(register: property_register, resolver: @property_resolver, dispacher: @property_dispacher)
        @property_handler.dispatch(**kwargs)
      end

      super
    end
  end

  def state(name)
    @property_handler.invoke(name)
  end

  # HTML属性
  def html_options
    @property_handler.html_options
  end

  private

  # プロパティではない場合は、再度method_missingを呼び出す
  def method_missing(called, *args, **kwargs, &block)
    if @property_handler.invokable?(called)
      if args.empty? && kwargs.empty? && !block_given?
        @property_handler.invoke(called.to_sym)
      else
        raise ArgumentError, "Invalid arguments for property #{called}"
      end
    else
      super(called, *args, **kwargs, &block)
    end
  end


end
