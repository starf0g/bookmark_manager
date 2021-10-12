## Database setup instructions
1) Connect to `psql`
2) Create the database using the `psql` command `CREATE DATABASE "bookmark_manager";`
3) Connect to the database using the `psql` command `\c bookmark_manager;`
4) Run the query saved in the file `01_create_bookmarks_table.sql` located in db/migrations

You can run the file using the `\i` command in psql