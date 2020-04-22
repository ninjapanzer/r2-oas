# R2-OAS

[![Build Status](https://travis-ci.org/yukihirop/r2-oas.svg?branch=master)](https://travis-ci.org/yukihirop/r2-oas)
[![Coverage Status](https://coveralls.io/repos/github/yukihirop/r2-oas/badge.svg)](https://coveralls.io/github/yukihirop/r2-oas)
[![Maintainability](https://api.codeclimate.com/v1/badges/f8c3846f350bb412fd63/maintainability)](https://codeclimate.com/github/yukihirop/r2-oas/maintainability)

Generate api docment(OpenAPI) side only from `Rails` routing.

Provides a rake command to help `generate` , `view` , and `edit` OpenAPI documents.

```bash
bundle exec rake routes:oas:docs    # generate
bundle exec rake routes:oas:ui      # view
bundle exec rake routes:oas:editor  # edit
bundle exec rake routes:oas:monitor # monitor
bundle exec rake routes:oas:dist    # distribute
bundle exec rake routes:oas:clean   # clean
bundle exec rake routes:oas:analyze # analyze
bundle exec rake routes:oas:deploy  # deploy
```

## 💎 Installation

Add this line to your application's Gemfile:

```ruby
group :development do
  gem 'r2-oas'
end
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install r2-oas

## 🔦 Requirements

If you want to view with `Swagger UI` or edit with `Swagger Editor`, This gem needs the following:

- [`swaggerapi/swagger-ui:latest` docker image](https://hub.docker.com/r/swaggerapi/swagger-ui/)
- [`swaggerapi/swagger-editor:latest` docker image](https://hub.docker.com/r/swaggerapi/swagger-editor/)
- [`chromedriver`](http://chromedriver.chromium.org/downloads)

If you do not have it download as below.

```
$ docker pull swaggerapi/swagger-editor:latest
$ docker pull swaggerapi/swagger-ui:latest
$ brew cask install chromedriver
```

## 🚀 Tutorial

After requiring a gem,

```bash
bundle exec routes:oas:docs
bundle exec routes:oas:editor
```

## 📖 Usage

All settings are optional. The initial value is as follows.

In your rails project, Write `config/environments/development.rb` like that:

```ruby
# default setting
R2OAS.configure do |config|
  config.version                            = :v3
  config.root_dir_path                      = "./oas_docs"
  config.schema_save_dir_name               = "src"
  config.doc_save_file_name                 = "oas_doc.yml"
  config.force_update_schema                = false
  config.use_tag_namespace                  = true
  config.use_schema_namespace               = false
  config.interval_to_save_edited_tmp_schema = 15
  # :dot or :underbar
  config.namespace_type                     = :underbar
  config.deploy_dir_path                    = "./deploy_docs"

  config.server.data = [
    {
      url: "http://localhost:3000",
      description: "localhost"
    }
  ]

  config.swagger.configure do |swagger|
    swagger.ui.image            = "swaggerapi/swagger-ui"
    swagger.ui.port             = "8080"
    swagger.ui.exposed_port     = "8080/tcp"
    swagger.ui.volume           = "/app/swagger.json"
    swagger.editor.image        = "swaggerapi/swagger-editor"
    swagger.editor.port         = "81"
    swagger.editor.exposed_port = "8080/tcp" 
  end

  config.use_object_classes = {
    info_object:                    R2OAS::Schema::V3::InfoObject,
    paths_object:                   R2OAS::Schema::V3::PathsObject,
    path_item_object:               R2OAS::Schema::V3::PathItemObject,
    external_document_object:       R2OAS::Schema::V3::ExternalDocumentObject,
    components_object:              R2OAS::Schema::V3::ComponentsObject,
    components_schema_object:       R2OAS::Schema::V3::Components::SchemaObject,
    components_request_body_object: R2OAS::Schema::V3::Components::RequestBodyObject
  }

  config.http_statuses_when_http_method = {
    get: {
      default: %w(200 422),
      path_parameter: %w(200 404 422)
    },
    post: {
      default: %w(201 422),
      path_parameter: %w(201 404 422)
    },
    patch: {
      default: %w(204 422),
      path_parameter: %w(204 404 422)
    },
    put: {
      default: %w(204 422),
      path_parameter: %w(204 404 422)
    },
    delete: {
      default: %w(200 422),
      path_parameter: %w(200 404 422)
    }
  }

  config.http_methods_when_generate_request_body = %w[post patch put]
  config.ignored_http_statuses_when_generate_component_schema = %w[204 404]

  config.tool.paths_stats.configure do |paths_stats|
    paths_stats.month_to_turn_to_warning_color = 3
    paths_stats.warning_color                  = :red
    paths_stats.table_title_color              = :yellow
    paths_stats.heading_color                  = :yellow
    paths_stats.highlight_color                = :magenta
  end
end
```

You can execute the following command in the root directory of rails.

```bash
$ # Generate docs
$ bundle exec rake routes:oas:docs                                                                        # Generate docs
$ PATHS_FILE="oas_docs/schema/paths/api/v1/task.yml" bundle exec rake routes:oas:docs    # Generate docs by specify unit paths

$ # Start swagger editor
$ bundle exec rake routes:oas:editor                                                                      # Start swagger editor
$ PATHS_FILE="oas_docs/schema/paths/api/v1/task.yml" bundle exec rake routes:oas:editor  # Start swagger editor by specify unit paths
$ # Start swagger ui
$ bundle exec rake routes:oas:ui                                                                          # Start swagger ui
$ PATHS_FILE="oas_docs/schema/paths/api/v1/task.yml" bundle exec rake routes:oas:ui      # Start swagger ui by specify unit paths
$ # Monitor swagger document
$ bundle exec rake routes:oas:monitor                                                                     # Monitor swagger document
$ PATHS_FILE="oas_docs/schema/paths/api/v1/task.yml" bundle exec rake routes:oas:monitor # Monitor swagger by specify unit paths

$ # Analyze docs
$ OAS_FILE="~/Desktop/swagger.yml" bundle exec rake routes:oas:analyze
$ # Clean docs
$ bundle exec rake routes:oas:clean
$ # Deploy docs
$ bundle exec rake routes:oas:deploy
$ # Distribute swagger document
$ bundle exec rake routes:oas:dist
$ # Distribute swagger document
$ PATHS_FILE="oas_docs/schema/paths/api/v1/task.yml" bundle exec rake routes:oas:dist # Distribute swagger document by specify unit paths
 
# Display paths list
$ bundle exec rake routes:oas:paths_ls
# Display paths stats
$ bundle exec rake routes:oas:paths_stats
```

## ❤️ Support Rails Version

- Rails (>= 4.2.5.1)

## ❤️ Support Ruby Version

- Ruby (>= 2.3.3p222 (2016-11-21 revision 56859) [x86_64-darwin18])

## ❤️ Support Rouging

- Rails Engine Routing
- Rails Normal Routing

## ❗️ Convention over Configuration (CoC)

- `tag name` represents `controller name` and determine `paths file name`.
  - For example, If `controller name` is `Api::V1::UsersController`, `tag_name` is `api/v1/user`. and `paths file name` is `api/v1/user.yml`

- `_` of `components/{schemas,requestBodies, ...} name` convert `/` when save file.
  - For example, If `components/schemas name` is `Api_V1_User`, `components/schemas file name` is `api/v1/user.yml`.
  - `_` is supposed to be used to express `namespace`.
  - format is `Namespace1_Namespace2_Model`.

- `.` of `components/{schemas,requestBodies, ...} name` convert `/` when save file.
  - For example, If `components/schemas name` is `api.v1.User`, `components/schemas file name` is `api/v1/user.yml`.
  - `.` is supposed to be used to express `namespace`.
  - format is `namespace1.namespace2.Model`.

## ⚙ Configure

we explain the options that can be set.

#### basic

|option|description|default|
|------|-----------|---|
|version|OpenAPI schema version| `:v3` |
|root_dir_path|Root directory for storing products.| `"./oas_docs"` |
|schema_save_dir_name|Directory name for storing swagger schemas|`"src"`|
|doc_save_file_name|File name for storing swagger doc|`"oas_doc.yml"`|
|force_update_schema|Force update schema from routes data|`false`|
|use_tag_namespace|Use namespace for tag name|`true`|
|use_schema_namespace|Use namespace for schema name|`true`|
|interval_to_save_edited_tmp_schema|Interval(sec) to save edited tmp schema|`15`|
|http_statuses_when_http_method|Determine the response to support for each HTTP method|omission...|
|http_methods_when_generate_request_body|HTTP methods when generate requestBody|`[post put patch]`|
|ignored_http_statuses_when_generate_component_schema|Ignore HTTP statuses when generate component schema|`[204 404]`|
|namespace_type|namespace for components(schemas/requestBodies) name| `underbar` |
|deploy_dir_path|deploy directory.|`"./deploy_docs"`|

#### server

|option|children option|description|default|
|------|---------------|-----------|-------|
|server|data|Server data (url, description) |[{ url: `http://localhost:3000`, description: `localhost` }] |

#### swagger

|option|children option|grandchild option|description|default|
|------|---------------|-----------------|-----------|-------|
|swagger|ui|image|Swagger UI Docker Image|`"swaggerapi/swagger-ui"`|
|swagger|ui|port|Swagger UI Port|`"8080"`|
|swagger|ui|exposed_port|Swagger UI Exposed Port|`"8080/tcp"`|
|swagger|ui|volume|Swagger UI Volume|`"/app/swagger.json"`|
|swagger|editor|image|Swagger Editor Docker Image|`"swaggerapi/swagger-editor"`|
|swagger|editor|port|Swagger Editor Port|`"8080"`|
|swagger|editor|exposed_port|Swagger Editor Exposed Port|`"8080/tcp"`|

#### hook

|option|description|default|
|------|-----------|-------|
|use_object_classes|Object class(hook class) to generate Openapi document|{ info_object: `R2OAS::Schema::V3::InfoObject`,<br>paths_object: `R2OAS::Schema::V3::PathsObject`,<br>path_item_object: `R2OAS::Schema::V3::PathItemObject`, external_document_object: `R2OAS::Schema::V3::ExternalDocumentObject`,<br> components_object: `R2OAS::Schema::V3::ComponentsObject`,<br> components_schema_object: `R2OAS::Schema::V3::Components::SchemaObject`, <br> components_request_body_object:`R2OAS::Schema::V3::Components::RequestBodyObject` }|

#### tool

|option|children option|grandchild option|description|default|
|------|---------------|-----------------|-----------|-------|
|tool|paths_stats|month_to_turn_to_warning_color|Elapsed month to issue a warning|`3`|
|tool|paths_stats|warning_color|Warning Color|`:red`|
|tool|paths_stats|table_title_color|Table Title Color|`:yellow`|
|tool|paths_stats|heading_color|Heading Color|`:yellow`|
|tool|paths_stats|highlight_color|Highlight Color|`:magenta`|

Please refer to [here](https://github.com/janlelis/paint) for the color.

## Environment variables

We explain the environment variables that can be set.

|variable|description|default|
|--------|-----------|-------|
|PATHS_FILE|Specify one paths file path|`""`|
|OAS_FILE|Specify swagger file path to analyze|`""`|


## .paths

Writing file paths in .paths will only read them.
You can comment out with `#`

`oas_docs/.paths`

```
#account_user_role.yml    # ignore
account.yml
account.yml               # ignore
account.yml               # ignore
```

## 🔩 CORS

Use [rack-cors](https://github.com/cyu/rack-cors) to enable CORS.

```ruby
require 'rack/cors'
use Rack::Cors do
  allow do
    origins '*'
    resource '*', headers: :any, methods: [ :get, :post, :put, :delete, :options ]
  end
end
```

Alternatively you can set CORS headers in a `before` block.

```ruby
before do
  header['Access-Control-Allow-Origin'] = '*'
  header['Access-Control-Request-Method'] = '*'
end
```

## 📝 License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## 🤝 Contributing

1. Fork it ( http://github.com/yukihirop/r2-oas/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request