# 'List Jobs Sought' CRUD example website using create-react-ap

## This code is not running on heroku yet:

## Why I wrote this site:

* because I found the Rails 5.1 webpacker code was not asynchonous, so I am using the standard create-react-app setup.
* as a realistic example to teach myself react.js
* to develop a versioned api in the backend
* to work out deployment to localhost and/or heroku
* to work out best practice testing methods
* possibly make a tutorial on developing a react website with a rails api

## what this code demonstrates:

* Use of Rails 5 as a versioned API backend.
* Use of create-react-app configuration front-end for the standard react environment and to be asynchronous.
* Use of standard react environment for development, testing and production.
* My approaches to having maintainable documentation:
    * comments on major pieces of code, so documentation is next to the code.
    * Providing installation instruction as part of standard documentation.
    * Single place (this README.md) for Overview and installation instructions.
* My newly developed approaches to react coding standards/techniques.
* My newly developed approaches to testing react code.
* Testing and Development done side by side.
    * I find doing Test Driven Development problematic when working on new techniques.
    * My best practice is to get test coverage before and after coding:
        * to provide development to requirements (if possible).
        * to fill in edge cases with the tests.


## What this example site does and will do.
This website is designed to keep track of jobs applied for (and the recruiters that helped you find them). This is important, to ensure that you are not submitted to the same company by two different recruiters.

Future enhancements:
* will consider adding additional information about submission, such as date sent, job description, version of resume, additional materials sent, etc.
* May include Authentication with three roles, admin, recruiter, seeker. This could allow a recruiting firm to let their recruitees use this, while at the same time see what their recruitees have applied for.
* Will probably deploy on a server, such as Heroku for demonstration (and possible usage).



## Installation instructions for localhost:
- note: $ is the command prompt.

* download this repo as zip file and create the repo on local machine
    * $ https://github.com/tayloredwebsites/jobsCreateReactApp/archive/railsBackend.zip
    * unzip railsBackend.zip into your chosen directory
    * $ cd jobsCreateReactApp
* Note: Requires a version of ruby that can handle Rails 5.1.4. (I am using 2.3.5p376 using rbenv)
    * $ ruby -v
* Note: Requires PostgreSQL - for compatibility with Heroku deployment.
* Install Postgres on Mac (with command line tools):
    * download postgres.app and move into Application directory.
    * Note: To set up postgres path for command line tools on Mac.
    * Edit ~/.bash_profile and add the following to the end:
    * export PATH=$PATH:/Applications/Postgres.app/Contents/Versions/latest/bin
* Set up database in Postgres using command line:
    * create database job_search;
    * \list (to list all databases to confirm created).
    * create user job_search_ror with password 'password';
    * \du (to list users to confirm creation).
    * grant all privileges on database job_search to job_search_ror;
    * \list (to confirm jobsearch has job_search_ror in access privileges).
* rails setup:
    * $ gem install pg -- --with-pg-config=/Applications/Postgres.app/Contents/Versions/latest/bin/pg_config
    * $ bundle install
    * $ bin/rake db:migrate

## Deploy to Heroku:

* Note: Requires Heroku toolbelt see: https://devcenter.heroku.com/articles/heroku-cli
* $ heroku create
* $ git push heroku master
* $ heroku run rake db:migrate
* $ git remote -v (to confirm remote name)
* ..... (to be determined)
