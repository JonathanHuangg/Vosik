use Vosik;

DROP TABLE IF EXISTS songs;
CREATE TABLE IF NOT EXISTS songs (
	id char(22),
    song_name varchar(100),
    intensity decimal(10, 9) not null,
    duration_ms decimal(32, 2) not null,
    track_href varchar(1000),
    album_image varchar(1000),
    primary key(id)
);