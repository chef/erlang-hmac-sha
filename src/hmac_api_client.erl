-module(hmac_api_client).

-export([
         signed_req/5,
         signed_req/6
        ]).

-include("hmac_api.hrl").

signed_req(PublicKey, PrivateKey, Path, Headers, Method, Body) ->
    %% TODO: We should add Content-md5 if it's not there
    Authorization = hmac_api_lib:sign(PrivateKey, PublicKey, Method, Path, Headers),
    ibrowse:send_req(Path, [Authorization|Headers], Method, Body).

signed_req(PublicKey, PrivateKey, Path, Headers, Method) ->
    Authorization = hmac_api_lib:sign(PrivateKey, PublicKey, Method, Path, Headers),
    ibrowse:send_req(Path, [Authorization|Headers], Method).

