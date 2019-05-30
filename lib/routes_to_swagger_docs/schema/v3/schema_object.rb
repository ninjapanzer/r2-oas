require_relative '../../plugins/schema/v3/hookable_base_object'

module RoutesToSwaggerDocs
  module Schema
    module V3
      class SchemaObject < RoutesToSwaggerDocs::Plugins::Schema::V3::HookableBaseObject
        def create_doc
          result = {
            "type" => "object",
            "properties" => {
              "id" => {
                "type" => "integer",
                "format" => "int64"
              }
            } 
          }
          doc.merge!(result)
        end
      end
    end
  end
end