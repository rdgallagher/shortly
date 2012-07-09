Fabricator(:user) do
  user_password = ('a'..'z').to_a.shuffle[0,8].join

  email { Faker::Internet.email }
  password { user_password }
  confirm_password { user_password }
end
