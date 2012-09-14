Factory.define :user do |user|
  user.login                  "Michael Hartl"
  user.email                 "mhartl@example.com"
  user.password              "foobar"
  user.password_confirmation "foobar"
end
Factory.sequence :email do |n|
  "person-#{n}@example.com"
end
