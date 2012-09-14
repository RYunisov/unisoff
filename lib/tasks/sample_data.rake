namespace :db do
  desc "Fill database with sample data"
  task :populate => :environment do
    Rake::Task['db:reset'].invoke

    admin = User.create!(:login => "Example User",
                         :email => "example@railstutorial.org",
                         :password => "foobar",
                         :password_confirmation => "foobar")
    admin.toggle!(:admin)

#    User.create!(:login => "Example User",
#                 :email => "example@railstutorial.org",
#                 :password => "foobar",
#                 :password_confirmation => "foobar")
    99.times do |n|
      login  = Faker::Name.name
      email = "example-#{n+1}@railstutorial.org"
      password  = "password"
      User.create!(:login => login,
                   :email => email,
                   :password => password,
                   :password_confirmation => password)
    end
  end
end
