with orders as (

    select
        order_id,
        customer_id
    from {{ ref('stg_orders')}}

),

sucess_payments as (

    select
        orderid,
        amount
    from {{ ref('stg_payments')}}

    where status = 'success'

),

final as (

    select

        orders.order_id
        , customer_id
        , amount
        
    from orders

        left join sucess_payments
            on orders.order_id = sucess_payments.orderid

)

select * from final