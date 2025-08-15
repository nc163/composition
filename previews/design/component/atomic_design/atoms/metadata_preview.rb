# frozen_string_literal: true

#
module Design
  module Component
    module AtomicDesign
      module Atoms
        class MetadataPreview < ViewComponent::Preview
        
          # @!group default
        
          def plain
            render Metadata::UserName.new 'ユーザー'
          end
        
          def time
            render Metadata::Time.new Time.now
          end
        
          def date
            render Metadata::Date.new Date.today
          end
        
          def mail
            render Metadata::Mail.new 'admin@example.com'
          end
        
          def phone
            render Metadata::Phone.new '090-0123-4567'
          end
        
        end
      end
    end
  end
end