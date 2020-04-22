
# Display paths stats

## Prepare

Add this line to your application's Gemfile:

```ruby
group :development do
  gem 'r2-oas'
end
```

## Command

```bash
$ bundle exec rake routes:oas:paths_stats
```

## Example


```bash
$ bundle exec rake routes:oas:paths_stats
+----+--------------------------------------------------------+---------------------------+---------------------------+
|                                                     Paths Stats                                                     |
+----+--------------------------------------------------------+---------------------------+---------------------------+
| No | File Path                                              | Created At                | Updated At                |
+----+--------------------------------------------------------+---------------------------+---------------------------+
| 1  | oas_docs/schema/paths/user.yml                     | 2019-06-29 00:39:27 +0900 | 2019-06-29 01:20:33 +0900 |
+----+--------------------------------------------------------+---------------------------+---------------------------+
| 2  | oas_docs/schema/paths/api/v1/account_user_role.yml | 2019-06-29 00:28:56 +0900 | 2019-06-29 01:20:33 +0900 |
+----+--------------------------------------------------------+---------------------------+---------------------------+
| 3  | oas_docs/schema/paths/api/v1/user.yml              | 2019-06-29 00:28:56 +0900 | 2019-06-29 01:20:33 +0900 |
+----+--------------------------------------------------------+---------------------------+---------------------------+
| 4  | oas_docs/schema/paths/api/v1/account.yml           | 2019-06-29 00:28:56 +0900 | 2019-06-29 01:20:33 +0900 |
+----+--------------------------------------------------------+---------------------------+---------------------------+
| 5  | oas_docs/schema/paths/api/v1/task.yml              | 2019-06-29 00:28:56 +0900 | 2019-06-29 01:20:33 +0900 |
+----+--------------------------------------------------------+---------------------------+---------------------------+
| 6  | oas_docs/schema/paths/api/v1/post.yml              | 2019-06-29 00:28:56 +0900 | 2019-06-29 01:20:33 +0900 |
+----+--------------------------------------------------------+---------------------------+---------------------------+
| 7  | oas_docs/schema/paths/api/v2/custom_post.yml       | 2019-06-29 00:28:56 +0900 | 2019-06-29 01:20:33 +0900 |
+----+--------------------------------------------------------+---------------------------+---------------------------+
| 8  | oas_docs/schema/paths/api/v2/post.yml              | 2019-06-29 00:28:56 +0900 | 2019-06-29 01:20:33 +0900 |
+----+--------------------------------------------------------+---------------------------+---------------------------+
| 9  | oas_docs/schema/paths/task.yml                     | 2019-06-29 00:28:56 +0900 | 2019-06-29 01:20:33 +0900 |
+----+--------------------------------------------------------+---------------------------+---------------------------+
| 10 | oas_docs/schema/paths/rails_admin/engine.yml       | 2019-06-29 00:28:56 +0900 | 2019-06-29 01:20:33 +0900 |
+----+--------------------------------------------------------+---------------------------+---------------------------+
| 11 | oas_docs/schema/paths/rails_admin/main.yml         | 2019-06-29 00:28:56 +0900 | 2019-06-29 01:20:33 +0900 |
+----+--------------------------------------------------------+---------------------------+---------------------------+

Red: over 3 months since the last update.
```