# frozen_string_literal: true

# Kaminari専用
# https://github.com/kaminari/kaminari/blob/master/kaminari-core/lib/kaminari/models/page_scope_methods.rb
module AtomicDesign
  module Modules
    module Atoms # :nodoc:
      class Pagination < ::AtomicDesign::Modules::Base
        # == Layout
        default_layout class: '', aria: { label: 'Pages navigation' }

        # == Methods

        def call
          content_tag :nav, attributes do
            if context.total_pages >= 1
              concat(content_tag(:ul, class: 'pagination') do
                concat(content_tag(:li, class: 'page-item') do
                  concat(link_to(url_for(page: 1), class: 'page-link', aria: { label: 'Start' }) do
                    content_tag(:span, '«', aria: { hidden: true })
                  end)
                end)
                display_pages.each do |page|
                  html_class = 'page-item'
                  html_class += ' active' if page == context.current_page
                  concat(content_tag(:li, class: html_class) do
                    if page == context.current_page
                      concat(content_tag(:span, page, class: 'page-link'))
                    else
                      concat(link_to(page, url_for(page: page), class: 'page-link', aria: { label: 'Next' }))
                    end
                  end)
                end
                concat(content_tag(:li, class: 'page-item') do
                  concat(link_to(url_for(page: context.total_pages), class: 'page-link', aria: { label: 'End' }) do
                    content_tag(:span, '»', aria: { hidden: true })
                  end)
                end)
              end)
            end
          end
        end

        private

        DISPLAY_PAGE_NUM = 10

        def display_pages
          return (1..context.total_pages) if context.total_pages <= DISPLAY_PAGE_NUM

          half = DISPLAY_PAGE_NUM / 2
          if context.current_page <= half
            start_page = 1
            end_page = DISPLAY_PAGE_NUM
          elsif context.current_page > context.total_pages - half
            end_page = context.total_pages
            start_page = context.total_pages - DISPLAY_PAGE_NUM + 1
          else
            start_page = context.current_page - half
            end_page = context.current_page + half

            # DISPLAY_PAGE_NUMが偶数の場合
            end_page -= 1 if DISPLAY_PAGE_NUM.even?
          end

          (start_page..end_page)
        end
      end
    end
  end
end
