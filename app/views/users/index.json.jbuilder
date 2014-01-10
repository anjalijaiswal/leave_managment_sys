json.array!(@users) do |user|
  json.extract! user, :id, :name, :user_time, :leave
  json.url user_url(user, format: :json)
end
