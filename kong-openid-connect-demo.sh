. ./kong-openid-connect-env.sh
set -x o

echo Add a Service
http put ${KONG_ADMIN_API_URI}/services/${ROUTE}-service url=$REST_URL | jq

echo Add a Route to expose the Service
http -f put ${KONG_ADMIN_API_URI}/services/${ROUTE}-service/routes/${ROUTE}-route paths=/${ROUTE} | jq

echo Verifying the service
http get ${KONG_SERVICE_URI}/${ROUTE}${REST_API} | jq

echo Add OpenID Connect Plugin
http -f post ${KONG_ADMIN_API_URI}/routes/${ROUTE}-route/plugins \
name=openid-connect \
config.issuer=$CONFIG_ISSUER \
config.client_id=$CLIENT_ID \
config.client_secret=$CLIENT_SECRET \
config.redirect_uri=$REDIRECT_URI/${ROUTE} \
config.response_mode=form_post \
config.ssl_verify=false \
config.run_on_preflight=false | jq

echo Provide a client_id and secret to retrieve a token
http get ${KONG_SERVICE_URI}/${ROUTE}${REST_API} -a ${CLIENT_ID}:${CLIENT_SECRET} | jq

#echo Verify Kong is protecting the Service - http: 302
#http get ${KONG_SERVICE_URI}/${ROUTE}${REST_API} | jq
#
#echo Verify Kong is protecting the Service by providing invalid user credentials - http: 401
http get ${KONG_SERVICE_URI}/${ROUTE}${REST_API} -a user:password | jq
#
#echo Optional: View Kong Discovery Information from IDP
#http get ${KONG_ADMIN_API_URI}/openid-connect/issuers | jq

echo Provide a username/password to Kong and retrieve a token
http get ${KONG_SERVICE_URI}/${ROUTE}${REST_API} -a ${USERNAME}:${PASSWORD} | jq

exit

echo Obtain the URL to access the OIDC service via Kong and click on the link
echo To obtain the URL, run the command and open the URL in browser
echo  $KONG_SERVICE_URI/${ROUTE}

echo Validate Session is setup to allow access to other pages without having to re-authenticate
echo  $KONG_SERVICE_URI/${ROUTE}/verify-session

echo Authenticate with bearer token
export BEARER_TOKEN=$(http ${KONG_SERVICE_URI}/${ROUTE} -a ${USERNAME}:${PASSWORD} | jq -r '.headers .Authorization')
http get ${KONG_SERVICE_URI}/${ROUTE}${REST_API} Authorization:"$BEARER_TOKEN" | jq

echo Add upstream headers
PLUGIN_ID=$(http ${KONG_ADMIN_API_URI}/routes/${ROUTE}-route/plugins/ | jq -r '.data[] | select(.name == "openid-connect") | .id')
http -f patch ${KONG_ADMIN_API_URI}/plugins/$PLUGIN_ID  \
  config.upstream_headers_claims=preferred_username \
  config.upstream_headers_names=Service-Username | jq

echo Verify headers are added
http ${KONG_SERVICE_URI}/${ROUTE} -a ${USERNAME}:${PASSWORD} | jq

echo Configure a consumer
http put ${KONG_ADMIN_API_URI}/consumers/employee | jq

echo Modify OIDC plugin to require a consumer with the preferred_username claim
PLUGIN_ID=$(http ${KONG_ADMIN_API_URI}/routes/${ROUTE}-route/plugins/ | jq -r '.data[] | select(.name == "openid-connect") | .id')
http -f patch ${KONG_ADMIN_API_URI}/plugins/$PLUGIN_ID config.consumer_claim=preferred_username | jq

echo Verify authorization works for a user mapped to a Kong consumer
http get ${KONG_SERVICE_URI}/${ROUTE}${REST_API} -a ${USERNAME}:${PASSWORD} | jq

echo Verify authorization is forbidden for a user not mapped to a consumer - http: 403
http get ${KONG_SERVICE_URI}/${ROUTE}${REST_API} -a partner:test | jq

echo Add Rate Limiting
http -f ${KONG_ADMIN_API_URI}/consumers/employee/plugins name=rate-limiting config.minute=5 config.policy=local
echo Access the route with user employee:
http get ${KONG_SERVICE_URI}/${ROUTE}${REST_API} -a ${USERNAME}:${PASSWORD} | jq

echo Exceed Rate Limit
http get ${KONG_SERVICE_URI}/${ROUTE}${REST_API} username=${USERNAME} password=${PASSWORD}
http get ${KONG_SERVICE_URI}/${ROUTE}${REST_API} username=${USERNAME} password=${PASSWORD}
http get ${KONG_SERVICE_URI}/${ROUTE}${REST_API} username=${USERNAME} password=${PASSWORD}
http get ${KONG_SERVICE_URI}/${ROUTE}${REST_API} username=${USERNAME} password=${PASSWORD}
http get ${KONG_SERVICE_URI}/${ROUTE}${REST_API} username=${USERNAME} password=${PASSWORD}
http get ${KONG_SERVICE_URI}/${ROUTE}${REST_API} username=${USERNAME} password=${PASSWORD}


