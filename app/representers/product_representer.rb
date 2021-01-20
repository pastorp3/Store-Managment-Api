class ProductRepresenter< Api::V1::ProductsController 
	def initialize(product)
		@product = product
	end

	def as_json
			{
				id: product.id,
				name: product.name,
				price: product.price,
				stock: product.stock
			}
		
	end

	private

	attr_reader :product


end