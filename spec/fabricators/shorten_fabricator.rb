Fabricator(:shorten) do
  long_url { Faker::Internet.http_url }
  short_url { ('a'..'z').to_a.shuffle[0,8].join }
end
