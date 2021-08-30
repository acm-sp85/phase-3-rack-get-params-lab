class Application

  @@items = ["Apples","Carrots","Pears"]
  @@cart = []

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/items/)
      @@items.each do |item|
        resp.write "#{item}\n"
      end
    elsif req.path.match(/search/)
      search_term = req.params["q"]
      resp.write handle_search(search_term)
    elsif req.path.match(/cart/) && @@cart.length > 0
      @@cart.each do |item|
        resp.write "#{item}\n"
      end
    elsif req.path.match(/cart/) && @@cart.length == 0
        resp.write "Your cart is empty"

    else req.path.match(/add/) 

      item_name = req.path.split("/songs/").last 

      item = @@items.find{|s| s == item_name}

      if(item == nil)
        resp.write "We don't have that item"
      elsif
        item = item_name.capitalize
        @@cart << item
        resp.write "added #{item}"

    else
      resp.write "Path Not Found"
    end
  end

    resp.finish
  end

  def handle_search(search_term)
    if @@items.include?(search_term)
      return "#{search_term} is one of our items"
    else
      return "Couldn't find #{search_term}"
    end
  end
  private

  # def params_id
  #   req.path.split("/add/").last
  # end
end
