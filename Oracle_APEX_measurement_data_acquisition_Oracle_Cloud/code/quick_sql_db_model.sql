# ondelete: "restrict"
# verbose : true
# drop    : true

Actions
  name vc64 /nn
  parameterSet /nn
  Parameter   /nn
  Value      /nn
  
Sensors
   name vc64 /nn
   location vc100
   type     vc64
   remark   vc1000
   SensorAktions
      action_id /fk Actions
      unit  vc(16)  /nn 
      lower threshold num
      upper threshold num       
	Measured_values
        mdate timestamp /nn  
        unit vc(16)     /nn  
        value num       /nn  

    

view v_sensor_actions  Sensors SensorAktions Actions