module Api
  module V1
    class AuthorsController < Modules::BaseCrud
      self.model = Author
      self.store_validation = {
        name: [ :required, length: { min: 3, max: 15 } ]
      }
    end
  end
end
