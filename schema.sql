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

CREATE TABLE vets (
    id INT GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(100),
    age INT,
    date_of_graduation DATE,
    primary key(id)
);

CREATE TABLE specializations (
    vet_id INT REFERENCES vets(id),
    species_id INT REFERENCES species(id),
    PRIMARY KEY (vet_id, species_id)
);

CREATE TABLE visits (
    vet_id INT REFERENCES vets(id),
    animal_id INT REFERENCES animals(id),
    visit_date DATE,
    PRIMARY KEY (vet_id, animal_id, visit_date)
);

-- Database performance audit
ALTER TABLE owners ADD COLUMN email VARCHAR(120);

ALTER TABLE visits DROP CONSTRAINT visits_pkey;

CREATE INDEX visits_vet_id_asc ON visits (vet_id ASC);
CREATE INDEX visits_animal_id_asc ON visits (animal_id ASC);