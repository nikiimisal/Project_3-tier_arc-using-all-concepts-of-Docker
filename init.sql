USE FCT;


CREATE TABLE users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(20),
    email VARCHAR(100),
    website VARCHAR(255),
    gender VARCHAR(6),
    comment VARCHAR(100)
);








USE FCT;                                              # Selects the FCT database to run the queries on

CREATE TABLE users (                                 # Creates a table named users
    id INT PRIMARY KEY AUTO_INCREMENT,               # Unique ID for each user, auto-generated
    name VARCHAR(20),                                # Stores the user name
    email VARCHAR(100),                              # Stores the user email address
    website VARCHAR(255),                            # Stores the user website URL
    gender VARCHAR(6),                               # Stores the user gender
    comment VARCHAR(100)                             # Stores user comments or feedback
);













