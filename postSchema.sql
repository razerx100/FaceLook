CREATE TABLE Post (
    ID INT NOT NULL AUTO_INCREMENT,
    username VARCHAR(50),
    description VARCHAR(500),
    date DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (ID),
    FOREIGN KEY(username) REFERENCES User(username);
);