json.extract! comic, :id, :title, :issue, :publisher, :created_at, :updated_at
json.url comic_url(comic, format: :json)