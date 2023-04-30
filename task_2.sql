(select
    s.supplier as supplier,
    extract(year from a.action_date) as year,
    c.category as category,
    sum(a.price * a.qty)
from suppliers s
    join actions a on s.id = a.supplier_id
    join products p on p.id = a.product_id
    join categories c on c.id = p.category_id
group by s.supplier, year, c.category)

union all

(select
    s.supplier as supplier,
    extract(year from a.action_date) as year,
    null as category,
    sum(a.price * a.qty)
from suppliers s
    join actions a on s.id = a.supplier_id
    join products p on p.id = a.product_id
    join categories c on c.id = p.category_id
group by s.supplier, year)

union all

(select
    s.supplier as supplier,
    null as year,
    null as category,
    sum(a.price * a.qty)
from suppliers s
    join actions a on s.id = a.supplier_id
    join products p on p.id = a.product_id
    join categories c on c.id = p.category_id
group by s.supplier)
order by supplier, year, category;
