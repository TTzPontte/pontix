## notify-slack.api-key-env-var

Env var name of bot API TOKEN

#### type

non-empty string

#### example

```nix
{
  notify-slack.api-key-env-var = "SLACK_BOT_TOKEN";
}
```

#### default

```nix
{
  notify-slack.api-key-env-var = "SLACK_BOT_TOKEN";
}
```


## notify-slack.gifted-branch

branch with random gif

#### type

non-empty string

#### example

```nix
{
  notify-slack.gifted-branch = "main";
}
```

#### default

```nix
{
  notify-slack.gifted-branch = "master";
}
```


## pontix.aws

Ponttix AWS Options

#### type

submodule


#### default

```nix
{
  pontix.aws = {};
}
```


## pontix.aws.ci-cd

Pontte AWS Options for CI-CD

#### type

submodule


#### default

```nix
{
  pontix.aws.ci-cd = {};
}
```


## pontix.aws.ci-cd.envs

Pontte AWS Options for CI-CD defauult env

#### type

attribute set of strings


#### default

```nix
{
  pontix.aws.ci-cd.envs = {
    AWS_ACCESS_KEY_ID = "${{ secrets.AWS_ACCESS_KEY_ID }}";
    AWS_DEFAULT_REGION = "${{ secrets.AWS_DEFAULT_REGION }}";
    AWS_SECRET_ACCESS_KEY = "${{ secrets.AWS_SECRET_ACCESS_KEY }}";
  };
}
```


## pontix.aws.ci-cd.secrets

Pontte AWS Options for CI-CD secret names

#### type

submodule


#### default

```nix
{
  pontix.aws.ci-cd.secrets = {};
}
```


## pontix.aws.ci-cd.secrets.id

name of secret with AWS_ACCESS_KEY_ID

#### type

unspecified


#### default

```nix
{
  pontix.aws.ci-cd.secrets.id = "AWS_ACCESS_KEY_ID";
}
```


## pontix.aws.ci-cd.secrets.key

name of secret with AWS_SECRET_ACCESS_KEY

#### type

unspecified


#### default

```nix
{
  pontix.aws.ci-cd.secrets.key = "AWS_SECRET_ACCESS_KEY";
}
```


## pontix.aws.ci-cd.secrets.region

name of secret with AWS_DEFAULT_REGION

#### type

unspecified


#### default

```nix
{
  pontix.aws.ci-cd.secrets.region = "AWS_DEFAULT_REGION";
}
```


## random-gif.api-key-env-var

random gif name of env var with API TOKEN

#### type

non-empty string

#### example

```nix
{
  random-gif.api-key-env-var = "GIPHY_TOKEN";
}
```

#### default

```nix
{
  random-gif.api-key-env-var = "GIPHY_TOKEN";
}
```


## random-gif.rating

random gif rating https://developers.giphy.com/docs/optional-settings/#rating

#### type

non-empty string

#### example

```nix
{
  random-gif.rating = "pg";
}
```

#### default

```nix
{
  random-gif.rating = "pg";
}
```


## random-gif.tag

random gif search tag

#### type

non-empty string

#### example

```nix
{
  random-gif.tag = "cry";
}
```

#### default

```nix
{
  random-gif.tag = "celebrate";
}
```

