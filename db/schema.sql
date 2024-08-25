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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: clients; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.clients (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    place character varying(255),
    description character varying(255),
    telephone character varying(255)
);


--
-- Name: clients_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.clients ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.clients_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: delivery_orders; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.delivery_orders (
    id integer NOT NULL,
    invoice_id integer NOT NULL,
    sender_id integer,
    order_code character varying(255),
    note character varying(255),
    place character varying(255),
    photo_path character varying(255),
    status integer NOT NULL,
    created_at timestamp with time zone
);


--
-- Name: delivery_orders_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.delivery_orders ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.delivery_orders_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: delivery_products; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.delivery_products (
    id integer NOT NULL,
    delivery_id integer NOT NULL,
    sales_id integer NOT NULL,
    quantity integer NOT NULL,
    created_at timestamp with time zone
);


--
-- Name: delivery_products_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.delivery_products ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.delivery_products_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: delivery_statuses; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.delivery_statuses (
    id integer NOT NULL,
    name character varying(255) NOT NULL
);


--
-- Name: delivery_statuses_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.delivery_statuses ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.delivery_statuses_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: invoice_statuses; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.invoice_statuses (
    id integer NOT NULL,
    name character varying(255) NOT NULL
);


--
-- Name: invoice_statuses_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.invoice_statuses ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.invoice_statuses_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: invoices; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.invoices (
    id integer NOT NULL,
    invoice_status_id integer DEFAULT 1 NOT NULL,
    client_id integer NOT NULL,
    invoice_code character varying(255) NOT NULL,
    description character varying(255),
    payment_method character varying(255),
    po_code character varying(255),
    seller character varying(255),
    platform_number character varying(255),
    platform character varying(255),
    platform_description character varying(255),
    tax integer,
    discount integer,
    payment_term integer,
    note character varying(255),
    facture_path character varying(255),
    is_taxable boolean DEFAULT false,
    po_path character varying(255),
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    project_name character varying(255),
    total_price integer,
    date timestamp with time zone
);


--
-- Name: invoices_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.invoices ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.invoices_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: products; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.products (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    stock integer DEFAULT 0,
    updated_at timestamp with time zone,
    created_at timestamp with time zone,
    deleted_at timestamp with time zone
);


--
-- Name: products_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.products ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.products_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: purchases; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.purchases (
    id integer NOT NULL,
    product_id integer NOT NULL,
    image_path character varying(255),
    count integer DEFAULT 0,
    price integer DEFAULT 0,
    created_at timestamp with time zone,
    is_paid boolean DEFAULT false
);


--
-- Name: purchases_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.purchases ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.purchases_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: receipt_invoices; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.receipt_invoices (
    id integer NOT NULL,
    receipt_id integer NOT NULL,
    invoice_id integer NOT NULL
);


--
-- Name: receipt_invoices_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.receipt_invoices ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.receipt_invoices_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: receipts; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.receipts (
    id integer NOT NULL,
    number integer NOT NULL,
    photo character varying(255),
    created_at timestamp with time zone,
    client_id integer NOT NULL,
    status integer NOT NULL
);


--
-- Name: receipts_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.receipts ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.receipts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: sales; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.sales (
    id integer NOT NULL,
    invoice_id integer NOT NULL,
    product_id integer NOT NULL,
    quantity integer NOT NULL,
    price integer NOT NULL,
    not_sent_count integer DEFAULT 0,
    send_status boolean DEFAULT false,
    created_at timestamp with time zone
);


--
-- Name: sales_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.sales ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.sales_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.schema_migrations (
    version character varying(128) NOT NULL
);


--
-- Name: users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.users (
    id integer NOT NULL,
    name character varying(255),
    email character varying(255) NOT NULL,
    password character varying(255),
    is_verified boolean DEFAULT false,
    otp_code character varying(5),
    created_at timestamp with time zone,
    updated_at timestamp with time zone
);


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.users ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: clients clients_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.clients
    ADD CONSTRAINT clients_pkey PRIMARY KEY (id);


--
-- Name: delivery_orders delivery_orders_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.delivery_orders
    ADD CONSTRAINT delivery_orders_pkey PRIMARY KEY (id);


--
-- Name: delivery_products delivery_products_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.delivery_products
    ADD CONSTRAINT delivery_products_pkey PRIMARY KEY (id);


--
-- Name: delivery_statuses delivery_statuses_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.delivery_statuses
    ADD CONSTRAINT delivery_statuses_pkey PRIMARY KEY (id);


--
-- Name: invoice_statuses invoice_statuses_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.invoice_statuses
    ADD CONSTRAINT invoice_statuses_pkey PRIMARY KEY (id);


--
-- Name: invoices invoices_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.invoices
    ADD CONSTRAINT invoices_pkey PRIMARY KEY (id);


--
-- Name: products products_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_pkey PRIMARY KEY (id);


--
-- Name: purchases purchases_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.purchases
    ADD CONSTRAINT purchases_pkey PRIMARY KEY (id);


--
-- Name: receipt_invoices receipt_invoices_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.receipt_invoices
    ADD CONSTRAINT receipt_invoices_pkey PRIMARY KEY (id);


--
-- Name: receipts receipts_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.receipts
    ADD CONSTRAINT receipts_pkey PRIMARY KEY (id);


--
-- Name: sales sales_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sales
    ADD CONSTRAINT sales_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: invoices unique_facture_path; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.invoices
    ADD CONSTRAINT unique_facture_path UNIQUE (facture_path);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: delivery_orders delivery_orders_invoice_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.delivery_orders
    ADD CONSTRAINT delivery_orders_invoice_id_fkey FOREIGN KEY (invoice_id) REFERENCES public.invoices(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: delivery_orders delivery_orders_sender_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.delivery_orders
    ADD CONSTRAINT delivery_orders_sender_id_fkey FOREIGN KEY (sender_id) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: delivery_products delivery_products_delivery_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.delivery_products
    ADD CONSTRAINT delivery_products_delivery_id_fkey FOREIGN KEY (delivery_id) REFERENCES public.delivery_orders(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: delivery_products delivery_products_sales_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.delivery_products
    ADD CONSTRAINT delivery_products_sales_id_fkey FOREIGN KEY (sales_id) REFERENCES public.sales(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: invoices invoices_client_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.invoices
    ADD CONSTRAINT invoices_client_id_fkey FOREIGN KEY (client_id) REFERENCES public.clients(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: invoices invoices_invoice_status_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.invoices
    ADD CONSTRAINT invoices_invoice_status_id_fkey FOREIGN KEY (invoice_status_id) REFERENCES public.invoice_statuses(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: purchases purchases_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.purchases
    ADD CONSTRAINT purchases_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.products(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: receipt_invoices receipt_invoices_invoice_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.receipt_invoices
    ADD CONSTRAINT receipt_invoices_invoice_id_fkey FOREIGN KEY (invoice_id) REFERENCES public.invoices(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: receipt_invoices receipt_invoices_receipt_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.receipt_invoices
    ADD CONSTRAINT receipt_invoices_receipt_id_fkey FOREIGN KEY (receipt_id) REFERENCES public.receipts(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: receipts receipts_client_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.receipts
    ADD CONSTRAINT receipts_client_id_fkey FOREIGN KEY (client_id) REFERENCES public.clients(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: sales sales_invoice_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sales
    ADD CONSTRAINT sales_invoice_id_fkey FOREIGN KEY (invoice_id) REFERENCES public.invoices(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: sales sales_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sales
    ADD CONSTRAINT sales_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.products(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--


--
-- Dbmate schema migrations
--

INSERT INTO public.schema_migrations (version) VALUES
    ('20240720151325'),
    ('20240722053345'),
    ('20240722102339'),
    ('20240722173157'),
    ('20240722173536'),
    ('20240722174245'),
    ('20240722175256'),
    ('20240804100526'),
    ('20240804113120'),
    ('20240804113424'),
    ('20240817022844'),
    ('20240817023654');
