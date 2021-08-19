with payments as (
    select 
    id
    ,orderid
    ,paymentmethod
    ,status
    ,amount / 100 as amount
    ,created
    ,_batched_at
    from `dbt-tutorial.stripe.payment`
)
select * from payments