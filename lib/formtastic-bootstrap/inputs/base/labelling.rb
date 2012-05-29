module FormtasticBootstrap
  module Inputs
    module Base
      module Labelling

        include Formtastic::Inputs::Base::Labelling

        def label_html_options
          {}.tap do |opts|
            opts[:for] ||= input_html_options[:id]
            opts[:class] = [opts[:class]]
            if render_horizontal?
              opts[:class] << "control-label"
            end
          end
        end

      end
    end
  end
end