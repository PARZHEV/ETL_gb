from airflow import DAG
from datetime import datetime, timedelta
from airflow.operators.postgres_operator import PostgresOperator

default_args = {
    'owner': 'airflow',
    'depends_on_past': False,
    'start_date': datetime(2022, 3, 1),
    'email_on_failure': False,
    'email_on_retry': False,
    'retries': 1,
    'retry_delay': timedelta(minutes=5),
}

with DAG('drop_if_exists',
            max_active_runs=3,
            schedule_interval='@daily',
            default_args=default_args) as dag:

    create_tables_step = PostgresOperator(
        task_id='my_task',
        postgres_conn_id='target_db',
        sql='from_stage_to_core copy.sql'
    )
