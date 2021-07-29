class Application

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    Item.new(name: "aa", price: 1.05)
    Item.new(name: "bb", price: 2.10)

    if req.path.match(/items/)

      item_name = req.path.split("/items/").last
      item = Item.all.find{|et| et.name == item_name}
      resp.write "#{item.price}" if !!item

      resp.status = 404 unless !!item
      resp.write error_out unless !!item
    else
      resp.status = 404
      resp.write error_out
    end
    resp.finish

    # Item.reset
  end

  def error_out
    # Can the below:
    #   resp.status = 404
    #  be set in a method outside of "call" ?
    "Route not found"
  end



end