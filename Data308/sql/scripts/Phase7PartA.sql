/*
A. Create table of Trush (To examine how many times grant access was successful or not) with the attributes of
    a. FailedAttempts=> tinyInt
    b. SuccessfulAttempt=> tinyInt
    c. username=> with the domain of username column in login table
    d. username would be the primary key
    e. the engine of BLACKHOLE.
*/
CREATE TABLE Trush (
    FailedAttempts TINYINT,
    SuccessfulAttempts TINYINT,
    username VARCHAR(255) NOT NULL,
    PRIMARY KEY (username),
    CONSTRAINT fk_username FOREIGN KEY (username) REFERENCES login(username)
) ENGINE=BLACKHOLE;
