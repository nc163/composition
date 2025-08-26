# frozen_string_literal: true

module AtomicDesign
  module Modules
    module Atoms
      class PaginationPreview < ::AtomicDesign::Modules::Preview # :nodoc:
        # @!group default

        # @param page
        # @param per_page
        def default(page: 5, per_page: 10)
          paginated_users = WebPage.page(page).per(per_page)
          render Pagination.new(paginated_users)
        end

        # @param page
        def first_page(page: 1)
          paginated_users = WebPage.page(page).per(10)
          render Pagination.new(paginated_users)
        end

        # @param page
        def last_page(page: nil)
          total_pages = (WebPage.count / 10.0).ceil
          paginated_users = WebPage.page(page || total_pages).per(10)
          render Pagination.new(paginated_users)
        end

        # @param page
        def single_page(page: 1)
          paginated_users = WebPage.page(page).per(WebPage.count + 1)
          render Pagination.new(paginated_users)
        end
      end
    end
  end
end
