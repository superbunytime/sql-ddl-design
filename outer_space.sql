-- from the terminal run:
-- psql < outer_space.sql

DROP DATABASE IF EXISTS outer_space;

CREATE DATABASE outer_space;

\c outer_space

-- CREATE TABLE planets
-- (
--   id SERIAL PRIMARY KEY,
--   name TEXT NOT NULL,
--   orbital_period_in_years FLOAT NOT NULL,
--   orbits_around TEXT NOT NULL,
--   galaxy TEXT NOT NULL,
--   moons TEXT[]
-- );

-- INSERT INTO planets
--   (name, orbital_period_in_years, orbits_around, galaxy, moons)
-- VALUES
--   ('Earth', 1.00, 'The Sun', 'Milky Way', '{"The Moon"}'),
--   ('Mars', 1.88, 'The Sun', 'Milky Way', '{"Phobos", "Deimos"}'),
--   ('Venus', 0.62, 'The Sun', 'Milky Way', '{}'),
--   ('Neptune', 164.8, 'The Sun', 'Milky Way', '{"Naiad", "Thalassa", "Despina", "Galatea", "Larissa", "S/2004 N 1", "Proteus", "Triton", "Nereid", "Halimede", "Sao", "Laomedeia", "Psamathe", "Neso"}'),
--   ('Proxima Centauri b', 0.03, 'Proxima Centauri', 'Milky Way', '{}'),
--   ('Gliese 876 b', 0.23, 'Gliese 876', 'Milky Way', '{}');

-- so what we're looking for is a separation of concerns

CREATE TABLE milky_way
(
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL
);

CREATE TABLE the_sun
(
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL,
  galaxyID INTEGER REFERENCES milky_way 
);

CREATE TABLE planets
(
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL,
  orbital_period_in_years FLOAT NOT NULL,
  orbits_around INTEGER REFERENCES the_sun,
  galaxyID INTEGER REFERENCES milky_way
);

CREATE TABLE moons
(
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL,
  planetID INTEGER REFERENCES planets
);

INSERT INTO milky_way
(name)
VALUES 
('Milky Way');

INSERT INTO the_sun
(name, galaxyID)
VALUES
('The Sun', 1), ('Proxima Centauri', 1), ('Gliese 876', 1);

INSERT INTO planets
  (name, orbital_period_in_years, orbits_around, galaxyID)
VALUES
  ('Earth', 1.00, 1, 1),
  ('Mars', 1.88, 1, 1),
  ('Venus', 0.62, 1, 1),
  ('Neptune', 164.8, 1, 1),
  ('Proxima Centauri b', 0.03, 2, 1),
  ('Gliese 876 b', 0.23, 3, 1);

  INSERT INTO moons
    (name, planetID)
  VALUES
    ('The Moon', 1), 
    ('Phobos', 2), 
    ('Deimos', 2), 
    ('Naiad', 4), 
    ('Thalassa', 4), 
    ('Despina', 4), 
    ('Galatea', 4), 
    ('Larissa', 4), 
    ('S/2004 N 1', 4), 
    ('Proteus', 4), 
    ('Triton', 4), 
    ('Nereid', 4), 
    ('Halimede', 4), 
    ('Sao', 4), 
    ('Laomedeia', 4), 
    ('Psamanthe', 4), 
    ('Neso', 4);