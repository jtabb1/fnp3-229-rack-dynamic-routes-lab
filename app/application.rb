class Application

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    # Initialize the below for testing
    #  outside of rspec:
    Item.new("aa", 1.05)
    Item.new("bb", 2.10)

    if req.path.match(/items/)

      item_name = req.path.split("/items/").last
      item = Item.all.find{|et| et.name == item_name}
      resp.write "#{item.price}" if !!item

      resp.status = 400 unless !!item
      resp.write "Item not found" unless !!item
    else
      resp.status = 404
      resp.write "Route not found"
    end
    resp.finish
  end
end

=begin

The alternate solution provided by the official
solution is below.

I prefer it in the way that there are less conditional 
operations in it.

I may prefer my solution in the way that the holding
of the items is restricted to my revised Item class.


class Application

  @@items = [Item.new("Apples",5.23), Item.new("Oranges",2.43)]
  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/items/)
      item_name = req.path.split("/items/").last
      if item =@@items.find{|i| i.name == item_name}
        resp.write item.price
      else 
        resp.status = 400
        resp.write "Item not found"
      end
    else
      resp.status=404
      resp.write "Route not found"
    end
    resp.finish
  end

end

=end