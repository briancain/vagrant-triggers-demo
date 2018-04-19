sudo apt-get update
sudo apt-get install postgresql postgresql-contrib -y
sudo -u postgres createdb test
sudo -u postgres psql -c "CREATE TABLE playground ( equip_id serial PRIMARY KEY, type varchar (50) NOT NULL, color varchar (25) NOT NULL, location varchar(25) check (location in ('north', 'south', 'west', 'east', 'northeast', 'southeast', 'southwest', 'northwest')), install_date date);"
sudo -u postgres psql -c "INSERT INTO playground (equip_id, type, color, location, install_date) VALUES (1, 'cool', 'green', 'west', 'now');"
