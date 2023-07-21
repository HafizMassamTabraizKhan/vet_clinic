/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
    id INT GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(100),
    date_of_birth DATE,
    escape_attempts INT,
    neutered BOOLEAN,
    weight_kg DECIMAL
);

ALTER TABLE animals 
	ADD species VARCHAR(100);

CREATE TABLE owners (
    id INT GENERATED ALWAYS AS IDENTITY,
    full_name VARCHAR(100),
    age INT,
    primary key(id)
);

CREATE TABLE species (
    id INT GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(100),
    primary key(id)
);

ALTER TABLE animals 
	ADD primary key(id);

ALTER TABLE animals 
	DROP COLUMN species;

ALTER TABLE animals
    ADD species_id INT REFERENCES species(id);

ALTER TABLE animals
    ADD owner_id INT REFERENCES owners(id);