# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
  config.vm.box = "bento/ubuntu-16.04"

  # Global trigger, runs for every guest
  #
  # name:       gives the trigger a name to be displayed
  # info:       prints a message to the user
  # run_remote: acts exacty like a Shell Provisioner
  config.trigger.after :up do |trigger|
    trigger.name = "Gather Information"
    trigger.info =  "Running info gathering script..."
    trigger.run_remote = {path: "scripts/info.sh",
                          env: {"HELLO"=>"Hello ",
                                "THERE"=>"there."}}
  end

  # Only_on restricts trigger to guests named `ubuntu`
  # or guest names that match `linux`
  #
  # run: Is similar to a shell provisioner, but runs locally
  #      on the host.
  config.trigger.before :up, :destroy, :halt do |trigger|
    trigger.name = "Greetings"
    trigger.info = "Hello world"
    trigger.only_on = ["ubuntu", /linux/]
    trigger.run = {inline: "echo 'Hi'"}
  end

  config.vm.define "ubuntu" do |m|
    m.vm.box = "bento/ubuntu-16.04"
    m.vm.provision "shell", path: "scripts/psql-setup.sh"

    # Machine scoped trigger (i.e. only runs on this guest)
    #
    # warn:     Prints a warning message to the user
    # on_error: Defines how the trigger behaves when it encounters an error.
    #           By default, it will halt, but can be configured to continue on
    m.trigger.before :destroy do |trigger|
      trigger.name = "Database Backup"
      trigger.warn = "Backing up local postgresql db before destroy..."
      trigger.on_error = :continue
      trigger.run_remote = {inline: "sudo -u postgres pg_dump test > /vagrant/db-backup/dbexport.pgsql"}
    end
  end
end
