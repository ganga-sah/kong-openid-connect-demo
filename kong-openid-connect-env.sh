HOST_SUFFIX=85480ddc
KONG_ADMIN_API_URI=https://8001-0-${HOST_SUFFIX}.labs.konghq.com
KONG_SERVICE_URI=https://8000-0-${HOST_SUFFIX}.labs.konghq.com

# Keycloak
REDIRECT_URI=https://8000-0-${HOST_SUFFIX}.labs.konghq.com
USERNAME=employee
PASSWORD=test

# Kong Keyclock
#ROUTE=keycloak-kong
#CONFIG_ISSUER=https://8080-1-${HOST_SUFFIX}.labs.konghq.com/auth/realms/kong/.well-known/openid-configuration
#CLIENT_ID=kong
#CLIENT_SECRET=681d81ee-9ff0-438a-8eca-e9a4f892a96b

# Local Keyclock
ROUTE=keycloak-local
CLIENT_ID=kong
# Keycloak 16.1.1
#CONFIG_ISSUER=https://73f8-2601-646-8100-5160-2509-4d3f-ba57-d4c9.ngrok.io/auth/realms/master/.well-known/openid-configuration
#CLIENT_SECRET=HjMJ1bRfq26ya1gSlf3C8IqU0GkN0mHO
# Keycloak 19.0.1
CONFIG_ISSUER=https://73f8-2601-646-8100-5160-2509-4d3f-ba57-d4c9.ngrok.io/realms/master/.well-known/openid-configuration
CLIENT_SECRET=ZmmdpFd72yqM3e0hfFJDbM2kBpRWcQOk

# Auth0
#ROUTE=oidc-auth0
#CLIENT_ID=9GvEIGKASiYvYvkz0mdrnZbHBxFe8IeR
#CLIENT_SECRET=2uofAnntwE38EPwTiUJBTUqh0zPMYRNOeLn9vFfg9r7M_ZL7MIy6VY3ZZ_yf5VB2
#CONFIG_ISSUER=https://dev-yr-0zftc.us.auth0.com/.well-known/openid-configuration
#USERNAME=admin@example.com
#PASSWORD=Gs0821@Auth0
