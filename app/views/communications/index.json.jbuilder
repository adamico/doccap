json.array!(@communications) do |communication|
  json.extract! communication, :titre
  json.url communication_url(communication, format: :json)
end
