# # frozen_string_literal: true

# #
# module Design
#   module Component
#     module AtomicDesign
#       module Molecules
#         class Form < Component
        
#           attr_accessor :model, :url, :method, :local
        
#           def call
#             form_with model: model || nil, url: url || nil, method: method || nil, builder: ApplicationComponent::FormBuilder, **attributes do
#               context || content
#             end
#           end
        
#         end
#       end
#     end
#   end
# end