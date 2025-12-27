            List of tables
 Schema |   Name    | Type  |  Owner   
--------+-----------+-------+----------
 public | bills     | table | postgres
 public | customers | table | postgres
 public | invoices  | table | postgres
(3 rows)

                                         Table "public.customers"
    Column    |            Type             | Collation | Nullable |                Default                
--------------+-----------------------------+-----------+----------+---------------------------------------
 id           | integer                     |           | not null | nextval('customers_id_seq'::regclass)
 first_name   | character varying(250)      |           | not null | 
 last_name    | character varying(250)      |           | not null | 
 email        | character varying(250)      |           | not null | 
 due_date_day | integer                     |           | not null | 30
 reliability  | numeric(3,2)                |           |          | 0.5
 time_created | timestamp without time zone |           |          | CURRENT_TIMESTAMP
Indexes:
    "customers_pkey" PRIMARY KEY, btree (id)
Referenced by:
    TABLE "bills" CONSTRAINT "bills_customer_id_fkey" FOREIGN KEY (customer_id) REFERENCES customers(id)
    TABLE "invoices" CONSTRAINT "invoices_customer_id_fkey" FOREIGN KEY (customer_id) REFERENCES customers(id)

                                        Table "public.invoices"
     Column     |          Type          | Collation | Nullable |               Default                
----------------+------------------------+-----------+----------+--------------------------------------
 id             | integer                |           | not null | nextval('invoices_id_seq'::regclass)
 customer_id    | integer                |           |          | 
 amount         | numeric(10,2)          |           | not null | 
 invoice_number | character varying(250) |           | not null | 
 date_issued    | date                   |           | not null | 
 due_date       | date                   |           | not null | 
 paid_date      | date                   |           |          | 
 status         | character varying(50)  |           |          | 'outstanding'::character varying
 notes          | text                   |           |          | 
Indexes:
    "invoices_pkey" PRIMARY KEY, btree (id)
    "invoices_invoice_number_key" UNIQUE CONSTRAINT, btree (invoice_number)
Foreign-key constraints:
    "invoices_customer_id_fkey" FOREIGN KEY (customer_id) REFERENCES customers(id)

                                      Table "public.bills"
   Column    |          Type          | Collation | Nullable |              Default              
-------------+------------------------+-----------+----------+-----------------------------------
 id          | integer                |           | not null | nextval('bills_id_seq'::regclass)
 customer_id | integer                |           |          | 
 bill_number | character varying(250) |           | not null | 
 amount      | numeric(10,2)          |           | not null | 
 due_date    | date                   |           | not null | 
 paid_date   | date                   |           |          | 
 priority    | character varying(250) |           |          | 'normal'::character varying
Indexes:
    "bills_pkey" PRIMARY KEY, btree (id)
Foreign-key constraints:
    "bills_customer_id_fkey" FOREIGN KEY (customer_id) REFERENCES customers(id)

