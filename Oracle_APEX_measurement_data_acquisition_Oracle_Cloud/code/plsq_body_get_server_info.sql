
-- ============================================
-- Sensor Client API Test
-- Very simple demo to show the basics usage REST Oracle APEX
-- See Slides 
-- Dienstag, 24. November 2020
-- Meetup Oracle APEX  Kassel  
-- https://www.meetup.com/de-DE/Oracle-APEX-Kassel/events/274381875/
--
-- =============================================

declare
v_script_name varchar2(256):='sensor/serverinfo';

begin

-- see https://oracle-base.com/articles/misc/oracle-rest-data-services-ords-http-headers-and-ords-specific-bind-variables
OWA_UTIL.mime_header('text/plain');

HTP.p('Individual Calls:');
HTP.p('=======================================================');
HTP.p('SERVER_SOFTWARE='      || OWA_UTIL.get_cgi_env('SERVER_SOFTWARE'));
HTP.p('SERVER_NAME='          || OWA_UTIL.get_cgi_env('SERVER_NAME'));
HTP.p('GATEWAY_INTERFACE='    || OWA_UTIL.get_cgi_env('GATEWAY_INTERFACE'));
HTP.p('SERVER_PROTOCOL='      || OWA_UTIL.get_cgi_env('SERVER_PROTOCOL'));
HTP.p('SERVER_PORT='          || OWA_UTIL.get_cgi_env('SERVER_PORT'));
HTP.p('REQUEST_METHOD='       || OWA_UTIL.get_cgi_env('REQUEST_METHOD'));
HTP.p('PATH_INFO='            || OWA_UTIL.get_cgi_env('PATH_INFO'));
HTP.p('PATH_TRANSLATED='      || OWA_UTIL.get_cgi_env('PATH_TRANSLATED'));
HTP.p('SCRIPT_NAME='          || OWA_UTIL.get_cgi_env('SCRIPT_NAME'));
HTP.p('QUERY_STRING='         || OWA_UTIL.get_cgi_env('QUERY_STRING'));
HTP.p('REMOTE_HOST='          || OWA_UTIL.get_cgi_env('REMOTE_HOST'));
HTP.p('REMOTE_ADDR='          || OWA_UTIL.get_cgi_env('REMOTE_ADDR'));
HTP.p('AUTH_TYPE='            || OWA_UTIL.get_cgi_env('AUTH_TYPE'));
HTP.p('REMOTE_USER='          || OWA_UTIL.get_cgi_env('REMOTE_USER'));
HTP.p('REMOTE_IDENT='         || OWA_UTIL.get_cgi_env('REMOTE_IDENT'));
HTP.p('CONTENT_TYPE='         || OWA_UTIL.get_cgi_env('CONTENT_TYPE'));
HTP.p('CONTENT_LENGTH='       || OWA_UTIL.get_cgi_env('CONTENT_LENGTH'));
HTP.p('HTTP_ACCEPT='          || OWA_UTIL.get_cgi_env('HTTP_ACCEPT'));
HTP.p('HTTP_ACCEPT_LANGUAGE=' || OWA_UTIL.get_cgi_env('HTTP_ACCEPT_LANGUAGE'));
HTP.p('HTTP_USER_AGENT='      || OWA_UTIL.get_cgi_env('HTTP_USER_AGENT'));
HTP.p('HTTP_COOKIE='          || OWA_UTIL.get_cgi_env('HTTP_COOKIE'));
HTP.p(' ');

/*
:content_type : The Media Type of the request body. For example "application/json".
:body : The request payload presented as BLOB. Note this value MUST only be dereferenced once, if it needs to be dereferenced more than once in a handler, assign it's value to a local variable and dereference the local variable instead. This is because the stream backing the BLOB can only be read once.
:body_text : The request payload presented as CLOB. Introduced in 18.3, this is the text equivalent of ":body".
:current_user : The identity of authenticated user. Blank if no authentication is presented.
:page_size : The maximum number of rows to include in the page. Note this value will be +1 of the actual desired page size. If the page size is configured to be 25, this value will be 26. ORDS always requests one extra row so it can detect if there is a subsequent page or not (If 25 or less rows are returned then we are on the last page).
:page_offset : The page number, indexed from zero.
:row_offset : The offset of the first row in this page, indexed from one.
:row_count : The offset of the last row in this page, indexed from one (in other words :row_count = :row_offset + :page_size)
*/
HTP.p('content_type=' || :content_type);
HTP.p('body='         || UTL_RAW.cast_to_varchar2(:body));
HTP.p('current_user=' || :current_user);
HTP.p('page_size='    || :page_size);
HTP.p('page_offset='  || :page_offset);
HTP.p('row_offset='   || :row_offset);
HTP.p('row_count='    || :row_count);
HTP.p('List from PRINT_CGI_ENV including <br /> terminator:');
HTP.p('=======================================================');

OWA_UTIL.print_cgi_env;

 :status_code:=200; --Sucess 

end;
