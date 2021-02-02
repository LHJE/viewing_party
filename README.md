# Viewing Party
Viewing party is an application in which users can explore movie options and create a viewing party event for the user and friend's.

This is the base repo for the [viewing party project](https://backend.turing.io/module3/projects/viewing_party) used for Turing's Backend Module 3.

# About this Project  

## Contributors
[Philip DeFraties](https://github.com/PhilipDeFraties)  
[Luke Hunter James-Erickson](https://github.com/LHJE/)

## Installation
In order to install Viewing Party on your computer, simply copy the below into your terminal's command line, and hit 'return':

```
git clone https://github.com/LHJE/viewing_party.git
```

You will have to go to [The Movie Database](https://www.themoviedb.org/login), create an account if you don't already have one, and obtain an API key from them.  

You will also have to login to the [New York Times](https://developer.nytimes.com/accounts/login) and obtain an API key for their movie reviews.

## Dev Environment Setup
Next you're going to want to run these commands from your terminal's command line just to get everything set up:

```
bundle install
bundle update
rails db:create
rails db:migrate
```

This has created a file called `application.yml` in your `config` folder.

In that file, paste this:

```
MOVIEDB_API_KEY: "<YOUR API KEY>"
NYT_MOVIE_REVIEWS_API_KEY: "<YOUR API KEY>"
```  

## Usage
To get this app up and running on your computer, simply type this into your command line and hit return:

```
rails s
```

## Gems Being Utilized
Here are the more relevant gems we've added to the base rails gems to make this app really sing:

```
gem 'faraday'
gem 'webmock'
gem 'vcr'
gem "figaro"
gem 'travis'
gem "nyan-cat-formatter"
```  

We're using `faraday` to allow for API calls.  
We're using `figaro` to abstract the API Keys we're using.  
We're using `webmock` and `vcr`  to stub out API calls for testing.  
We're using `travis` to ensure that new changes to the build merge successfully.  
And we added `nyan-cat-formatter` just for fun.

## Schema
Below is our schema.

![our schema](/viewing_party_schema.png)

## Learning Goals
For this project, we focused on learning:
 - How to consume API's  
 - How to keep API's concealed  
 - How and why to make POROs files.

## Future Changes
- Add a dedicated `movies` table that would store information on the db so API calls don't need to be made every time.  
- Abstracting the `top 40` and `keyword search` into the SearchFacade.  

## Code We're Proud Of
- Calling a second API Key.  
- The Movie Poro in general.

## Versions

- Ruby 2.5.3	- Ruby 2.5.3

- Rails 5.2.4.3	- Rails 5.2.4.3

2020-10-15: v 1.0

## License
Copyright 2020 Philip DeFraties, Luke Hunter James-Erickson

Permission is hereby granted to any person obtaining a copy of this software and associated materials to make use of the software and associated materials according to the terms of the MIT License (see included file `LICENSE_MIT`) IF AND ONLY IF they have not read any portion of this file.

Any person who has read any portion of this file may not make any use of the software and associated materials for any purpose whatsoever. Any permissions previously granted to any person to use this software and associated materials terminate and are revoked with immediate effect upon their reading of any portion of this file.
