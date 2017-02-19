# GameMooch

GameMooch is a Rails project to exchange games between gamers.

---

To run the application localy you have to install [rails], [bundler] and setup
one mysql database.

### Configure database

* edit config/database.yml with the correct database, username and password

### Configure secrets

* edit config/secrets.yml

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
> Soon

### Demo

* Demo at https://gamemooch.herokuapp.com/

[bundler]:<http://bundler.io/>
[rails]:<http://rubyonrails.org/>
