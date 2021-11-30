#### config.notify-slack.api-key-env-var

Env var name of bot API TOKEN

**type**

non-empty string

**example**

```nix
{
  config.notify-slack.api-key-env-var = "SLACK_BOT_TOKEN";
}
```

**default**

```nix
{
  config.notify-slack.api-key-env-var = "SLACK_BOT_TOKEN";
}
```


#### config.notify-slack.gifted-branch

branch with random gif

**type**

non-empty string

**example**

```nix
{
  config.notify-slack.gifted-branch = "main";
}
```

**default**

```nix
{
  config.notify-slack.gifted-branch = "master";
}
```


#### config.pontix.aws

Pontte AWS Options

**type**

submodule


**default**

```nix
{
  config.pontix.aws = {};
}
```


#### config.pontix.aws.ci-cd

Pontte AWS Options for CI-CD

**type**

submodule


**default**

```nix
{
  config.pontix.aws.ci-cd = {};
}
```


#### config.pontix.aws.ci-cd.envs

Pontte AWS Options for CI-CD defauult env

**type**

attribute set of strings


**default**

```nix
{
  config.pontix.aws.ci-cd.envs = {
    AWS_ACCESS_KEY_ID = "${{ secrets.AWS_ACCESS_KEY_ID }}";
    AWS_DEFAULT_REGION = "${{ secrets.AWS_DEFAULT_REGION }}";
    AWS_SECRET_ACCESS_KEY = "${{ secrets.AWS_SECRET_ACCESS_KEY }}";
  };
}
```


#### config.pontix.aws.ci-cd.secrets

Pontte AWS Options for CI-CD secret names

**type**

submodule


**default**

```nix
{
  config.pontix.aws.ci-cd.secrets = {};
}
```


#### config.pontix.aws.ci-cd.secrets.id

name of secret with AWS_ACCESS_KEY_ID

**type**

unspecified


**default**

```nix
{
  config.pontix.aws.ci-cd.secrets.id = "AWS_ACCESS_KEY_ID";
}
```


#### config.pontix.aws.ci-cd.secrets.key

name of secret with AWS_SECRET_ACCESS_KEY

**type**

unspecified


**default**

```nix
{
  config.pontix.aws.ci-cd.secrets.key = "AWS_SECRET_ACCESS_KEY";
}
```


#### config.pontix.aws.ci-cd.secrets.region

name of secret with AWS_DEFAULT_REGION

**type**

unspecified


**default**

```nix
{
  config.pontix.aws.ci-cd.secrets.region = "AWS_DEFAULT_REGION";
}
```


#### config.random-gif.api-key-env-var

random gif name of env var with API TOKEN

**type**

non-empty string

**example**

```nix
{
  config.random-gif.api-key-env-var = "GIPHY_TOKEN";
}
```

**default**

```nix
{
  config.random-gif.api-key-env-var = "GIPHY_TOKEN";
}
```


#### config.random-gif.rating

random gif rating https://developers.giphy.com/docs/optional-settings/#rating

**type**

non-empty string

**example**

```nix
{
  config.random-gif.rating = "pg";
}
```

**default**

```nix
{
  config.random-gif.rating = "pg";
}
```


#### config.random-gif.tag

random gif search tag

**type**

non-empty string

**example**

```nix
{
  config.random-gif.tag = "cry";
}
```

**default**

```nix
{
  config.random-gif.tag = "celebrate";
}
```

