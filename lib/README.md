```ruby
record = Model.find(params[:id])

<%= render component(**record.attributes) %>
```
