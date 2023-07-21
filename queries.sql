/*Queries that provide answers to the questions from all projects.*/

SELECT * FROM animals WHERE NAME LIKE '%mon';

SELECT name FROM animals WHERE date_of_birth >= '2016-01-01' AND date_of_birth <= '2019-12-31'; 
SELECT name FROM animals WHERE date_of_birth Between '2016-01-01' AND '2019-12-31';

SELECT name FROM animals WHERE neutered = TRUE AND escape_attempts < 3;

SELECT date_of_birth FROM animals WHERE name = 'Agumon' OR name = 'Pikachu';

SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;

SELECT * FROM animals WHERE neutered = TRUE;

SELECT * FROM animals WHERE name != 'Gabumon';

SELECT * FROM animals WHERE weight_kg >= 10.4 AND weight_kg <= 17.3; 
SELECT * FROM animals WHERE weight_kg Between 10.4 AND 17.3;

BEGIN;

    UPDATE animals
    SET species = 'unspecified';

    SELECT * FROM animals;

ROLLBACK;

SELECT * FROM animals;

BEGIN;

    UPDATE animals SET species='digimon' WHERE name LIKE '%mon';

    UPDATE animals SET species='pokemon' WHERE species IS NULL;

    SELECT * FROM animals;

COMMIT;

SELECT * FROM animals;

BEGIN;

    DELETE FROM animals;
    SELECT * FROM animals;

ROLLBACK;

SELECT * FROM animals;

BEGIN;

    DELETE FROM animals WHERE date_of_birth > '2022-01-01';

    SAVEPOINT SP1;

    UPDATE animals 
    SET weight_kg = weight_kg * -1;

    ROLLBACK TO SP1;

    UPDATE animals 
    SET weight_kg = weight_kg * -1
    WHERE weight_kg < 0;

COMMIT;

SELECT * FROM animals;

SELECT COUNT(*) FROM animals;

SELECT COUNT(*) FROM animals WHERE escape_attempts = 0;

SELECT AVG(weight_kg) FROM animals;

SELECT MAX(escape_attempts), neutered 
FROM animals
GROUP BY neutered;

SELECT species, MIN(weight_kg) AS min_weight, MAX(weight_kg) AS max_weight
FROM animals
GROUP BY species;

SELECT species, AVG(escape_attempts) 
FROM animals 
WHERE date_of_birth 
BETWEEN '1990-01-01' AND '2000-12-31'
GROUP BY species;

SELECT name
FROM animals
JOIN owners ON animals.owner_id = owners.id
WHERE owners.full_name = 'Melody Pond';

SELECT animals.name
FROM animals
JOIN species ON animals.species_id = species.id
WHERE species.name = 'Pokemon';

SELECT o.full_name AS owner_name, a.name AS animal_name
FROM owners o
LEFT JOIN animals a ON o.id = a.owner_id;

SELECT species.name, COUNT(*) AS animals_count
FROM animals JOIN species ON animals.species_id = species.id
GROUP BY species.name;

SELECT animals.name 
FROM animals
JOIN owners ON animals.owner_id = owners.id
JOIN species ON animals.species_id = species.id
WHERE species.name = 'Digimon' AND owners.full_name = 'Jennifer Orwell'; 

SELECT animals.name
FROM animals
JOIN owners ON animals.owner_id = owners.id
WHERE owners.full_name = 'Dean Winchester' AND animals.escape_attempts = 0;

SELECT o.full_name AS owner_name, COUNT(a.id) AS animal_count
FROM owners o
JOIN animals a ON o.id = a.owner_id
GROUP BY o.id, o.full_name
ORDER BY animal_count DESC
LIMIT 1;