# Nano-DBMS
This is a small (Nano) DBMS with minimal functionality of DBMS like mysql.

## Getting started

## Running the app

#### No third party packages are required
to start the app, simply run the following command inside app directory:

```bash
./main.sh
```

## A deep dive in the app

### Where does the the app store its files?

The app creates a directory in the user's home path, the directory is called 'My_Nano_mysql'.
Inside that directory is a directory called databaseses, inside it, each database created by user has its own directory, inside that database directory are the files that represnt the tables.
Databases are stored as directories, while tables are stored as files.
> _Example for a table called bar inside database foo_: /$HOME/My_Nano_mysql/databaseses/foo/bar


## Scripts

### 1] Scripts in main app directory:
--------------------------------------

#### 1] init.sh: used to created app files and folders in the user's home root.
#### 2] main.sh: run it to start the app.

### 2] Scripts in utils directory:
--------------------------------------
> _Note_: utils hold helper scripts that do certain functions, like getting a word, a number, ....
#### 1] get_column_name.sh: used to ensure uniqueness of tables' column names (no duplicate column name).
#### 2] get_clean_number.sh: used as a helper scriot in get_number.sh script.
#### 3] get_number.sh: used to ensure that the input from user is a number.
#### 4] get_clean_word.sh: used as a helper scriot in get_word.sh script.
#### 5] get_word.sh: used to ensure that the input from user is a valid a word.
#### 6] header.sh: contains some lines to be printed in some app menues.

### 3] Scripts in database_scripts directory:
----------------------------------------------
> _Note_: scripts that handle the database itself, like creation, deletion, ....
1] create_database.sh: used to create database.
2] database_view.sh: the main menu the user sees to create, remove, list and open a database.
#### 3] delete_database.sh: used to remove a database.
#### 4] inside_database.sh: displays operations that can be done inside a database (create, remove tables).
#### 5] list_database.sh: used to list all available databases.
#### 6] open_database.sh: used to open a certain database (which fires the inside_database.sh script).

### 4] Scripts in table_scripts directory:
----------------------------------------------
> _Note_: scripts that handle the table itself, like creation, deletion, ....
#### 1] create_table.sh: used to create a table.
#### 2] create_table_helper.sh: helper script used in table creation to get the columns.
#### 3] delete_table.sh: used to remove a table.
#### 4] inside_table.sh: displays operations that can be done inside a table (create, remove record).
#### 5] list_table.sh: used to list all available tables.
#### 6] open_table.sh: used to open a certain table (which fires the inside_table.sh script).

### 5] Scripts in record_scripts directory:
----------------------------------------------
> _Note_: scripts that handle the record itself, like creation, deletion, ....
#### 1] create_record.sh: used to create a row.
#### 2] delete_record.sh: used to remove a row.
#### 3] list_records.sh: used to list all records.
#### 4] update_record.sh: used to update a record.
#### 5] update_record_helper.sh: used in update_record.sh to get the value of the column we want to update, as well as the new value.
#### 6] update_by_id.sh: used in update_record.sh to handle updating by id, since updating by id is a little different than any other fields.


## Deployment N/A

## Authors

The great team of ITI, Wessal and Ahmad Khaled

## Acknowledgment

The awesome team of ITI and bash script instructors :D 
