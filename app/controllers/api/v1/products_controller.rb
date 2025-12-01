class Api::V1::ProductsController < Api::BaseController
  before_action :authenticate_partner!
  def index
    @products = Product.all
    render json: @products
  end

  def show
    @product = Product.find_by(c10: params[:c10])
    render json: @product
  end

  private

  def product_params
    params.require(:product).permit(:c10)
  end
end
