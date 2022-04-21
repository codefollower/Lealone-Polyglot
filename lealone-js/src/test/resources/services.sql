
create service if not exists hello_service (
  hello(name varchar) varchar
)
language 'js' implement by './src/test/resources/js/hello_service.js'
;

--execute service hello_service hello('test');
