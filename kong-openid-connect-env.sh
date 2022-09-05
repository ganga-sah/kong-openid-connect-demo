HOST_SUFFIX=5acc68e9
KONG_ADMIN_API_URI=https://8001-0-${HOST_SUFFIX}.labs.konghq.com
KONG_SERVICE_URI=https://8000-0-${HOST_SUFFIX}.labs.konghq.com
REST_URL=http://73.15.195.77:8081
#REST_URL=http://httpbin.org/anything
#REST_URL=https://qa.safeguardcyber.app/safeguard
REST_API=/resource-server/api/foos/
# Keycloak
REDIRECT_URI=https://8000-0-${HOST_SUFFIX}.labs.konghq.com

# Kong Keyclock
#ROUTE=keycloak-kong
#CONFIG_ISSUER=https://8080-1-${HOST_SUFFIX}.labs.konghq.com/auth/realms/kong/.well-known/openid-configuration
#CLIENT_ID=kong
#CLIENT_SECRET=681d81ee-9ff0-438a-8eca-e9a4f892a96b
#USERNAME=employee

# Local Keyclock
#ROUTE=keycloak-httpbin
ROUTE=keycloak-resource-server
USERNAME=mike@other.com
PASSWORD=pass
# Keycloak 16.1.1
#CONFIG_ISSUER=https://73f8-2601-646-8100-5160-2509-4d3f-ba57-d4c9.ngrok.io/auth/realms/master/.well-known/openid-configuration
#CLIENT_SECRET=HjMJ1bRfq26ya1gSlf3C8IqU0GkN0mHO
# Keycloak 19.0.1
CONFIG_ISSUER=https://bd2f-2601-646-8100-5160-7d52-d250-f546-8071.ngrok.io/auth/realms/baeldung/.well-known/openid-configuration
CLIENT_ID=newClient
CLIENT_SECRET=newClientSecret
#CLIENT_SECRET=ZmmdpFd72yqM3e0hfFJDbM2kBpRWcQOk
#CLIENT_SECRET=O56JP1GoMpHRDJAPTZ5OOLUBtOIhHp4j

# Auth0
#ROUTE=oidc-auth0
#CLIENT_ID=9GvEIGKASiYvYvkz0mdrnZbHBxFe8IeR
#CLIENT_SECRET=2uofAnntwE38EPwTiUJBTUqh0zPMYRNOeLn9vFfg9r7M_ZL7MIy6VY3ZZ_yf5VB2
#CONFIG_ISSUER=https://dev-yr-0zftc.us.auth0.com/.well-known/openid-configuration
#USERNAME=admin@example.com
#PASSWORD=Gs0821@Auth0
