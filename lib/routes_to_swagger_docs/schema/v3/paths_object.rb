require_relative 'base_object'
require_relative 'path_item_object'

module RoutesToSwaggerDocs
  module Schema
    module V3
      class PathsObject < BaseObject
        def initialize(routes_data)
          @routes_data = routes_data
          @paths = {}
        end
  
        def to_doc
          paths.each_with_object({}) do |(path, path_item_object), docs|
            docs[path] = path_item_object.to_doc
          end
        end
  
        private
        
        attr_accessor :routes_data
  
        def paths
          # e.x.) 
          # [
          #  { path: "/tasks", data: {:verb=>"get", :path=>"/tasks", :tag_name=>"task" } },
          # ]
          routes_data.each_with_object({}) do |(route_el), data|
            path = route_el[:path]
            route_data = route_el[:data]
            data[path] = PathItemObject.new(route_data)
          end
        end
      end
    end
  end
end