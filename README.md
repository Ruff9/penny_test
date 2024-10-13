# Penny test

Cookbook app built for the Pennylane tech test, following [this spec](https://gist.github.com/quentindemetz/2096248a1e8d362e669350700e1e6add)

The app is deployed here : [penny-test.osc-fr1.scalingo.io](https://penny-test.osc-fr1.scalingo.io/)

## User stories

- A user can access to a list of recipes
- A user can filter that list by ingredients
- A user can read details about a recipe

### Possible improvements

- A user can filter the list just by clicking the checkboxes (no filter button)
- A user can keep the filters when he goes back to the home page from the detailed page

## Data structure

![Graph ERD](/docs/erd.png)

## Local setup

First you need to create a `.env` file at the root of the project, following `.env.sample` model.

In this file you will need a database url on this format :

```
DATABASE_URL=postgresql://user:password@localhost
```

To make it work, you need to have a local setup for PostgreSQL, and to report in the `.env` file the user and password with sufficient privileges to create a database.

You can then run the following commands :

```
$ bundle install
$ rails db:setup
$ rails recipes:import
```

Once this setup is done, you can launch a local server with `$ rails s`, or the test suite with `$ rspec`. You can also launch guard, who will watch the files and start rspec and rubocop.