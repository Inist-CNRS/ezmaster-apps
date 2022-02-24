# A dedicated webservice for Lodex

with docker

    make build
    make run-debug

or with [ezmaster](https://github.com/Inist-CNRS/ezmaster)


## to test

```
echo '<root>toto</root>'|curl --data-binary @- 'http://localhost:31976/parse'
```

