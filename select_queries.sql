select name, count(singer_id) from singersgenre
join genre on genre_id = genre.id
group by name;

select count(albom_id), date_of_release from tracks
left join alboms on albom_id = alboms.id
group by date_of_release
having date_of_release = 2019 or date_of_release = 2020;

select alboms.name, avg(tracks.duration) from alboms
join tracks on alboms.id = albom_id
group by alboms.name;

select distinct singers.name from alboms
join singersalboms on alboms.id = albom_id
join singers on singers.id = singer_id
where date_of_release != 2020;

select distinct collections.name from singers
join singersalboms sa on singers.id = singer_id
join alboms on sa.albom_id = alboms.id
join tracks on alboms.id = tracks.albom_id
join collectiontracks on tracks.id = tracks_id
join collections on collection_id = collections.id
where singers.name like '%%Kanye%%';

select alboms.name, count(genre.name) from singers
join singersalboms sa on singers.id = singer_id
join alboms on sa.albom_id = alboms.id
join singersgenre sg on singers.id = sg.singer_id
join genre on genre_id = genre.id
group by alboms.name
having count(genre.name) > 1;

select singers.name, tracks.name from singers
join singersalboms sa on singers.id = singer_id
join alboms on sa.albom_id = alboms.id
join tracks on alboms.id = tracks.albom_id
full outer join collectiontracks on tracks.id = tracks_id
where tracks.id is null or tracks_id is null;

select singers.name, tracks.name, tracks.duration from tracks
join alboms on tracks.albom_id= alboms.id
join singersalboms sa on alboms.id = sa.albom_id
join singers on sa.singer_id = singers.id
where tracks.duration = (select min(tracks.duration) from tracks);

select alboms.name, count(tracks.id) from alboms
join tracks on alboms.id= albom_id
group by alboms.name
having count(tracks.id) = 
(select count(tracks.id) from alboms
join tracks on alboms.id= albom_id
group by alboms.name order by count(tracks.id) asc
limit(1));