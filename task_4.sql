select
    c.category,
    extract(year from a.action_date) as year,
    avg(a.price) as average_price,
    min(a.price) as min_price,
    max(a.price) as max_price
from actions a
    join products p on p.id = a.product_id
    join categories c on c.id = p.category_id
group by c.category, year
order by c.category, year;
