json.array!(@goals) do |goal|
  json.extract! goal, :id, :title, :due_date, :completed
  json.url goal_url(goal, format: :json)
end
