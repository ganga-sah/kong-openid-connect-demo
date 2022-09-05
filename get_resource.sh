TOKEN=$(./authorization_code_login.sh -a http://bd2f-2601-646-8100-5160-7d52-d250-f546-8071.ngrok.io/auth -r baeldung -c newClient -l http://localhost:8089/ -u mike@other.com)
# http get http://localhost:8081/resource-server/api/foos/1 Authorization:"Bearer $TOKEN"
http get https://8000-0-5acc68e9.labs.konghq.com/keycloak-resource-server/resource-server/api/foos/1 Authorization:"Bearer $TOKEN"
