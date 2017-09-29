BEGIN TRANSACTION;

CREATE TABLE owner (
        owner_id serial,
        first_name varchar(255) NOT NULL,
        last_name varchar(255) NOT NULL,
        address varchar(255),
        phone_number char(14),
        CONSTRAINT pk_owner_id PRIMARY KEY (owner_id)    
);
 
 
CREATE TABLE pettype (
        pet_type_id serial,
        pet_type_name varchar(255) NOT NULL,
        CONSTRAINT pk_type_id PRIMARY KEY (pet_type_id)    
);

CREATE TABLE pet (
        pet_id serial,
        owner_id integer NOT NULL,
        pet_age integer,
        pet_name varchar(255) NOT NULL,
        pet_type_id integer NOT NULL,
        CONSTRAINT fk_pet_type_id FOREIGN KEY (pet_type_id) REFERENCES pettype(pet_type_id),
        CONSTRAINT fk_owner_id FOREIGN KEY (owner_id) REFERENCES owner(owner_id),
        CONSTRAINT pk_pet_id PRIMARY KEY (pet_id) 
);

CREATE TABLE visit (
        visit_id serial,
        pet_id integer NOT NULL,
        visit_date date NOT NULL,
        visit_price numeric NOT NULL,
        CONSTRAINT pk_visit_id PRIMARY KEY (visit_id),
        CONSTRAINT fk_pet_id FOREIGN KEY (pet_id) REFERENCES pet(pet_id)     
);

CREATE TABLE procedure (
        procedure_id serial,
        procedure_name varchar(255) NOT NULL,
        procedure_price varchar(255) NOT NULL,
        CONSTRAINT pk_proceducre_id PRIMARY KEY (procedure_id) 
); 
 
CREATE TABLE visit_procedure (
        visit_id integer NOT NULL,
        procedure_id integer NOT NULL,
        CONSTRAINT pk_visit_id_procedure_id PRIMARY KEY(visit_id,procedure_id), 
        CONSTRAINT fk_visit_id FOREIGN KEY(visit_id) REFERENCES visit(visit_id),
        CONSTRAINT fk_procedure_id FOREIGN KEY (procedure_id) REFERENCES procedure(procedure_id)
);

CREATE TABLE invoice (

        invoice_id serial,
        visit_id integer NOT NULL,
        total_amount numeric NOT NULL,
        CONSTRAINT pk_invoice_id PRIMARY KEY(invoice_id),
        CONSTRAINT fk_visit_id FOREIGN KEY (visit_id) REFERENCES visit(visit_id) 
);


 --INSERT INTO department (name) VALUES ('department name goes here')
 
 ROLLBACK;
 
 COMMIT;