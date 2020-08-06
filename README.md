Project realized by Benoit Ferretti & Julien Lamalle for THP.

This web application is an application gathering gossip published by users that we generated in our database initially, we will add later the possibility to create your account and therefore to publish your own gossips, these additions will be on the repos that will arrive in the following days

This version arrives with the addition of the possibility of creating a gossip, alerts have also been added during certain events ...

The used version of Ruby is 2.5.1, for Rails we used version 5.2.4.3

If your versions are different, you can use the command :

```
rm gemfile.lock
```

To launch the project, consider making a

```
bundle install
```
```
rails db:seed
```
```
rails s
```

Now you can go to :

```
http://localhost:3000/index
```


