alter table singer drop column genre_id; 
alter table singer rename to singers;

create table if not exists singersGenre(
	singer_id integer references singers(id),
	genre_id integer references genre(id),
	constraint pk primary key (singer_id, genre_id)
);

alter table alboms drop column singer_id;
create table if not exists singersAlboms(
	singer_id integer references singers(id),
	albom_id integer references alboms(id),
	constraint pk1 primary key (singer_id, albom_id)
);

alter table tracks drop column albom_id;
alter table tracks add FOREIGN KEY (id) REFERENCES alboms(id);

create table if not exists collectionAlboms(
	id serial primary key,
	tracks_id integer references tracks(id),
	albom_id integer references alboms(id),
	name varchar(40),
	year_of_issue date
);
alter table tracks drop column id cascade;
alter table tracks add column id serial primary key;
alter table tracks add column albom_id integer references alboms(id);
create table if not exists collections(
	id serial primary key,
	name varchar(40),
	year_of_issue date
);
drop table collectionalboms;
create table if not exists collectiontracks(
	tracks_id integer references tracks(id),
	collection_id integer references collections(id),
	constraint pk2 primary key (tracks_id, collection_id)
);
