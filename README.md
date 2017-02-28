# GameMooch

GameMooch is a Rails project to exchange games between gamers.

---

To run the application localy you have to install [rails], [bundler] and setup
one mysql database.

### Configure database

* edit config/database.yml with the correct database, username and password

### Configure local env file

* edit config/local_env.yml

### Install dependencies

```Bash
$ bundle install
```
### Run migrations

```Bash
$ rails db:migrate
```

### Start the app
```Bash
$ rails server
```

### The application will run on:
```Bash
http://localhost:3000
```

### Docker
* Download [docker] and [docker-compose] and simply run
```Bash
$ docker-compose up
```

### Demo

* Demo at https://gamemooch.herokuapp.com/

[bundler]:<http://bundler.io/>
[rails]:<http://rubyonrails.org/>
[docker]:<https://www.docker.com/>
[docker-compose]:<https://docs.docker.com/compose/>
