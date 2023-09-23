
# Doctor-Patient Appointment API

Welcome to the Doctor-Patient Appointment API, a Ruby on Rails application that allows patients to schedule appointments with doctors for various medical services. This API is designed to manage appointments, prescriptions, services, user authentication, and email confirmations.


## Features

- **User Authentication:** Patients are required to sign up and log in before booking an appointment.
- **Prescriptions:** Doctor(Admin) can add Prescriptions.
- **Service Selection:** Users can select from various medical services when booking an appointment.
- **Working Hours:** Appointments can only be booked during specified working hours (8 am to 5 pm).
- **Email Confirmation:** Users receive a confirmation email after successfully booking an appointment.
- **Admin Dashboard:** Admin users can view and manage all appointments, with the ability to mark them as fulfilled or missed.

## Getting Started

1. **Clone the Repository**: Start by cloning the repository of the Rails application from GitHub. You can use the `git clone` command followed by the repository URL. For example:
   ```
   git clone git@github.com:username/repository.git
   ```

2. **Install Dependencies**: Once the repository is cloned, navigate into the project directory and install the required dependencies. This can be done using the `bundle install` command. It will read the `Gemfile` in the project and install the necessary gems.
   ```
   cd repository
   bundle install
   ```

3. **Set Up the Database**: If the Rails application uses a database, you may need to set it up. Run the necessary database migrations using the `rake db:migrate` command. This will create the required tables and schema in the database.
   ```
   rake db:migrate
   ```

4. **Start the Rails Server**: Finally, you can start the Rails server to run the application locally. Use the `rails server` command or its shorthand `rails s`. This will start the server, and you can access the application in your browser at `http://localhost:3000`.
   ```
   rails server
   ```

### Prerequisites

Before getting started, ensure you have the following prerequisites installed on your system:

- Ruby (version >= 2.6)
- Ruby on Rails (version >= 5.2)
- PostgreSQL (for the database)
- SendGrid or SMTP settings for email notifications (configured in `config/environments/development.rb` and `config/environments/production.rb`)

## Usage

To use the API, you can make HTTP requests to the provided endpoints. Here's an overview of the available endpoints and their functionality.

## Endpoints

- **Registering new patients:**
  - `POST /api/users/signup`: Sign up as a new user.
  - `POST /api/users/login`: Log in as an existing user.

  - **Retrieving patient information:**
  - `GET /api/users`: Retrieve a list of patients.

- **Scheduling appointments:**
  - `GET /api/appointments`: Retrieve a list of appointments.
  - `POST /api/appointments`: Create a new appointment.
  - `PATCH /api/appointments/:id/mark_as_fulfilled`: Mark an appointment as fulfilled (admin only).
  - `PATCH /api/appointments/:id/mark_as_missed`: Mark an appointment as missed (admin only).

- **Managing patient prescriptions:**
  - `POST /api/prescriptions`: Add medical Prescriptions.

- **Services:**
  - `POST /api/services`: Add medical services.

## Authentication

- Patients must sign up and log in to access appointment-related functionality.
- Admin users are identified by a special flag in their user profile.
- Admin users can access additional actions, such as marking appointments as fulfilled or missed.

## Email Notifications

- Users receive a confirmation email after successfully booking an appointment.
- Configure email settings and templates in `config/environments/development.rb` and `config/environments/production.rb`.

## Testing

To run tests, use the following command:

```bash
rspec
```

## Authors

John Okari.
ex. John Okari

Live github link: https://github.com/JohnOkari/Damu-Sasa-Backend-Developer-Hackathon
 
## Licence
MIT License

Copyright (c) [2023] [John Okari]

