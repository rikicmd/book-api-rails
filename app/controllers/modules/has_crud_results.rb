module Modules
  module HasCrudResults
    def __successList(queries)
      if self.class.page_type == "pagination"
        render json: {
          data: queries,
          total_pages: queries.total_pages,
          current_page: queries.current_page,
          next_page: queries.next_page,
          prev_page: queries.prev_page,
          total_count: queries.total_count
        }
      else
        render json: queries
      end
    end
  end
end
