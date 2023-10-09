use cob_cartera
go

IF OBJECT_ID ('tgu_ca_seguro_externo','TR') IS NOT NULL
   drop trigger tgu_ca_seguro_externo
go

create trigger tgu_ca_seguro_externo
on  ca_seguro_externo
after update, insert, delete
as
begin

   DECLARE @w_operacion varchar(7) 
   
   select @w_operacion = case when exists (select * from inserted) and exists(select * from deleted) 
                             THEN 'U'
                         when exists(select * from inserted) 
                             THEN 'I'
                         when exists(select * from deleted)
                             THEN 'D'
                         else 
                             NULL --Unknown
                         end
	
   if @w_operacion = 'I' or @w_operacion = 'U' begin 
   
      insert into cob_cartera_his..ca_seguro_externo_his
      (seh_operacion,     seh_fecha,             seh_usuario,
       seh_terminal,      seh_banco,             seh_cliente,          
      seh_fecha_ini,     seh_fecha_ult_intento,  seh_monto,            
      seh_estado,        seh_fecha_reporte,      seh_tramite,          
      seh_grupo,         seh_monto_pagado,       seh_monto_devuelto,   
      seh_forma_pago,    seh_tipo_seguro,        seh_monto_basico)   
       select 
	  @w_operacion,      getdate(),              se_usuario,
      se_terminal,       se_banco,               se_cliente,          
      se_fecha_ini,      se_fecha_ult_intento,   se_monto,            
      se_estado,         se_fecha_reporte,       se_tramite,          
      se_grupo,          se_monto_pagado,        se_monto_devuelto,   
      se_forma_pago,     se_tipo_seguro,         se_monto_basico
      from inserted 
	  
   end else if @w_operacion = 'D' begin
   
      insert into cob_cartera_his..ca_seguro_externo_his
      (seh_operacion,    seh_fecha,              seh_usuario,
       seh_terminal,     seh_banco,              seh_cliente,          
      seh_fecha_ini,     seh_fecha_ult_intento,  seh_monto,            
      seh_estado,        seh_fecha_reporte,      seh_tramite,          
      seh_grupo,         seh_monto_pagado,       seh_monto_devuelto,   
      seh_forma_pago,    seh_tipo_seguro,        seh_monto_basico)   
       select 
	  @w_operacion,      getdate(),              se_usuario,
      se_terminal,       se_banco,               se_cliente,          
      se_fecha_ini,      se_fecha_ult_intento,   se_monto,            
      se_estado,         se_fecha_reporte,       se_tramite,          
      se_grupo,          se_monto_pagado,        se_monto_devuelto,   
      se_forma_pago,     se_tipo_seguro,         se_monto_basico
      from deleted 
   
   end
end

go