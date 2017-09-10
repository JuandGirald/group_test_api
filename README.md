# Project Title

This is a Group Event creator for Whitespectre

## Installing

Inside your project, run this command:

```
Bundle install
```
## Database

The project use PostgreSQL as database. Setup your local database and modify database.yml file with your credentials, then run:

```
rake db:migrate
```

then run:

```
rails server
```


## Running the tests

Before run the specs you must run the following command:

```
rake db:test:load
```

And then, run the tests!

```
rspec
```

## Api Endpoint

You will find an API documentation at the following url in your local with all the enpoints and specifications for each one.

```
http://localhost:3000/apidoc
```

## Authors

* **Juan David Giraldo** - *Initial work* - [JuanGiraldo](https://github.com/JuandGirald)

