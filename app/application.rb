class Application

  @@items = [Item.new("Pencil", "1.99"),
            Item.new("Pen","2.99")]

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/items/)
      item_name = req.path.split("/items/").last #turn /songs/Sorry into Sorry
      item = @@items.find{|i| i.name == item_name}
      if item != nil
        resp.write item.price
      else
        resp.write "Item not found"
        resp.status = 400
      end
    else
      resp.write "Route not found"
      resp.status = 404
    end
    resp.finish
  end
end
