json.array!(@users) do |user|
  json.extract! user, :id, :firstname, :lastname, :user_type, :school_id
  json.url user_url(user, format: :json)
end
