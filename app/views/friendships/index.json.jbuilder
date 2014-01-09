json.array!(@friendships) do |friendship|
  json.extract! friendship, :id, :expert_id, :friend_id
  json.url friendship_url(friendship, format: :json)
end
