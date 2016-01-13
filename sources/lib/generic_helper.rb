def return_resource object: nil
  if object
    respond_to do |type|
      
      type.html do
        'enter view code here'
      end
      
      type.json do
        clazz = object.class.to_s.downcase
        clazz = if clazz[/([\S]+)::/]
                  clazz = /([\S]+)::/.match(clazz)[1].pluralize
                else
                  clazz
                end
        json clazz => object
      end
    
    end
  end
end
