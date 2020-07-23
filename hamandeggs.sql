--
-- PostgreSQL database dump
--

-- Dumped from database version 12.3
-- Dumped by pg_dump version 12.0

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: trigger_set_timestamp(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.trigger_set_timestamp() RETURNS trigger
    LANGUAGE plpgsql
    AS $$ 
BEGIN
NEW.updated_at = NOW();
RETURN NEW;
END;
$$;


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: categories; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.categories (
    id integer NOT NULL,
    name text NOT NULL
);


--
-- Name: categories_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.categories_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.categories_id_seq OWNED BY public.categories.id;


--
-- Name: diet_restriction; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.diet_restriction (
    id integer NOT NULL,
    name text NOT NULL
);


--
-- Name: diet_restriction_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.diet_restriction_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: diet_restriction_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.diet_restriction_id_seq OWNED BY public.diet_restriction.id;


--
-- Name: difficulties; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.difficulties (
    id integer NOT NULL,
    name text NOT NULL
);


--
-- Name: difficulties_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.difficulties_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: difficulties_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.difficulties_id_seq OWNED BY public.difficulties.id;


--
-- Name: files; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.files (
    id integer NOT NULL,
    name text,
    path text NOT NULL,
    recipe_id integer
);


--
-- Name: files_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.files_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: files_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.files_id_seq OWNED BY public.files.id;


--
-- Name: invoice; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.invoice (
    id integer NOT NULL,
    orders_id integer[],
    user_id integer,
    created_at timestamp without time zone DEFAULT now()
);


--
-- Name: invoice_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.invoice_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: invoice_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.invoice_id_seq OWNED BY public.invoice.id;


--
-- Name: meal_type; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.meal_type (
    id integer NOT NULL,
    name text NOT NULL
);


--
-- Name: meal_type_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.meal_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: meal_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.meal_type_id_seq OWNED BY public.meal_type.id;


--
-- Name: orders; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.orders (
    id integer NOT NULL,
    user_id integer NOT NULL,
    product_id integer NOT NULL,
    price integer NOT NULL,
    quantity integer DEFAULT 0,
    total integer NOT NULL,
    status text DEFAULT 'open'::text NOT NULL,
    created_at timestamp without time zone DEFAULT now(),
    update_at timestamp without time zone DEFAULT now()
);


--
-- Name: orders_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.orders_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: orders_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.orders_id_seq OWNED BY public.orders.id;


--
-- Name: product_image; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.product_image (
    id integer NOT NULL,
    name text,
    path text NOT NULL,
    product_id integer
);


--
-- Name: product_image_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.product_image_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: product_image_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.product_image_id_seq OWNED BY public.product_image.id;


--
-- Name: products; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.products (
    id integer NOT NULL,
    category_id integer,
    title text NOT NULL,
    description text NOT NULL,
    information text[],
    price double precision NOT NULL,
    quantity integer DEFAULT 1,
    available boolean DEFAULT true NOT NULL,
    sale double precision DEFAULT 1,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


--
-- Name: products_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.products_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: products_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.products_id_seq OWNED BY public.products.id;


--
-- Name: recipes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.recipes (
    id integer NOT NULL,
    title text NOT NULL,
    user_id integer,
    serving_size text,
    cooking_time integer,
    difficulty_id integer,
    ingredients text[],
    preparation text[],
    information text,
    diet_restriction_id integer,
    meal_type_id integer,
    world_cuisine_id integer,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


--
-- Name: recipes_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.recipes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: recipes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.recipes_id_seq OWNED BY public.recipes.id;


--
-- Name: session; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.session (
    sid character varying NOT NULL,
    sess json NOT NULL,
    expire timestamp(6) without time zone NOT NULL
);


--
-- Name: users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.users (
    id integer NOT NULL,
    name text NOT NULL,
    email text NOT NULL,
    password text NOT NULL,
    is_admin boolean DEFAULT false NOT NULL,
    about text,
    instagram text,
    twitter text,
    profile_image text,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now(),
    reset_token text,
    reset_token_expires text
);


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: world_cuisine; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.world_cuisine (
    id integer NOT NULL,
    name text NOT NULL
);


--
-- Name: world_cuisine_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.world_cuisine_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: world_cuisine_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.world_cuisine_id_seq OWNED BY public.world_cuisine.id;


--
-- Name: categories id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.categories ALTER COLUMN id SET DEFAULT nextval('public.categories_id_seq'::regclass);


--
-- Name: diet_restriction id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.diet_restriction ALTER COLUMN id SET DEFAULT nextval('public.diet_restriction_id_seq'::regclass);


--
-- Name: difficulties id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.difficulties ALTER COLUMN id SET DEFAULT nextval('public.difficulties_id_seq'::regclass);


--
-- Name: files id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.files ALTER COLUMN id SET DEFAULT nextval('public.files_id_seq'::regclass);


--
-- Name: invoice id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.invoice ALTER COLUMN id SET DEFAULT nextval('public.invoice_id_seq'::regclass);


--
-- Name: meal_type id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.meal_type ALTER COLUMN id SET DEFAULT nextval('public.meal_type_id_seq'::regclass);


--
-- Name: orders id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.orders ALTER COLUMN id SET DEFAULT nextval('public.orders_id_seq'::regclass);


--
-- Name: product_image id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product_image ALTER COLUMN id SET DEFAULT nextval('public.product_image_id_seq'::regclass);


--
-- Name: products id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.products ALTER COLUMN id SET DEFAULT nextval('public.products_id_seq'::regclass);


--
-- Name: recipes id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.recipes ALTER COLUMN id SET DEFAULT nextval('public.recipes_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Name: world_cuisine id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.world_cuisine ALTER COLUMN id SET DEFAULT nextval('public.world_cuisine_id_seq'::regclass);


--
-- Data for Name: categories; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.categories (id, name) FROM stdin;
1	book
2	artwork
3	clothe
4	toy
5	accessory
6	mug
7	plush
\.


--
-- Data for Name: diet_restriction; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.diet_restriction (id, name) FROM stdin;
1	Diabetic
2	Low Carb Recipes
3	Dairy Free Recipes
4	Gluten Free
5	Healthy
6	Heart-Healthy Recipes
7	High Fiber Recipes
8	Low Calorie
9	Low Cholesterol Recipes
10	Low Fat
11	Weight-Loss Recipes
12	none
13	Vegetarian
14	Vegan
\.


--
-- Data for Name: difficulties; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.difficulties (id, name) FROM stdin;
1	easy
2	medium
3	hard
4	harder
5	hardest
6	hardestest
7	darksouls
8	Dante must die
\.


--
-- Data for Name: files; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.files (id, name, path, recipe_id) FROM stdin;
170	1594917616506-photo-1484723091739-30a097e8f929.jpeg	public/images/1594917616506-photo-1484723091739-30a097e8f929.jpeg	1
1	http://lorempixel.com/640/480/food	public/images/placeholder.png	4
2	http://lorempixel.com/640/480/food	public/images/placeholder.png	11
3	http://lorempixel.com/640/480/food	public/images/placeholder.png	4
5	http://lorempixel.com/640/480/food	public/images/placeholder.png	4
6	http://lorempixel.com/640/480/food	public/images/placeholder.png	6
7	http://lorempixel.com/640/480/food	public/images/placeholder.png	5
8	http://lorempixel.com/640/480/food	public/images/placeholder.png	4
9	http://lorempixel.com/640/480/food	public/images/placeholder.png	15
12	http://lorempixel.com/640/480/food	public/images/placeholder.png	7
13	http://lorempixel.com/640/480/food	public/images/placeholder.png	7
14	http://lorempixel.com/640/480/food	public/images/placeholder.png	10
16	http://lorempixel.com/640/480/food	public/images/placeholder.png	7
17	http://lorempixel.com/640/480/food	public/images/placeholder.png	4
21	http://lorempixel.com/640/480/food	public/images/placeholder.png	9
25	http://lorempixel.com/640/480/food	public/images/placeholder.png	15
26	http://lorempixel.com/640/480/food	public/images/placeholder.png	11
27	http://lorempixel.com/640/480/food	public/images/placeholder.png	9
28	http://lorempixel.com/640/480/food	public/images/placeholder.png	10
29	http://lorempixel.com/640/480/food	public/images/placeholder.png	10
30	http://lorempixel.com/640/480/food	public/images/placeholder.png	10
31	http://lorempixel.com/640/480/food	public/images/placeholder.png	11
32	http://lorempixel.com/640/480/food	public/images/placeholder.png	3
33	http://lorempixel.com/640/480/food	public/images/placeholder.png	7
34	http://lorempixel.com/640/480/food	public/images/placeholder.png	4
35	http://lorempixel.com/640/480/food	public/images/placeholder.png	9
37	http://lorempixel.com/640/480/food	public/images/placeholder.png	10
38	http://lorempixel.com/640/480/food	public/images/placeholder.png	3
41	1594429188553-Screen Shot 2020-07-10 at 21.39.31.png	public/images/1594429188553-Screen Shot 2020-07-10 at 21.39.31.png	17
43	1594429188529-Screen Shot 2020-07-10 at 21.39.24.png	public/images/1594429188529-Screen Shot 2020-07-10 at 21.39.24.png	17
40	1594429188560-Screen Shot 2020-07-10 at 21.39.46.png	public/images/1594429188560-Screen Shot 2020-07-10 at 21.39.46.png	17
39	1594429188558-Screen Shot 2020-07-10 at 21.39.39.png	public/images/1594429188558-Screen Shot 2020-07-10 at 21.39.39.png	17
44	1594429188563-Screen Shot 2020-07-10 at 21.40.07.png	public/images/1594429188563-Screen Shot 2020-07-10 at 21.40.07.png	17
42	1594429188567-Screen Shot 2020-07-10 at 21.40.18.png	public/images/1594429188567-Screen Shot 2020-07-10 at 21.40.18.png	17
55	1594654308802-Screen Shot 2020-07-13 at 12.27.34.png	public/images/1594654308802-Screen Shot 2020-07-13 at 12.27.34.png	20
56	1594654308808-Screen Shot 2020-07-13 at 12.27.52.png	public/images/1594654308808-Screen Shot 2020-07-13 at 12.27.52.png	20
57	1594654308813-Screen Shot 2020-07-13 at 12.28.15.png	public/images/1594654308813-Screen Shot 2020-07-13 at 12.28.15.png	20
58	1594654308812-Screen Shot 2020-07-13 at 12.28.00.png	public/images/1594654308812-Screen Shot 2020-07-13 at 12.28.00.png	20
59	http://lorempixel.com/640/480/food	public/images/placeholder.png	28
60	http://lorempixel.com/640/480/food	public/images/placeholder.png	32
61	http://lorempixel.com/640/480/food	public/images/placeholder.png	43
63	http://lorempixel.com/640/480/food	public/images/placeholder.png	60
62	http://lorempixel.com/640/480/food	public/images/placeholder.png	38
64	http://lorempixel.com/640/480/food	public/images/placeholder.png	56
65	http://lorempixel.com/640/480/food	public/images/placeholder.png	21
66	http://lorempixel.com/640/480/food	public/images/placeholder.png	28
171	1594917616504-photo-1482049016688-2d3e1b311543.jpeg	public/images/1594917616504-photo-1482049016688-2d3e1b311543.jpeg	1
67	http://lorempixel.com/640/480/food	public/images/placeholder.png	55
169	1594917616521-photo-1540189549336-e6e99c3679fe.jpeg	public/images/1594917616521-photo-1540189549336-e6e99c3679fe.jpeg	1
68	http://lorempixel.com/640/480/food	public/images/placeholder.png	44
69	http://lorempixel.com/640/480/food	public/images/placeholder.png	52
70	http://lorempixel.com/640/480/food	public/images/placeholder.png	53
71	http://lorempixel.com/640/480/food	public/images/placeholder.png	59
72	http://lorempixel.com/640/480/food	public/images/placeholder.png	44
73	http://lorempixel.com/640/480/food	public/images/placeholder.png	25
74	http://lorempixel.com/640/480/food	public/images/placeholder.png	32
75	http://lorempixel.com/640/480/food	public/images/placeholder.png	42
76	http://lorempixel.com/640/480/food	public/images/placeholder.png	38
77	http://lorempixel.com/640/480/food	public/images/placeholder.png	48
78	http://lorempixel.com/640/480/food	public/images/placeholder.png	32
79	http://lorempixel.com/640/480/food	public/images/placeholder.png	53
80	http://lorempixel.com/640/480/food	public/images/placeholder.png	36
81	http://lorempixel.com/640/480/food	public/images/placeholder.png	55
82	http://lorempixel.com/640/480/food	public/images/placeholder.png	37
83	http://lorempixel.com/640/480/food	public/images/placeholder.png	46
84	http://lorempixel.com/640/480/food	public/images/placeholder.png	31
85	http://lorempixel.com/640/480/food	public/images/placeholder.png	39
86	http://lorempixel.com/640/480/food	public/images/placeholder.png	32
87	http://lorempixel.com/640/480/food	public/images/placeholder.png	59
88	http://lorempixel.com/640/480/food	public/images/placeholder.png	77
89	http://lorempixel.com/640/480/food	public/images/placeholder.png	83
90	http://lorempixel.com/640/480/food	public/images/placeholder.png	96
91	http://lorempixel.com/640/480/food	public/images/placeholder.png	93
92	http://lorempixel.com/640/480/food	public/images/placeholder.png	61
93	http://lorempixel.com/640/480/food	public/images/placeholder.png	87
94	http://lorempixel.com/640/480/food	public/images/placeholder.png	88
95	http://lorempixel.com/640/480/food	public/images/placeholder.png	98
96	http://lorempixel.com/640/480/food	public/images/placeholder.png	80
97	http://lorempixel.com/640/480/food	public/images/placeholder.png	87
98	http://lorempixel.com/640/480/food	public/images/placeholder.png	72
99	http://lorempixel.com/640/480/food	public/images/placeholder.png	87
100	http://lorempixel.com/640/480/food	public/images/placeholder.png	100
101	http://lorempixel.com/640/480/food	public/images/placeholder.png	68
102	http://lorempixel.com/640/480/food	public/images/placeholder.png	83
104	http://lorempixel.com/640/480/food	public/images/placeholder.png	66
103	http://lorempixel.com/640/480/food	public/images/placeholder.png	66
105	http://lorempixel.com/640/480/food	public/images/placeholder.png	68
106	http://lorempixel.com/640/480/food	public/images/placeholder.png	73
107	http://lorempixel.com/640/480/food	public/images/placeholder.png	88
108	http://lorempixel.com/640/480/food	public/images/placeholder.png	96
109	http://lorempixel.com/640/480/food	public/images/placeholder.png	88
110	http://lorempixel.com/640/480/food	public/images/placeholder.png	61
111	http://lorempixel.com/640/480/food	public/images/placeholder.png	62
112	http://lorempixel.com/640/480/food	public/images/placeholder.png	100
113	http://lorempixel.com/640/480/food	public/images/placeholder.png	99
114	http://lorempixel.com/640/480/food	public/images/placeholder.png	69
115	http://lorempixel.com/640/480/food	public/images/placeholder.png	99
116	http://lorempixel.com/640/480/food	public/images/placeholder.png	72
117	http://lorempixel.com/640/480/food	public/images/placeholder.png	100
118	http://lorempixel.com/640/480/food	public/images/placeholder.png	96
121	http://lorempixel.com/640/480/food	public/images/placeholder.png	94
127	http://lorempixel.com/640/480/food	public/images/placeholder.png	96
128	http://lorempixel.com/640/480/food	public/images/placeholder.png	61
131	http://lorempixel.com/640/480/food	public/images/placeholder.png	56
132	http://lorempixel.com/640/480/food	public/images/placeholder.png	15
133	http://lorempixel.com/640/480/food	public/images/placeholder.png	20
135	http://lorempixel.com/640/480/food	public/images/placeholder.png	92
136	http://lorempixel.com/640/480/food	public/images/placeholder.png	3
140	http://lorempixel.com/640/480/food	public/images/placeholder.png	44
141	http://lorempixel.com/640/480/food	public/images/placeholder.png	56
142	http://lorempixel.com/640/480/food	public/images/placeholder.png	62
143	http://lorempixel.com/640/480/food	public/images/placeholder.png	96
145	http://lorempixel.com/640/480/food	public/images/placeholder.png	58
148	http://lorempixel.com/640/480/food	public/images/placeholder.png	39
152	http://lorempixel.com/640/480/food	public/images/placeholder.png	3
154	http://lorempixel.com/640/480/food	public/images/placeholder.png	94
146	http://lorempixel.com/640/480/food	public/images/placeholder.png	73
151	http://lorempixel.com/640/480/food	public/images/placeholder.png	93
153	http://lorempixel.com/640/480/food	public/images/placeholder.png	58
156	http://lorempixel.com/640/480/food	public/images/placeholder.png	21
157	http://lorempixel.com/640/480/food	public/images/placeholder.png	25
160	http://lorempixel.com/640/480/food	public/images/placeholder.png	17
161	http://lorempixel.com/640/480/food	public/images/placeholder.png	55
163	http://lorempixel.com/640/480/food	public/images/placeholder.png	99
165	http://lorempixel.com/640/480/food	public/images/placeholder.png	6
166	http://lorempixel.com/640/480/food	public/images/placeholder.png	32
\.


--
-- Data for Name: invoice; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.invoice (id, orders_id, user_id, created_at) FROM stdin;
1	{1,2,3}	16	2020-07-22 16:30:15.999719
\.


--
-- Data for Name: meal_type; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.meal_type (id, name) FROM stdin;
1	Breakfast and Brunch
3	Desserts
2	Lunch
4	Dinners
5	Snacks
\.


--
-- Data for Name: orders; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.orders (id, user_id, product_id, price, quantity, total, status, created_at, update_at) FROM stdin;
2	16	13	1090	1	1090	open	2020-07-22 14:35:48.447391	2020-07-22 14:35:48.447391
3	16	1	1999	2	3998	open	2020-07-22 14:35:48.447696	2020-07-22 14:35:48.447696
1	16	9	7500	2	15000	completed	2020-07-22 14:35:48.447308	2020-07-22 14:35:48.447308
\.


--
-- Data for Name: product_image; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.product_image (id, name, path, product_id) FROM stdin;
1	1594860527244-Screen Shot 2020-07-15 at 21.36.24.png	public/images/1594860527244-Screen Shot 2020-07-15 at 21.36.24.png	1
4	1594910964112-cat-in-the-hat-by-jim-shore-statue.jpg	public/images/1594910964112-cat-in-the-hat-by-jim-shore-statue.jpg	5
7	1594911629720-Screen Shot 2020-07-16 at 11.50.23.png	public/images/1594911629720-Screen Shot 2020-07-16 at 11.50.23.png	5
9	1594920935764-fox-in-socks-and-socks-in-box-set.jpg	public/images/1594920935764-fox-in-socks-and-socks-in-box-set.jpg	8
10	1594921064115-loungefly-the-grinch-faux-leather-mini-backpack-alt-1.jpg	public/images/1594921064115-loungefly-the-grinch-faux-leather-mini-backpack-alt-1.jpg	9
11	1594921064124-loungefly-the-grinch-faux-leather-mini-backpack-alt-3.jpg	public/images/1594921064124-loungefly-the-grinch-faux-leather-mini-backpack-alt-3.jpg	9
12	1594921064120-loungefly-the-grinch-faux-leather-mini-backpack-alt-2.jpg	public/images/1594921064120-loungefly-the-grinch-faux-leather-mini-backpack-alt-2.jpg	9
13	1594921064129-loungefly-the-grinch-faux-leather-mini-backpack.jpg	public/images/1594921064129-loungefly-the-grinch-faux-leather-mini-backpack.jpg	9
14	1594921137324-the-grinch-knee-high-sock-alt2.jpg	public/images/1594921137324-the-grinch-knee-high-sock-alt2.jpg	10
15	1594921137328-the-grinch-knee-high-sock.jpg	public/images/1594921137328-the-grinch-knee-high-sock.jpg	10
16	1594921687287-dr-seuss-cat-in-the-hat-oval-ceramic-mug.jpg	public/images/1594921687287-dr-seuss-cat-in-the-hat-oval-ceramic-mug.jpg	11
17	1595017842120-horton-hears-a-who-horton-6-stuffed-figure.jpg	public/images/1595017842120-horton-hears-a-who-horton-6-stuffed-figure.jpg	12
18	1595017959923-thing-1-thing-2-crew-socks.jpg	public/images/1595017959923-thing-1-thing-2-crew-socks.jpg	13
19	1595018035307-dr-seuss-grinch-ceramic-mug.jpg	public/images/1595018035307-dr-seuss-grinch-ceramic-mug.jpg	14
20	1595018035354-dr-seuss-grinch-ceramic-mug2.jpg	public/images/1595018035354-dr-seuss-grinch-ceramic-mug2.jpg	14
21	1595033355839-cat-in-the-hat-by-jim-shore-statue2.jpg	public/images/1595033355839-cat-in-the-hat-by-jim-shore-statue2.jpg	5
\.


--
-- Data for Name: products; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.products (id, category_id, title, description, information, price, quantity, available, sale, created_at, updated_at) FROM stdin;
12	4	Horton Hears a Who Horton 6	Horton Hears a Who Horton 6	{"A Plush Is a PlushNo Matter How Small.;This wee Horton is not elephant sizedbut he still has a huge heart! Snuggle up with a much loved Dr. Seuss character with a Horton Hears a Who Horton 6' Stuffed Figure. He has proven himself a very loyal friend!"}	1699	5	t	1	2020-07-17 17:30:42.156569	2020-07-17 17:30:42.156569
11	6	Dr. Seuss Cat in the Hat Oval Ceramic Mug	Dr. Seuss Cat in the Hat Oval Ceramic Mug 18 oz. capacity Microwave and dishwasher safe 4.5	{"It’s a question that we’ve often pondered. How does The Cat in the Hat remain so full of energy? He does a regular circus act in front of Sally and her brother. He wrangles a couple of wacky creaturesnamed Thing 1 and Thing 2into the house. Thenonce they ran amok in the househe captures them with ease just in time before the children’s mother gets home! Boyhe must drink a TON of coffee if he has the energy for all that in a single day.;Of courseus humans usually need to drink a bit of coffee to feel energizedso why not do it the Dr. Seuss way using this Cat in the Hat Mug?;This Dr. Seuss inspired mug is made entirely out of ceramic and it is microwave and dishwasher safe. It has an 18-ounce capacityperfect for getting in your daily dose of coffee or tea. It has a vibrant illustration of The Cat in the Hat on the side and a nicelarge handle!;Fans of the Dr. Seuss book will love drinking their coffee out of this Cat in the Hat Mug. It also makes a great gift for teachers and bookworms!"}	1299	200	t	1	2020-07-16 14:48:07.309339	2020-07-16 14:48:07.309339
8	3	Fox in Socks and Socks in Box	Socks: 97% polyester, 2% spandex, 1% rubber Board book has 24 pages w/ large-print typeface and cartoon-style illustrations Knitted-in image on top and nonslip rubber grips on bottom of socks Socks are size 4-5.5 and will fit a baby/toddler from 12-36 months	{"Looking for a new book for the wee one in your life? This Fox in Socks and Socks in Box Set is a fantastic combo for little storylovers with little toes. The nonslip-bottomed socks fit 12 to 36-month-old kiddos. Slip them on for a snuggly reading session.@Items Included: Book and Pair of Socks."}	1199	1001	t	0.9	2020-07-16 14:35:35.780373	2020-07-16 14:35:35.780373
9	5	Loungefly The Grinch Mini Faux Leather Backpack	Faux leather shell w/ fabric lining, zipper closures Outer dimensions: 9	{"Look at that cheek-to-cheek smile. This happy Grinch must be up to something. But what is it? Is he trying to steal Christmas again or are there gifts for his favorite Whos tucked inside? We suppose you’ll get to decide when you add this Loungefly The Grinch mini backpack to your wardrobe. Whether you’re giving or receivingthis faux leather accessory is a must-have for any Dr."}	7500	13	t	1	2020-07-16 14:37:44.132705	2020-07-16 14:37:44.132705
1	6	Dr. Seuss- Cat In The Hat 16 oz. Sculpted Ceramic Mug	Ceramic mug has 16 oz capacity	{"The Cat in the Hat performs plenty of tricks with that fabulous cap of his. But our favorite one yet is this.;Wake up in the morning with 16 ounces to sipbrighten a cloudyno-fun gloomor celebrate a playful Dr. Seuss Day."}	1999	4994	t	1	2020-07-15 21:48:47.261563	2020-07-15 21:48:47.261563
14	6	Dr. Seuss Grinch Ceramic Mug	18 oz. capacity molded ceramic mug Hand-wash only, not dishwasher safe	{"While the Grinch looks down upon Whoville from his mountainhe likes to pity the Whos while he sips on something hot. Sometimes he's drinking coffeesometimes teasometimes hot cider. It's always a hot beverage because he needs to warm his icy heart. You can be certain that he is always drinking out of this Dr. Seuss Grinch Ceramic Mug. You should too if you're particularly grumpy in the moments. It's the perfect mug for morning Grinches."}	1699	5	t	0.9	2020-07-17 17:33:55.548097	2020-07-17 17:33:55.548097
5	4	Cat in the Hat by Jim Shore Statue	Molded resin figurine Approx. 10	{"Bring home the most celebrated Dr. Seuss character of all time with this Cat in the Hat Statue created by the amazing Jim Shore! This statue stands 10 inches tall and will make the perfect centerpiece for your collection of Dr.@Ohand we promise that The Cat in the Hat has no plans to turn your house into a messy disaster... All should be back to normalfor the most partat the end of every day."}	5000	1000	t	0.8	2020-07-16 11:49:24.155815	2020-07-16 11:49:24.155815
10	3	Women The Grinch Knee High Sock	The Grinch Knee High Sock 68%acrylic; 30% nylon; 2% spandex Socks have woven design on top	{"Items Included: One Pair of Socks.;Even the Grinch likes to kick up his feet and take stock of life once and a while. Now you can settle in for a bit of holiday-themed R&R with these The Grinch Knee-High Socks! These officially-licensed socks pair together to create the Grinch's signature grumpy mug."}	1199	200	t	1	2020-07-16 14:38:57.332562	2020-07-16 14:38:57.332562
13	3	Adult Thing 1 & Thing 2 Crew Socks	Thing 1 & Thing 2 Crew Socks 68%acrylic; 30% nylon; 2% spandex Socks have woven design on top	{"Rhyme Time When you do not know what it is you should dowe recommend a walk on Foot 1 and Foot 2. After allhaving two feet means that you can play...and runand jumpand frolick all day. But what if the weather should be not so sunny? Or a chill in the air makes your feet feel real funny? Should you sitsad at homelike you're locked in a box? No! You should cover your toes with Thing 1 & Thing 2 Crew Socks!   Now isn't that better? Now isn't that FUN? Now isn't having two Thing socks better than one? You're welcomeno worries—we were happy to do it. No get out there and prove there's no-Thing 1 and -Thing 2 it.@Fun Details These cute crew socks bring everyone's favorite Things to life! Vibrant red-knit bases feature the blue hairwhite facesand signature Thing 1 and Thing 2 labels of Dr. Suess' classic mischief-makers. The best part about these blue-toed beauties is that you can proudly display them beneath a short dress or rolled pantsor you can hide them behind a longer hem and get a kick out of secretly knowing you've upped the fun of your business attire!.@There's Mayhem Afoot So have fun with your new socks—we hear your goal was to try to take life a little seriously. We must sayyou're starting out on the right foot!"}	1090	16	t	1	2020-07-17 17:32:39.931381	2020-07-17 17:32:39.931381
\.


--
-- Data for Name: recipes; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.recipes (id, title, user_id, serving_size, cooking_time, difficulty_id, ingredients, preparation, information, diet_restriction_id, meal_type_id, world_cuisine_id, created_at, updated_at) FROM stdin;
11	Product Program Producer	5	5	26	3	{"3 kg de carne moída (escolha uma carne magra e macia)","300 g de bacon moído","1 ovo","3 colheres (sopa) de farinha de trigo","3 colheres (sopa) de tempero caseiro: feito com alho, sal, cebola, pimenta e cheiro verde processados no liquidificador","30 ml de água gelada"}	{"Misture todos os ingredientes muito bem e amasse para que fique tudo muito bem misturado","Faça porções de 90 g a 100 g","Forre um plástico molhado em uma bancada e modele os hambúrgueres utilizando um aro como base","Faça um de cada vez e retire o aro logo em seguida","Forre uma assadeira de metal com plástico, coloque os hambúrgueres e intercale camadas de carne e plásticos (sem apertar)","Faça no máximo 4 camadas por forma e leve para congelar","Retire do congelador, frite ou asse e está pronto"}	Dolores libero tempore minima sapiente. Vitae et magnam. Inventore quia tenetur asperiores accusamus quisquam sed. Quia facilis excepturi. Itaque ullam deserunt molestiae.	8	4	11	2020-06-25 22:29:19.303092	2020-06-25 22:29:19.303092
1	National Branding Architect	16	6	12	7	{"3 kg de carne moída (escolha uma carne magra e macia)","300 g de bacon moído","1 ovo","3 colheres (sopa) de farinha de trigo","3 colheres (sopa) de tempero caseiro: feito com alho",sal,cebola,"pimenta e cheiro verde processados no liquidificador","30 ml de água gelada"}	{"Misture todos os ingredientes muito bem e amasse para que fique tudo muito bem misturado.@","Faça porções de 90 g a 100 gForre um plástico molhado em uma bancada e modele os hambúrgueres utilizando um aro como base.@","Faça um de cada vez e retire o aro logo em seguidaForre uma assadeira de metal com plástico","coloque os hambúrgueres e intercale camadas de carne e plásticos (sem apertar)Faça no máximo 4 camadas por forma e leve para congelar.@","Retire do congelador","frite ou asse e está pronto.@"}	Cum nihil consequuntur in. Adipisci quia laborum numquam minima est vel in. Rerum ea inventore saepe ullam provident aut beatae consectetur.	8	5	16	2020-06-25 22:29:19.296034	2020-06-25 22:29:19.296034
20	Agua Fresca de Pepino (Cucumber Limeade)	20	6	5	1	{"5 cups water","or to taste","3 eaches cucumbers","peeled and chopped","½ cup freshly squeezed lime juice","¼ cup granular sucralose sweetener (such as Splenda®)","or to taste"}	{"Blend 2 cups water",cucumbers,"lime juice","and 2 tablespoons sweetener together in a blender until smooth. Pour into pitcher; add remaining water. Stir in additional sweetener to taste.@"}	This is another common agua fresca from Mexico. Refreshing, healthy, and delicious! Serve over ice.\r\n\r\nNutrition Facts\r\nPer Serving:\r\n5.1 calories; 0.1 g protein; 1.7 g carbohydrates; 0 mg cholesterol; 6.3 mg sodium.	1	5	12	2020-07-13 12:31:48.9339	2020-07-13 12:31:48.9339
17	Pepperoni Meatza	20	6	45	2	{"1 tablespoon salt","1 teaspoon caraway seeds","1 teaspoon dried oregano","1 teaspoon garlic salt","1 teaspoon ground black pepper","1 teaspoon red pepper flakes","or to taste","2 eggs","½ cup grated Parmesan cheese","1 (12 ounce) package shredded mozzarella cheese","1 cup tomato sauce","1 (3.5 ounce) package sliced pepperoni","or to taste"}	{"Preheat oven to 450 degrees F (230 degrees C).","Mix together salt","caraway seeds",oregano,"garlic salt","ground black pepper","and crushed red pepper flakes in a small bowl.","Mix ground beef and eggs in a mixing bowl until thoroughly incorporated. Add Parmesan cheese and seasoning mixture to beef; combine. Press ground beef mixture into a 12x17-inch pan","spread out evenly.","Bake in the preheated oven until meat is no longer pink","about 10 minutes. Drain grease.","Set oven rack about 6 inches from the heat source and turn on the oven's broiler.","Sprinkle 1/3 of the mozzarella cheese over baked meat","followed by tomato sauce in an even layer. Sprinkle another 1/3 of the mozzarella cheese over the sauce and top with slices of pepperoni. Sprinkle remaining mozzarella cheese over pizza.","Broil until cheese is melted",bubbling,"and lightly browned","3 to 5 minutes."}	For people that are gluten-intolerant, low-carb, paleo, or whatever, it can be hard to go without pizza. This dish makes it a lot easier. It is made pretty much exactly the same as pizza, but with ground beef as the crust. Sounds weird at first, but it is absolutely delicious and very filling. This is something great to make ahead of time and then eat as leftovers later on. It's great hot or cold, just like pizza! I find that if you make 6 square slices, each slice is usually more than enough to fill you up. Feel free to add whatever toppings you normally eat on pizza. It will taste just as good!	2	4	11	2020-07-10 21:59:48.57222	2020-07-10 21:59:48.57222
3	Future Response Executive	14	2	6	2	{"3 kg de carne moída (escolha uma carne magra e macia)","300 g de bacon moído","1 ovo","3 colheres (sopa) de farinha de trigo","3 colheres (sopa) de tempero caseiro: feito com alho, sal, cebola, pimenta e cheiro verde processados no liquidificador","30 ml de água gelada"}	{"Misture todos os ingredientes muito bem e amasse para que fique tudo muito bem misturado","Faça porções de 90 g a 100 g","Forre um plástico molhado em uma bancada e modele os hambúrgueres utilizando um aro como base","Faça um de cada vez e retire o aro logo em seguida","Forre uma assadeira de metal com plástico, coloque os hambúrgueres e intercale camadas de carne e plásticos (sem apertar)","Faça no máximo 4 camadas por forma e leve para congelar","Retire do congelador, frite ou asse e está pronto"}	Alias enim eum explicabo nesciunt laudantium. Magnam molestias exercitationem corporis quas aspernatur saepe. Placeat dicta animi ut sit reiciendis iusto amet totam consectetur. Ut placeat unde asperiores perferendis veniam. Eum deleniti ut rerum incidunt aperiam. Ipsam minus possimus quas. Reprehenderit vel explicabo sit dolores. Quia ut quidem. Quos nobis totam.	2	4	9	2020-06-25 22:29:19.295941	2020-06-25 22:29:19.295941
21	Corporate Intranet Coordinator	56	6	4	2	{"3 kg de carne moída (escolha uma carne magra e macia)","300 g de bacon moído","1 ovo","3 colheres (sopa) de farinha de trigo","3 colheres (sopa) de tempero caseiro: feito com alho, sal, cebola, pimenta e cheiro verde processados no liquidificador","30 ml de água gelada"}	{"Combine milk with vinegar in a medium bowl and set aside for 5 minutes to sour.@","Combine flour,sugar,baking powder,baking soda,and salt in a large mixing bowl. Whisk egg and butter into soured milk. Pour the flour mixture into the wet ingredients and whisk until lumps are gone.@","Heat a large skillet over medium heat,and coat with cooking spray. Pour 1/4 cupfuls of batter onto the skillet,and cook until bubbles appear on the surface. Flip with a spatula,and cook until browned on the other side.@"}	Quis beatae et ut vel reprehenderit cumque et harum. Similique eius odio dolores. Rem aut unde aut commodi dolorem aspernatur ullam maiores voluptatem. Laborum et fugiat fuga earum doloribus quam doloribus enim sunt. Quia ipsam nobis laborum dolore ullam neque quaerat culpa et. Rerum ipsa distinctio sint cumque voluptatibus autem aut culpa. Sit sit itaque aut vel neque et dolor veniam. Esse doloremque eum aut magni cum vel.	11	1	10	2020-07-14 08:45:40.785814	2020-07-14 08:45:40.785814
4	Future Implementation Agent	7	2	2	3	{"3 kg de carne moída (escolha uma carne magra e macia)","300 g de bacon moído","1 ovo","3 colheres (sopa) de farinha de trigo","3 colheres (sopa) de tempero caseiro: feito com alho, sal, cebola, pimenta e cheiro verde processados no liquidificador","30 ml de água gelada"}	{"Misture todos os ingredientes muito bem e amasse para que fique tudo muito bem misturado","Faça porções de 90 g a 100 g","Forre um plástico molhado em uma bancada e modele os hambúrgueres utilizando um aro como base","Faça um de cada vez e retire o aro logo em seguida","Forre uma assadeira de metal com plástico, coloque os hambúrgueres e intercale camadas de carne e plásticos (sem apertar)","Faça no máximo 4 camadas por forma e leve para congelar","Retire do congelador, frite ou asse e está pronto"}	Fugiat voluptate numquam est sint illum. Autem voluptatibus distinctio porro optio facere. Debitis nihil qui. Dolor voluptas eum iste dolore. Quibusdam assumenda aut. Consequatur voluptatem totam modi enim magni tempore. Id maiores fuga quia ad animi est ipsa ipsam. Facilis dolores ullam facilis quia est quo natus. Rerum ipsam animi culpa aut aut neque sequi minima. Quaerat nobis rem libero ut qui ipsam sint aut sapiente.	5	3	1	2020-06-25 22:29:19.29698	2020-06-25 22:29:19.29698
15	International Applications Consultant	11	2	40	4	{"3 kg de carne moída (escolha uma carne magra e macia)","300 g de bacon moído","1 ovo","3 colheres (sopa) de farinha de trigo","3 colheres (sopa) de tempero caseiro: feito com alho, sal, cebola, pimenta e cheiro verde processados no liquidificador","30 ml de água gelada"}	{"Misture todos os ingredientes muito bem e amasse para que fique tudo muito bem misturado","Faça porções de 90 g a 100 g","Forre um plástico molhado em uma bancada e modele os hambúrgueres utilizando um aro como base","Faça um de cada vez e retire o aro logo em seguida","Forre uma assadeira de metal com plástico, coloque os hambúrgueres e intercale camadas de carne e plásticos (sem apertar)","Faça no máximo 4 camadas por forma e leve para congelar","Retire do congelador, frite ou asse e está pronto"}	Voluptatem architecto aspernatur molestiae. Numquam dolores officia similique nulla qui unde magni. Non est molestiae soluta hic ab aut ut. Velit delectus doloremque possimus et. Nam eum placeat voluptatibus cupiditate quia quae saepe hic. Sint dolor quis exercitationem placeat mollitia quidem saepe. Error porro corporis id ea vel nulla maiores. Animi est aperiam explicabo distinctio excepturi amet non ab. Et ut consequuntur sed qui est et itaque. Hic tenetur ipsam officia eligendi odio tenetur quae.	3	3	14	2020-06-25 22:29:19.303702	2020-06-25 22:29:19.303702
5	International Integration Administrator	1	10	31	5	{"3 kg de carne moída (escolha uma carne magra e macia)","300 g de bacon moído","1 ovo","3 colheres (sopa) de farinha de trigo","3 colheres (sopa) de tempero caseiro: feito com alho, sal, cebola, pimenta e cheiro verde processados no liquidificador","30 ml de água gelada"}	{"Misture todos os ingredientes muito bem e amasse para que fique tudo muito bem misturado","Faça porções de 90 g a 100 g","Forre um plástico molhado em uma bancada e modele os hambúrgueres utilizando um aro como base","Faça um de cada vez e retire o aro logo em seguida","Forre uma assadeira de metal com plástico, coloque os hambúrgueres e intercale camadas de carne e plásticos (sem apertar)","Faça no máximo 4 camadas por forma e leve para congelar","Retire do congelador, frite ou asse e está pronto"}	Qui illo nemo officia.	4	2	17	2020-06-25 22:29:19.298407	2020-06-25 22:29:19.298407
31	Direct Research Technician	75	1	3	2	{"3 kg de carne moída (escolha uma carne magra e macia)","300 g de bacon moído","1 ovo","3 colheres (sopa) de farinha de trigo","3 colheres (sopa) de tempero caseiro: feito com alho, sal, cebola, pimenta e cheiro verde processados no liquidificador","30 ml de água gelada"}	{"Combine milk with vinegar in a medium bowl and set aside for 5 minutes to sour.@","Combine flour,sugar,baking powder,baking soda,and salt in a large mixing bowl. Whisk egg and butter into soured milk. Pour the flour mixture into the wet ingredients and whisk until lumps are gone.@","Heat a large skillet over medium heat,and coat with cooking spray. Pour 1/4 cupfuls of batter onto the skillet,and cook until bubbles appear on the surface. Flip with a spatula,and cook until browned on the other side.@"}	Qui qui doloremque dolorum expedita magnam sit voluptatem beatae. Qui ut totam. Error dolores culpa ut qui laudantium nulla soluta quod rerum. Quo possimus et. Error debitis repudiandae. Explicabo reiciendis id nulla sed illum nesciunt sapiente saepe non. Quia qui ipsam vero deleniti in. Aut reiciendis totam dolorum mollitia. Possimus in neque porro quia et blanditiis. Rerum vitae quis. Perspiciatis nemo voluptatem odit alias.	9	4	17	2020-07-14 08:45:40.820291	2020-07-14 08:45:40.820291
6	Direct Program Supervisor	8	3	32	6	{"3 kg de carne moída (escolha uma carne magra e macia)","300 g de bacon moído","1 ovo","3 colheres (sopa) de farinha de trigo","3 colheres (sopa) de tempero caseiro: feito com alho, sal, cebola, pimenta e cheiro verde processados no liquidificador","30 ml de água gelada"}	{"Misture todos os ingredientes muito bem e amasse para que fique tudo muito bem misturado","Faça porções de 90 g a 100 g","Forre um plástico molhado em uma bancada e modele os hambúrgueres utilizando um aro como base","Faça um de cada vez e retire o aro logo em seguida","Forre uma assadeira de metal com plástico, coloque os hambúrgueres e intercale camadas de carne e plásticos (sem apertar)","Faça no máximo 4 camadas por forma e leve para congelar","Retire do congelador, frite ou asse e está pronto"}	Voluptatem consequatur rerum accusamus ratione distinctio facilis modi nostrum et. Culpa sit consectetur officiis a. Explicabo odit ex non. Ipsam nesciunt et non. Laboriosam enim dolore omnis voluptatibus et doloremque et eius qui. Sed est doloremque blanditiis velit ipsum adipisci pariatur. Accusamus dolorem et expedita quia sit magni eius vero.	9	3	16	2020-06-25 22:29:19.29894	2020-06-25 22:29:19.29894
7	Principal Brand Director	6	5	30	4	{"3 kg de carne moída (escolha uma carne magra e macia)","300 g de bacon moído","1 ovo","3 colheres (sopa) de farinha de trigo","3 colheres (sopa) de tempero caseiro: feito com alho, sal, cebola, pimenta e cheiro verde processados no liquidificador","30 ml de água gelada"}	{"Misture todos os ingredientes muito bem e amasse para que fique tudo muito bem misturado","Faça porções de 90 g a 100 g","Forre um plástico molhado em uma bancada e modele os hambúrgueres utilizando um aro como base","Faça um de cada vez e retire o aro logo em seguida","Forre uma assadeira de metal com plástico, coloque os hambúrgueres e intercale camadas de carne e plásticos (sem apertar)","Faça no máximo 4 camadas por forma e leve para congelar","Retire do congelador, frite ou asse e está pronto"}	Sint voluptatem sit quo quia officia. Enim qui voluptas.	5	5	10	2020-06-25 22:29:19.299001	2020-06-25 22:29:19.299001
9	Forward Usability Assistant	11	8	5	1	{"3 kg de carne moída (escolha uma carne magra e macia)","300 g de bacon moído","1 ovo","3 colheres (sopa) de farinha de trigo","3 colheres (sopa) de tempero caseiro: feito com alho, sal, cebola, pimenta e cheiro verde processados no liquidificador","30 ml de água gelada"}	{"Misture todos os ingredientes muito bem e amasse para que fique tudo muito bem misturado","Faça porções de 90 g a 100 g","Forre um plástico molhado em uma bancada e modele os hambúrgueres utilizando um aro como base","Faça um de cada vez e retire o aro logo em seguida","Forre uma assadeira de metal com plástico, coloque os hambúrgueres e intercale camadas de carne e plásticos (sem apertar)","Faça no máximo 4 camadas por forma e leve para congelar","Retire do congelador, frite ou asse e está pronto"}	Eaque iusto ut ab beatae error ratione qui aliquam. Dicta quis et consequatur aliquid. At maiores recusandae. Illum numquam quo eius recusandae.	6	3	9	2020-06-25 22:29:19.301012	2020-06-25 22:29:19.301012
25	Legacy Functionality Assistant	63	10	40	7	{"3 kg de carne moída (escolha uma carne magra e macia)","300 g de bacon moído","1 ovo","3 colheres (sopa) de farinha de trigo","3 colheres (sopa) de tempero caseiro: feito com alho, sal, cebola, pimenta e cheiro verde processados no liquidificador","30 ml de água gelada"}	{"Combine milk with vinegar in a medium bowl and set aside for 5 minutes to sour.@","Combine flour,sugar,baking powder,baking soda,and salt in a large mixing bowl. Whisk egg and butter into soured milk. Pour the flour mixture into the wet ingredients and whisk until lumps are gone.@","Heat a large skillet over medium heat,and coat with cooking spray. Pour 1/4 cupfuls of batter onto the skillet,and cook until bubbles appear on the surface. Flip with a spatula,and cook until browned on the other side.@"}	In qui officiis quis dolorem aliquid ipsum officiis nihil. Sit a et aut ut. Voluptas necessitatibus repellat ipsam ipsam qui sit ut. Culpa ipsam aliquid sed magni ut sit quia et rerum. Aliquam porro aut dignissimos distinctio distinctio mollitia modi voluptatum quae. Voluptates incidunt nostrum adipisci omnis animi ut eius autem error. Natus repellat exercitationem eum molestias mollitia minima.	4	4	14	2020-07-14 08:45:40.786714	2020-07-14 08:45:40.786714
10	National Directives Facilitator	12	4	33	7	{"3 kg de carne moída (escolha uma carne magra e macia)","300 g de bacon moído","1 ovo","3 colheres (sopa) de farinha de trigo","3 colheres (sopa) de tempero caseiro: feito com alho, sal, cebola, pimenta e cheiro verde processados no liquidificador","30 ml de água gelada"}	{"Misture todos os ingredientes muito bem e amasse para que fique tudo muito bem misturado","Faça porções de 90 g a 100 g","Forre um plástico molhado em uma bancada e modele os hambúrgueres utilizando um aro como base","Faça um de cada vez e retire o aro logo em seguida","Forre uma assadeira de metal com plástico, coloque os hambúrgueres e intercale camadas de carne e plásticos (sem apertar)","Faça no máximo 4 camadas por forma e leve para congelar","Retire do congelador, frite ou asse e está pronto"}	Et in dolorem excepturi perspiciatis a ut laborum rerum eos. Consectetur ea est consectetur mollitia quis adipisci deserunt possimus nisi.	6	2	16	2020-06-25 22:29:19.300981	2020-06-25 22:29:19.300981
28	Regional Interactions Officer	58	1	12	5	{"3 kg de carne moída (escolha uma carne magra e macia)","300 g de bacon moído","1 ovo","3 colheres (sopa) de farinha de trigo","3 colheres (sopa) de tempero caseiro: feito com alho, sal, cebola, pimenta e cheiro verde processados no liquidificador","30 ml de água gelada"}	{"Combine milk with vinegar in a medium bowl and set aside for 5 minutes to sour.@","Combine flour,sugar,baking powder,baking soda,and salt in a large mixing bowl. Whisk egg and butter into soured milk. Pour the flour mixture into the wet ingredients and whisk until lumps are gone.@","Heat a large skillet over medium heat,and coat with cooking spray. Pour 1/4 cupfuls of batter onto the skillet,and cook until bubbles appear on the surface. Flip with a spatula,and cook until browned on the other side.@"}	Est quis blanditiis sit ab vel esse rerum. Consequatur assumenda incidunt non sit quia id aut ipsa. Aut quod odio. In officia sapiente sit ea ea. Eligendi dolores in non nisi harum saepe iusto. Iusto quae reiciendis. Nam repellat accusamus sapiente eos. Iusto ea debitis suscipit corrupti perspiciatis. Ex vel temporibus eos aut distinctio sapiente nihil cumque ut. Tempora inventore architecto eum quos quos tenetur sunt ab tempora. Nulla nostrum in sapiente qui explicabo possimus ipsam excepturi.	6	1	13	2020-07-14 08:45:40.787193	2020-07-14 08:45:40.787193
32	Senior Directives Consultant	73	7	11	6	{"3 kg de carne moída (escolha uma carne magra e macia)","300 g de bacon moído","1 ovo","3 colheres (sopa) de farinha de trigo","3 colheres (sopa) de tempero caseiro: feito com alho, sal, cebola, pimenta e cheiro verde processados no liquidificador","30 ml de água gelada"}	{"Combine milk with vinegar in a medium bowl and set aside for 5 minutes to sour.@","Combine flour,sugar,baking powder,baking soda,and salt in a large mixing bowl. Whisk egg and butter into soured milk. Pour the flour mixture into the wet ingredients and whisk until lumps are gone.@","Heat a large skillet over medium heat,and coat with cooking spray. Pour 1/4 cupfuls of batter onto the skillet,and cook until bubbles appear on the surface. Flip with a spatula,and cook until browned on the other side.@"}	Odio dignissimos nisi voluptas ipsum. Qui sit doloremque. Fugit illum vero eos.	1	1	10	2020-07-14 08:45:40.820746	2020-07-14 08:45:40.820746
48	Senior Factors Producer	59	9	28	1	{"3 kg de carne moída (escolha uma carne magra e macia)","300 g de bacon moído","1 ovo","3 colheres (sopa) de farinha de trigo","3 colheres (sopa) de tempero caseiro: feito com alho, sal, cebola, pimenta e cheiro verde processados no liquidificador","30 ml de água gelada"}	{"Combine milk with vinegar in a medium bowl and set aside for 5 minutes to sour.@","Combine flour,sugar,baking powder,baking soda,and salt in a large mixing bowl. Whisk egg and butter into soured milk. Pour the flour mixture into the wet ingredients and whisk until lumps are gone.@","Heat a large skillet over medium heat,and coat with cooking spray. Pour 1/4 cupfuls of batter onto the skillet,and cook until bubbles appear on the surface. Flip with a spatula,and cook until browned on the other side.@"}	Aperiam vitae sequi et ut. Eos sit veniam odit et. Quia cumque aut enim soluta facere necessitatibus. Voluptatem autem repudiandae sed numquam qui. Est doloremque animi est et quas ut rerum eius. Eum officia adipisci. Odit et quaerat suscipit ea ut aut voluptas. Et beatae minus velit. Accusantium magnam eos facilis ut quos. Voluptatem laboriosam rerum itaque fugit pariatur.	1	4	1	2020-07-14 08:45:40.959428	2020-07-14 08:45:40.959428
36	Customer Research Supervisor	78	3	27	4	{"3 kg de carne moída (escolha uma carne magra e macia)","300 g de bacon moído","1 ovo","3 colheres (sopa) de farinha de trigo","3 colheres (sopa) de tempero caseiro: feito com alho, sal, cebola, pimenta e cheiro verde processados no liquidificador","30 ml de água gelada"}	{"Combine milk with vinegar in a medium bowl and set aside for 5 minutes to sour.@","Combine flour,sugar,baking powder,baking soda,and salt in a large mixing bowl. Whisk egg and butter into soured milk. Pour the flour mixture into the wet ingredients and whisk until lumps are gone.@","Heat a large skillet over medium heat,and coat with cooking spray. Pour 1/4 cupfuls of batter onto the skillet,and cook until bubbles appear on the surface. Flip with a spatula,and cook until browned on the other side.@"}	Dolorem ducimus quos sed modi. Placeat est ad necessitatibus vel consequatur voluptatem dolores consequatur et. Nemo consequatur laborum odit nihil numquam aut.	2	2	12	2020-07-14 08:45:40.82908	2020-07-14 08:45:40.82908
52	District Markets Designer	79	9	22	7	{"3 kg de carne moída (escolha uma carne magra e macia)","300 g de bacon moído","1 ovo","3 colheres (sopa) de farinha de trigo","3 colheres (sopa) de tempero caseiro: feito com alho, sal, cebola, pimenta e cheiro verde processados no liquidificador","30 ml de água gelada"}	{"Combine milk with vinegar in a medium bowl and set aside for 5 minutes to sour.@","Combine flour,sugar,baking powder,baking soda,and salt in a large mixing bowl. Whisk egg and butter into soured milk. Pour the flour mixture into the wet ingredients and whisk until lumps are gone.@","Heat a large skillet over medium heat,and coat with cooking spray. Pour 1/4 cupfuls of batter onto the skillet,and cook until bubbles appear on the surface. Flip with a spatula,and cook until browned on the other side.@"}	Accusamus blanditiis provident omnis aspernatur sunt accusantium reprehenderit sit atque. Vero at eius et voluptatum. Incidunt fugit voluptatem voluptas quis id nulla at quas exercitationem. Libero nulla quia nihil et fuga voluptatibus nihil et et. Eos omnis sit qui voluptas est id. Fugiat incidunt reiciendis. Iusto aut dignissimos quis voluptas quia deserunt dolores odio. Quas ut unde suscipit consequatur eos expedita expedita possimus.	5	4	11	2020-07-14 08:45:40.962499	2020-07-14 08:45:40.962499
37	Customer Quality Analyst	63	9	10	7	{"3 kg de carne moída (escolha uma carne magra e macia)","300 g de bacon moído","1 ovo","3 colheres (sopa) de farinha de trigo","3 colheres (sopa) de tempero caseiro: feito com alho, sal, cebola, pimenta e cheiro verde processados no liquidificador","30 ml de água gelada"}	{"Combine milk with vinegar in a medium bowl and set aside for 5 minutes to sour.@","Combine flour,sugar,baking powder,baking soda,and salt in a large mixing bowl. Whisk egg and butter into soured milk. Pour the flour mixture into the wet ingredients and whisk until lumps are gone.@","Heat a large skillet over medium heat,and coat with cooking spray. Pour 1/4 cupfuls of batter onto the skillet,and cook until bubbles appear on the surface. Flip with a spatula,and cook until browned on the other side.@"}	Et ducimus expedita unde. Quis est magni sint autem officia mollitia sunt incidunt omnis. Est autem dicta molestiae voluptatem. Ut dicta placeat porro doloremque deleniti molestias nisi inventore ab. Quia doloremque provident eaque et vel officia. Officiis non exercitationem non quam error corrupti. Ducimus voluptates est molestias soluta ut eveniet. Est odit quod enim.	1	3	16	2020-07-14 08:45:40.829501	2020-07-14 08:45:40.829501
38	Regional Integration Engineer	77	10	33	1	{"3 kg de carne moída (escolha uma carne magra e macia)","300 g de bacon moído","1 ovo","3 colheres (sopa) de farinha de trigo","3 colheres (sopa) de tempero caseiro: feito com alho, sal, cebola, pimenta e cheiro verde processados no liquidificador","30 ml de água gelada"}	{"Combine milk with vinegar in a medium bowl and set aside for 5 minutes to sour.@","Combine flour,sugar,baking powder,baking soda,and salt in a large mixing bowl. Whisk egg and butter into soured milk. Pour the flour mixture into the wet ingredients and whisk until lumps are gone.@","Heat a large skillet over medium heat,and coat with cooking spray. Pour 1/4 cupfuls of batter onto the skillet,and cook until bubbles appear on the surface. Flip with a spatula,and cook until browned on the other side.@"}	Suscipit quaerat illo repudiandae. Possimus est in qui nobis asperiores. Rerum tempora et consectetur veritatis odio. Unde ut sint. Laboriosam dignissimos velit sequi odio ex ad accusamus. Quaerat animi maiores. Et sequi eligendi odit non dolorem. Officiis quia excepturi explicabo molestiae et unde omnis. Ipsam at quia est inventore tempora iusto aut qui et. Et repudiandae aspernatur architecto delectus consequuntur quo. Sunt sapiente laudantium minus et et.	1	4	14	2020-07-14 08:45:40.831417	2020-07-14 08:45:40.831417
39	Legacy Metrics Designer	61	1	35	2	{"3 kg de carne moída (escolha uma carne magra e macia)","300 g de bacon moído","1 ovo","3 colheres (sopa) de farinha de trigo","3 colheres (sopa) de tempero caseiro: feito com alho, sal, cebola, pimenta e cheiro verde processados no liquidificador","30 ml de água gelada"}	{"Combine milk with vinegar in a medium bowl and set aside for 5 minutes to sour.@","Combine flour,sugar,baking powder,baking soda,and salt in a large mixing bowl. Whisk egg and butter into soured milk. Pour the flour mixture into the wet ingredients and whisk until lumps are gone.@","Heat a large skillet over medium heat,and coat with cooking spray. Pour 1/4 cupfuls of batter onto the skillet,and cook until bubbles appear on the surface. Flip with a spatula,and cook until browned on the other side.@"}	Animi ut cupiditate necessitatibus blanditiis quia. Voluptas aut qui maxime saepe distinctio commodi. Perspiciatis ut maxime et porro voluptas natus nesciunt. Ducimus qui omnis itaque rerum quo laboriosam velit eum et. Dicta iste perferendis blanditiis omnis. Et et debitis ut. Debitis culpa et deleniti vel accusamus earum. Autem ea suscipit quibusdam deleniti. Quos animi minima.	12	3	12	2020-07-14 08:45:40.832778	2020-07-14 08:45:40.832778
42	Dynamic Directives Liaison	63	1	18	3	{"3 kg de carne moída (escolha uma carne magra e macia)","300 g de bacon moído","1 ovo","3 colheres (sopa) de farinha de trigo","3 colheres (sopa) de tempero caseiro: feito com alho, sal, cebola, pimenta e cheiro verde processados no liquidificador","30 ml de água gelada"}	{"Combine milk with vinegar in a medium bowl and set aside for 5 minutes to sour.@","Combine flour,sugar,baking powder,baking soda,and salt in a large mixing bowl. Whisk egg and butter into soured milk. Pour the flour mixture into the wet ingredients and whisk until lumps are gone.@","Heat a large skillet over medium heat,and coat with cooking spray. Pour 1/4 cupfuls of batter onto the skillet,and cook until bubbles appear on the surface. Flip with a spatula,and cook until browned on the other side.@"}	Voluptatem et reiciendis et rerum ipsum minus assumenda unde placeat. Deleniti ut sed quia. Nemo ipsam aspernatur id nulla cumque. Numquam voluptatibus ullam alias sit exercitationem maiores nihil totam. Assumenda veritatis magnam repudiandae excepturi accusantium distinctio aspernatur id. Ut eligendi consequatur officia. Voluptas unde quia eos.	2	5	14	2020-07-14 08:45:40.838472	2020-07-14 08:45:40.838472
53	Product Paradigm Developer	70	4	17	3	{"3 kg de carne moída (escolha uma carne magra e macia)","300 g de bacon moído","1 ovo","3 colheres (sopa) de farinha de trigo","3 colheres (sopa) de tempero caseiro: feito com alho, sal, cebola, pimenta e cheiro verde processados no liquidificador","30 ml de água gelada"}	{"Combine milk with vinegar in a medium bowl and set aside for 5 minutes to sour.@","Combine flour,sugar,baking powder,baking soda,and salt in a large mixing bowl. Whisk egg and butter into soured milk. Pour the flour mixture into the wet ingredients and whisk until lumps are gone.@","Heat a large skillet over medium heat,and coat with cooking spray. Pour 1/4 cupfuls of batter onto the skillet,and cook until bubbles appear on the surface. Flip with a spatula,and cook until browned on the other side.@"}	Dolorum placeat et deleniti iusto amet molestias architecto. Soluta ipsum voluptatem minus rem nisi facere. Nostrum fuga et numquam optio eius molestias esse velit. Labore expedita qui. Optio impedit explicabo sit. Et non ipsam similique reprehenderit.	2	2	17	2020-07-14 08:45:40.963045	2020-07-14 08:45:40.963045
43	Legacy Marketing Consultant	80	4	26	7	{"3 kg de carne moída (escolha uma carne magra e macia)","300 g de bacon moído","1 ovo","3 colheres (sopa) de farinha de trigo","3 colheres (sopa) de tempero caseiro: feito com alho, sal, cebola, pimenta e cheiro verde processados no liquidificador","30 ml de água gelada"}	{"Combine milk with vinegar in a medium bowl and set aside for 5 minutes to sour.@","Combine flour,sugar,baking powder,baking soda,and salt in a large mixing bowl. Whisk egg and butter into soured milk. Pour the flour mixture into the wet ingredients and whisk until lumps are gone.@","Heat a large skillet over medium heat,and coat with cooking spray. Pour 1/4 cupfuls of batter onto the skillet,and cook until bubbles appear on the surface. Flip with a spatula,and cook until browned on the other side.@"}	Quis expedita dolor ullam vero. Amet cumque voluptatem et modi corrupti. Autem sapiente consequatur natus beatae occaecati omnis cupiditate nam ut. Facere alias sint qui aliquam nisi unde eum.	9	1	17	2020-07-14 08:45:40.838828	2020-07-14 08:45:40.838828
44	Customer Marketing Engineer	59	1	8	4	{"3 kg de carne moída (escolha uma carne magra e macia)","300 g de bacon moído","1 ovo","3 colheres (sopa) de farinha de trigo","3 colheres (sopa) de tempero caseiro: feito com alho, sal, cebola, pimenta e cheiro verde processados no liquidificador","30 ml de água gelada"}	{"Combine milk with vinegar in a medium bowl and set aside for 5 minutes to sour.@","Combine flour,sugar,baking powder,baking soda,and salt in a large mixing bowl. Whisk egg and butter into soured milk. Pour the flour mixture into the wet ingredients and whisk until lumps are gone.@","Heat a large skillet over medium heat,and coat with cooking spray. Pour 1/4 cupfuls of batter onto the skillet,and cook until bubbles appear on the surface. Flip with a spatula,and cook until browned on the other side.@"}	Unde quasi nihil dolorem qui hic minima animi dolorum. Minima quia numquam rerum facilis aut necessitatibus et recusandae. Dolores dignissimos officiis unde et enim. Laboriosam ullam voluptas. Nemo et sit. Nobis ipsa quis tenetur eos. Enim tenetur libero quidem cumque. Ut et error fugit. Sit et temporibus. Magnam et facere.	12	5	10	2020-07-14 08:45:40.841293	2020-07-14 08:45:40.841293
55	Dynamic Solutions Architect	76	3	27	6	{"3 kg de carne moída (escolha uma carne magra e macia)","300 g de bacon moído","1 ovo","3 colheres (sopa) de farinha de trigo","3 colheres (sopa) de tempero caseiro: feito com alho, sal, cebola, pimenta e cheiro verde processados no liquidificador","30 ml de água gelada"}	{"Combine milk with vinegar in a medium bowl and set aside for 5 minutes to sour.@","Combine flour,sugar,baking powder,baking soda,and salt in a large mixing bowl. Whisk egg and butter into soured milk. Pour the flour mixture into the wet ingredients and whisk until lumps are gone.@","Heat a large skillet over medium heat,and coat with cooking spray. Pour 1/4 cupfuls of batter onto the skillet,and cook until bubbles appear on the surface. Flip with a spatula,and cook until browned on the other side.@"}	Vel qui itaque dolorem sunt repudiandae in sapiente est eum. Incidunt est amet et rerum ut. Eum ut maiores voluptas voluptatem omnis et numquam in. Nesciunt necessitatibus et aut qui excepturi corporis occaecati. Dolores porro enim qui non quo et. Velit fugit fugiat aut corrupti. Iusto necessitatibus sapiente necessitatibus magni nisi sit aut. Sit beatae aut et veniam magnam accusantium asperiores aperiam. Quia nulla ad placeat dolores.	10	3	9	2020-07-14 08:45:40.964167	2020-07-14 08:45:40.964167
46	International Program Designer	65	10	29	1	{"3 kg de carne moída (escolha uma carne magra e macia)","300 g de bacon moído","1 ovo","3 colheres (sopa) de farinha de trigo","3 colheres (sopa) de tempero caseiro: feito com alho, sal, cebola, pimenta e cheiro verde processados no liquidificador","30 ml de água gelada"}	{"Combine milk with vinegar in a medium bowl and set aside for 5 minutes to sour.@","Combine flour,sugar,baking powder,baking soda,and salt in a large mixing bowl. Whisk egg and butter into soured milk. Pour the flour mixture into the wet ingredients and whisk until lumps are gone.@","Heat a large skillet over medium heat,and coat with cooking spray. Pour 1/4 cupfuls of batter onto the skillet,and cook until bubbles appear on the surface. Flip with a spatula,and cook until browned on the other side.@"}	Quia voluptatibus quis et ut minus vitae vitae dolor. Reiciendis sed nulla rerum soluta eveniet et id quia mollitia. Est provident explicabo aut voluptatem et aut et recusandae tempore.	1	5	18	2020-07-14 08:45:40.941076	2020-07-14 08:45:40.941076
56	Principal Quality Architect	58	10	17	5	{"3 kg de carne moída (escolha uma carne magra e macia)","300 g de bacon moído","1 ovo","3 colheres (sopa) de farinha de trigo","3 colheres (sopa) de tempero caseiro: feito com alho, sal, cebola, pimenta e cheiro verde processados no liquidificador","30 ml de água gelada"}	{"Combine milk with vinegar in a medium bowl and set aside for 5 minutes to sour.@","Combine flour,sugar,baking powder,baking soda,and salt in a large mixing bowl. Whisk egg and butter into soured milk. Pour the flour mixture into the wet ingredients and whisk until lumps are gone.@","Heat a large skillet over medium heat,and coat with cooking spray. Pour 1/4 cupfuls of batter onto the skillet,and cook until bubbles appear on the surface. Flip with a spatula,and cook until browned on the other side.@"}	Natus earum ratione sapiente. Rerum rem debitis repudiandae amet beatae nam magnam deleniti amet. Ut temporibus dolores culpa voluptas et quos nemo autem nesciunt. Quaerat eligendi reprehenderit voluptatum et iste eum. Quia libero expedita dicta in optio cupiditate eum sint qui. Accusantium ut a rerum quidem mollitia distinctio ut non nisi. Delectus tempora placeat. Aut nihil voluptatem odio eligendi et maxime aliquid voluptas. Fuga optio eaque deserunt. A quia et molestiae voluptatem tenetur magnam. Veniam vero rem aspernatur.	10	1	18	2020-07-14 08:45:40.964882	2020-07-14 08:45:40.964882
58	District Quality Planner	77	6	39	1	{"3 kg de carne moída (escolha uma carne magra e macia)","300 g de bacon moído","1 ovo","3 colheres (sopa) de farinha de trigo","3 colheres (sopa) de tempero caseiro: feito com alho, sal, cebola, pimenta e cheiro verde processados no liquidificador","30 ml de água gelada"}	{"Combine milk with vinegar in a medium bowl and set aside for 5 minutes to sour.@","Combine flour,sugar,baking powder,baking soda,and salt in a large mixing bowl. Whisk egg and butter into soured milk. Pour the flour mixture into the wet ingredients and whisk until lumps are gone.@","Heat a large skillet over medium heat,and coat with cooking spray. Pour 1/4 cupfuls of batter onto the skillet,and cook until bubbles appear on the surface. Flip with a spatula,and cook until browned on the other side.@"}	Expedita qui consequatur corrupti vel in. Eligendi est explicabo est. Praesentium voluptates et corporis id rerum corporis quam eum. Quod ea nam dolore. Quis ut harum dolores quas. Esse distinctio qui pariatur. Enim ab pariatur quam facere rem occaecati.	2	2	14	2020-07-14 08:45:40.981807	2020-07-14 08:45:40.981807
59	Global Security Supervisor	60	8	15	4	{"3 kg de carne moída (escolha uma carne magra e macia)","300 g de bacon moído","1 ovo","3 colheres (sopa) de farinha de trigo","3 colheres (sopa) de tempero caseiro: feito com alho, sal, cebola, pimenta e cheiro verde processados no liquidificador","30 ml de água gelada"}	{"Combine milk with vinegar in a medium bowl and set aside for 5 minutes to sour.@","Combine flour,sugar,baking powder,baking soda,and salt in a large mixing bowl. Whisk egg and butter into soured milk. Pour the flour mixture into the wet ingredients and whisk until lumps are gone.@","Heat a large skillet over medium heat,and coat with cooking spray. Pour 1/4 cupfuls of batter onto the skillet,and cook until bubbles appear on the surface. Flip with a spatula,and cook until browned on the other side.@"}	Modi beatae quod accusantium aspernatur. Aspernatur fugit neque. Vitae non magni iure doloremque consequatur sequi numquam corporis sed. Quis eos rem velit molestias quisquam ullam aliquid ut voluptas. Et repudiandae tenetur quaerat. Fugiat nam sit qui vel atque architecto. Est atque eius sed totam voluptatem modi exercitationem magnam id. Ipsum temporibus cumque cum qui odit exercitationem ut totam. Ab omnis aut quos non aut quidem et. Ea maiores in commodi animi at nulla. Laboriosam quia ea et accusantium sint sit molestias.	11	1	1	2020-07-14 08:45:40.981965	2020-07-14 08:45:40.981965
60	Chief Data Orchestrator	59	6	37	7	{"3 kg de carne moída (escolha uma carne magra e macia)","300 g de bacon moído","1 ovo","3 colheres (sopa) de farinha de trigo","3 colheres (sopa) de tempero caseiro: feito com alho, sal, cebola, pimenta e cheiro verde processados no liquidificador","30 ml de água gelada"}	{"Combine milk with vinegar in a medium bowl and set aside for 5 minutes to sour.@","Combine flour,sugar,baking powder,baking soda,and salt in a large mixing bowl. Whisk egg and butter into soured milk. Pour the flour mixture into the wet ingredients and whisk until lumps are gone.@","Heat a large skillet over medium heat,and coat with cooking spray. Pour 1/4 cupfuls of batter onto the skillet,and cook until bubbles appear on the surface. Flip with a spatula,and cook until browned on the other side.@"}	Non consectetur pariatur nulla voluptate ipsum. Voluptatem nam eos molestiae dolore possimus. Omnis quam veniam voluptatum pariatur nulla consectetur dolorem omnis in. Numquam suscipit magni placeat non. Voluptas voluptates adipisci. Labore voluptates quia.	14	3	11	2020-07-14 08:45:40.982156	2020-07-14 08:45:40.982156
61	Dynamic Quality Executive	85	3	5	2	{"3 kg de carne moída (escolha uma carne magra e macia)","300 g de bacon moído","1 ovo","3 colheres (sopa) de farinha de trigo","3 colheres (sopa) de tempero caseiro: feito com alho, sal, cebola, pimenta e cheiro verde processados no liquidificador","30 ml de água gelada"}	{"Combine milk with vinegar in a medium bowl and set aside for 5 minutes to sour.@","Combine flour,sugar,baking powder,baking soda,and salt in a large mixing bowl. Whisk egg and butter into soured milk. Pour the flour mixture into the wet ingredients and whisk until lumps are gone.@","Heat a large skillet over medium heat,and coat with cooking spray. Pour 1/4 cupfuls of batter onto the skillet,and cook until bubbles appear on the surface. Flip with a spatula,and cook until browned on the other side.@"}	Quidem consequatur esse dolorem vero assumenda doloremque. Nobis reprehenderit quis laborum mollitia consectetur quo earum consequuntur est. Dolore non et blanditiis illo expedita quia voluptates. Quasi in molestiae est similique reiciendis eveniet ea. Laudantium natus aut et hic excepturi rem at soluta. Id vel aut sequi eius. Fuga iusto quisquam.	3	4	12	2020-07-14 08:48:42.767261	2020-07-14 08:48:42.767261
62	Global Creative Representative	94	1	12	3	{"3 kg de carne moída (escolha uma carne magra e macia)","300 g de bacon moído","1 ovo","3 colheres (sopa) de farinha de trigo","3 colheres (sopa) de tempero caseiro: feito com alho, sal, cebola, pimenta e cheiro verde processados no liquidificador","30 ml de água gelada"}	{"Combine milk with vinegar in a medium bowl and set aside for 5 minutes to sour.@","Combine flour,sugar,baking powder,baking soda,and salt in a large mixing bowl. Whisk egg and butter into soured milk. Pour the flour mixture into the wet ingredients and whisk until lumps are gone.@","Heat a large skillet over medium heat,and coat with cooking spray. Pour 1/4 cupfuls of batter onto the skillet,and cook until bubbles appear on the surface. Flip with a spatula,and cook until browned on the other side.@"}	Modi totam tempore perspiciatis non corporis ea maxime molestias. Natus iusto sed et et aut. Ut ipsam officia quidem quibusdam error enim. Accusamus est ratione distinctio est. Nemo et eligendi. Et rerum est aperiam et neque voluptatum. Rerum et ad dignissimos quia laudantium. Distinctio commodi consequatur ea distinctio aperiam soluta cupiditate.	6	3	13	2020-07-14 08:48:42.772306	2020-07-14 08:48:42.772306
72	Chief Security Analyst	98	5	31	7	{"3 kg de carne moída (escolha uma carne magra e macia)","300 g de bacon moído","1 ovo","3 colheres (sopa) de farinha de trigo","3 colheres (sopa) de tempero caseiro: feito com alho, sal, cebola, pimenta e cheiro verde processados no liquidificador","30 ml de água gelada"}	{"Combine milk with vinegar in a medium bowl and set aside for 5 minutes to sour.@","Combine flour,sugar,baking powder,baking soda,and salt in a large mixing bowl. Whisk egg and butter into soured milk. Pour the flour mixture into the wet ingredients and whisk until lumps are gone.@","Heat a large skillet over medium heat,and coat with cooking spray. Pour 1/4 cupfuls of batter onto the skillet,and cook until bubbles appear on the surface. Flip with a spatula,and cook until browned on the other side.@"}	Commodi modi omnis ut ex consequatur dolor. Laudantium accusantium consequatur beatae. Minima in voluptatibus ipsam et. Maxime ut consequatur rerum eos. Laudantium quia magni. Repellendus est assumenda natus aut natus. Saepe earum est.	9	5	17	2020-07-14 08:48:42.781621	2020-07-14 08:48:42.781621
66	Senior Paradigm Coordinator	90	5	22	7	{"3 kg de carne moída (escolha uma carne magra e macia)","300 g de bacon moído","1 ovo","3 colheres (sopa) de farinha de trigo","3 colheres (sopa) de tempero caseiro: feito com alho, sal, cebola, pimenta e cheiro verde processados no liquidificador","30 ml de água gelada"}	{"Combine milk with vinegar in a medium bowl and set aside for 5 minutes to sour.@","Combine flour,sugar,baking powder,baking soda,and salt in a large mixing bowl. Whisk egg and butter into soured milk. Pour the flour mixture into the wet ingredients and whisk until lumps are gone.@","Heat a large skillet over medium heat,and coat with cooking spray. Pour 1/4 cupfuls of batter onto the skillet,and cook until bubbles appear on the surface. Flip with a spatula,and cook until browned on the other side.@"}	Voluptatum blanditiis ad optio culpa nihil suscipit quia. At corporis eos dolor ratione. Ex aliquam minus.	14	4	1	2020-07-14 08:48:42.775789	2020-07-14 08:48:42.775789
73	Central Accountability Orchestrator	89	9	29	2	{"3 kg de carne moída (escolha uma carne magra e macia)","300 g de bacon moído","1 ovo","3 colheres (sopa) de farinha de trigo","3 colheres (sopa) de tempero caseiro: feito com alho, sal, cebola, pimenta e cheiro verde processados no liquidificador","30 ml de água gelada"}	{"Combine milk with vinegar in a medium bowl and set aside for 5 minutes to sour.@","Combine flour,sugar,baking powder,baking soda,and salt in a large mixing bowl. Whisk egg and butter into soured milk. Pour the flour mixture into the wet ingredients and whisk until lumps are gone.@","Heat a large skillet over medium heat,and coat with cooking spray. Pour 1/4 cupfuls of batter onto the skillet,and cook until bubbles appear on the surface. Flip with a spatula,and cook until browned on the other side.@"}	Rerum fugiat nobis qui mollitia et voluptatem a. Accusamus voluptate ut. Modi eaque enim qui. Est vel quibusdam voluptatem quaerat quas eveniet distinctio tempore. Rem molestiae eligendi nobis harum iusto dolorem recusandae facere id.	12	1	11	2020-07-14 08:48:42.782044	2020-07-14 08:48:42.782044
68	Central Implementation Executive	97	2	37	4	{"3 kg de carne moída (escolha uma carne magra e macia)","300 g de bacon moído","1 ovo","3 colheres (sopa) de farinha de trigo","3 colheres (sopa) de tempero caseiro: feito com alho, sal, cebola, pimenta e cheiro verde processados no liquidificador","30 ml de água gelada"}	{"Combine milk with vinegar in a medium bowl and set aside for 5 minutes to sour.@","Combine flour,sugar,baking powder,baking soda,and salt in a large mixing bowl. Whisk egg and butter into soured milk. Pour the flour mixture into the wet ingredients and whisk until lumps are gone.@","Heat a large skillet over medium heat,and coat with cooking spray. Pour 1/4 cupfuls of batter onto the skillet,and cook until bubbles appear on the surface. Flip with a spatula,and cook until browned on the other side.@"}	Veniam omnis magni facere magni iste. Libero possimus explicabo amet et porro voluptas molestias. Culpa delectus soluta repellat aperiam quis soluta. A harum sequi autem dolor temporibus. Aut voluptate sed fuga. Ducimus quis aut enim aut reiciendis fugit omnis dolore. Sint quos esse dicta dolor et. Dolorem molestias et nemo molestiae voluptates atque omnis repudiandae fugiat.	11	2	15	2020-07-14 08:48:42.7762	2020-07-14 08:48:42.7762
96	National Infrastructure Architect	95	1	23	3	{"3 kg de carne moída (escolha uma carne magra e macia)","300 g de bacon moído","1 ovo","3 colheres (sopa) de farinha de trigo","3 colheres (sopa) de tempero caseiro: feito com alho, sal, cebola, pimenta e cheiro verde processados no liquidificador","30 ml de água gelada"}	{"Combine milk with vinegar in a medium bowl and set aside for 5 minutes to sour.@","Combine flour,sugar,baking powder,baking soda,and salt in a large mixing bowl. Whisk egg and butter into soured milk. Pour the flour mixture into the wet ingredients and whisk until lumps are gone.@","Heat a large skillet over medium heat,and coat with cooking spray. Pour 1/4 cupfuls of batter onto the skillet,and cook until bubbles appear on the surface. Flip with a spatula,and cook until browned on the other side.@"}	Asperiores molestiae et aut neque eaque modi rem dolore. Minus consequatur et corporis ipsum corporis molestiae placeat consequatur est. Sapiente nam minus ad et dolor doloremque ullam iure. Iure ut illo in error fugiat. Tempora nihil et porro molestiae aut tenetur. Et eum consequuntur dolorem. Numquam mollitia laudantium eum excepturi harum porro laboriosam odit.	7	4	15	2020-07-14 08:48:42.892214	2020-07-14 08:48:42.892214
69	Dynamic Branding Liaison	109	4	2	3	{"3 kg de carne moída (escolha uma carne magra e macia)","300 g de bacon moído","1 ovo","3 colheres (sopa) de farinha de trigo","3 colheres (sopa) de tempero caseiro: feito com alho, sal, cebola, pimenta e cheiro verde processados no liquidificador","30 ml de água gelada"}	{"Combine milk with vinegar in a medium bowl and set aside for 5 minutes to sour.@","Combine flour,sugar,baking powder,baking soda,and salt in a large mixing bowl. Whisk egg and butter into soured milk. Pour the flour mixture into the wet ingredients and whisk until lumps are gone.@","Heat a large skillet over medium heat,and coat with cooking spray. Pour 1/4 cupfuls of batter onto the skillet,and cook until bubbles appear on the surface. Flip with a spatula,and cook until browned on the other side.@"}	Sapiente quae eveniet corporis possimus ab ut veritatis. Est distinctio tempora beatae aliquam voluptatibus. Quis illum nobis rem dolores. Ea ducimus exercitationem consequatur autem qui voluptatem natus.	3	4	14	2020-07-14 08:48:42.777663	2020-07-14 08:48:42.777663
77	International Paradigm Manager	86	9	15	6	{"3 kg de carne moída (escolha uma carne magra e macia)","300 g de bacon moído","1 ovo","3 colheres (sopa) de farinha de trigo","3 colheres (sopa) de tempero caseiro: feito com alho, sal, cebola, pimenta e cheiro verde processados no liquidificador","30 ml de água gelada"}	{"Combine milk with vinegar in a medium bowl and set aside for 5 minutes to sour.@","Combine flour,sugar,baking powder,baking soda,and salt in a large mixing bowl. Whisk egg and butter into soured milk. Pour the flour mixture into the wet ingredients and whisk until lumps are gone.@","Heat a large skillet over medium heat,and coat with cooking spray. Pour 1/4 cupfuls of batter onto the skillet,and cook until bubbles appear on the surface. Flip with a spatula,and cook until browned on the other side.@"}	Deserunt culpa et iste non amet aut. Quia sint provident voluptatem possimus adipisci qui asperiores omnis. Ipsa et ut. Quia est earum corporis voluptatem deleniti nobis autem itaque dolores. Exercitationem corrupti sapiente ipsam enim. Ea quasi dolor tempora aut quidem laborum aliquid dolor. Laborum reiciendis vitae ea eum. Maiores molestiae ut at et laborum. Odio facere maiores dolor doloribus commodi sunt temporibus voluptatem. Aliquid eaque necessitatibus molestias officiis molestiae sint consequatur itaque. Porro consequatur veniam fugiat. Voluptates laborum id expedita molestias.	9	1	13	2020-07-14 08:48:42.804586	2020-07-14 08:48:42.804586
80	Legacy Optimization Technician	99	8	19	2	{"3 kg de carne moída (escolha uma carne magra e macia)","300 g de bacon moído","1 ovo","3 colheres (sopa) de farinha de trigo","3 colheres (sopa) de tempero caseiro: feito com alho, sal, cebola, pimenta e cheiro verde processados no liquidificador","30 ml de água gelada"}	{"Combine milk with vinegar in a medium bowl and set aside for 5 minutes to sour.@","Combine flour,sugar,baking powder,baking soda,and salt in a large mixing bowl. Whisk egg and butter into soured milk. Pour the flour mixture into the wet ingredients and whisk until lumps are gone.@","Heat a large skillet over medium heat,and coat with cooking spray. Pour 1/4 cupfuls of batter onto the skillet,and cook until bubbles appear on the surface. Flip with a spatula,and cook until browned on the other side.@"}	Odio reiciendis maiores ullam. Nesciunt placeat eaque voluptatem non dignissimos. Totam exercitationem ducimus sunt repellendus non. Voluptas totam velit necessitatibus ipsum.	5	2	11	2020-07-14 08:48:42.819272	2020-07-14 08:48:42.819272
83	Central Assurance Developer	92	4	7	5	{"3 kg de carne moída (escolha uma carne magra e macia)","300 g de bacon moído","1 ovo","3 colheres (sopa) de farinha de trigo","3 colheres (sopa) de tempero caseiro: feito com alho, sal, cebola, pimenta e cheiro verde processados no liquidificador","30 ml de água gelada"}	{"Combine milk with vinegar in a medium bowl and set aside for 5 minutes to sour.@","Combine flour,sugar,baking powder,baking soda,and salt in a large mixing bowl. Whisk egg and butter into soured milk. Pour the flour mixture into the wet ingredients and whisk until lumps are gone.@","Heat a large skillet over medium heat,and coat with cooking spray. Pour 1/4 cupfuls of batter onto the skillet,and cook until bubbles appear on the surface. Flip with a spatula,and cook until browned on the other side.@"}	Totam aut quibusdam doloribus perferendis illum. Consequatur dolor et voluptas voluptas corporis et illo. Temporibus officiis corporis. Molestias minima illum aperiam tenetur laboriosam est blanditiis exercitationem. Atque laudantium voluptate illum et. Eum ut omnis. Non cumque ipsa. Delectus et molestias officiis culpa. Porro exercitationem blanditiis velit aut nam dignissimos hic et dicta. Consequatur optio magni est occaecati dolores blanditiis qui. Temporibus commodi sint iusto consequuntur eius dolor quae.	4	3	18	2020-07-14 08:48:42.821031	2020-07-14 08:48:42.821031
99	Customer Configuration Designer	97	4	9	6	{"3 kg de carne moída (escolha uma carne magra e macia)","300 g de bacon moído","1 ovo","3 colheres (sopa) de farinha de trigo","3 colheres (sopa) de tempero caseiro: feito com alho, sal, cebola, pimenta e cheiro verde processados no liquidificador","30 ml de água gelada"}	{"Combine milk with vinegar in a medium bowl and set aside for 5 minutes to sour.@","Combine flour,sugar,baking powder,baking soda,and salt in a large mixing bowl. Whisk egg and butter into soured milk. Pour the flour mixture into the wet ingredients and whisk until lumps are gone.@","Heat a large skillet over medium heat,and coat with cooking spray. Pour 1/4 cupfuls of batter onto the skillet,and cook until bubbles appear on the surface. Flip with a spatula,and cook until browned on the other side.@"}	Nisi dolor labore voluptatem. Omnis eaque aliquid aut quis quod qui ipsam ut qui. Ipsa impedit molestias provident debitis aut. Consequuntur aliquam illum accusamus. Ipsa est magnam. Sunt non quo nam repudiandae quia nihil ad. Sunt consectetur modi tempora dolores non vel in ullam.	3	4	17	2020-07-14 08:48:42.916992	2020-07-14 08:48:42.916992
87	Investor Response Executive	108	6	13	7	{"3 kg de carne moída (escolha uma carne magra e macia)","300 g de bacon moído","1 ovo","3 colheres (sopa) de farinha de trigo","3 colheres (sopa) de tempero caseiro: feito com alho, sal, cebola, pimenta e cheiro verde processados no liquidificador","30 ml de água gelada"}	{"Combine milk with vinegar in a medium bowl and set aside for 5 minutes to sour.@","Combine flour,sugar,baking powder,baking soda,and salt in a large mixing bowl. Whisk egg and butter into soured milk. Pour the flour mixture into the wet ingredients and whisk until lumps are gone.@","Heat a large skillet over medium heat,and coat with cooking spray. Pour 1/4 cupfuls of batter onto the skillet,and cook until bubbles appear on the surface. Flip with a spatula,and cook until browned on the other side.@"}	Quo eos quo praesentium quaerat atque magni unde qui et. Dolores magni est voluptate harum ipsa velit molestias odio. Nihil assumenda quasi aut nemo delectus. Aut commodi eveniet laudantium. Omnis neque non tempore consequatur autem ad voluptatum perferendis magnam. Amet voluptas error et dolorem aut earum et vel. Aut deserunt mollitia.	1	1	16	2020-07-14 08:48:42.830237	2020-07-14 08:48:42.830237
88	Dynamic Web Orchestrator	93	5	19	7	{"3 kg de carne moída (escolha uma carne magra e macia)","300 g de bacon moído","1 ovo","3 colheres (sopa) de farinha de trigo","3 colheres (sopa) de tempero caseiro: feito com alho, sal, cebola, pimenta e cheiro verde processados no liquidificador","30 ml de água gelada"}	{"Combine milk with vinegar in a medium bowl and set aside for 5 minutes to sour.@","Combine flour,sugar,baking powder,baking soda,and salt in a large mixing bowl. Whisk egg and butter into soured milk. Pour the flour mixture into the wet ingredients and whisk until lumps are gone.@","Heat a large skillet over medium heat,and coat with cooking spray. Pour 1/4 cupfuls of batter onto the skillet,and cook until bubbles appear on the surface. Flip with a spatula,and cook until browned on the other side.@"}	Ipsam explicabo nam voluptatem dolores aut similique officiis. Quidem totam quo. Veritatis perspiciatis sunt maiores. Odit maiores asperiores. Fuga aut velit ea est suscipit pariatur itaque. Soluta sed hic id. Eos ut excepturi aut accusantium. Et doloremque voluptatum inventore. Eligendi ipsum et qui. Enim at exercitationem minima recusandae. Harum rerum quos non eos.	9	1	15	2020-07-14 08:48:42.830425	2020-07-14 08:48:42.830425
98	Future Accounts Technician	95	8	36	1	{"3 kg de carne moída (escolha uma carne magra e macia)","300 g de bacon moído","1 ovo","3 colheres (sopa) de farinha de trigo","3 colheres (sopa) de tempero caseiro: feito com alho, sal, cebola, pimenta e cheiro verde processados no liquidificador","30 ml de água gelada"}	{"Combine milk with vinegar in a medium bowl and set aside for 5 minutes to sour.@","Combine flour,sugar,baking powder,baking soda,and salt in a large mixing bowl. Whisk egg and butter into soured milk. Pour the flour mixture into the wet ingredients and whisk until lumps are gone.@","Heat a large skillet over medium heat,and coat with cooking spray. Pour 1/4 cupfuls of batter onto the skillet,and cook until bubbles appear on the surface. Flip with a spatula,and cook until browned on the other side.@"}	Quasi hic optio amet blanditiis eligendi doloremque et. Dolores voluptates omnis ab. Ducimus sapiente optio esse ut perspiciatis aut aut asperiores qui. Iusto qui magni cum tempora. In qui commodi accusantium sed possimus porro quis. Perferendis consequatur quo repudiandae consequatur deserunt nihil perspiciatis sit. Suscipit neque illo dicta et nesciunt esse dolorem dolor temporibus. Quo ut necessitatibus explicabo.	6	5	16	2020-07-14 08:48:42.916275	2020-07-14 08:48:42.916275
92	Corporate Response Consultant	85	6	32	5	{"3 kg de carne moída (escolha uma carne magra e macia)","300 g de bacon moído","1 ovo","3 colheres (sopa) de farinha de trigo","3 colheres (sopa) de tempero caseiro: feito com alho, sal, cebola, pimenta e cheiro verde processados no liquidificador","30 ml de água gelada"}	{"Combine milk with vinegar in a medium bowl and set aside for 5 minutes to sour.@","Combine flour,sugar,baking powder,baking soda,and salt in a large mixing bowl. Whisk egg and butter into soured milk. Pour the flour mixture into the wet ingredients and whisk until lumps are gone.@","Heat a large skillet over medium heat,and coat with cooking spray. Pour 1/4 cupfuls of batter onto the skillet,and cook until bubbles appear on the surface. Flip with a spatula,and cook until browned on the other side.@"}	Ipsum provident magni. Quam laborum odit et ullam tempora dicta vitae. A ut est voluptatem voluptas voluptate quia placeat. Nobis molestiae eius ea harum est consequatur quo. Magni sunt fugit ex. Velit qui quia. Aliquid non praesentium incidunt id. Aliquam dicta natus sit quae officia suscipit vitae odio at.	2	5	9	2020-07-14 08:48:42.840516	2020-07-14 08:48:42.840516
100	Regional Data Liaison	92	4	34	5	{"3 kg de carne moída (escolha uma carne magra e macia)","300 g de bacon moído","1 ovo","3 colheres (sopa) de farinha de trigo","3 colheres (sopa) de tempero caseiro: feito com alho, sal, cebola, pimenta e cheiro verde processados no liquidificador","30 ml de água gelada"}	{"Combine milk with vinegar in a medium bowl and set aside for 5 minutes to sour.@","Combine flour,sugar,baking powder,baking soda,and salt in a large mixing bowl. Whisk egg and butter into soured milk. Pour the flour mixture into the wet ingredients and whisk until lumps are gone.@","Heat a large skillet over medium heat,and coat with cooking spray. Pour 1/4 cupfuls of batter onto the skillet,and cook until bubbles appear on the surface. Flip with a spatula,and cook until browned on the other side.@"}	Assumenda nulla totam et necessitatibus voluptas ut dolor dolor fugit. Et consectetur nam assumenda. Consectetur accusamus beatae hic ipsa aut blanditiis. Dignissimos blanditiis dolor hic eius. Officiis ut voluptas qui consectetur distinctio et exercitationem vel. Voluptas labore in aspernatur laborum quasi libero aspernatur. Totam quia sunt odit magni aut est et asperiores ad. Voluptas repudiandae dolorum aut. Vero sed quis laboriosam ratione minima nam dicta earum non. Voluptatem earum dolorem qui nesciunt eum voluptatem dignissimos rerum. Harum mollitia repudiandae sed non fugit in reiciendis. Nobis et quod optio eius.	2	1	12	2020-07-14 08:48:42.917793	2020-07-14 08:48:42.917793
93	District Metrics Orchestrator	108	2	17	6	{"3 kg de carne moída (escolha uma carne magra e macia)","300 g de bacon moído","1 ovo","3 colheres (sopa) de farinha de trigo","3 colheres (sopa) de tempero caseiro: feito com alho, sal, cebola, pimenta e cheiro verde processados no liquidificador","30 ml de água gelada"}	{"Combine milk with vinegar in a medium bowl and set aside for 5 minutes to sour.@","Combine flour,sugar,baking powder,baking soda,and salt in a large mixing bowl. Whisk egg and butter into soured milk. Pour the flour mixture into the wet ingredients and whisk until lumps are gone.@","Heat a large skillet over medium heat,and coat with cooking spray. Pour 1/4 cupfuls of batter onto the skillet,and cook until bubbles appear on the surface. Flip with a spatula,and cook until browned on the other side.@"}	Ut officia ab. Sit ut ut sed eos iusto. Ut quia sequi sunt eaque voluptates et ipsum. Eos dicta voluptatem aut nobis dicta ducimus ut aspernatur minus. Atque eos placeat illum ut quae non officiis repellendus quo. Sit voluptatibus non. Deleniti eaque ut laboriosam repudiandae quia quasi. Ratione non modi quis dicta necessitatibus doloremque laboriosam. Enim veritatis molestiae id qui et.	5	5	10	2020-07-14 08:48:42.840956	2020-07-14 08:48:42.840956
94	Human Usability Supervisor	101	7	23	6	{"3 kg de carne moída (escolha uma carne magra e macia)","300 g de bacon moído","1 ovo","3 colheres (sopa) de farinha de trigo","3 colheres (sopa) de tempero caseiro: feito com alho, sal, cebola, pimenta e cheiro verde processados no liquidificador","30 ml de água gelada"}	{"Combine milk with vinegar in a medium bowl and set aside for 5 minutes to sour.@","Combine flour,sugar,baking powder,baking soda,and salt in a large mixing bowl. Whisk egg and butter into soured milk. Pour the flour mixture into the wet ingredients and whisk until lumps are gone.@","Heat a large skillet over medium heat,and coat with cooking spray. Pour 1/4 cupfuls of batter onto the skillet,and cook until bubbles appear on the surface. Flip with a spatula,and cook until browned on the other side.@"}	Quis eius rerum. Assumenda esse magni aut doloremque explicabo. Cum culpa esse est velit quia totam sit. Delectus omnis et. Ut repellendus accusamus facilis non. Sed quae maiores eum est vel. Et culpa voluptas. Qui esse ut quibusdam qui. Sunt voluptatibus tempora natus molestiae. Voluptatibus culpa qui nihil vel sed voluptatem.	14	4	14	2020-07-14 08:48:42.845698	2020-07-14 08:48:42.845698
\.


--
-- Data for Name: session; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.session (sid, sess, expire) FROM stdin;
V9I0ZNpouIkhczFzudASToYyVrq5BaqJ	{"cookie":{"originalMaxAge":2591999998,"expires":"2020-08-21T17:35:48.474Z","httpOnly":true,"path":"/"},"difficulties":[{"id":1,"name":"easy"},{"id":2,"name":"medium"},{"id":3,"name":"hard"},{"id":4,"name":"harder"},{"id":5,"name":"hardest"},{"id":6,"name":"hardestest"},{"id":7,"name":"darksouls"},{"id":8,"name":"Dante must die"}],"diet_restriction":[{"id":1,"name":"Diabetic"},{"id":2,"name":"Low Carb Recipes"},{"id":3,"name":"Dairy Free Recipes"},{"id":4,"name":"Gluten Free"},{"id":5,"name":"Healthy"},{"id":6,"name":"Heart-Healthy Recipes"},{"id":7,"name":"High Fiber Recipes"},{"id":8,"name":"Low Calorie"},{"id":9,"name":"Low Cholesterol Recipes"},{"id":10,"name":"Low Fat"},{"id":11,"name":"Weight-Loss Recipes"},{"id":12,"name":"none"},{"id":13,"name":"Vegetarian"},{"id":14,"name":"Vegan"}],"meal_type":[{"id":1,"name":"Breakfast and Brunch"},{"id":3,"name":"Desserts"},{"id":2,"name":"Lunch"},{"id":4,"name":"Dinners"},{"id":5,"name":"Snacks"}],"world_cuisine":[{"id":1,"name":"Brazilian"},{"id":9,"name":"Middle Eastern Recipes"},{"id":10,"name":"African Recipes"},{"id":11,"name":"European Recipes"},{"id":12,"name":"Latin American Recipes"},{"id":13,"name":"Eastern European Recipes"},{"id":14,"name":"Australian and New Zealander Recipes"},{"id":15,"name":"Asian Recipes"},{"id":16,"name":"Mediterranean Diet Recipes"},{"id":17,"name":"Canadian Recipes"},{"id":18,"name":"U.S. Recipes"},{"id":19,"name":"other"}],"categories":[{"id":1,"name":"book"},{"id":2,"name":"artwork"},{"id":3,"name":"clothe"},{"id":4,"name":"toy"},{"id":5,"name":"accessory"},{"id":6,"name":"mug"},{"id":7,"name":"plush"}],"userId":16,"user":{"id":16,"name":"Fernanda Penna","email":"fernanda.panda@gmail.com","password":"$2a$08$gqOhy/KYoeRWyOjlkMhPPuX8zatIYEh24PXaeetxOCqndqrqx65DC","is_admin":true,"about":"Neptune opposition the Ascendant shows that you are greatly influenced by the people with whom you associate.","instagram":"@panda","twitter":"@panda","profile_image":"https://images.unsplash.com/photo-1557431177-36141475c676?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80","created_at":"2020-07-08T18:55:17.479Z","updated_at":"2020-07-08T18:55:17.479Z","reset_token":null,"reset_token_expires":null},"admin":true}	2020-08-21 19:19:13
m04C7ywUmu0RUF9e_SSmLXbXgY2EAPE5	{"cookie":{"originalMaxAge":2592000000,"expires":"2020-08-20T19:30:55.162Z","httpOnly":true,"path":"/"},"difficulties":[{"id":1,"name":"easy"},{"id":2,"name":"medium"},{"id":3,"name":"hard"},{"id":4,"name":"harder"},{"id":5,"name":"hardest"},{"id":6,"name":"hardestest"},{"id":7,"name":"darksouls"},{"id":8,"name":"Dante must die"}],"diet_restriction":[{"id":1,"name":"Diabetic"},{"id":2,"name":"Low Carb Recipes"},{"id":3,"name":"Dairy Free Recipes"},{"id":4,"name":"Gluten Free"},{"id":5,"name":"Healthy"},{"id":6,"name":"Heart-Healthy Recipes"},{"id":7,"name":"High Fiber Recipes"},{"id":8,"name":"Low Calorie"},{"id":9,"name":"Low Cholesterol Recipes"},{"id":10,"name":"Low Fat"},{"id":11,"name":"Weight-Loss Recipes"},{"id":12,"name":"none"},{"id":13,"name":"Vegetarian"},{"id":14,"name":"Vegan"}],"meal_type":[{"id":1,"name":"Breakfast and Brunch"},{"id":3,"name":"Desserts"},{"id":2,"name":"Lunch"},{"id":4,"name":"Dinners"},{"id":5,"name":"Snacks"}],"world_cuisine":[{"id":1,"name":"Brazilian"},{"id":9,"name":"Middle Eastern Recipes"},{"id":10,"name":"African Recipes"},{"id":11,"name":"European Recipes"},{"id":12,"name":"Latin American Recipes"},{"id":13,"name":"Eastern European Recipes"},{"id":14,"name":"Australian and New Zealander Recipes"},{"id":15,"name":"Asian Recipes"},{"id":16,"name":"Mediterranean Diet Recipes"},{"id":17,"name":"Canadian Recipes"},{"id":18,"name":"U.S. Recipes"},{"id":19,"name":"other"}],"categories":[{"id":1,"name":"book"},{"id":2,"name":"artwork"},{"id":3,"name":"clothe"},{"id":4,"name":"toy"},{"id":5,"name":"accessory"},{"id":6,"name":"mug"},{"id":7,"name":"plush"}],"userId":16,"user":{"id":16,"name":"Fernanda Penna","email":"fernanda.panda@gmail.com","password":"$2a$08$gqOhy/KYoeRWyOjlkMhPPuX8zatIYEh24PXaeetxOCqndqrqx65DC","is_admin":true,"about":"Neptune opposition the Ascendant shows that you are greatly influenced by the people with whom you associate.","instagram":"@panda","twitter":"@panda","profile_image":"https://images.unsplash.com/photo-1557431177-36141475c676?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80","created_at":"2020-07-08T18:55:17.479Z","updated_at":"2020-07-08T18:55:17.479Z","reset_token":null,"reset_token_expires":null},"admin":true,"cart":{"items":[],"total":{"quantity":0,"price":0,"formattedPrice":"$0.00"}}}	2020-08-20 17:51:09
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.users (id, name, email, password, is_admin, about, instagram, twitter, profile_image, created_at, updated_at, reset_token, reset_token_expires) FROM stdin;
1	Alana Shanahan	Hallie.Tremblay7@hotmail.com	$2a$08$gqOhy/KYoeRWyOjlkMhPPuX8zatIYEh24PXaeetxOCqndqrqx65DC	f	Odit suscipit atque aut quidem repellat.\nEst aut blanditiis.\nSaepe repellat nesciunt dolor et voluptate placeat voluptas.\nCorporis iusto sint eaque quidem libero et omnis.\nVeniam repudiandae laborum aut suscipit laborum ipsum tempore at nobis.	Trenton_Schmidt73	Trenton_Schmidt73	https://s3.amazonaws.com/uifaces/faces/twitter/iamkeithmason/128.jpg	2020-06-25 22:29:19.263376	2020-06-25 22:29:19.263376	\N	\N
2	Carleton Pagac I	Gertrude_Mayer@yahoo.com	$2a$08$gqOhy/KYoeRWyOjlkMhPPuX8zatIYEh24PXaeetxOCqndqrqx65DC	f	Et eos quis rerum dignissimos et sed in.\nQuos voluptatem ipsam dolor ut corporis qui rem.\nArchitecto consequatur assumenda autem quia possimus aut ipsa saepe voluptatum.\nSaepe quibusdam in tempora accusamus commodi.\nQuaerat ut at rem dolorem nam.	Whitney_Botsford61	Whitney_Botsford61	https://s3.amazonaws.com/uifaces/faces/twitter/baumann_alex/128.jpg	2020-06-25 22:29:19.264599	2020-06-25 22:29:19.264599	\N	\N
3	Mr. Braxton Weber	Theresa37@hotmail.com	$2a$08$gqOhy/KYoeRWyOjlkMhPPuX8zatIYEh24PXaeetxOCqndqrqx65DC	f	Illo molestias ratione molestiae veritatis laborum dicta.\nNulla atque sed in.\nSunt eligendi iure quisquam.\nHic aut ducimus earum quisquam aperiam.\nQuasi blanditiis sed.	Danyka.Mann18	Danyka.Mann18	https://s3.amazonaws.com/uifaces/faces/twitter/anoff/128.jpg	2020-06-25 22:29:19.264874	2020-06-25 22:29:19.264874	\N	\N
5	Michelle Lehner	Vernie11@yahoo.com	$2a$08$gqOhy/KYoeRWyOjlkMhPPuX8zatIYEh24PXaeetxOCqndqrqx65DC	f	Corporis qui consequuntur qui et non excepturi.\nAsperiores voluptates ad.\nRepellat at optio fuga vitae ea rerum sed.\nAssumenda est rem quaerat minus harum dolores qui.\nDoloribus amet asperiores ipsum atque omnis voluptate ipsam alias dicta.	Alberto.Nader38	Alberto.Nader38	https://s3.amazonaws.com/uifaces/faces/twitter/javorszky/128.jpg	2020-06-25 22:29:19.265777	2020-06-25 22:29:19.265777	\N	\N
6	Kacie Bauch	Adell_Frami@hotmail.com	$2a$08$gqOhy/KYoeRWyOjlkMhPPuX8zatIYEh24PXaeetxOCqndqrqx65DC	f	A at harum molestiae sit quo cupiditate.\nExcepturi voluptas nulla magni molestiae.\nAliquam sit fugit tempora quia aperiam ut praesentium.\nQuam velit et qui autem qui nobis odit animi.\nModi dicta atque sapiente perspiciatis laudantium necessitatibus totam ipsum quos.	Cale70	Cale70	https://s3.amazonaws.com/uifaces/faces/twitter/mutlu82/128.jpg	2020-06-25 22:29:19.265919	2020-06-25 22:29:19.265919	\N	\N
7	Haylie Jaskolski	Aniya63@hotmail.com	$2a$08$gqOhy/KYoeRWyOjlkMhPPuX8zatIYEh24PXaeetxOCqndqrqx65DC	f	Minus a iusto assumenda nihil cum odit rem.\nHic est et est nisi ipsa et in rerum non.\nDebitis ad fuga excepturi possimus dolores eum iste natus.\nEos pariatur et voluptatem quaerat aut odit porro provident et.\nNihil facere ullam eum expedita architecto ipsam est necessitatibus explicabo.	Jennings_Goodwin58	Jennings_Goodwin58	https://s3.amazonaws.com/uifaces/faces/twitter/abdullindenis/128.jpg	2020-06-25 22:29:19.266092	2020-06-25 22:29:19.266092	\N	\N
8	Electa Kovacek	Kasandra.Witting@hotmail.com	$2a$08$gqOhy/KYoeRWyOjlkMhPPuX8zatIYEh24PXaeetxOCqndqrqx65DC	f	Iusto et ex praesentium dignissimos dolores.\nEnim dolorem ut laudantium id illo perferendis eum culpa.\nDolores facere et perspiciatis officiis soluta omnis hic exercitationem.\nMolestiae aperiam dolores dolor molestiae incidunt enim consectetur non et.\nIn eum iusto reprehenderit in.	Estefania4	Estefania4	https://s3.amazonaws.com/uifaces/faces/twitter/larrybolt/128.jpg	2020-06-25 22:29:19.267475	2020-06-25 22:29:19.267475	\N	\N
10	Gabriella Morar	Bettye84@hotmail.com	$2a$08$gqOhy/KYoeRWyOjlkMhPPuX8zatIYEh24PXaeetxOCqndqrqx65DC	f	Est nostrum consequatur ipsam sunt repellat neque.\nSed ut expedita provident ipsam eveniet.\nAperiam provident veniam exercitationem aut.\nDistinctio eius alias eaque nam praesentium ut qui assumenda.\nFacilis nam dolores reiciendis commodi.	Amiya56	Amiya56	https://s3.amazonaws.com/uifaces/faces/twitter/terryxlife/128.jpg	2020-06-25 22:29:19.269522	2020-06-25 22:29:19.269522	\N	\N
11	Pattie Bartoletti	Imani44@yahoo.com	$2a$08$gqOhy/KYoeRWyOjlkMhPPuX8zatIYEh24PXaeetxOCqndqrqx65DC	f	Sed id aut quaerat nesciunt alias qui quia consequatur.\nUt qui quasi inventore labore sed dolores quo.\nAut est voluptatem quia iste.\nAut aut at earum et ex alias aliquam molestias sint.\nModi rerum omnis unde consequatur.	Ludwig6	Ludwig6	https://s3.amazonaws.com/uifaces/faces/twitter/tomas_janousek/128.jpg	2020-06-25 22:29:19.269723	2020-06-25 22:29:19.269723	\N	\N
12	Danyka Hessel	Felipa.Jacobson@gmail.com	$2a$08$gqOhy/KYoeRWyOjlkMhPPuX8zatIYEh24PXaeetxOCqndqrqx65DC	f	Rerum aut consequatur.\nItaque sed ipsa deleniti omnis beatae harum at quos aspernatur.\nUt dicta rem porro corporis culpa ut voluptates omnis assumenda.\nAtque voluptatem sed ex architecto voluptatem porro sunt fuga.\nNecessitatibus molestiae mollitia porro quia.	Fanny_Swaniawski	Fanny_Swaniawski	https://s3.amazonaws.com/uifaces/faces/twitter/gonzalorobaina/128.jpg	2020-06-25 22:29:19.269926	2020-06-25 22:29:19.269926	\N	\N
13	Alivia Kiehn	Waldo.Smith1@gmail.com	$2a$08$gqOhy/KYoeRWyOjlkMhPPuX8zatIYEh24PXaeetxOCqndqrqx65DC	f	Qui perspiciatis molestias.\nOmnis et eos aliquid possimus consectetur animi delectus repellendus voluptas.\nId dolorem voluptatem.\nAb qui autem aliquam velit quae ut culpa dolorem non.\nMolestias et impedit temporibus perspiciatis atque enim tenetur.	Joanie.Rowe87	Joanie.Rowe87	https://s3.amazonaws.com/uifaces/faces/twitter/ssiskind/128.jpg	2020-06-25 22:29:19.270157	2020-06-25 22:29:19.270157	\N	\N
14	Nels Beahan	Reece.Rice@hotmail.com	$2a$08$gqOhy/KYoeRWyOjlkMhPPuX8zatIYEh24PXaeetxOCqndqrqx65DC	f	Sunt sequi quod.\nVoluptate earum vel voluptas quam aut nam sequi.\nRepellendus dolorum distinctio placeat magni nihil.\nEst quidem reiciendis unde et.\nVel laborum sint qui sed dolorem dolorum non quo.	Yvette.Kertzmann9	Yvette.Kertzmann9	https://s3.amazonaws.com/uifaces/faces/twitter/oktayelipek/128.jpg	2020-06-25 22:29:19.271038	2020-06-25 22:29:19.271038	\N	\N
15	Ramona Schultz	Geoffrey_Dickinson@gmail.com	$2a$08$gqOhy/KYoeRWyOjlkMhPPuX8zatIYEh24PXaeetxOCqndqrqx65DC	f	Quam reiciendis dolores natus eligendi amet sit molestiae ut maiores.\r\nSuscipit praesentium ipsa at eius enim deleniti.\r\nAmet ut cupiditate minima adipisci mollitia sit excepturi.\r\nSit occaecati et consectetur in sit unde.\r\nEt tenetur consectetur ea ipsum sapiente qui impedit quam quia.	Eda_Beahan10	Eda_Beahan10	https://s3.amazonaws.com/uifaces/faces/twitter/gauchomatt/128.jpg	2020-06-25 22:29:19.271198	2020-06-25 22:29:19.271198	\N	\N
27	Brisa Murphy	Liam.Steuber@yahoo.com	$2a$08$ocGCQfF7E/SBnBYCxnpn2ObRJuUvdLVE6Rg0ugFPcdwtfIuoxQoNa	f	Ea qui ratione ut.\nConsequatur ipsa hic.\nAperiam nihil minima.\nQui perspiciatis ut iste voluptatibus molestiae autem corporis perferendis.\nQuo commodi facilis quo ullam asperiores porro rerum suscipit.	Scottie_Oberbrunner43	Scottie_Oberbrunner43	https://s3.amazonaws.com/uifaces/faces/twitter/de_ascanio/128.jpg	2020-07-14 08:43:16.878821	2020-07-14 08:43:16.878821	\N	\N
29	Alessandro Hirthe	Marley6@hotmail.com	$2a$08$ocGCQfF7E/SBnBYCxnpn2ObRJuUvdLVE6Rg0ugFPcdwtfIuoxQoNa	f	Eius necessitatibus qui quis accusamus odio praesentium facilis accusantium.\nDignissimos fuga distinctio eligendi eligendi minus.\nEnim facere numquam molestiae voluptatibus deleniti sequi quia doloremque enim.\nVoluptatem facilis deleniti quasi quos ea esse.\nNulla ipsam architecto assumenda aut sed et suscipit id omnis.	Delpha54	Delpha54	https://s3.amazonaws.com/uifaces/faces/twitter/cynthiasavard/128.jpg	2020-07-14 08:43:16.880043	2020-07-14 08:43:16.880043	\N	\N
28	Marc Aufderhar	Montana_Bayer36@gmail.com	$2a$08$ocGCQfF7E/SBnBYCxnpn2ObRJuUvdLVE6Rg0ugFPcdwtfIuoxQoNa	f	Impedit voluptas porro incidunt magni aut harum.\nTempora quae consequatur et.\nPorro aut aperiam eius aliquam temporibus eveniet similique est voluptatem.\nVel velit ut.\nQuibusdam cum ab expedita.	Eusebio.Mertz21	Eusebio.Mertz21	https://s3.amazonaws.com/uifaces/faces/twitter/antongenkin/128.jpg	2020-07-14 08:43:16.877674	2020-07-14 08:43:16.877674	\N	\N
16	Fernanda Penna	fernanda.panda@gmail.com	$2a$08$gqOhy/KYoeRWyOjlkMhPPuX8zatIYEh24PXaeetxOCqndqrqx65DC	t	Neptune opposition the Ascendant shows that you are greatly influenced by the people with whom you associate.	@panda	@panda	https://images.unsplash.com/photo-1557431177-36141475c676?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80	2020-07-08 15:55:17.479408	2020-07-08 15:55:17.479408	\N	\N
24	Mollie Renner	Hershel24@hotmail.com	$2a$08$ocGCQfF7E/SBnBYCxnpn2ObRJuUvdLVE6Rg0ugFPcdwtfIuoxQoNa	f	Vel autem quod nulla corrupti ut eos dolore amet.\nLaboriosam quo et.\nFugiat rerum omnis asperiores impedit suscipit beatae.\nConsequuntur quibusdam autem consectetur sit illo provident veniam harum.\nQuidem maiores doloremque qui ea eligendi.	Harmony66	Harmony66	https://s3.amazonaws.com/uifaces/faces/twitter/imomenui/128.jpg	2020-07-14 08:43:16.87949	2020-07-14 08:43:16.87949	\N	\N
25	Sarah Grimes	Noemy.Bins@gmail.com	$2a$08$ocGCQfF7E/SBnBYCxnpn2ObRJuUvdLVE6Rg0ugFPcdwtfIuoxQoNa	f	Dignissimos eligendi eligendi esse.\nNisi ut dolorem.\nExplicabo consequatur voluptatibus.\nId dignissimos et corporis qui suscipit.\nFugiat voluptas tempore voluptas.	Karelle_Lubowitz41	Karelle_Lubowitz41	https://s3.amazonaws.com/uifaces/faces/twitter/jjsiii/128.jpg	2020-07-14 08:43:16.876309	2020-07-14 08:43:16.876309	\N	\N
21	Coty Thompson	Coleman71@yahoo.com	$2a$08$ocGCQfF7E/SBnBYCxnpn2ObRJuUvdLVE6Rg0ugFPcdwtfIuoxQoNa	f	Excepturi et vitae.\nEt numquam sit sit delectus soluta odio.\nQuisquam eligendi aspernatur cupiditate et necessitatibus.\nAnimi aut ullam.\nA totam officia expedita sit dolorem eligendi exercitationem natus.	Rosanna8	Rosanna8	https://s3.amazonaws.com/uifaces/faces/twitter/prrstn/128.jpg	2020-07-14 08:43:16.877043	2020-07-14 08:43:16.877043	\N	\N
22	Alanna Reichert	Dolly.Crist5@gmail.com	$2a$08$ocGCQfF7E/SBnBYCxnpn2ObRJuUvdLVE6Rg0ugFPcdwtfIuoxQoNa	f	Asperiores aut non perferendis ut ullam.\nQuos est modi voluptate ut minus adipisci.\nMolestiae sed consequatur velit a ratione.\nMaxime eius velit molestiae autem praesentium et cum tenetur.\nAnimi ratione est perferendis totam voluptatum eos possimus et.	Cielo.Veum24	Cielo.Veum24	https://s3.amazonaws.com/uifaces/faces/twitter/webtanya/128.jpg	2020-07-14 08:43:16.877641	2020-07-14 08:43:16.877641	\N	\N
20	Jamie Oliver	jojo@gmail.com	$2a$08$tvGF4AoxRcTdE3lCTntBKub8pqmWSaP03CI40eo.MH6FacDtxV.YG	f	A 13-episode original video animation series adapting the mangas third part, Stardust Crusaders, was produced by A.P.P.P. and released from 1993 to 2002.	@jojo4adventurer	@jojo4adventurer	./public/images/1594405968189-JoJo-no-Kimyou-na-Bouken.jpg	2020-07-10 15:32:48.271034	2020-07-10 15:32:48.271034	\N	\N
19	Larissa	lala@uol.com.br	$2a$08$F.x5sqaWDxYsifBylW5mEed1y1sOezmorNw1Kg/RuMJRx0Eb5zz0m	f	The Sun was found in the ninth house at the time of birth. This is an indication that your real self possesses an attraction to higher levels of thought. Additionally, this indicates that the most important realizations may come through the process of pure reasoning.	@lala	@lala	./public/images/1594340617728-Screen Shot 2020-07-05 at 12.55.20.png	2020-07-09 15:29:45.785975	2020-07-09 15:29:45.785975	\N	\N
18	Julia Kinoto	juju@uol.com	$2a$08$MLqzcurgQ6sj.kmQ6ZWr/eKlIjVOJ1dsqSUKFWlqu3xjbQwGsDcR2	f	The Sun was found in the ninth house at the time of birth. This is an indication that your real self possesses an attraction to higher levels of thought. Additionally, this indicates that the most important realizations may come through the process of pure reasoning.	@juju	@juju	./public/images/1594340617728-Screen Shot 2020-07-05 at 12.55.20.png	2020-07-09 15:09:55.008673	2020-07-09 15:09:55.008673	\N	\N
26	Dr. Una Quigley	Efren.Swaniawski20@gmail.com	$2a$08$ocGCQfF7E/SBnBYCxnpn2ObRJuUvdLVE6Rg0ugFPcdwtfIuoxQoNa	f	Neque accusamus consectetur rem eligendi animi.\nNam voluptas iusto.\nPraesentium consequatur blanditiis vero in minima eum eius.\nSit illo ipsam.\nOdit est earum et consequatur magni similique modi.	Haleigh25	Haleigh25	https://s3.amazonaws.com/uifaces/faces/twitter/runningskull/128.jpg	2020-07-14 08:43:16.878867	2020-07-14 08:43:16.878867	\N	\N
23	Andre Schmidt	Napoleon_Grimes29@gmail.com	$2a$08$ocGCQfF7E/SBnBYCxnpn2ObRJuUvdLVE6Rg0ugFPcdwtfIuoxQoNa	f	Dolor reiciendis autem quia natus et fugit.\nNesciunt et et.\nUt quia incidunt quis omnis ipsam ut quia.\nQuo consequuntur voluptatum voluptatem porro qui.\nUt itaque totam itaque debitis.	Velda.Beier	Velda.Beier	https://s3.amazonaws.com/uifaces/faces/twitter/_scottburgess/128.jpg	2020-07-14 08:43:16.878039	2020-07-14 08:43:16.878039	\N	\N
30	Richard Hilll	Rhoda.Goodwin61@yahoo.com	$2a$08$ocGCQfF7E/SBnBYCxnpn2ObRJuUvdLVE6Rg0ugFPcdwtfIuoxQoNa	f	Possimus ut rerum occaecati minima.\nQuo voluptatem in.\nAliquam exercitationem et dolores sed nam aperiam impedit qui.\nVoluptas numquam autem dolor repellat mollitia.\nEnim tempora sed molestiae tempore quibusdam.	Christina5	Christina5	https://s3.amazonaws.com/uifaces/faces/twitter/r_oy/128.jpg	2020-07-14 08:43:16.88024	2020-07-14 08:43:16.88024	\N	\N
31	Joanny Flatley PhD	Muriel24@gmail.com	$2a$08$ocGCQfF7E/SBnBYCxnpn2ObRJuUvdLVE6Rg0ugFPcdwtfIuoxQoNa	f	Dolor ut blanditiis eaque explicabo id reiciendis cupiditate possimus tenetur.\nPlaceat est quae est assumenda voluptatem.\nQui sit et illum consequuntur excepturi.\nVero voluptas cupiditate quia.\nMinima eos vitae id.	Trenton.Effertz59	Trenton.Effertz59	https://s3.amazonaws.com/uifaces/faces/twitter/imomenui/128.jpg	2020-07-14 08:43:16.885169	2020-07-14 08:43:16.885169	\N	\N
32	Wilhelmine Kirlin	Destiney_Okuneva91@gmail.com	$2a$08$ocGCQfF7E/SBnBYCxnpn2ObRJuUvdLVE6Rg0ugFPcdwtfIuoxQoNa	f	Autem animi officia omnis.\nOmnis necessitatibus vel cumque aliquam provident mollitia.\nEius est quas repudiandae sed quis.\nEum sit eaque at consequatur exercitationem sed eaque.\nDeleniti deserunt dolorem impedit voluptates sint laudantium voluptates quo itaque.	Ava79	Ava79	https://s3.amazonaws.com/uifaces/faces/twitter/lhausermann/128.jpg	2020-07-14 08:43:16.890978	2020-07-14 08:43:16.890978	\N	\N
33	Royce Olson II	Zelma_Feil@hotmail.com	$2a$08$ocGCQfF7E/SBnBYCxnpn2ObRJuUvdLVE6Rg0ugFPcdwtfIuoxQoNa	f	Quos incidunt suscipit nostrum.\nRerum et harum.\nReprehenderit aut amet ut non.\nTempore ut iusto nesciunt.\nIllo aut eum odio esse reiciendis reiciendis.	Sydnie.Dibbert	Sydnie.Dibbert	https://s3.amazonaws.com/uifaces/faces/twitter/daykiine/128.jpg	2020-07-14 08:43:16.891516	2020-07-14 08:43:16.891516	\N	\N
34	Margaret Heathcote	Alycia_Walsh38@yahoo.com	$2a$08$ocGCQfF7E/SBnBYCxnpn2ObRJuUvdLVE6Rg0ugFPcdwtfIuoxQoNa	f	Qui harum quisquam in sit sequi.\nAspernatur sed nobis praesentium.\nA expedita dolorem ut aut.\nCorporis voluptates enim occaecati.\nConsequatur sapiente rem tempore odio non est ut est eos.	Heidi_Eichmann	Heidi_Eichmann	https://s3.amazonaws.com/uifaces/faces/twitter/thiagovernetti/128.jpg	2020-07-14 08:43:16.892058	2020-07-14 08:43:16.892058	\N	\N
44	Helga Fahey	Gladyce_Baumbach36@hotmail.com	$2a$08$ocGCQfF7E/SBnBYCxnpn2ObRJuUvdLVE6Rg0ugFPcdwtfIuoxQoNa	f	Distinctio maxime pariatur aut adipisci.\nEst in laborum praesentium neque eum.\nSed impedit autem id et ex quis quisquam iure.\nAperiam quam dolor dolor sapiente omnis natus quisquam officia ea.\nNam ipsum illum fugiat nihil.	Ally82	Ally82	https://s3.amazonaws.com/uifaces/faces/twitter/tgerken/128.jpg	2020-07-14 08:43:16.897193	2020-07-14 08:43:16.897193	\N	\N
35	Shemar Gaylord	Veda.Legros22@yahoo.com	$2a$08$ocGCQfF7E/SBnBYCxnpn2ObRJuUvdLVE6Rg0ugFPcdwtfIuoxQoNa	f	Nulla nobis eveniet quibusdam.\nIn ex a qui sint esse sequi omnis aliquam.\nRerum et et in amet et repellat qui.\nPossimus accusamus et.\nMagni nemo rerum placeat.	Birdie_Christiansen	Birdie_Christiansen	https://s3.amazonaws.com/uifaces/faces/twitter/teeragit/128.jpg	2020-07-14 08:43:16.892556	2020-07-14 08:43:16.892556	\N	\N
45	Stewart Stroman	Moriah69@hotmail.com	$2a$08$ocGCQfF7E/SBnBYCxnpn2ObRJuUvdLVE6Rg0ugFPcdwtfIuoxQoNa	f	Aut totam natus officiis quaerat dolorem.\nDistinctio provident ut corporis doloremque dolor deserunt.\nEveniet cum ratione nobis labore provident quaerat dolore facilis.\nQui sit porro minus et voluptate odio et.\nAutem fugiat eos doloremque fugit fugiat itaque quibusdam.	Noelia69	Noelia69	https://s3.amazonaws.com/uifaces/faces/twitter/chrisslowik/128.jpg	2020-07-14 08:43:16.897678	2020-07-14 08:43:16.897678	\N	\N
36	Esta Nikolaus	Elinore_Monahan@gmail.com	$2a$08$ocGCQfF7E/SBnBYCxnpn2ObRJuUvdLVE6Rg0ugFPcdwtfIuoxQoNa	f	Perferendis libero ducimus.\nRepudiandae aliquam consequuntur saepe.\nUt odit est quisquam beatae nulla.\nEveniet optio illum.\nVoluptatibus iusto a pariatur.	Katelin.Rosenbaum	Katelin.Rosenbaum	https://s3.amazonaws.com/uifaces/faces/twitter/eitarafa/128.jpg	2020-07-14 08:43:16.892998	2020-07-14 08:43:16.892998	\N	\N
46	Mrs. Marcellus Volkman	Hayley_Stroman@yahoo.com	$2a$08$ocGCQfF7E/SBnBYCxnpn2ObRJuUvdLVE6Rg0ugFPcdwtfIuoxQoNa	f	Asperiores qui qui adipisci et numquam autem cum.\nVoluptate et deleniti animi sapiente eum sit.\nRepellat non optio quia.\nSaepe asperiores esse perspiciatis.\nQuia minus sed nam deleniti sunt qui.	Jamel_Kuhn84	Jamel_Kuhn84	https://s3.amazonaws.com/uifaces/faces/twitter/kennyadr/128.jpg	2020-07-14 08:43:16.898158	2020-07-14 08:43:16.898158	\N	\N
37	Miss Emmy Goyette	Sydnie93@yahoo.com	$2a$08$ocGCQfF7E/SBnBYCxnpn2ObRJuUvdLVE6Rg0ugFPcdwtfIuoxQoNa	f	Eos magni est commodi laudantium aut tenetur.\nDelectus asperiores voluptatem voluptas voluptatem sint nesciunt nihil.\nDolores et reprehenderit dicta aut repellendus.\nQuia corrupti et voluptatibus explicabo magni.\nQuia officia omnis ad cupiditate veritatis ea earum.	Elsie.Wolf19	Elsie.Wolf19	https://s3.amazonaws.com/uifaces/faces/twitter/itsajimithing/128.jpg	2020-07-14 08:43:16.893638	2020-07-14 08:43:16.893638	\N	\N
47	Roma Terry	Darius_Murazik3@yahoo.com	$2a$08$ocGCQfF7E/SBnBYCxnpn2ObRJuUvdLVE6Rg0ugFPcdwtfIuoxQoNa	f	Quo dignissimos qui et illo et molestiae vel magni est.\nSint saepe cumque debitis mollitia et magnam qui nisi.\nExercitationem assumenda rerum officiis consequatur sed aut.\nQui eius sit rerum ipsa eum rerum.\nQuod et enim voluptatem ipsa dolores.	Ashley.Dibbert	Ashley.Dibbert	https://s3.amazonaws.com/uifaces/faces/twitter/markretzloff/128.jpg	2020-07-14 08:43:16.898597	2020-07-14 08:43:16.898597	\N	\N
38	Diana Raynor Sr.	Crawford_Balistreri@yahoo.com	$2a$08$ocGCQfF7E/SBnBYCxnpn2ObRJuUvdLVE6Rg0ugFPcdwtfIuoxQoNa	f	Minus autem sint aut odio dolorem libero expedita blanditiis.\nVoluptate ut dignissimos sit facilis ullam.\nDucimus quod quis maxime ut asperiores ipsam saepe.\nVoluptas odio nobis hic molestiae eum.\nUt dolor harum.	Danyka_Jacobi8	Danyka_Jacobi8	https://s3.amazonaws.com/uifaces/faces/twitter/jonathansimmons/128.jpg	2020-07-14 08:43:16.894154	2020-07-14 08:43:16.894154	\N	\N
48	Madalyn Russel	Rafaela53@hotmail.com	$2a$08$ocGCQfF7E/SBnBYCxnpn2ObRJuUvdLVE6Rg0ugFPcdwtfIuoxQoNa	f	Fugit atque asperiores et illum nemo deserunt accusamus.\nVoluptas eius eum minus praesentium.\nEt nihil ea quia sit vel molestias id vel expedita.\nLabore repellat recusandae.\nDolorem et qui libero corporis velit quos.	Summer25	Summer25	https://s3.amazonaws.com/uifaces/faces/twitter/jnmnrd/128.jpg	2020-07-14 08:43:16.899071	2020-07-14 08:43:16.899071	\N	\N
39	Godfrey Towne III	Adrain.Harber@gmail.com	$2a$08$ocGCQfF7E/SBnBYCxnpn2ObRJuUvdLVE6Rg0ugFPcdwtfIuoxQoNa	f	Et architecto sed et quos commodi veniam magnam iure.\nNihil sapiente enim.\nRatione voluptatem et et voluptates.\nLaboriosam voluptates quia et est quasi tempora.\nVeniam minus ut excepturi deserunt dolores deserunt inventore.	Pearline77	Pearline77	https://s3.amazonaws.com/uifaces/faces/twitter/diansigitp/128.jpg	2020-07-14 08:43:16.89466	2020-07-14 08:43:16.89466	\N	\N
49	Vesta Johnson	Santino_Wunsch5@hotmail.com	$2a$08$ocGCQfF7E/SBnBYCxnpn2ObRJuUvdLVE6Rg0ugFPcdwtfIuoxQoNa	f	Qui nulla dolorem molestiae ut.\nIpsum quo id.\nDeleniti aut voluptates.\nIllo cupiditate enim dolore suscipit non possimus quia iure.\nVitae autem itaque aliquid quia et pariatur voluptatem perspiciatis eum.	Zakary.Howell	Zakary.Howell	https://s3.amazonaws.com/uifaces/faces/twitter/uxpiper/128.jpg	2020-07-14 08:43:16.899544	2020-07-14 08:43:16.899544	\N	\N
40	Mrs. Maudie Veum	Alba_Heathcote@yahoo.com	$2a$08$ocGCQfF7E/SBnBYCxnpn2ObRJuUvdLVE6Rg0ugFPcdwtfIuoxQoNa	f	Ut veritatis vel quibusdam asperiores vitae accusantium ullam ad.\nQuia nihil itaque.\nAliquid laboriosam assumenda et dolorem consectetur.\nBlanditiis nisi dolores modi aperiam dicta iure.\nA et eum odit consectetur nam.	Hiram32	Hiram32	https://s3.amazonaws.com/uifaces/faces/twitter/louis_currie/128.jpg	2020-07-14 08:43:16.895123	2020-07-14 08:43:16.895123	\N	\N
50	Ken Harvey IV	Helga.Bailey@gmail.com	$2a$08$ocGCQfF7E/SBnBYCxnpn2ObRJuUvdLVE6Rg0ugFPcdwtfIuoxQoNa	f	Mollitia ipsam eos mollitia ut cum et sed eligendi.\nNam odit aut minus.\nPraesentium dicta saepe odit provident natus consequatur fugiat harum nemo.\nQuis autem ut non.\nMinima accusamus nam eveniet.	Sid.Kunde	Sid.Kunde	https://s3.amazonaws.com/uifaces/faces/twitter/joshuaraichur/128.jpg	2020-07-14 08:43:16.899966	2020-07-14 08:43:16.899966	\N	\N
41	Garland Hodkiewicz	Casandra_Marquardt@hotmail.com	$2a$08$ocGCQfF7E/SBnBYCxnpn2ObRJuUvdLVE6Rg0ugFPcdwtfIuoxQoNa	f	Et reprehenderit qui quae unde quidem.\nPerspiciatis adipisci hic ut consequatur magni sapiente dolorem rem harum.\nQuidem non perspiciatis.\nDelectus consectetur voluptatum maiores quaerat et.\nUt ullam ex.	Alvis41	Alvis41	https://s3.amazonaws.com/uifaces/faces/twitter/levisan/128.jpg	2020-07-14 08:43:16.895697	2020-07-14 08:43:16.895697	\N	\N
42	Jairo Dicki DVM	Lavern59@yahoo.com	$2a$08$ocGCQfF7E/SBnBYCxnpn2ObRJuUvdLVE6Rg0ugFPcdwtfIuoxQoNa	f	Assumenda alias id optio et.\nBlanditiis rerum cum sed aspernatur excepturi doloremque beatae omnis placeat.\nUt suscipit aliquid.\nHarum illum enim quibusdam rerum nobis assumenda.\nUllam omnis hic iure vel cupiditate cupiditate dolores voluptates.	Antonetta89	Antonetta89	https://s3.amazonaws.com/uifaces/faces/twitter/ryanjohnson_me/128.jpg	2020-07-14 08:43:16.896234	2020-07-14 08:43:16.896234	\N	\N
43	Era Gutmann	Jerrod82@hotmail.com	$2a$08$ocGCQfF7E/SBnBYCxnpn2ObRJuUvdLVE6Rg0ugFPcdwtfIuoxQoNa	f	Aut quis omnis rerum id optio.\nVeniam quas ipsam quisquam nemo.\nAut est qui est adipisci et maxime facere ullam.\nItaque error voluptatem laborum et quia enim libero et.\nEveniet delectus autem vel necessitatibus.	Marco.Watsica63	Marco.Watsica63	https://s3.amazonaws.com/uifaces/faces/twitter/spacewood_/128.jpg	2020-07-14 08:43:16.896704	2020-07-14 08:43:16.896704	\N	\N
51	Willy Schneider	Berniece81@hotmail.com	$2a$08$/r7INwHbY4xBlBf2LBet5OkG9mnm.cSMAr8rek/y9kiBarpZd4pAC	f	Molestiae praesentium sequi aliquam laboriosam reprehenderit officia voluptate beatae.\nDolore architecto nobis.\nVelit veritatis ullam quia quis suscipit ipsam accusamus consequatur.\nModi cumque sunt nostrum magni vitae est sequi reiciendis.\nRerum incidunt illo error aut possimus sed sed hic.	Nella_Keebler	Nella_Keebler	https://s3.amazonaws.com/uifaces/faces/twitter/kimcool/128.jpg	2020-07-14 08:45:40.735995	2020-07-14 08:45:40.735995	\N	\N
52	Dr. Tressa Cassin	Derek.Lehner85@gmail.com	$2a$08$/r7INwHbY4xBlBf2LBet5OkG9mnm.cSMAr8rek/y9kiBarpZd4pAC	f	Voluptatibus cupiditate sint impedit quasi similique.\nA id quae neque repudiandae et neque.\nOmnis saepe quia et provident facere voluptatem impedit voluptatibus suscipit.\nDicta aut quaerat illum dolorem est maxime laborum.\nEnim fuga nam omnis qui est error.	Shawna54	Shawna54	https://s3.amazonaws.com/uifaces/faces/twitter/balakayuriy/128.jpg	2020-07-14 08:45:40.736389	2020-07-14 08:45:40.736389	\N	\N
53	Xavier Hane	Tate.Stracke59@yahoo.com	$2a$08$/r7INwHbY4xBlBf2LBet5OkG9mnm.cSMAr8rek/y9kiBarpZd4pAC	f	Fugiat ut vero non ratione voluptatum.\nNulla qui fugit eum excepturi eos qui est repudiandae.\nNecessitatibus aut nihil rerum.\nIpsum hic est maiores.\nVelit illo quasi modi non.	Anabelle0	Anabelle0	https://s3.amazonaws.com/uifaces/faces/twitter/quailandquasar/128.jpg	2020-07-14 08:45:40.736664	2020-07-14 08:45:40.736664	\N	\N
54	Marshall Rutherford	Tyrel83@yahoo.com	$2a$08$/r7INwHbY4xBlBf2LBet5OkG9mnm.cSMAr8rek/y9kiBarpZd4pAC	f	Ipsum temporibus aut facere itaque optio dolorem.\nVoluptatum minima qui blanditiis cumque aut perferendis error similique eius.\nEius nemo doloribus et in velit veniam.\nSint qui perferendis necessitatibus eligendi aperiam esse neque.\nLaudantium vel voluptatem tempore numquam.	Mina.Hyatt93	Mina.Hyatt93	https://s3.amazonaws.com/uifaces/faces/twitter/therealmarvin/128.jpg	2020-07-14 08:45:40.736925	2020-07-14 08:45:40.736925	\N	\N
55	Lelia Gutmann	Bettye61@yahoo.com	$2a$08$/r7INwHbY4xBlBf2LBet5OkG9mnm.cSMAr8rek/y9kiBarpZd4pAC	f	Accusantium esse qui aliquam itaque fuga ullam qui autem.\nAliquid ea nulla non.\nSunt facere ducimus hic distinctio ipsum.\nUt sapiente deserunt natus voluptatem.\nIllo explicabo quia ea.	Lorenz42	Lorenz42	https://s3.amazonaws.com/uifaces/faces/twitter/aleinadsays/128.jpg	2020-07-14 08:45:40.738372	2020-07-14 08:45:40.738372	\N	\N
56	Myra Renner	Joanne31@hotmail.com	$2a$08$/r7INwHbY4xBlBf2LBet5OkG9mnm.cSMAr8rek/y9kiBarpZd4pAC	f	Et excepturi odio qui ea natus aliquam earum.\nDucimus laborum provident ad sapiente excepturi magni et et.\nSit ut id vel suscipit sit fugiat.\nMagni qui velit animi harum quo est maiores fugit.\nError at et rerum.	Samantha.Moore8	Samantha.Moore8	https://s3.amazonaws.com/uifaces/faces/twitter/patrickcoombe/128.jpg	2020-07-14 08:45:40.737618	2020-07-14 08:45:40.737618	\N	\N
57	Ambrose Bednar	Ansley.Stokes@gmail.com	$2a$08$/r7INwHbY4xBlBf2LBet5OkG9mnm.cSMAr8rek/y9kiBarpZd4pAC	f	Dolorem quasi optio ipsum minus aut velit.\nEst dicta omnis qui et error.\nQuod aut qui ea.\nDicta quos dolores minus ex et.\nCumque rerum est commodi.	Lynn.Dibbert44	Lynn.Dibbert44	https://s3.amazonaws.com/uifaces/faces/twitter/privetwagner/128.jpg	2020-07-14 08:45:40.739046	2020-07-14 08:45:40.739046	\N	\N
58	Cecile Zboncak	Michael80@yahoo.com	$2a$08$/r7INwHbY4xBlBf2LBet5OkG9mnm.cSMAr8rek/y9kiBarpZd4pAC	f	Vel eos commodi.\nPlaceat eaque quas iste dolorum placeat ea maxime id perspiciatis.\nPraesentium similique inventore voluptatibus nostrum placeat magni molestiae quas.\nQui unde iusto autem doloremque laboriosam ad.\nMolestias rem voluptatem.	Lily_Kuvalis	Lily_Kuvalis	https://s3.amazonaws.com/uifaces/faces/twitter/dzantievm/128.jpg	2020-07-14 08:45:40.739951	2020-07-14 08:45:40.739951	\N	\N
59	Lempi Bernhard	Alexys.Cartwright@yahoo.com	$2a$08$/r7INwHbY4xBlBf2LBet5OkG9mnm.cSMAr8rek/y9kiBarpZd4pAC	f	Vero incidunt doloremque corrupti voluptatem minima autem magnam quibusdam laudantium.\nVel laborum sapiente cum porro.\nAdipisci nisi cum.\nAdipisci eum explicabo possimus suscipit tenetur eum.\nMinima et sapiente blanditiis.	Giovani.Schneider	Giovani.Schneider	https://s3.amazonaws.com/uifaces/faces/twitter/herkulano/128.jpg	2020-07-14 08:45:40.740478	2020-07-14 08:45:40.740478	\N	\N
60	Maribel Kutch	Maria.Miller@hotmail.com	$2a$08$/r7INwHbY4xBlBf2LBet5OkG9mnm.cSMAr8rek/y9kiBarpZd4pAC	f	Velit qui itaque minus consequatur.\nInventore dignissimos in soluta rerum ut at omnis ad modi.\nOccaecati quisquam hic esse molestiae et veritatis qui.\nMagnam sed ad culpa aut.\nAccusamus voluptas sapiente ea eos.	Maia42	Maia42	https://s3.amazonaws.com/uifaces/faces/twitter/jpenico/128.jpg	2020-07-14 08:45:40.740783	2020-07-14 08:45:40.740783	\N	\N
61	Arely Prosacco	Vella.Wehner@gmail.com	$2a$08$/r7INwHbY4xBlBf2LBet5OkG9mnm.cSMAr8rek/y9kiBarpZd4pAC	f	Enim quo consequuntur vel culpa occaecati consequatur.\nAut doloremque aut autem dolorem.\nConsequatur doloribus ex et voluptatibus omnis et nisi aliquid.\nEt et occaecati cum inventore et.\nEt similique voluptatem aut voluptatem esse possimus perferendis eum dolorum.	Wilmer76	Wilmer76	https://s3.amazonaws.com/uifaces/faces/twitter/gaborenton/128.jpg	2020-07-14 08:45:40.742824	2020-07-14 08:45:40.742824	\N	\N
62	Marcelle Jones	Pierce39@hotmail.com	$2a$08$/r7INwHbY4xBlBf2LBet5OkG9mnm.cSMAr8rek/y9kiBarpZd4pAC	f	Libero dolorem exercitationem optio harum.\nVelit autem eum eum accusamus.\nDistinctio quia eligendi.\nEt ut velit.\nUt velit qui ullam saepe quidem et debitis.	Brycen.Stokes73	Brycen.Stokes73	https://s3.amazonaws.com/uifaces/faces/twitter/guillemboti/128.jpg	2020-07-14 08:45:40.747641	2020-07-14 08:45:40.747641	\N	\N
63	Ralph Donnelly	Gregoria43@gmail.com	$2a$08$/r7INwHbY4xBlBf2LBet5OkG9mnm.cSMAr8rek/y9kiBarpZd4pAC	f	Nisi vitae dolor pariatur soluta ut iste qui.\nVel earum quibusdam voluptates ipsa consequatur consectetur ut dicta.\nDolor atque ullam ea dicta aut error est pariatur qui.\nEt quaerat magnam accusantium ut placeat fuga error ipsam.\nBeatae enim voluptate dicta expedita voluptatum.	Matilde_Hansen35	Matilde_Hansen35	https://s3.amazonaws.com/uifaces/faces/twitter/aaronalfred/128.jpg	2020-07-14 08:45:40.748235	2020-07-14 08:45:40.748235	\N	\N
64	Justice Ruecker	Pansy_Moore@gmail.com	$2a$08$/r7INwHbY4xBlBf2LBet5OkG9mnm.cSMAr8rek/y9kiBarpZd4pAC	f	Voluptas fuga et.\nDebitis rerum rerum.\nEst suscipit unde temporibus est.\nVeritatis ea odit provident ratione doloremque vel alias quis quis.\nRepellat repudiandae doloribus.	Toni_Bahringer67	Toni_Bahringer67	https://s3.amazonaws.com/uifaces/faces/twitter/kimcool/128.jpg	2020-07-14 08:45:40.748761	2020-07-14 08:45:40.748761	\N	\N
65	Miss Alena Block	Norbert76@gmail.com	$2a$08$/r7INwHbY4xBlBf2LBet5OkG9mnm.cSMAr8rek/y9kiBarpZd4pAC	f	Iusto qui corrupti quis.\nQuo voluptas tempore aut asperiores aut maxime.\nSuscipit et amet reprehenderit.\nOdio itaque accusantium omnis qui.\nCupiditate error sapiente doloribus.	Henri.Stiedemann	Henri.Stiedemann	https://s3.amazonaws.com/uifaces/faces/twitter/panchajanyag/128.jpg	2020-07-14 08:45:40.749243	2020-07-14 08:45:40.749243	\N	\N
66	Janice Fisher	Domingo.Hilpert@hotmail.com	$2a$08$/r7INwHbY4xBlBf2LBet5OkG9mnm.cSMAr8rek/y9kiBarpZd4pAC	f	Rerum aliquam accusantium vitae quam natus ad.\nLaudantium ut ipsum placeat similique neque voluptatem ipsum.\nAut architecto harum quis impedit.\nCorrupti veritatis qui nihil suscipit aut et.\nInventore ut sed.	Destin_Conn	Destin_Conn	https://s3.amazonaws.com/uifaces/faces/twitter/diansigitp/128.jpg	2020-07-14 08:45:40.74969	2020-07-14 08:45:40.74969	\N	\N
67	Wilburn Kuhic	Arlo85@gmail.com	$2a$08$/r7INwHbY4xBlBf2LBet5OkG9mnm.cSMAr8rek/y9kiBarpZd4pAC	f	Incidunt saepe omnis.\nEst nesciunt beatae voluptatem nihil voluptas ut vero sed tenetur.\nEt voluptatem omnis non quas.\nNihil illum laborum eius error qui.\nAtque pariatur libero sequi labore voluptatem corporis.	Rosalia21	Rosalia21	https://s3.amazonaws.com/uifaces/faces/twitter/buleswapnil/128.jpg	2020-07-14 08:45:40.75019	2020-07-14 08:45:40.75019	\N	\N
77	Lisette Monahan	Lilyan_Beer58@gmail.com	$2a$08$/r7INwHbY4xBlBf2LBet5OkG9mnm.cSMAr8rek/y9kiBarpZd4pAC	f	Amet corporis consequatur.\nQuidem omnis in quasi nihil.\nDoloremque qui explicabo.\nQuia doloremque repellendus ad.\nQuia soluta rerum fugit incidunt delectus blanditiis optio omnis.	Violette.Schulist3	Violette.Schulist3	https://s3.amazonaws.com/uifaces/faces/twitter/ernestsemerda/128.jpg	2020-07-14 08:45:40.770877	2020-07-14 08:45:40.770877	\N	\N
78	Miss Dock Hilll	Reina_Kemmer@yahoo.com	$2a$08$/r7INwHbY4xBlBf2LBet5OkG9mnm.cSMAr8rek/y9kiBarpZd4pAC	f	Autem sunt ducimus.\nIn qui tempora commodi doloremque dolorum accusamus ut.\nAssumenda ullam quia ex.\nImpedit commodi et rem.\nAliquid sunt et distinctio ut ut neque modi a similique.	Cathy78	Cathy78	https://s3.amazonaws.com/uifaces/faces/twitter/ky/128.jpg	2020-07-14 08:45:40.771424	2020-07-14 08:45:40.771424	\N	\N
79	Casey VonRueden MD	Ashtyn_Effertz60@hotmail.com	$2a$08$/r7INwHbY4xBlBf2LBet5OkG9mnm.cSMAr8rek/y9kiBarpZd4pAC	f	Velit et voluptas laborum eaque illo omnis.\nDeserunt distinctio ratione quod voluptates magnam omnis aut nostrum.\nDolore minima at doloribus possimus.\nMinima est suscipit quod.\nQuos temporibus quia optio illo tempora commodi omnis suscipit.	Mabel.Ondricka86	Mabel.Ondricka86	https://s3.amazonaws.com/uifaces/faces/twitter/terryxlife/128.jpg	2020-07-14 08:45:40.772016	2020-07-14 08:45:40.772016	\N	\N
80	Aubrey Powlowski	Mona_Lesch34@hotmail.com	$2a$08$/r7INwHbY4xBlBf2LBet5OkG9mnm.cSMAr8rek/y9kiBarpZd4pAC	f	Voluptas est libero.\nEnim consequuntur ut.\nOfficiis odit architecto rem quis quaerat.\nQui in eum.\nQui ut officiis exercitationem inventore quia.	Berniece_Hudson13	Berniece_Hudson13	https://s3.amazonaws.com/uifaces/faces/twitter/ryanmclaughlin/128.jpg	2020-07-14 08:45:40.772693	2020-07-14 08:45:40.772693	\N	\N
69	Layne Funk	Payton_Yundt35@yahoo.com	$2a$08$/r7INwHbY4xBlBf2LBet5OkG9mnm.cSMAr8rek/y9kiBarpZd4pAC	f	Quia voluptatem eos rerum ut voluptates voluptatibus autem in ad.\nDolore itaque sit nulla et est voluptatum ut facere.\nIste fugiat molestiae ab incidunt recusandae.\nUnde voluptas unde.\nVoluptatem et ad sed ex odio.	Pierce.Marks	Pierce.Marks	https://s3.amazonaws.com/uifaces/faces/twitter/carlyson/128.jpg	2020-07-14 08:45:40.751284	2020-07-14 08:45:40.751284	\N	\N
70	Katrina Harvey	Lucas83@yahoo.com	$2a$08$/r7INwHbY4xBlBf2LBet5OkG9mnm.cSMAr8rek/y9kiBarpZd4pAC	f	Excepturi nemo illum sequi.\nPerferendis voluptas sunt quis molestiae doloribus nihil non et consequuntur.\nDucimus dolorem voluptatem velit distinctio omnis nam qui.\nConsequuntur asperiores est vero possimus omnis odit quo labore saepe.\nUt dignissimos provident enim reiciendis.	Esther.Eichmann	Esther.Eichmann	https://s3.amazonaws.com/uifaces/faces/twitter/eyronn/128.jpg	2020-07-14 08:45:40.75172	2020-07-14 08:45:40.75172	\N	\N
71	Ervin Lang	Stuart.Dietrich@hotmail.com	$2a$08$/r7INwHbY4xBlBf2LBet5OkG9mnm.cSMAr8rek/y9kiBarpZd4pAC	f	Dolores et molestiae aut quia libero qui.\nDolores facere dolor provident.\nUt aperiam et odit.\nNumquam consectetur molestiae.\nVoluptatum veritatis sit molestiae eveniet dolorem sed qui eum sit.	Nina.Walsh	Nina.Walsh	https://s3.amazonaws.com/uifaces/faces/twitter/antonyzotov/128.jpg	2020-07-14 08:45:40.752187	2020-07-14 08:45:40.752187	\N	\N
72	Blair Brakus	Earline50@gmail.com	$2a$08$/r7INwHbY4xBlBf2LBet5OkG9mnm.cSMAr8rek/y9kiBarpZd4pAC	f	Nam tempora omnis accusamus qui reiciendis nemo magnam nostrum.\nEt illum et.\nQuia temporibus nihil eaque fugit voluptas aliquam at ut ad.\nLaborum esse facere dolorum qui.\nEt autem rem ut ducimus dolor minima nostrum est voluptatibus.	Lelia_Murazik28	Lelia_Murazik28	https://s3.amazonaws.com/uifaces/faces/twitter/d_nny_m_cher/128.jpg	2020-07-14 08:45:40.752605	2020-07-14 08:45:40.752605	\N	\N
73	Miss Jolie Goodwin	Brando_Dickens77@gmail.com	$2a$08$/r7INwHbY4xBlBf2LBet5OkG9mnm.cSMAr8rek/y9kiBarpZd4pAC	f	Placeat delectus est reprehenderit nobis odit voluptatem.\nLibero at sit repellendus.\nMaiores magnam voluptatem earum dignissimos voluptatem.\nSapiente fuga et et pariatur dolore qui sit.\nUnde sint et nulla quis quae reprehenderit veritatis ipsam.	Abdul.Macejkovic	Abdul.Macejkovic	https://s3.amazonaws.com/uifaces/faces/twitter/lingeswaran/128.jpg	2020-07-14 08:45:40.75315	2020-07-14 08:45:40.75315	\N	\N
74	Addie Swaniawski	Omari_Howe@yahoo.com	$2a$08$/r7INwHbY4xBlBf2LBet5OkG9mnm.cSMAr8rek/y9kiBarpZd4pAC	f	Qui aspernatur id consequatur eum labore et placeat distinctio aut.\nEst aut consequatur voluptatem blanditiis.\nEt velit inventore et dolorem aspernatur.\nPlaceat nihil rerum sunt laboriosam ipsum hic amet.\nIn aperiam aut at.	Crystel71	Crystel71	https://s3.amazonaws.com/uifaces/faces/twitter/iamsteffen/128.jpg	2020-07-14 08:45:40.753575	2020-07-14 08:45:40.753575	\N	\N
75	Miss Boris Turcotte	Arlo22@yahoo.com	$2a$08$/r7INwHbY4xBlBf2LBet5OkG9mnm.cSMAr8rek/y9kiBarpZd4pAC	f	Ea est nam fugit et nobis voluptate a est excepturi.\nNeque nihil esse assumenda dolorem recusandae qui a aut vel.\nEligendi magni cupiditate illo.\nIn quis deserunt nihil dolore ut adipisci voluptas qui.\nAlias vero suscipit ea omnis.	Laurine.Romaguera27	Laurine.Romaguera27	https://s3.amazonaws.com/uifaces/faces/twitter/chadengle/128.jpg	2020-07-14 08:45:40.753939	2020-07-14 08:45:40.753939	\N	\N
76	Darron Johnson	Geo40@yahoo.com	$2a$08$/r7INwHbY4xBlBf2LBet5OkG9mnm.cSMAr8rek/y9kiBarpZd4pAC	f	Quo ipsam et.\nAutem quis earum dolorem earum quia harum.\nPlaceat voluptatum qui amet error.\nEa aut optio minus nostrum sit.\nNostrum magni quasi itaque dolorem beatae quia et soluta.	Wyman72	Wyman72	https://s3.amazonaws.com/uifaces/faces/twitter/dreizle/128.jpg	2020-07-14 08:45:40.75432	2020-07-14 08:45:40.75432	\N	\N
81	Rene Halvorson	Madie.Torp@hotmail.com	$2a$08$Nkf0CItjTgF1sU7j6w3Vf.EzKGWhvxEnWB7NYtdfQxCLKhR7NQVjS	f	Ea reiciendis non pariatur.\nMolestiae praesentium tempore et similique dolorem reprehenderit illo.\nQuod at sit corrupti in in.\nNulla velit error praesentium illum aut voluptatem dolorum architecto illo.\nIncidunt labore nostrum officiis.	Dell_Kassulke58	Dell_Kassulke58	https://s3.amazonaws.com/uifaces/faces/twitter/switmer777/128.jpg	2020-07-14 08:48:42.725888	2020-07-14 08:48:42.725888	\N	\N
90	Christy Mayer	Dane_Nolan7@gmail.com	$2a$08$Nkf0CItjTgF1sU7j6w3Vf.EzKGWhvxEnWB7NYtdfQxCLKhR7NQVjS	f	Ad est expedita occaecati qui quae dolor tempore aspernatur.\nVoluptatem rerum culpa voluptatem cumque.\nEos rem illum.\nDignissimos vel sunt quidem aut perferendis maxime voluptatem.\nQui modi debitis cupiditate eum eos.	Micah.Stehr43	Micah.Stehr43	https://s3.amazonaws.com/uifaces/faces/twitter/mdsisto/128.jpg	2020-07-14 08:48:42.731591	2020-07-14 08:48:42.731591	\N	\N
93	Miss Danika Franecki	Janice.Stracke@gmail.com	$2a$08$Nkf0CItjTgF1sU7j6w3Vf.EzKGWhvxEnWB7NYtdfQxCLKhR7NQVjS	f	Consequatur voluptatem eligendi voluptatum non voluptas totam et pariatur expedita.\nAccusamus tempora earum in aut totam.\nVoluptas reprehenderit autem beatae provident facilis sint et dolorum iste.\nQuae neque est iusto.\nFacere saepe voluptates suscipit.	Duane39	Duane39	https://s3.amazonaws.com/uifaces/faces/twitter/jnmnrd/128.jpg	2020-07-14 08:48:42.735858	2020-07-14 08:48:42.735858	\N	\N
103	Isadore Kuvalis Jr.	Cornelius.Tromp@yahoo.com	$2a$08$Nkf0CItjTgF1sU7j6w3Vf.EzKGWhvxEnWB7NYtdfQxCLKhR7NQVjS	f	Aspernatur quia qui in cum architecto.\nMaxime quae sit sit corporis non.\nDolorem laborum ullam architecto.\nHarum quo illo voluptatem voluptatibus nihil recusandae reiciendis impedit.\nAperiam sit quidem ad autem pariatur aliquam sed quos culpa.	Sharon.Cormier	Sharon.Cormier	https://s3.amazonaws.com/uifaces/faces/twitter/dhoot_amit/128.jpg	2020-07-14 08:48:42.750897	2020-07-14 08:48:42.750897	\N	\N
82	Merl Conroy	Ryley_Metz@yahoo.com	$2a$08$Nkf0CItjTgF1sU7j6w3Vf.EzKGWhvxEnWB7NYtdfQxCLKhR7NQVjS	f	Atque ut non.\nVoluptatem et repellat et aspernatur praesentium dolor ut magni.\nAccusantium fugiat eum voluptatem ea numquam laudantium unde.\nNon necessitatibus corrupti non eum.\nEa qui minus eveniet totam ea sed omnis architecto ad.	Vincenzo50	Vincenzo50	https://s3.amazonaws.com/uifaces/faces/twitter/ciaranr/128.jpg	2020-07-14 08:48:42.726268	2020-07-14 08:48:42.726268	\N	\N
92	Milford Jast	Daija57@hotmail.com	$2a$08$Nkf0CItjTgF1sU7j6w3Vf.EzKGWhvxEnWB7NYtdfQxCLKhR7NQVjS	f	Minima aut maxime at aut distinctio ad.\nEt aut hic est illo at mollitia.\nQuod magni ipsum iste rerum itaque in ex.\nEst in ea quam qui velit sunt aut non dolores.\nNon numquam ut alias.	Mara_Glover0	Mara_Glover0	https://s3.amazonaws.com/uifaces/faces/twitter/rohixx/128.jpg	2020-07-14 08:48:42.735323	2020-07-14 08:48:42.735323	\N	\N
102	Pete Lockman	Benjamin44@hotmail.com	$2a$08$Nkf0CItjTgF1sU7j6w3Vf.EzKGWhvxEnWB7NYtdfQxCLKhR7NQVjS	f	Iusto dolor rerum incidunt officia provident perspiciatis aut itaque.\nNon at magni et quae suscipit voluptas aperiam.\nMolestias et eum ipsum dolorem magnam dolore enim fugit.\nQui et error.\nTotam doloribus sapiente voluptatem aut.	Pietro.Cummings	Pietro.Cummings	https://s3.amazonaws.com/uifaces/faces/twitter/switmer777/128.jpg	2020-07-14 08:48:42.750356	2020-07-14 08:48:42.750356	\N	\N
83	Jennyfer Parker	Chesley.Schultz@gmail.com	$2a$08$Nkf0CItjTgF1sU7j6w3Vf.EzKGWhvxEnWB7NYtdfQxCLKhR7NQVjS	f	Vel sapiente voluptates amet ut facilis.\nAspernatur deleniti modi velit natus vel ut qui et.\nCulpa consequatur nemo quia.\nIllo natus rem et delectus ad debitis nam.\nEst officia illum velit reprehenderit.	Mose_Heaney30	Mose_Heaney30	https://s3.amazonaws.com/uifaces/faces/twitter/arpitnj/128.jpg	2020-07-14 08:48:42.727193	2020-07-14 08:48:42.727193	\N	\N
94	Isaac Davis DDS	Jaylan26@hotmail.com	$2a$08$Nkf0CItjTgF1sU7j6w3Vf.EzKGWhvxEnWB7NYtdfQxCLKhR7NQVjS	f	Occaecati omnis aut ullam tempora quisquam laborum.\nAccusantium aliquid doloremque illo suscipit id.\nAsperiores est et ut error.\nDeserunt atque impedit rerum aliquid eos.\nUt voluptate et quo reprehenderit quisquam ea.	Terrill.Reichel22	Terrill.Reichel22	https://s3.amazonaws.com/uifaces/faces/twitter/operatino/128.jpg	2020-07-14 08:48:42.736341	2020-07-14 08:48:42.736341	\N	\N
104	Kara Heidenreich II	Margarett.Kub7@yahoo.com	$2a$08$Nkf0CItjTgF1sU7j6w3Vf.EzKGWhvxEnWB7NYtdfQxCLKhR7NQVjS	f	Dignissimos rerum optio vitae ut exercitationem et deserunt earum.\nVelit non nam minima quidem vel.\nDicta vel at saepe dolores reiciendis quae facere laboriosam totam.\nPerspiciatis nemo nam suscipit cumque dicta aut qui.\nEst distinctio corporis consectetur occaecati recusandae in asperiores alias et.	Joyce_Mann	Joyce_Mann	https://s3.amazonaws.com/uifaces/faces/twitter/travishines/128.jpg	2020-07-14 08:48:42.751318	2020-07-14 08:48:42.751318	\N	\N
84	Mrs. Mariana Fay	Diamond31@gmail.com	$2a$08$Nkf0CItjTgF1sU7j6w3Vf.EzKGWhvxEnWB7NYtdfQxCLKhR7NQVjS	f	Molestiae sit praesentium ut tempora.\nPraesentium cupiditate molestias minima.\nFacilis et labore saepe non assumenda.\nDolores non magnam quo laboriosam enim non pariatur ut nostrum.\nEveniet ut mollitia autem.	Karolann30	Karolann30	https://s3.amazonaws.com/uifaces/faces/twitter/levisan/128.jpg	2020-07-14 08:48:42.727618	2020-07-14 08:48:42.727618	\N	\N
95	Adah Smitham	Iliana94@yahoo.com	$2a$08$Nkf0CItjTgF1sU7j6w3Vf.EzKGWhvxEnWB7NYtdfQxCLKhR7NQVjS	f	Quasi omnis eos officia odit.\nPorro ut enim cumque molestiae est placeat sit.\nDolorem nisi molestiae et voluptatibus dolor aut.\nExpedita voluptate et modi omnis assumenda itaque fugiat.\nDolorem qui animi consequatur quae in voluptatibus fuga et quam.	Donna.Bahringer	Donna.Bahringer	https://s3.amazonaws.com/uifaces/faces/twitter/apriendeau/128.jpg	2020-07-14 08:48:42.736781	2020-07-14 08:48:42.736781	\N	\N
106	Amaya Ruecker	Henry.Ebert2@hotmail.com	$2a$08$Nkf0CItjTgF1sU7j6w3Vf.EzKGWhvxEnWB7NYtdfQxCLKhR7NQVjS	f	Et aut eveniet.\nVoluptatum delectus beatae corporis ad impedit sed.\nImpedit iure suscipit voluptatum quia eum possimus eum voluptas.\nQuos inventore molestiae maxime distinctio quo qui saepe.\nUt doloribus alias.	Vilma79	Vilma79	https://s3.amazonaws.com/uifaces/faces/twitter/mattbilotti/128.jpg	2020-07-14 08:48:42.752338	2020-07-14 08:48:42.752338	\N	\N
85	Adrian Herman	Helmer_Schneider@hotmail.com	$2a$08$Nkf0CItjTgF1sU7j6w3Vf.EzKGWhvxEnWB7NYtdfQxCLKhR7NQVjS	f	Magni earum soluta.\nFugiat beatae aut.\nFacere ut deserunt.\nConsequatur vitae labore.\nImpedit aliquid quia odit.	Eden10	Eden10	https://s3.amazonaws.com/uifaces/faces/twitter/jayrobinson/128.jpg	2020-07-14 08:48:42.728465	2020-07-14 08:48:42.728465	\N	\N
97	Hassie Bradtke	Micah.Osinski@gmail.com	$2a$08$Nkf0CItjTgF1sU7j6w3Vf.EzKGWhvxEnWB7NYtdfQxCLKhR7NQVjS	f	In enim temporibus voluptatem consectetur.\nSit voluptate corrupti laboriosam explicabo.\nIpsum repellat occaecati et.\nIllo facere reprehenderit deserunt vitae rerum praesentium sed sed.\nId non sapiente quis qui illum quia temporibus aperiam.	Hallie71	Hallie71	https://s3.amazonaws.com/uifaces/faces/twitter/elisabethkjaer/128.jpg	2020-07-14 08:48:42.737602	2020-07-14 08:48:42.737602	\N	\N
105	Dr. Maryse Torphy	William_Oberbrunner24@yahoo.com	$2a$08$Nkf0CItjTgF1sU7j6w3Vf.EzKGWhvxEnWB7NYtdfQxCLKhR7NQVjS	f	Vero saepe aliquid architecto omnis.\nUt earum laudantium.\nIpsum et fuga ad quidem.\nVoluptas laborum omnis temporibus quia in accusamus.\nMagnam inventore quas nisi facilis dolor sint nihil.	Toy87	Toy87	https://s3.amazonaws.com/uifaces/faces/twitter/craigrcoles/128.jpg	2020-07-14 08:48:42.751824	2020-07-14 08:48:42.751824	\N	\N
86	Milton Mueller	Ford28@yahoo.com	$2a$08$Nkf0CItjTgF1sU7j6w3Vf.EzKGWhvxEnWB7NYtdfQxCLKhR7NQVjS	f	Labore recusandae saepe voluptatem itaque sint magnam voluptatum aliquam.\nDucimus libero aliquid ipsa dolor ut est.\nVeritatis omnis laborum ipsam sed odit ratione.\nA et non est sint.\nMolestiae ab et consequatur qui sunt quae sed nihil.	Zackary.Treutel	Zackary.Treutel	https://s3.amazonaws.com/uifaces/faces/twitter/rez___a/128.jpg	2020-07-14 08:48:42.728912	2020-07-14 08:48:42.728912	\N	\N
98	Jermain Zieme	Kiarra_Beatty@gmail.com	$2a$08$Nkf0CItjTgF1sU7j6w3Vf.EzKGWhvxEnWB7NYtdfQxCLKhR7NQVjS	f	Nemo consequuntur aut dolores aliquid.\nVel et facilis ducimus animi iste.\nRatione dolores id culpa qui quam suscipit commodi praesentium vitae.\nFacere occaecati perspiciatis at.\nNobis saepe nam non ut fugiat asperiores.	Ernie.Bogan51	Ernie.Bogan51	https://s3.amazonaws.com/uifaces/faces/twitter/mwarkentin/128.jpg	2020-07-14 08:48:42.738054	2020-07-14 08:48:42.738054	\N	\N
107	Dorothea Frami	Hallie_Collins@hotmail.com	$2a$08$Nkf0CItjTgF1sU7j6w3Vf.EzKGWhvxEnWB7NYtdfQxCLKhR7NQVjS	f	Quas fugit error et dignissimos minus.\nQui nostrum officia aliquam.\nAliquam consequatur quisquam neque recusandae.\nFugit aut placeat impedit sint.\nPerferendis qui omnis voluptates ullam.	Zechariah65	Zechariah65	https://s3.amazonaws.com/uifaces/faces/twitter/jarjan/128.jpg	2020-07-14 08:48:42.752764	2020-07-14 08:48:42.752764	\N	\N
87	Aron Boyle	Viviane93@hotmail.com	$2a$08$Nkf0CItjTgF1sU7j6w3Vf.EzKGWhvxEnWB7NYtdfQxCLKhR7NQVjS	f	Qui quidem qui fugiat.\nDolores impedit consectetur tempore quia.\nIn aut natus accusantium ullam.\nExpedita mollitia rerum quod in.\nNon illum nemo.	Nedra23	Nedra23	https://s3.amazonaws.com/uifaces/faces/twitter/keyuri85/128.jpg	2020-07-14 08:48:42.729667	2020-07-14 08:48:42.729667	\N	\N
99	Stefanie Koelpin	Vidal_Gulgowski@hotmail.com	$2a$08$Nkf0CItjTgF1sU7j6w3Vf.EzKGWhvxEnWB7NYtdfQxCLKhR7NQVjS	f	Officia praesentium vel ab non voluptatibus cupiditate tempora.\nDolorem unde sequi.\nFacilis eos enim.\nUt ullam quaerat quo quisquam ducimus corrupti quibusdam et.\nId sit voluptas odit est est dolor dolorem optio.	Nora_Runolfsson	Nora_Runolfsson	https://s3.amazonaws.com/uifaces/faces/twitter/maz/128.jpg	2020-07-14 08:48:42.738461	2020-07-14 08:48:42.738461	\N	\N
108	Elliot Hansen	Wilma.Marquardt@yahoo.com	$2a$08$Nkf0CItjTgF1sU7j6w3Vf.EzKGWhvxEnWB7NYtdfQxCLKhR7NQVjS	f	Tempora aliquid consequuntur.\nIpsum earum consequatur facere placeat saepe autem corrupti.\nEx laborum fuga non at assumenda repellendus impedit.\nCorporis aut cum nihil quasi labore.\nDebitis facilis dolorem cupiditate assumenda vero similique ipsam nesciunt eligendi.	Caesar.Schaefer	Caesar.Schaefer	https://s3.amazonaws.com/uifaces/faces/twitter/HenryHoffman/128.jpg	2020-07-14 08:48:42.753208	2020-07-14 08:48:42.753208	\N	\N
88	Mrs. Zoie Ledner	Idell.Pouros2@gmail.com	$2a$08$Nkf0CItjTgF1sU7j6w3Vf.EzKGWhvxEnWB7NYtdfQxCLKhR7NQVjS	f	Voluptate nesciunt reprehenderit et aut.\nSapiente tempore quidem est cumque.\nMinima omnis atque eum.\nInventore quia aut sequi doloribus debitis quia ex.\nOdio suscipit vel ut quis neque.	Oran6	Oran6	https://s3.amazonaws.com/uifaces/faces/twitter/a_brixen/128.jpg	2020-07-14 08:48:42.729976	2020-07-14 08:48:42.729976	\N	\N
100	Travon Mertz	Melany5@yahoo.com	$2a$08$Nkf0CItjTgF1sU7j6w3Vf.EzKGWhvxEnWB7NYtdfQxCLKhR7NQVjS	f	Sunt magnam ut itaque voluptas tempore ea et accusantium.\nDeserunt maiores exercitationem maiores quis sequi totam suscipit perspiciatis ut.\nTenetur ut ipsa veniam molestiae a aut ratione aspernatur nobis.\nAut commodi et eos molestias voluptas doloribus ad.\nVoluptatem quasi debitis incidunt vitae magnam dolorem.	Lowell_Tillman	Lowell_Tillman	https://s3.amazonaws.com/uifaces/faces/twitter/kimcool/128.jpg	2020-07-14 08:48:42.738851	2020-07-14 08:48:42.738851	\N	\N
109	Lloyd Boehm PhD	Brennon77@yahoo.com	$2a$08$Nkf0CItjTgF1sU7j6w3Vf.EzKGWhvxEnWB7NYtdfQxCLKhR7NQVjS	f	Rerum dolores magnam architecto nemo et ut.\nQuae tempore nemo velit nisi unde.\nAut eligendi magnam qui ut.\nVel esse sequi itaque vel est.\nSunt corporis sunt.	Dandre37	Dandre37	https://s3.amazonaws.com/uifaces/faces/twitter/dreizle/128.jpg	2020-07-14 08:48:42.753691	2020-07-14 08:48:42.753691	\N	\N
89	Jerad Murazik	Tate90@gmail.com	$2a$08$Nkf0CItjTgF1sU7j6w3Vf.EzKGWhvxEnWB7NYtdfQxCLKhR7NQVjS	f	Praesentium labore inventore optio omnis ea placeat maiores.\nOccaecati non consequatur consectetur consequatur natus nihil illum aspernatur et.\nSunt omnis doloremque ut officiis eaque dicta mollitia.\nDucimus quia inventore fuga in debitis ipsa corporis.\nNemo eligendi sit ut.	Hope_Medhurst41	Hope_Medhurst41	https://s3.amazonaws.com/uifaces/faces/twitter/emsgulam/128.jpg	2020-07-14 08:48:42.730695	2020-07-14 08:48:42.730695	\N	\N
96	Dr. Rudy Deckow	Blaze81@gmail.com	$2a$08$Nkf0CItjTgF1sU7j6w3Vf.EzKGWhvxEnWB7NYtdfQxCLKhR7NQVjS	f	Rerum aliquid eaque autem odit natus odit.\nTemporibus voluptatem itaque ea fugiat assumenda.\nNon laborum magni error porro id quaerat.\nVoluptas ipsa iusto libero aut provident porro iure.\nIncidunt magnam voluptate omnis enim corporis distinctio et esse maxime.	Addison64	Addison64	https://s3.amazonaws.com/uifaces/faces/twitter/michaelcomiskey/128.jpg	2020-07-14 08:48:42.737174	2020-07-14 08:48:42.737174	\N	\N
110	Patrick Mitchell	Gayle.Parisian18@hotmail.com	$2a$08$Nkf0CItjTgF1sU7j6w3Vf.EzKGWhvxEnWB7NYtdfQxCLKhR7NQVjS	f	Amet ducimus sint necessitatibus reprehenderit fuga laborum quia veniam corporis.\nUt ducimus doloremque aut sed rerum aut et.\nModi et dicta necessitatibus rerum non autem omnis.\nVoluptatem adipisci aliquam fugiat ducimus.\nNostrum ut occaecati.	Hosea59	Hosea59	https://s3.amazonaws.com/uifaces/faces/twitter/andytlaw/128.jpg	2020-07-14 08:48:42.754095	2020-07-14 08:48:42.754095	\N	\N
91	Connor Becker	Tony36@gmail.com	$2a$08$Nkf0CItjTgF1sU7j6w3Vf.EzKGWhvxEnWB7NYtdfQxCLKhR7NQVjS	f	Consequuntur facilis velit quaerat.\nQui deserunt rerum autem hic quod vel quo voluptatibus quia.\nNobis perferendis assumenda qui distinctio eum.\nNihil iste totam perferendis commodi laboriosam hic reiciendis at.\nRerum veniam laborum dicta.	Brett.Schaden	Brett.Schaden	https://s3.amazonaws.com/uifaces/faces/twitter/_dwite_/128.jpg	2020-07-14 08:48:42.730958	2020-07-14 08:48:42.730958	\N	\N
101	Halie Runte	Constance_Heathcote86@yahoo.com	$2a$08$Nkf0CItjTgF1sU7j6w3Vf.EzKGWhvxEnWB7NYtdfQxCLKhR7NQVjS	f	Facere est neque doloremque magnam et est qui ipsam.\nVoluptatem est autem ratione.\nExcepturi dolor temporibus minima nobis sed.\nTempora natus rerum est et et.\nId atque nam laboriosam quod provident labore.	Mattie_Bailey	Mattie_Bailey	https://s3.amazonaws.com/uifaces/faces/twitter/kalmerrautam/128.jpg	2020-07-14 08:48:42.739274	2020-07-14 08:48:42.739274	\N	\N
68	Mae Schowalter	Dena_Braun@yahoo.com	$2a$08$/r7INwHbY4xBlBf2LBet5OkG9mnm.cSMAr8rek/y9kiBarpZd4pAC	f	Sed soluta sed optio quia eveniet.\nDoloribus qui aut laudantium maxime maxime et maiores deserunt et.\nEnim error nihil ipsum quae non.\nSit fugit eos temporibus libero eos distinctio.\nUt dolor enim ut amet possimus nostrum et iure eveniet.	Araceli12	Araceli12	https://s3.amazonaws.com/uifaces/faces/twitter/ganserene/128.jpg	2020-07-14 08:45:40.750765	2020-07-14 08:45:40.750765	\N	\N
\.


--
-- Data for Name: world_cuisine; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.world_cuisine (id, name) FROM stdin;
1	Brazilian
9	Middle Eastern Recipes
10	African Recipes
11	European Recipes
12	Latin American Recipes
13	Eastern European Recipes
14	Australian and New Zealander Recipes
15	Asian Recipes
16	Mediterranean Diet Recipes
17	Canadian Recipes
18	U.S. Recipes
19	other
\.


--
-- Name: categories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.categories_id_seq', 7, true);


--
-- Name: diet_restriction_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.diet_restriction_id_seq', 14, true);


--
-- Name: difficulties_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.difficulties_id_seq', 7, true);


--
-- Name: files_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.files_id_seq', 171, true);


--
-- Name: invoice_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.invoice_id_seq', 1, true);


--
-- Name: meal_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.meal_type_id_seq', 5, true);


--
-- Name: orders_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.orders_id_seq', 3, true);


--
-- Name: product_image_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.product_image_id_seq', 21, true);


--
-- Name: products_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.products_id_seq', 14, true);


--
-- Name: recipes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.recipes_id_seq', 100, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.users_id_seq', 110, true);


--
-- Name: world_cuisine_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.world_cuisine_id_seq', 19, true);


--
-- Name: categories categories_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (id);


--
-- Name: diet_restriction diet_restriction_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.diet_restriction
    ADD CONSTRAINT diet_restriction_pkey PRIMARY KEY (id);


--
-- Name: difficulties difficulties_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.difficulties
    ADD CONSTRAINT difficulties_pkey PRIMARY KEY (id);


--
-- Name: files files_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.files
    ADD CONSTRAINT files_pkey PRIMARY KEY (id);


--
-- Name: invoice invoice_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.invoice
    ADD CONSTRAINT invoice_pkey PRIMARY KEY (id);


--
-- Name: meal_type meal_type_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.meal_type
    ADD CONSTRAINT meal_type_pkey PRIMARY KEY (id);


--
-- Name: orders orders_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (id);


--
-- Name: product_image product_image_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product_image
    ADD CONSTRAINT product_image_pkey PRIMARY KEY (id);


--
-- Name: products products_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_pkey PRIMARY KEY (id);


--
-- Name: recipes recipes_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.recipes
    ADD CONSTRAINT recipes_pkey PRIMARY KEY (id);


--
-- Name: session session_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.session
    ADD CONSTRAINT session_pkey PRIMARY KEY (sid);


--
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: world_cuisine world_cuisine_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.world_cuisine
    ADD CONSTRAINT world_cuisine_pkey PRIMARY KEY (id);


--
-- Name: IDX_session_expire; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_session_expire" ON public.session USING btree (expire);


--
-- Name: files files_recipe_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.files
    ADD CONSTRAINT files_recipe_id_fkey FOREIGN KEY (recipe_id) REFERENCES public.recipes(id) ON DELETE CASCADE;


--
-- Name: orders orders_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.products(id);


--
-- Name: orders orders_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: product_image product_image_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product_image
    ADD CONSTRAINT product_image_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.products(id) ON DELETE CASCADE;


--
-- Name: products products_category_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_category_id_fkey FOREIGN KEY (category_id) REFERENCES public.categories(id);


--
-- Name: recipes recipes_diet_restriction_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.recipes
    ADD CONSTRAINT recipes_diet_restriction_id_fkey FOREIGN KEY (diet_restriction_id) REFERENCES public.diet_restriction(id);


--
-- Name: recipes recipes_difficulty_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.recipes
    ADD CONSTRAINT recipes_difficulty_id_fkey FOREIGN KEY (difficulty_id) REFERENCES public.difficulties(id);


--
-- Name: recipes recipes_meal_type_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.recipes
    ADD CONSTRAINT recipes_meal_type_id_fkey FOREIGN KEY (meal_type_id) REFERENCES public.meal_type(id);


--
-- Name: recipes recipes_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.recipes
    ADD CONSTRAINT recipes_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: recipes recipes_world_cuisine_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.recipes
    ADD CONSTRAINT recipes_world_cuisine_id_fkey FOREIGN KEY (world_cuisine_id) REFERENCES public.world_cuisine(id);


--
-- PostgreSQL database dump complete
--

