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

  v_message varchar2(256):='OK';
  v_message_code integer:=200;
  
  v_payload    blob;
  v_json_data  clob;
  v_body_json  json_object_t;

  v_measurement_arr   json_array_t;
  v_measurement_obj  json_object_t;

  v_value  number;
  v_unit   varchar2(64);

  v_epoch_to_date timestamp(6):=systimestamp;

  v_time_stamp varchar2(64);
  v_time_stamp_type varchar2(64);
  
  v_sensor_id varchar2(64);

  -- debug
  v_script_name varchar2(256):='/sensor/:SENSORID/measurement';
  
begin

   -- check the URL
   v_sensor_id :=  CAST(:SENSORID AS NUMBER DEFAULT -1 ON CONVERSION ERROR);

    if v_sensor_id=-1 then
      
       :status_code := 400; -- Bad Request
     
       apex_json.open_object;
       apex_json.write( p_name  => 'Error Message '
                     , p_value => 'Sensor '||v_sensor_id||' invaild format - have to be a number' 
                     , p_write_null  => true);  
       apex_json.close_object;     
       apex_json.close_all;

   else
     
        
        -- read the data

        v_payload   :=:body;
        v_json_data := wwv_flow_utilities.blob_to_clob(v_payload);
        v_body_json := json_object_t.parse( v_json_data );     

    
        v_time_stamp:=v_body_json.get_String('timestamp');
        v_time_stamp_type:=v_body_json.get_String('timestamp_format');


         v_measurement_arr := v_body_json.get_array('measurements');
 
         <<mess_loop>>
         for i in 0 .. v_measurement_arr.get_size - 1 
         loop
             IF v_measurement_arr.get(i).is_object 
               THEN
                   v_measurement_obj := TREAT(v_measurement_arr.get(i) AS JSON_OBJECT_T);

                   v_unit  :=v_measurement_obj.get_String('unit');
                   v_value :=v_measurement_obj.get_String('value');


                   insert into MEASURED_VALUES  ( 
                         SENSOR_ID 
                       , MDATE
                       , UNIT
                       , VALUE
                   )
                   values (
                              v_sensor_id
                            , v_epoch_to_date
                            , v_unit
                            , v_value
                    );

                    commit; 

            end if;

         end loop mess_loop;


        -- return the data as Json 
    
        apex_json.open_object;        

        apex_json.write( p_name  => 'timestamp '
                        , p_value => v_time_stamp 
                        , p_write_null  => true);  
                        
        apex_json.write( p_name  => 'timestamp_format'
                        , p_value => v_time_stamp_type
                        , p_write_null  => true);  

        apex_json.write( p_name  => 'unit'
                        , p_value => v_unit
                        , p_write_null  => true);  
                        
        apex_json.write( p_name  => 'value'
                        , p_value => v_value
                        , p_write_null  => true);                  
    
        apex_json.write( p_name  => 'success'
                        , p_value => 'true' 
                        , p_write_null  => true);                    
        
        apex_json.close_object;
        
        apex_json.close_all;
    
    end if;
exception 
 when others then
  
       apex_json.open_object;
       apex_json.write( p_name  => 'Error Message : '
                     , p_value =>  'Error in Call to '|| v_script_name || ' SQL Error : ' ||SQLERRM 
                     , p_write_null  => true);  
       apex_json.write( p_name  => 'Get this data : '
                     , p_value =>  v_json_data
                     , p_write_null  => true);  
      
       apex_json.close_object;     
       apex_json.close_all;

       :status_code := 400;
end;
