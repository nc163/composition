# # frozen_string_literal: true

# #
# module AtomicDesign
#   module Components
#
#       module Molecules # :nodoc:
#         class Form < ::AtomicDesign::Components::Base

#           attr_accessor :model, :url, :method, :local

#           def call
#             form_with model: model || nil, url: url || nil, method: method || nil, builder: ApplicationComponents::FormBuilder, **attributes do
#               context || content
#             end
#           end

#         end
#       end
#     end
#   end
# end
