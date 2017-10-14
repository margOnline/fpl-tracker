# fpl-tracker
 
A small app that sends text alerts with information about the fantasy premier league.

## Setup

1.  In Terminal, go to your projects directory and clone the project:

        git clone git@github.com:margOnline/fpl-tracker.git

2.  Install gem dependencies:

        bundle install

3.  Save a copy of `env.example` as `.env`.
    Amend the values accordingly.

4.  Create and set up the databases:

        ruby database.rb

5.  Run the tests to make sure they pass with your environment:

        bundle exec rspec

## Running the app

        ruby tracker.rb

## Recognition
This app was based on a [tutorial](https://github.com/FanaHOVA/twilio-dfs-tracker/blob/master/Gemfile) by [Alessio Fanelli](https://github.com/FanaHOVA).
