create extension postgis 
create table if not exists parcela (
    fid SERIAL PRIMARY KEY,
    numar_cadastral VARCHAR(50) NOT NULL,
    suprafata FLOAT NOT NULL,
    geom GEOMETRY(Polygon, 4326) 
);


CREATE TABLE proprietar (
    fid SERIAL PRIMARY KEY,
    nume VARCHAR(200) NOT NULL,
    prenume VARCHAR(100) NOT NULL,
    CNP VARCHAR(13) NOT NULL UNIQUE,
    adresa TEXT
);

CREATE TABLE parcela_proprietar (
    fid SERIAL PRIMARY KEY,
	parcela_fid INT NOT NULL,
	proprietar_fid INT NOT NULL,
	foreign key (proprietar_fid) references proprietar(fid),
	foreign key (parcela_fid) references parcela(fid)
);

CREATE TABLE lucrare (
    fid SERIAL PRIMARY KEY,
    parcela_fid INT NOT NULL,
    numar_lucrare VARCHAR(50) NOT NULL,
    data_lucrare DATE NOT NULL,
    tip_lucrare VARCHAR(100),
	foreign key (parcela_fid) references parcela(fid),
    descriere TEXT
);


CREATE TABLE documente (
    fid SERIAL PRIMARY KEY,
    lucrare_fid INT NOT NULL,
    tip_document VARCHAR(100) NOT NULL,
    data_emitere DATE NOT NULL,
    descriere TEXT,
	foreign key (lucrare_fid) references lucrare(fid)
);


CREATE TABLE drum (
    fid SERIAL PRIMARY KEY,
    parcela_fid INT NOT NULL,
    nume VARCHAR(100) NOT NULL,
    tip VARCHAR(50) NOT NULL,
    geom GEOMETRY(LineString, 4326),
	foreign key (parcela_fid) references parcela(fid)
);


CREATE TABLE punct_interes (
    fid SERIAL PRIMARY KEY,
    parcela_fid INT NOT NULL,
    nume VARCHAR(100) NOT NULL,
    descriere TEXT,
    geom GEOMETRY(Point, 4326),
	foreign key (parcela_fid) references parcela(fid)
);



SELECT fid, ST_Area(geom::geography) AS suprafata_mp
FROM parcela;

SELECT fid, ST_Centroid(geom) AS centroid
FROM parcela;

