with customers as (

    select
        id as customer_id,
        first_name,
        last_name

    --from raw.jaffle_shop.customers
    from `dbt-tutorial.jaffle_shop.customers`

)
select * from customers
