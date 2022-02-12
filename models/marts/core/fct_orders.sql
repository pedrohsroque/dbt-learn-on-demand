-- How to reference other models
-- select * from {{ ref('stg_customers')}}

with orders as (
    select order_id, customer_id from {{ ref('stg_orders')}}
),

sucess_payments as (
    select orderid, amount from {{ ref('stg_payments')}}
    where status = 'success'
)

select 
    order_id
    , customer_id
    , amount
    
from orders O
left join sucess_payments P on O.order_id = P.orderid