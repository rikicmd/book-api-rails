module Modules
  module HasPreparedData
    def __prepareParamsList
      self.class.page_type =  params[:type]  || "pagination"
      self.class.page = params[:page] || 1
      self.class.per_page = params[:per_page] || 10
      self.class.sort_by = params[:sort_by] || "asc"
      self.class.order_by = params[:order_by] || "id"
    end

    def __prepareSortAndLimit(query)
      query = query.order("#{self.class.order_by} #{self.class.sort_by}")

      if self.class.page_type == "pagination"
        query = query.page(self.class.page).per(self.class.per_page)
      else
        query = query.all
      end
    end

    def __prepareDataStore(data)
      data
    end
  end
end
