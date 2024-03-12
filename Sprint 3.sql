#Nivel 1
#Ejercicio 2
UPDATE credit_card
SET iban ='R323456312213576817699999'
WHERE id = 'CcU-2938'
;

SELECT *
FROM credit_card
WHERE id= 'CcU-2938';

#Ejercicio 3
# Creo los registros en las tablas madres antes de cargar la transaccion en tabla hija para evitar integridad de datos
INSERT INTO company(id, company_name, phone, email, country, website)
VALUES ( 'b-9999', NULL, NULL, NULL, NULL, NULL);
INSERT INTO credit_card(id, iban, pan, pin, cvv, expiring_date)
VALUES ( 'CcU-9999', NULL, NULL, NULL, NULL, NULL);

# carga la nueva transaccion
INSERT INTO transaction(id, credit_card_id, company_id, user_id, lat, longitude, timestamp, amount, declined)
VALUES ( '108B1D1D-5B23-A76C-55EF-C568E49A99DD', 'CcU-9999', 'b-9999','9999', 829.999, -117.999, NULL, 111.11, 0);

SELECT * FROM transaction
WHERE ID= '108B1D1D-5B23-A76C-55EF-C568E49A99DD';

#Ejercicio 4
ALTER TABLE credit_card DROP COLUMN pan;

#Nivell 2
#Ejercicio 1
DELETE FROM transaction WHERE id='02C6201E-D90A-1859-B4EE-88D2986D3B02';

#Ejercicio 2
CREATE VIEW `vistamarketing` AS
SELECT company_name as Nombre, phone as Telefono, country as PaisResidencia, AVG(amount) as CompraMedia
FROM COMPANY
INNER JOIN transaction
on company.id = transaction.company_id
GROUP BY Company_name, phone, country
ORDER BY AVG(amount) DESC;
    
#Ejercicio 3
SELECT * FROM vistamarketing
WHERE PaisResidencia = 'Germany';

#Nivel 3
#Ejercicio 1
#eliminar columna website en tabla company
ALTER TABLE company DROP website;

#modificar el largo de una primarykey
# eliminar la restriccion
ALTER TABLE transaction
DROP FOREIGN KEY transaction_ibfk_2;

#modificar el tipo de la columna
ALTER TABLE credit_card
MODIFY ID VARCHAR(20);

#agregar la restriccion de nuevo
ALTER TABLE transaction
ADD CONSTRAINT transaction_ibfk_2
FOREIGN KEY (credit_card_id)
REFERENCES credit_card(id);

#modificar largo campo que no sea primarykey: iban,expiring_date y el tipo de cvv
ALTER TABLE credit_card
MODIFY iban VARCHAR(50), 
MODIFY expiring_date VARCHAR(10),
MODIFY cvv INT;

#añadir en tabla credit_card campo nuevo fecha_actual
ALTER TABLE credit_card
ADD fecha_actual DATE;

#modificar el nombre de una columna
ALTER TABLE user
CHANGE email personal_email VARCHAR(150);

#Ejercicio 2
CREATE VIEW InformeTecnico AS
SELECT transaction.id, 
user.name as Nom,
user.surname as Cognom,
credit_card.iban as IBAN,
company.company_name as Nom_companyia,
transaction.amount as Import
FROM transaction
JOIN user
ON transaction.user_id=user.id
JOIN credit_card
ON transaction.credit_card_id=credit_card.id
JOIN company
ON transaction.company_id= company.id
ORDER BY transaction.id DESC;
