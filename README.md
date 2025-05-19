![release workflow](https://github.com/easytocloud/akskrotate/actions/workflows/release.yml/badge.svg)

# akskrotate
rotate your AWS access key / secret key with confidence

## Install

Use homebrew to install

```
brew tap easytocloud/tap
brew install akskrotate
```

or copy the script from distribution/bin/akskrotate somewhere in your path:

```
cp distribution/bin/akskrotate /usr/local/bin
```

## Usage
akskrotate solves a challenge that many AWS cli users have.

> It is best practice to regularly change your passwords and rotate your AWS IAM Ak/Sk.

Use akskrotate to rotate the access key and secret key for your current IAM profile.
The variable ${AWS_PROFILE} should reference a profile configuration in ~/.aws/credentials.

The process is straigtforward and best explained by its output:

```
$ akskrotate 
akskrotate creates a new AK/SK key and deactivates the current AK/SK

akskrotate expects your profiles are stored in ~/.aws/credentials

akskrotate rotates the AWS IAM AK/SK for the user identified by erik@easytocloud

akskrotate updates ~/.aws/credentials automatically for
  - erik@easytocloud 
  - other profiles that reference the same access key

you are responsible for updating the keys should they be used anywhere else

akskrotate does not deactivate your current key until the new key is tested and functional

to be able to rotate your key, akskrotate deletes the inactive key should there be one
as at no time you can have more than 2 keys

Do you want to continue: [YN] Y
Here we go ..
Retrieving keys for erik@easytocloud ..
Making sure there is a free slot for a temporary second active key ..
Removing inactive key ..
Looking for other profiles with same access_key ..
Adding erik@ez2c to list of profiles to update
Creating new AK/SK ..
Backing up your credentials file into ~/.aws/credentials.akskrotate ..
Updating AK/SK for profile erik@easytocloud in ~/.aws/credentials ..
Updating AK/SK for profile erik@ez2c in ~/.aws/credentials ..
Waiting 15 seconds for IAM changes to globally propagate ..
Testing new key .. SUCCESS
Deactivating previous key ..
Cleaning up backup ..
Done.
$
```
