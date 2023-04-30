select
    s.supplier as supplier,
    c.category as category,
    sum(a.qty * a.price)
from actions a
    join products p on p.id = a.product_id
    join categories c on c.id = p.category_id
    join suppliers s on s.id = a.supplier_id
where extract(year from a.action_date) = 2016
group by supplier, category
order by supplier, category;
