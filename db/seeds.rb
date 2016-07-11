Array.new(20) do
  Expense.create(title: Faker::Lorem.sentence, date: Faker::Date.between(1.week.ago, Date.today), amount: Faker::Number.decimal(2))
end
