CREATE DATABASE hamandeggs;

CREATE TABLE "files" (
  "id" SERIAL PRIMARY KEY,
  "name" text,
  "path" text NOT NULL,
  "recipe_id" int
);

CREATE TABLE "users" (
  "id" SERIAL PRIMARY KEY,
  "name" text NOT NULL,
  "email" text UNIQUE NOT NULL,
  "password" text NOT NULL,
  "is_admin" BOOLEAN NOT NULL DEFAULT false,
  "about" text,
  "instagram" text,
  "twitter" text,
  "profile_image" text,
  "created_at" timestamp DEFAULT (now()),
  "updated_at" timestamp DEFAULT (now()),
  "reset_token" text,
  "reset_token_expires" text
);

CREATE TABLE "diet_restriction" (
  "id" SERIAL PRIMARY KEY,
  "name" text NOT NULL
);
CREATE TABLE "meal_type" (
  "id" SERIAL PRIMARY KEY,
  "name" text NOT NULL
);
CREATE TABLE "world_cuisine" (
  "id" SERIAL PRIMARY KEY,
  "name" text NOT NULL
);

CREATE TABLE "difficulties" (
  "id" SERIAL PRIMARY KEY,
  "name" text NOT NULL
);


CREATE TABLE "recipes" (
  "id" SERIAL PRIMARY KEY,
  "title" text NOT NULL,
  "user_id" int,
  "serving_size" text,
  "cooking_time" int,
  "difficulty_id" int, 
  "ingredients" text[],
  "preparation" text[],
  "information" text,
  "diet_restriction_id" int,
  "meal_type_id" int,
  "world_cuisine_id" int,
  "created_at" timestamp DEFAULT (now()),
  "updated_at" timestamp DEFAULT (now())
);

CREATE TABLE "categories" (
  "id" SERIAL PRIMARY KEY,
  "name" text NOT NULL
);

CREATE TABLE "product_image" (
  "id" SERIAL PRIMARY KEY,
  "name" text,
  "path" text NOT NULL,
  "product_id" int
);

-- just admin can create an product
CREATE TABLE "products" (
  "id" SERIAL PRIMARY KEY,
  "category_id" int UNIQUE,
  "title" text NOT NULL,
  "description" text NOT NULL,
  "information" text[],
  "price" int NOT NULL,
  "quantity" int DEFAULT 1,
  "available" BOOLEAN NOT NULL DEFAULT true,
  "sale" int DEFAULT 1,
  "created_at" timestamp DEFAULT (now()),
  "updated_at" timestamp DEFAULT (now())
);

-- tabela de pedidos
CREATE TABLE "orders" (
  "id" SERIAL PRIMARY KEY,
  "user_id" int NOT NULL,
  "product_id" int NOT NULL,
  "price" int NOT NULL,
  "quantity" int DEFAULT 0,
  "total" int NOT NULL,
  "status" text DEFAULT 'open' NOT NULL,
  "created_at" timestamp DEFAULT (now()),
  "update_at" timestamp DEFAULT (now())
);


ALTER TABLE "files" ADD FOREIGN KEY ("recipe_id") REFERENCES "recipes" ("id");
ALTER TABLE "product_image" ADD FOREIGN KEY ("product_id") REFERENCES "products" ("id");
ALTER TABLE "products" ADD FOREIGN KEY ("category_id") REFERENCES "categories" ("id");
ALTER TABLE "orders" ADD FOREIGN KEY ("user_id") REFERENCES "users" ("id");
ALTER TABLE "orders" ADD FOREIGN KEY ("product_id") REFERENCES "products" ("id");
ALTER TABLE "recipes" ADD FOREIGN KEY ("user_id") REFERENCES "users" ("id");
ALTER TABLE "recipes" ADD FOREIGN KEY ("difficulty_id") REFERENCES "difficulties" ("id");
ALTER TABLE "recipes" ADD FOREIGN KEY ("diet_restriction_id") REFERENCES "diet_restriction" ("id");
ALTER TABLE "recipes" ADD FOREIGN KEY ("meal_type_id") REFERENCES "meal_type" ("id");
ALTER TABLE "recipes" ADD FOREIGN KEY ("world_cuisine_id") REFERENCES "world_cuisine" ("id");


-- create delete cascade
ALTER TABLE "recipes" DROP CONSTRAINT IF EXISTS recipes_user_id_fkey,
ADD CONSTRAINT recipes_user_id_fkey
FOREIGN KEY ("user_id") REFERENCES "users" ("id")
ON DELETE CASCADE;

ALTER TABLE "chefs" DROP CONSTRAINT IF EXISTS chefs_user_id_fkey,
ADD CONSTRAINT chefs_user_id_fkey
FOREIGN KEY ("user_id") REFERENCES "users" ("id")
ON DELETE CASCADE;

ALTER TABLE "profile_image" DROP CONSTRAINT IF EXISTS profile_image_chefs_id_fkey,
ADD CONSTRAINT profile_image_chefs_id_fkey
FOREIGN KEY ("chef_id") REFERENCES "chefs" ("id")
ON DELETE CASCADE;

ALTER TABLE "files" DROP CONSTRAINT IF EXISTS files_recipe_id_fkey,
ADD CONSTRAINT files_recipe_id_fkey 
FOREIGN KEY ("recipe_id") REFERENCES "recipes" ("id") 
ON DELETE CASCADE;

-- procedures
CREATE FUNCTION trigger_set_timestamp()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- UPDATE timestamp recipes
CREATE TRIGGER set_timestamp
BEFORE UPDATE ON recipes
FOR EACH ROW
EXECUTE PROCEDURE trigger_set_timestamp();

-- UPDATE timestamp chefs
CREATE TRIGGER set_timestamp
BEFORE UPDATE ON chefs
FOR EACH ROW
EXECUTE PROCEDURE trigger_set_timestamp();

-- UPDATE timestamp users
CREATE TRIGGER set_timestamp
BEFORE UPDATE ON users
FOR EACH ROW
EXECUTE PROCEDURE trigger_set_timestamp();

CREATE TRIGGER set_timestamp
BEFORE UPDATE ON orders
FOR EACH ROW
EXECUTE PROCEDURE trigger_set_timestamp();

-- connect pg simple table
CREATE TABLE "session" (
  "sid" varchar NOT NULL COLLATE "default",
	"sess" json NOT NULL,
	"expire" timestamp(6) NOT NULL
)
WITH (OIDS=FALSE);

ALTER TABLE "session" ADD CONSTRAINT "session_pkey" PRIMARY KEY ("sid") NOT DEFERRABLE INITIALLY IMMEDIATE;

CREATE INDEX "IDX_session_expire" ON "session" ("expire");


-- restart to run seed.js
DELETE FROM users;
DELETE FROM recipes;
DELETE FROM chefs;
DELETE FROM recipe_files;
DELETE FROM files;
DELETE FROM session;

-- restart sequence ids
ALTER SEQUENCE users_id_seq RESTART WITH 1;
ALTER SEQUENCE recipes_id_seq RESTART WITH 1;
ALTER SEQUENCE chefs_id_seq RESTART WITH 1;
ALTER SEQUENCE recipe_files_id_seq RESTART WITH 1;
ALTER SEQUENCE files_id_seq RESTART WITH 1;


----------------------------------------------
DELETE FROM recipes;
DELETE FROM users;
DELETE FROM files;

-- restart sequence auto_increment from tables ids
ALTER SEQUENCE recipes_id_seq RESTART WITH 1;
ALTER SEQUENCE users_id_seq RESTART WITH 1;
ALTER SEQUENCE files_id_seq RESTART WITH 1;


----------

-- SESSION

CREATE TABLE "session" (
  "sid" varchar NOT NULL COLLATE "default",
	"sess" json NOT NULL,
	"expire" timestamp(6) NOT NULL
)
WITH (OIDS=FALSE);

ALTER TABLE "session" ADD CONSTRAINT "session_pkey" PRIMARY KEY ("sid") NOT DEFERRABLE INITIALLY IMMEDIATE;

CREATE INDEX "IDX_session_expire" ON "session" ("expire");


------------------------------------------------------------

https://www.postgresql.org/docs/current/arrays.html#ARRAYS-INPUT
INSERT INTO sal_emp
    VALUES ('Bill',
    '{10000, 10000, 10000, 10000}',
    '{{"meeting", "lunch"}, {"meeting"}}');
ERROR:  multidimensional arrays must have array expressions with matching dimensions
The ARRAY constructor syntax can also be used:

INSERT INTO sal_emp
    VALUES ('Bill',
    ARRAY[10000, 10000, 10000, 10000],
    ARRAY[['meeting', 'lunch'], ['training', 'presentation']]);

INSERT INTO sal_emp
    VALUES ('Carol',
    ARRAY[20000, 25000, 25000, 25000],
    ARRAY[['breakfast', 'consulting'], ['meeting', 'lunch']]);