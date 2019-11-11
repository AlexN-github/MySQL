use newdb;

select p.name as product_name, c.name as catalog_name  
from  newdb.catalogs as c
        join 
      products as p on c.id = p.catalog_id