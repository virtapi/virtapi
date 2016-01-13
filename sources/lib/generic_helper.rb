def return_resource object: nil
  if object
    clazz = object.class.to_s
    clazz = if clazz[/([\S]+)::/]
              clazz = /([\S]+)::/.match(clazz)[1].pluralize
            else
              clazz
            end.underscore
    
    respond_to do |type|
      type.html do
        haml clazz.to_sym
      end
      
      type.json do
        json clazz => object
      end
    
    end
  end
end
