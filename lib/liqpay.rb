require "liqpay/version"
require 'active_support/configurable'
require 'liqpay/client'
require 'liqpay/coder'
require 'liqpay/liqpay'

module Liqpay

  def self.init
    Liqpay.new(
      public_key: self.config.public_key,
      private_key: self.config.private_key
    )
  end

  def self.config
    @config
  end

  def self.configure(&block)
    yield @config ||= Configuration.new
  end
  # need a Class for 3.0
  class Configuration #:nodoc:
    include ActiveSupport::Configurable
    config_accessor :public_key
    config_accessor :private_key

    def param_name
      config.param_name.respond_to?(:call) ? config.param_name.call : config.param_name
    end

    # define param_name writer (copied from AS::Configurable)
    writer, line = 'def param_name=(value); config.param_name = value; end', __LINE__
    singleton_class.class_eval writer, __FILE__, line
    class_eval writer, __FILE__, line
  end
end
