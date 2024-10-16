module Modules
  class BaseCrud < ApplicationController
    include Validator
    include HasCrudHooks
    include HasPreparedData
    include HasCrudResults

    class << self
      attr_accessor :model,
                    :store_validation,
                    :request_data,
                    :row,
                    :page_type,
                    :per_page,
                    :page,
                    :sort_by,
                    :order_by
    end

    def index
      __prepareParamsList
      query = __prepareSortAndLimit self.class.model
      __successList query
    end

    def show
      query = self.class.model.find(params[:id])
      render json: query
    end

    def create
      validate = validate self.class.store_validation

      return render json: validate if validate.length > 0

      self.class.request_data = JSON.parse request.body.read

      __beforeStore

      data = model_params

      data = __prepareDataStore data

      self.class.row = self.class.model.new data

      if self.class.row.save

        self.class.row = self.class.row.to_json

        __afterStore

        render json: self.class.row
      else
        render json: self.class.row.errors, status: :unprocessable_entity
      end
    end

    private

    def model_params
      params.require(self.class.model.to_s.underscore.to_sym).permit!
    end
  end
end
