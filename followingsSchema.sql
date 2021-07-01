CREATE TABLE Username (
    ID INT NOT NULL AUTO_INCREMENT,
    following VARCHAR(50),
    PRIMARY KEY (ID),
    FOREIGN KEY(following) REFERENCES User(username)
);