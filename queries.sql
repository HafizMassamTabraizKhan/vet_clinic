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

SELECT animals.name 
FROM animals
JOIN visits ON animals.id = visits.animal_id
JOIN vets ON visits.vet_id = vets.id
WHERE vets.name = 'William Tatcher'
ORDER BY visits.visit_date DESC
LIMIT 1;

SELECT COUNT(visits.animal_id)
FROM visits
JOIN animals ON visits.animal_id = animals.id
JOIN vets ON visits.vet_id = vets.id
WHERE vets.name = 'Stephanie Mendez';

SELECT v.name AS vet_name, s.name AS specialization
FROM vets v
FULL JOIN specializations sp ON v.id = sp.vet_id
FULL JOIN species s ON sp.species_id = s.id;

SELECT a.name AS animal_name
FROM animals a
JOIN visits v ON a.id = v.animal_id
JOIN vets vet ON v.vet_id = vet.id
WHERE vet.name = 'Stephanie Mendez'
AND v.visit_date
BETWEEN '2020-04-01' AND '2020-08-30';

SELECT a.name AS animal_name, COUNT(*) AS visit_count
FROM animals a
JOIN visits v ON a.id = v.animal_id
GROUP BY a.name
ORDER BY visit_count DESC
LIMIT 1;

SELECT a.name AS animal_name, v.visit_date
FROM animals a
JOIN visits v ON a.id = v.animal_id
JOIN vets vet ON v.vet_id = vet.id
WHERE vet.name = 'Maisy Smith'
ORDER BY v.visit_date ASC
LIMIT 1;

SELECT 
    a.name AS animal_name,
    a.date_of_birth,
    a.escape_attempts,
    a.neutered,
    vet.name AS vet_name,
    vet.age AS vet_age,
    vet.date_of_graduation,
    v.visit_date
FROM animals a
JOIN visits v ON a.id = v.animal_id
JOIN vets vet ON v.vet_id = vet.id
ORDER BY v.visit_date DESC
LIMIT 1;

SELECT s.name AS species_name, count(*) AS visit_count
FROM animals a
JOIN visits v ON a.id = v.animal_id
JOIN vets ve ON v.vet_id = ve.id
JOIN species s ON a.species_id = s.id
WHERE ve.name = 'Maisy Smith'
GROUP BY s.name
ORDER By visit_count DESC
LIMIT 1;