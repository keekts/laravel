Ci HMVC rest APIs

use 
CodeIgniter Rest Server
https://github.com/chriskacerguis/codeigniter-restserver

CodeIgniter Rest Server With JWT Authentication
https://github.com/dodistyo/ci-rest-jwt

# Exampl for CodeIgniter Backend REST API 

url  run project
http://localhost/ci-hmvc-rest-api-jwt/api/v1/

or

http://localhost/ci-hmvc-rest-api-jwt/index.php/api/v1/


edit routes controllers to
/Application/modules/api/controllers/v1/welcome.php

# HMVC

# Feature
- JWT
- User Auth
- Example model

email: mark@gmail.com
pwd: 12345678

#Example header 
http://localhost/ci-hmvc-rest-api-jwt/index.php/api/v1/profile (get method http)
{
	"Authorization": "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjEiLCJlbWFpbCI6Im1hcmtAZ21haWwuY29tIiwiZnVsbG5hbWUiOiJNYXJrIn0.4mTzrVuTJzyXKUij1gu_yhOlyoppJPOb-gAEfVJGtlw"
}


https://stackoverflow.com/questions/19218247/codeigniter-image-resize

not https://github.com/dalers/mywind

``` base 
git rm -r --cached src/.history/

```

https://davejansen.com/how-to-dump-and-restore-a-mariadb-mysql-database-from-a-docker-container/
Dump using mysqldump
docker exec db_container_name mysqldump [--user yourusername] [--password=yourpassword] databasename > /desired/path/to/db.dump

docker exec -i db_container_name mysql [--user yourusername] [--password=yourpassword] databasename < /path/to/db.dump