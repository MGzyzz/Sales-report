with grouped_actions as (
  select
    to_char(action_date, 'YYYY') as year,
    to_char(action_date, 'MM/YYYY') as month,
    to_char(action_date, 'DD/MM/YYYY') as day,
    SUM(qty * price) as total
  from
    actions
  group by
    grouping sets (
      (year, month, day)
    )
  union all
  select
    to_char(action_date, 'YYYY') as year,
    '' as month,
    '' as day,
    SUM(qty * price) as total
  from
      actions a
  group by grouping sets (
      (year))
  union all
  select
    to_char(action_date, 'YYYY') as year,
    to_char(action_date, 'MM/YYYY') as month,
    '' as day,
    SUM(qty * price) as total
  from actions a
  group by year,month
  order by
    year,
    month,
    day

)
select
  case
    when year = LAG(year) over (order by year, month, day) then ''
    else year
  end as year,
  case
    when month = LAG(month) over (order by year, month, day) then ''
    else month
  end as month,
   case
       when day = lag(day) over (order by year,month, day) then ''
       else day
   end as day,
  total
FROM
  grouped_actions;
