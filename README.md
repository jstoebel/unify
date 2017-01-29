# unify
## Deploying

If you have previously run the `./bin/setup` script,
you can deploy to staging and production with:

    $ ./bin/deploy staging
    $ ./bin/deploy production

## Random notes on provisioning (This will need to be cleaned up)

 - set up a mysql user with access to three databases
 - place that password in `.env`
 - for paperclip: `sudo apt-get install imagemagick -y`
