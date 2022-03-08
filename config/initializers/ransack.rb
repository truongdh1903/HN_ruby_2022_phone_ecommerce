Ransack.configure do |config|
  config.add_predicate "date_gteq",
                       arel_predicate: "gteq",
                       formatter: proc {|v| v.to_date},
                       validator: proc {|v| v.present?},
                       type: :string
  config.add_predicate "datelteq",
                       arel_predicate: "lteq",
                       formatter: proc { |v| v.end_of_day },
                       type: :date
  config.search_key = :query
end
