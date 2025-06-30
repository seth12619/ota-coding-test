# OTA Coding Challenge

## Requirements

- Ruby 3.x
- Rails 8.x
- PostgreSQL (running locally or via Ubuntu)

## Setup Instructions

1. **Install dependencies:**
   ```sh
   bundle install
   ```

2. **Configure your database:**
   - Ensure PostgreSQL is running and you have a user with createdb privileges.
   - Edit `config/database.yml` if needed for your local setup.

3. **Set up the database:**
   ```sh
   bin/rails db:setup
   # or, if you want to reset:
   bin/rails db:migrate:reset && bin/rails db:seed
   ```

4. **Run the application:**
   ```sh
   bin/rails s
   ```
   The app will be available at [http://localhost:3000](http://localhost:3000)

5. **Using the app:**
   - The root page will redirect you to a cart where you can add items and see the summary with pricing rules applied.

6. **Run the test suite:**
   ```sh
   bin/rspec
   ```

## Notes

- Make sure PostgreSQL is running before starting the Rails server.
- For Ubuntu users, you may want to add `sudo service postgresql start` to your shell profile for convenience.

---
For any issues, please check the code comments or contact the author.
