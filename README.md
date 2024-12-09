# Sleep Tracker

The **Sleep Tracker** application allows users to log their sleep schedules, follow other users, and view the sleep patterns of their connections. This is a RESTful API built with Ruby on Rails.

## Features

- **Clock In and Clock Out:** Track when users go to bed and wake up.
- **Follow/Unfollow Users:** Manage a list of connections to share and view sleep records.
- **Sleep Insights:** Retrieve and sort sleep records of followed users by duration.


## Installation

### Prerequisites
- Ruby 3.0+
- Rails 7.0+
- PostgreSQL

### Steps
1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/good-night-tracker.git
   cd good-night-tracker
   ```

2. Install dependencies:
   ```bash
   bundle install
   ```

3. Modify the database configuration in `config/database.yml` to use your PostgreSQL credentials. 

4. Set up the database:
   ```bash
   rails db:create
   rails db:migrate
   rails db:seed
   ```

5. Start the server:
   ```bash
   rails s
   ```

## API Endpoints

### Authentication
- **API Key**: All requests require an `Authorization` header with a valid API key.

### Sleep Records
- **POST** `/api/v1/sleep_records`: Clock in a new sleep record.
- **PUT** `/api/v1/sleep_records/clock_out`: Clock out the latest sleep record.
- **GET** `/api/v1/sleep_records`: Retrieve all sleep records for the logged-in user.
- **GET** `api/v1/sleep_records/following`: View sleep records of followed users, sorted by duration.

### User Management
- **POST** `/api/v1/users/:id/follow`: Follow a user.
- **DELETE** `/api/v1/users/:id/unfollow`: Unfollow a user.


## Running Tests
Run the test suite using RSpec:
```bash
bundle exec rspec
```
