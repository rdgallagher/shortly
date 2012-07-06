Fabricator(:user) do
  email { Faker::Internet.email }
  password { ('a'..'z').to_a.shuffle[0,8].join }
  confirm_password { password }
end
