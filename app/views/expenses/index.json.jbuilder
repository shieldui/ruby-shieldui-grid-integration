json.array!(@expenses) do |expense|
  json.extract! expense, :id, :date, :title, :amount
  json.url expense_url(expense, format: :json)
end
