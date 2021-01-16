class ProductsRepresenter< Api::V1::ProductsController 
	def initialize(products)
		@products = products
	end

	def as_json
		products.map do |product|
			{
				name: product.name,
				price: product.price,
				stock: product.stock
			}
		end
	end

	private

	attr_reader :products


end