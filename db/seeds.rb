admin = User.create(email: 'admin@example.com', password: '12345678', role: 'admin')

puts "Admin - email: admin@example.com | password: 12345678"

%w(joe sue fred mary ryan daniel jason marsh albert).each do |dev|
  User.create(
    email: dev+'@example.com',
    password: '12345678',
    role: 'developer'
  )
end

%w(Android IOS Ruby Java Python Testing).each do |name|
  Project.create(title: name)
end