# unify

This is a water donation app for Unify Water's H20 Initiative. Customers purchasing a bottle of water from Unify are invited to use this app to select where to donate a gallon of water to people in need.

The interactive world map is forked from [here](https://github.com/tomnoda/interactive_d3_map).

## Setup

### Server Set up

We use Ansible to provision the server hosting this app. The playbook is [here](https://github.com/jstoebel/unify_config). The playbook assumes that the app will be hosted alongside a Wordpress install with WP at "/" and this app at "/h20-initiative"

### App deployment

We use Capistrano to handle deployment. Enter the relevant info in `config/deploy.rb` and `config/deploy/production.rb`.

### Environment Variables

Environment variables are managed using Figaro. Ansible provisioning will take care of creating `application.yml` and placing it in a linked directory.

### Setting up the Facebook app

This site requires regular users to authenticate via Facebook. You will need to create a Facebook app [here](https://developers.facebook.com/). You also need to ensure that the proper callback URL is safe-listed.

### Initial data setup

Run `rake db:seed` to initialize all world countries and every US state in the database. These data are read from `public/json`. US States are initialized as active places (meaning that users can select them) All other places are not active by default.

To set up an admin account run `rake create_admin`.

### Administration

The login portal for administrators is at `/login/admin` (no link is provided). Administrators have the ability to do the following

 - **Create batches** Individual bottles are grouped together as a `batch`. To create a batch select, from the home screen `admin -> create bottle codes`. On the next screen select `New Batch`. On the next screen enter the number of bottles to create and select `Create Batch`. The bottles will be created, each with a unique bottle code. You will then be prompted to download a spreadsheet of the batches' codes.

 - **Admin Panel** Here you can view and interact with all data in the database. Some common tasks include

   - Activate/deactivate places: To do so select `Places` then find the place you want to interact with and click the pencil icon on the right. On the following screen you can activate or deactivate the place.

   - Create/remove forever bottles. The client stated the need to use a UPC code for a period of time as a valid bottle code. Since UPC codes are the same for every bottle, you will need to create a bottle code that can be used more than once. To do so, create a bottle by clicking `Bottles` -> `Add New` and selecting the `forever` option.

# development setup

 1. In mysql as `root`

```
CREATE USER 'h20_user'@'localhost' IDENTIFIED BY 'password';
GRANT ALL PRIVILEGES ON * . * TO 'h20_user'@'localhost';
```

 1. In command line:
```
bundle exec rake db:create db:schema:load db:seed
`cp .env.example .env`
```

 1. Add Facebook app id and secret to `.env`
