from datetime import datetime, timedelta
from airflow import DAG
from airflow.operators.postgres_operator import PostgresOperator
from airflow.operators.python_operator import PythonOperator
from airflow.hooks.postgres_hook import PostgresHook


def dump_data(**kwargs):
    for table in ['customer', 'lineitem', 'nation', 'orders', 'part', 'partsupp', 'region', 'supplier']:
        phook = PostgresHook(postgres_conn_id="postgres_target1")

        conn = phook.get_conn()
        with conn.cursor() as cur:
            
                with open(f"{table}.csv", "w") as f:
                    cur.copy_expert(f"COPY {table} TO STDOUT WITH DELIMITER ',' CSV HEADER;", f) 

def input_data(**kwargs):
    for table in ['customer', 'lineitem', 'nation', 'orders', 'part', 'partsupp', 'region', 'supplier']:
        phook = PostgresHook(postgres_conn_id="postgres_target")
        
        conn = phook.get_conn()
        with conn.cursor() as cur:
        
                with open(f"{table}.csv", "r") as f:
                    cur.copy_expert(f"COPY {table} from STDIN WITH DELIMITER ',' CSV HEADER;", f)

DEFAULT_ARGS = {
    "owner": "airflow",
    "start_date": datetime(2022, 1, 1),
    "retries": 1,
    "email_on_failure": False,
    "email_on_retry": False,
    "depends_on_past": False,
}

with DAG(
    dag_id="Dump_insert",
    default_args=DEFAULT_ARGS,
    schedule_interval="@daily",
    tags=['data-flow'],
    catchup=False
) as dag:



    dump_data = PythonOperator(
        task_id = 'dump_my_data',
        python_callable = dump_data
    )

    input_data = PythonOperator(
        task_id = 'input_my_data',
        python_callable = input_data
    )

dump_data >> input_data