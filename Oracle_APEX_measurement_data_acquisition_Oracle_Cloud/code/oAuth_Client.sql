-- ============================================
-- Sensor Client API Test
-- Very simple demo to show the basics usage REST Oracle APEX
-- See Slides 
-- Dienstag, 24. November 2020
-- Meetup Oracle APEX  Kassel  
-- https://www.meetup.com/de-DE/Oracle-APEX-Kassel/events/274381875/
--
-- =============================================

BEGIN 

  OAuth.delete_client(p_name => 'SENSOR_HARDWARE');
 
  -- create the client
  OAuth.create_client
    ( p_name            => 'SENSOR_HARDWARE',
      p_description     => 'Sensor API Hardware Client',
      p_grant_type      => 'client_credentials',
      p_privilege_names => 'SENSOR_PRIV',  
      p_support_email   => 'gunther@pipperr.de');
  

  -- Grant the new client access to the SENSOR Rolle
  OAuth.grant_client_role
     (  p_client_name => 'SENSOR_HARDWARE',
        p_role_name   => 'SENSOR'
	 );
  
  COMMIT;

END;
/


SELECT id, name, client_id, client_secret FROM   user_ords_clients;