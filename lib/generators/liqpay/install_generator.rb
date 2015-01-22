require 'rails/generators/base'

module Liqpay
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path("../../templates", __FILE__)

      def copy_initializer
        template "liqpay.rb", "config/initializers/liqpay.rb"
      end

    end
  end
end
