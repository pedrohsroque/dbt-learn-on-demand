--select * from `dbt-tutorial.jaffle_shop.customers`;
--select * from `dbt-tutorial.jaffle_shop.orders`;
--select * from `dbt-tutorial.stripe.payment`;

{{ config (
    materialized="table"
)}}

with customers as (

    select * from {{ ref('stg_customers')}}

),

orders as (

    select * from {{ ref('stg_orders')}}

),

fact_orders_grouped_by_customer as (
    select 
    customer_id,
    sum(amount) as total_amount from {{ ref('fct_orders')}}
    group by customer_id
),

customer_orders as (

    select
        customer_id,

        min(order_date) as first_order_date,
        max(order_date) as most_recent_order_date,
        count(order_id) as number_of_orders

    from orders

    group by 1

),


final as (

    select
        customers.customer_id,
        customers.first_name,
        customers.last_name,
        customer_orders.first_order_date,
        customer_orders.most_recent_order_date,
        coalesce(customer_orders.number_of_orders, 0) as number_of_orders,
        coalesce(fact_orders_grouped_by_customer.total_amount, 0) as lifetime_value

    from customers

    left join customer_orders using (customer_id)
    left join fact_orders_grouped_by_customer using (customer_id)

)

select * from final
