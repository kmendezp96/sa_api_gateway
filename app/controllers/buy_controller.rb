class BuyController < ApplicationController

  def error(message, code, description)
    render status: code,json: {
      message: message,
      code: code,
      description: description
    }
  end

  def sale
      @product = params[:product_id]
      @user = params[:user_id]
      result_product = checkProduct(@product)
      result_user = checkUser(@user)
      if result_product.include? "stock" and result_user.include? "firstName"
        if result_product['stock'] > 0
          options = {
              :body => {
              :product_id => @product,
              :user_id => @user
            }.to_json,
            :headers => {
            'Content-Type' => 'application/json'
            }
          }
          results = HTTParty.post("http://192.168.99.101:3002/sales", options)
          options = {
              :body => {
              :stock => result_product['stock'].to_f-1
            }.to_json,
            :headers => {
            'Content-Type' => 'application/json'
            }
          }
          head 201
          results = HTTParty.patch("http://192.168.99.101:3000/products/"+@product.to_s, options)
        else
          error("No content", 204, "Producto con stock insuficiente.")
        end
      else
        error("Bad Request", 400, "Petición incorrecta. No existe el producto o el usuario.")
      end
  end

  def salesbyUser
    @user = params[:user_id]
    result_user = checkUser(@user)
    if result_user.include? "firstName"
      results= HTTParty.get("http://192.168.99.101:3002/sales")
      data = results.parsed_response
      sales=[]
      data['list'].each do |item|
        if @user.to_f == item["user_id"]
          id_sale=item["id"]
          user_id= item["user_id"]
          product_id= item["product_id"]
          dataj={id: id_sale, product_id: product_id, user_id: user_id}
          sales.push(dataj)
        end
      end
      render json: {list: sales}
    else
      error("Bad Request", 400, "Petición incorrecta. No existe ese usuario")
    end
  end

  def checkProduct(id)
    results = HTTParty.get("http://192.168.99.101:3000/products/" + id.to_s)
    return results
  end

  def checkUser(id)
    results = HTTParty.get("http://192.168.99.101:3001/users/" + id.to_s)
    return results
  end
end
