# Rails api demo

## Usage

```ruby
    api_pages GET /api/pages
    POST /api/pages
    api_page GET /api/pages/:id
    PUT /api/pages/:id
    DELETE /api/pages/:id

    # Return a list of published pages sorted published_on DESC
    published_api_pages GET /api/pages/published

    # Return a list of unpublished pages sorted by published_on DESC
    unpublished_api_pages GET /api/pages/unpublished

    # Set a Page to published immediately (ie. current timestamp)
    publish_api_page POST /api/pages/:id/publish

    # Return the total number of words (title and content) for the given page
    total_words_api_page GET /api/pages/:id/total_words
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
