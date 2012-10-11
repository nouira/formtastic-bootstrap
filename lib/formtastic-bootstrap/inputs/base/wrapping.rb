module FormtasticBootstrap
  module Inputs
    module Base
      module Wrapping

        include Formtastic::Inputs::Base::Wrapping
        include FormtasticBootstrap::Inputs::Base::Timeish

        def bootstrap_wrapping(&block)
          if render_horizontal?
            control_group_div_wrapping do
              control_label_html <<
                  horizontal_input_div_wrapping do
                    if options[:prepend]
                      prepended_input_wrapping do
                        [template.content_tag(:span, options[:prepend], :class => 'add-on'), yield, hint_html].join("\n").html_safe
                      end
                    else
                      [yield, hint_html].join("\n").html_safe
                    end
                  end
            end
          else
            control_group_wrapping do
              control_label_html <<
                  controls_wrapping do
                    if options[:prepend]
                      prepended_input_wrapping do
                        [template.content_tag(:span, options[:prepend], :class => 'add-on'), yield, hint_html].join("\n").html_safe
                      end
                    else
                      [yield, hint_html].join("\n").html_safe
                    end
                  end
            end
          end
        end

        def control_group_wrapping(&block)
          template.content_tag(:div,
                               [template.capture(&block), error_html].join("\n").html_safe,
                               wrapper_html_options
          )
        end

        def controls_wrapping(&block)
          template.content_tag(:div, template.capture(&block).html_safe, controls_wrapper_html_options)
        end

        def controls_wrapper_html_options
          {
              :class => "controls"
          }
        end

        def wrapper_html_options
          super.tap do |options|
            options[:class] << " control-group"
          end
        end

        def control_group_div_wrapping(&block)
          template.content_tag(:div, control_group_wrapper_html_options) do
            yield
          end
        end

        def control_group_wrapper_html_options
          opts = options[:wrapper_html] || {}
          opts[:class] ||= []
          opts[:class] = [opts[:class].to_s] unless opts[:class].is_a?(Array)
          opts[:class] << as
          opts[:class] << "control-group"
          # opts[:class] << "input"
          opts[:class] << "error" if errors?
          opts[:class] << "optional" if optional?
          opts[:class] << "required" if required?
          opts[:class] << "autofocus" if autofocus?
          opts[:class] = opts[:class].join(' ')

          opts[:id] ||= wrapper_dom_id

          opts
        end

        def horizontal_input_div_wrapping(inline_or_block_errors = :inline)
          template.content_tag(:div, :class => "input controls") do
            [yield, error_html(inline_or_block_errors), hint_html(inline_or_block_errors)].join("\n").html_safe
          end
        end

        def render_horizontal?
          !(@builder.options[:html][:class] =~ /form-horizontal/).nil?
        end

        # Bootstrap prepend feature
        def prepended_input_wrapping(&block)
          template.content_tag(:div, :class => 'input-prepend') do
            yield
          end
        end
      end
    end
  end
end