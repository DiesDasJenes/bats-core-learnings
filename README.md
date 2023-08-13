# Learnings from using bats-core

In this repository I want to collect my recent learnings on bats-core and bats-mock from the user grayhemp. Although their documentation is great some parts are missing around bats-mock. The readme itself doesn't explain much. I have found different examples of bats-mock usage that worked and I want to summarize them here. 

## Docker 

I wrote this small Dockerfile instead of using the official bats image to be more flexible and not waste more time to understand how I should add bats-mock. 

How to build the docker image locally from repository root:

```shell
docker build -t testing-bats ./docker/.
```

How to execute the docker container:

```shell
docker run -it -v "$PWD:/bats-mock-learnings" -w "/bats-mock-learnings/test/" testing-bats
```

Then to run all tests

```shell
bats .
```