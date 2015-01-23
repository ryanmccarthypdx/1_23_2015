# Salon

This program manages the clients and stylists at a salon.

## Setup Instructions

### Gems used
```
sinatra
sinatra-contrib
pg
```
### Setup Your Database
```
This program is designed for use with PostgreSQL.  Database should be named 'salon', with tables 'clients' and 'stylist'.  Table clients should include columns id, name, phone, and stylist_id.  Table stylist should include columns id, and name.  
#OR YOU CAN JUST RUN THIS SCRIPT:

CREATE DATABASE salon;
\c salon;
CREATE TABLE stylists (id serial PRIMARY KEY, name varchar);
CREATE TABLE clients (id serial PRIMARY KEY, name varchar, phone varchar, stylist_id int);

#And to use rspec, be sure to add this line:

CREATE DATABASE salon_test WITH TEMPLATE salon;

```
### Install Bundler
```
$ gem install bundler
```
### Run Bundler
```
$ bundle
```
### Bug Reports
No known bugs

### Authors
Ryan McCarthy (ryanmccarthypdx@gmail.com)

#### License

Copyright (C) 2015 Ryan McCarthy

This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with this program. If not, see http://www.gnu.org/licenses/.
