module SOAP
module Mapping


class Factory
  
  def setiv2soap(node, obj, map)
    if obj.class.class_variables.include?('@@schema_element')
      obj.class.class_eval('@@schema_element').each do |name, info|
        type, qname = info
        if qname
          elename = qname.name
        else
          elename = Mapping.name2elename(name)
        end
        node.add(elename,
          Mapping._obj2soap(obj.instance_variable_get('@' + name), map))
      end
    else
      # should we sort instance_variables?
      obj.instance_variables.each do |var|
        name = var.sub(/^@/, '')
        elename = Mapping.name2elename(name.camelcase)
        node.add(elename,
          Mapping._obj2soap(obj.instance_variable_get(var), map))
      end
    end
  end
  
  def setiv2ary(obj, node, map)
    node.each do |name, value|
      Array.instance_method(:<<).bind(obj).call(Mapping._soap2obj(value, map))
    end
  end

  def setiv2struct(obj, node, map)
    vars = {}
    node.each do |name, value|
      vars[Mapping.elename2name(name.underscore)] = Mapping._soap2obj(value, map)
    end
    Mapping.set_attributes(obj, vars)
  end
end


end
end