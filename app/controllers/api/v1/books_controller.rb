module Api
  module V1
    class BooksController < Modules::BaseCrud
      @model = Book
      @store_validation = {
        name: [ :required, length: { min: 3 } ],
        author: [ :required, length: { min: 4, max: 10 } ]
      }

      def __beforeStore
        puts "=========BEFORE=========="
        puts self.class.row
      end

      def __afterStore
         puts "=========AFTER=========="
        puts self.class.row
      end
    end
  end
end
