# # Create services
# Service.create(specialist: 'Doctor', option: 'Consultation', duration: 20)
# Service.create(specialist: 'Doctor', option: 'Checkup', duration: 10)
# Service.create(specialist: 'Dentist', option: 'Checkup', duration: 15)
# # Add more services as needed

# Create users
User.create(name: 'John Doe', email: 'john@example.com', password: 'password', role: 'user')
User.create(name: 'Admin User', email: 'admin@example.com', password: 'adminpassword', role: 'admin')
# Add more users as needed

# Create appointments
user1 = User.find_by(email: 'john@example.com')
user2 = User.find_by(email: 'admin@example.com')

service1 = Service.find_by(option: 'Consultation')
service2 = Service.find_by(option: 'Checkup')

Appointment.create(user: user1, service: service1, start_time: DateTime.now + 1.day, end_time: DateTime.now + 1.day + 20.minutes, status: 'scheduled')
Appointment.create(user: user2, service: service2, start_time: DateTime.now + 2.days, end_time: DateTime.now + 2.days + 10.minutes, status: 'scheduled')
