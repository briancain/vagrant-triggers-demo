# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
  config.vm.box = "bento/ubuntu-16.04"

  config.trigger.after :up do |trigger|
    trigger.name = "Gather Information"
    trigger.info =  "Running info gathering script..."
    trigger.run_remote = {path: "scripts/info.sh",
                          env: {"HELLO"=>"Hello ",
                                "THERE"=>"there."},
                          privileged: false}
  end

  config.trigger.before :up, :destroy, :halt do |trigger|
    trigger.name = "Greetings"
    trigger.info = "Hello world"
    trigger.run = {inline: "echo 'Hi'"}
  end

  config.vm.define "ubuntu" do |m|
    m.vm.box = "bento/ubuntu-16.04"
    m.vm.provision "shell", inline: <<-SHELL
    sudo apt-get update
    sudo apt-get install postgresql postgresql-contrib -y
    sudo -u postgres createdb test
    sudo -u postgres psql -c "CREATE TABLE playground ( equip_id serial PRIMARY KEY, type varchar (50) NOT NULL, color varchar (25) NOT NULL, location varchar(25) check (location in ('north', 'south', 'west', 'east', 'northeast', 'southeast', 'southwest', 'northwest')), install_date date);"
    sudo -u postgres psql -c "INSERT INTO playground (equip_id, type, color, location, install_date) VALUES (1, 'cool', 'green', 'west', 'now');"
    SHELL

    m.trigger.before :up, warn: "Hello world!", name: "Welcome"

    m.trigger.before :destroy do |trigger|
      trigger.name = "Database Backup"
      trigger.warn = "Backing up local postgresql db before destroy..."
      trigger.on_error = :continue
      trigger.run_remote = {inline: "sudo -u postgres pg_dump test > /vagrant/db-backup/dbexport.pgsql"}
    end
  end
end
