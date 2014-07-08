if @tags.any?
  json.array! @tags do |tag|
    json.id tag
    json.text tag
  end
end
