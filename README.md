#Quake log parser
Just turn your quake game log simple to read, transform a games.log into a json response on http://localhost:3000

###Tech stack
  - Rails
  - Ruby 2.3.0

###How to run?
  - bundle install
  - rails s
  - open http://localhost:3000

###How to parse another log file?
To do this you will need replace the games.log file on rspec/fixtures/games.log or you can change the path into app/controllers/log_controller.rb on index action.

###So... how it works?
Its the game log have a pattern and some codes, to make simple build anything to read the log file, for example when you see this line:
```
20:54 Kill: 1022 2 22: <world> killed Isgalamido by MOD_TRIGGER_HURT
```
this means, the player 1022 killed the player 2 with the way 22, we know the max clients on a quake server is 16, so the player id 1022 is reserved to <world>. With this you dont need parse all the string to know what happened with players.

