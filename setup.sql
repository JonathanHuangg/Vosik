use music;

DROP TABLE IF EXISTS songs;
CREATE TABLE IF NOT EXISTS songs (
	id char(22),
    song_name varchar(100),
    intensity decimal(10, 9) not null,
    primary key(id)
);