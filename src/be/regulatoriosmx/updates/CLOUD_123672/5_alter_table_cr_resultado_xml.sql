use cob_credito
go

if not exists (SELECT 1  FROM sys.columns WHERE Name = N'rx_folio_ref' AND Object_ID = Object_ID(N'cob_credito..cr_resultado_xml'))
begin
   ALTER TABLE cob_credito..cr_resultado_xml add rx_folio_ref varchar(50) 
end
go

use cob_credito_his
go
if not exists (SELECT 1  FROM sys.columns WHERE Name = N'rxh_folio_ref'  AND Object_ID = Object_ID(N'cob_credito_his..cr_resultado_xml_his'))
begin
   ALTER TABLE cob_credito_his..cr_resultado_xml_his  add rxh_folio_ref varchar(50) 
end
go

/*******************************************************************************************/
use cob_credito
go
if not exists (SELECT 1 FROM sys.columns WHERE Name = N'rx_deuda_pagar' AND Object_ID = Object_ID(N'cob_credito..cr_resultado_xml'))
begin
   ALTER TABLE cob_credito..cr_resultado_xml add rx_deuda_pagar money 
end
go   

use cob_credito_his
go
if not exists (SELECT 1  FROM sys.columns WHERE Name = N'rxh_deuda_pagar'  AND Object_ID = Object_ID(N'cob_credito_his..cr_resultado_xml_his'))
begin
   ALTER TABLE cob_credito_his..cr_resultado_xml_his  add rxh_deuda_pagar money 
end
go
/*******************************************************************************************/
use cob_credito
go
if not exists (SELECT 1  FROM sys.columns WHERE Name = N'rx_total_saldo'  AND Object_ID = Object_ID(N'cob_credito..cr_resultado_xml'))
begin
   ALTER TABLE cob_credito..cr_resultado_xml add rx_total_saldo money 
end
go

use cob_credito_his
go

if not exists (SELECT 1  FROM sys.columns WHERE Name = N'rxh_total_saldo'  AND Object_ID = Object_ID(N'cob_credito_his..cr_resultado_xml_his'))
begin
   ALTER TABLE cob_credito_his..cr_resultado_xml_his  add rxh_total_saldo money 
end
go

/*******************************************************************************************/
use cob_credito
go
if not exists (SELECT 1  FROM sys.columns WHERE Name = N'rx_fecha_fin_mes'  AND Object_ID = Object_ID(N'cob_credito..cr_resultado_xml'))
begin
   ALTER TABLE cob_credito..cr_resultado_xml add rx_fecha_fin_mes datetime 
end
go

use cob_credito_his
go

if not exists (SELECT 1  FROM sys.columns WHERE Name = N'rxh_fecha_fin_mes'  AND Object_ID = Object_ID(N'cob_credito_his..cr_resultado_xml_his'))
begin
   ALTER TABLE cob_credito_his..cr_resultado_xml_his  add rxh_fecha_fin_mes datetime 
end
go

/*******************************************************************************************/
use cob_credito
go
if not exists (SELECT 1  FROM sys.columns WHERE Name = N'rx_pago_mes'  AND Object_ID = Object_ID(N'cob_credito..cr_resultado_xml'))
begin
   ALTER TABLE cob_credito..cr_resultado_xml add rx_pago_mes money 
end
go

use cob_credito_his
go

if not exists (SELECT 1  FROM sys.columns WHERE Name = N'rxh_pago_mes'  AND Object_ID = Object_ID(N'cob_credito_his..cr_resultado_xml_his'))
begin
   ALTER TABLE cob_credito_his..cr_resultado_xml_his add rxh_pago_mes money
end
go

/*******************************************************************************************/
use cob_credito
go
if not exists (SELECT 1  FROM sys.columns WHERE Name = N'rx_pago_mes_ant'  AND Object_ID = Object_ID(N'cob_credito..cr_resultado_xml'))
begin
   ALTER TABLE cob_credito..cr_resultado_xml add rx_pago_mes_ant money 
end
go

use cob_credito_his
go

if not exists (SELECT 1  FROM sys.columns WHERE Name = N'rxh_pago_mes_ant'  AND Object_ID = Object_ID(N'cob_credito_his..cr_resultado_xml_his'))
begin
   ALTER TABLE cob_credito_his..cr_resultado_xml_his add rxh_pago_mes_ant money
end
go

/*******************************************************************************************/
use cob_credito
go
if not exists (SELECT 1  FROM sys.columns WHERE Name = N'rx_pag_compl_ant'  AND Object_ID = Object_ID(N'cob_credito..cr_resultado_xml'))
begin
   ALTER TABLE cob_credito..cr_resultado_xml  add rx_pag_compl_ant money 
end

use cob_credito_his
go

if not exists (SELECT 1  FROM sys.columns WHERE Name = N'rxh_pag_compl_ant'  AND Object_ID = Object_ID(N'cob_credito_his..cr_resultado_xml_his'))
begin
   ALTER TABLE cob_credito_his..cr_resultado_xml_his add rxh_pag_compl_ant money
end
go

/*******************************************************************************************/
use cob_credito
go
if not exists (SELECT 1  FROM sys.columns WHERE Name = N'rx_com_acum'  AND Object_ID = Object_ID(N'cob_credito..cr_resultado_xml'))
begin
print 'A'
   ALTER TABLE cob_credito..cr_resultado_xml add rx_com_acum money 
end

use cob_credito_his
go
if not exists (SELECT 1  FROM sys.columns WHERE Name = N'rxh_com_acum'  AND Object_ID = Object_ID(N'cob_credito_his..cr_resultado_xml_his'))
begin
print 'A'
   ALTER TABLE cob_credito_his..cr_resultado_xml_his add rxh_com_acum money
end
go

/*******************************************************************************************/
use cob_credito
go
if not exists (SELECT 1  FROM sys.columns WHERE Name = N'rx_sec_id'  AND Object_ID = Object_ID(N'cob_credito..cr_resultado_xml'))
begin
print 'A'
   ALTER TABLE cob_credito..cr_resultado_xml add rx_sec_id int 
end
go

use cob_credito_his
go
if not exists (SELECT 1  FROM sys.columns WHERE Name = N'rxh_sec_id'  AND Object_ID = Object_ID(N'cob_credito_his..cr_resultado_xml_his'))
begin
print 'A'
   ALTER TABLE cob_credito_his..cr_resultado_xml_his add rxh_sec_id int
end
go

/*******************************************************************************************/
use cob_credito
go
if not exists (SELECT 1  FROM sys.columns WHERE Name = N'rx_genera_cmpl'  AND Object_ID = Object_ID(N'cob_credito..cr_resultado_xml'))
begin
print 'A'
   ALTER TABLE cob_credito..cr_resultado_xml add rx_genera_cmpl char(1) 
end
go

use cob_credito_his
go
if not exists (SELECT 1  FROM sys.columns WHERE Name = N'rxh_genera_cmpl'  AND Object_ID = Object_ID(N'cob_credito_his..cr_resultado_xml_his'))
begin
print 'A'
   ALTER TABLE cob_credito_his..cr_resultado_xml_his  add rxh_genera_cmpl char(1)
end
go

/*******************************************************************************************/
use cob_credito
go
if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where column_name = 'rx_cuota_desde' and table_name  = 'cr_resultado_xml') begin
      alter table cr_resultado_xml add rx_cuota_desde int
      print 'Se crea el campo "rx_cuota_desde"'
end else begin
      print 'El campo "rx_cuota_desde" ya existe'
end
go

use cob_credito_his
go
if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where column_name = 'rxh_cuota_desde' and table_name  = 'cr_resultado_xml_his') begin
    alter table cr_resultado_xml_his add rxh_cuota_desde int
      print 'Se crea el campo "rxh_cuota_desde"'
end else begin
      print 'El campo "rxh_cuota_desde" ya existe'
end
go

/*******************************************************************************************/
use cob_credito
go
if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where column_name = 'rx_cuota_hasta' and table_name  = 'cr_resultado_xml') begin
	  alter table cr_resultado_xml add rx_cuota_hasta int
	  print 'Se crea el campo "rx_cuota_hasta"'
end else begin
      print  'El campo "rx_cuota_hasta" ya existe'
end
go

use cob_credito_his
go
if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where column_name = 'rxh_cuota_hasta' and table_name  = 'cr_resultado_xml_his') begin
	  alter table cr_resultado_xml_his add rxh_cuota_hasta int
	  print 'Se crea el campo "rxh_cuota_hasta"'
end else begin
      print 'El campo "rxh_cuota_hasta" ya existe'
end
go

/*******************************************************************************************/
use cob_credito
go
if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where column_name = 'rx_int_rep' and table_name  = 'cr_resultado_xml') begin
	  alter table cr_resultado_xml add rx_int_rep money
	  print 'Se crea el campo "rx_int_rep"'
end else begin
      print 'El campo "rx_int_rep" ya existe'
end
go

use cob_credito_his
go
if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where column_name = 'rxh_int_rep' and table_name  = 'cr_resultado_xml_his') begin
	  alter table cr_resultado_xml_his add rxh_int_rep money
	  print 'Se crea el campo "rxh_int_rep"'
end else begin
      print 'El campo "rxh_int_rep" ya existe'
end
go

/*******************************************************************************************/
use cob_credito
go
if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where column_name = 'rx_com_rep' and table_name  = 'cr_resultado_xml') begin
	  alter table cr_resultado_xml add rx_com_rep money
	  print 'Se crea el campo "rx_com_rep"'
end else begin
      print 'El campo "rx_com_rep" ya existe'
end
go

use cob_credito_his
go
if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where column_name = 'rxh_com_rep' and table_name  = 'cr_resultado_xml_his') begin
	  alter table cr_resultado_xml_his add rxh_com_rep money
	  print 'Se crea el campo "rxh_com_rep"'
end else begin
      print 'El campo "rxh_com_rep" ya existe'
end
go
   
/*******************************************************************************************/
use cob_credito
go

if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where column_name = 'rx_int_ant' and table_name  = 'cr_resultado_xml') begin
	  alter table cr_resultado_xml add rx_int_ant money
	  print 'Se crea el campo "rx_int_ant"'
end else begin
      print 'El campo "rx_int_ant" ya existe'
end
go

use cob_credito_his
go
if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where column_name = 'rxh_int_ant' and table_name  = 'cr_resultado_xml_his') begin
	  alter table cr_resultado_xml_his add rxh_int_ant money
	  print 'Se crea el campo "rxh_int_ant"'
end else begin
      print  'El campo "rxh_int_ant" ya existe'
end
go
   
/*******************************************************************************************/
use cob_credito
go
if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where column_name = 'rx_iva' and table_name  = 'cr_resultado_xml') begin
	  alter table cr_resultado_xml add rx_iva money
	  print 'Se crea el campo "rx_iva"'
end else begin
      print 'El campo "rx_iva" ya existe'
end
go

use cob_credito_his
go
if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where column_name = 'rxh_iva' and table_name  = 'cr_resultado_xml_his') begin
	  alter table cr_resultado_xml_his add rxh_iva money
	  print 'Se crea el campo "rxh_iva"'
end else begin
      print 'El campo "rxh_iva" ya existe'
end
go
   
/*******************************************************************************************/
use cob_credito
go

if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where column_name = 'rx_met_fact' and table_name  = 'cr_resultado_xml') begin
	  alter table cr_resultado_xml add rx_met_fact varchar(3)
	  print 'Se crea el campo "rx_met_fact"'
end else begin
      print 'El campo "rx_met_fact" ya existe'
end
go

use cob_credito_his
go
if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where column_name = 'rxh_met_fact' and table_name  = 'cr_resultado_xml_his') begin
	  alter table cr_resultado_xml_his add rxh_met_fact varchar(3)
	  print 'Se crea el campo "rxh_met_fact"'
end else begin
      print 'El campo "rxh_met_fact" ya existe'
end
go
   
/*******************************************************************************************/
use cob_credito
go   
if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where column_name = 'rx_form_pag' and table_name  = 'cr_resultado_xml') begin
	  alter table cr_resultado_xml add rx_form_pag varchar(2)
	  print 'Se crea el campo "rx_form_pag"'
end else begin
      print  'El campo "rx_form_pag" ya existe'
end   
go

use cob_credito_his
go
if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where column_name = 'rxh_form_pag' and table_name  = 'cr_resultado_xml_his') begin
	  alter table cr_resultado_xml_his add rxh_form_pag varchar(2)
	  print 'Se crea el campo "rxh_form_pag"'
   end else begin
      print 'El campo "rxh_form_pag" ya existe'
end
go

/*******************************************************************************************/
use cob_credito
go   

if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where column_name = 'rx_fecha_ult_compl' and table_name  = 'cr_resultado_xml') begin
	  alter table cr_resultado_xml add rx_fecha_ult_compl date
	  print 'Se crea el campo "rx_fecha_ult_compl"'
end else begin
      print 'El campo "rx_fecha_ult_compl" ya existe'
end
go

use cob_credito_his
go
if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where column_name = 'rxh_fecha_ult_compl' and table_name  = 'cr_resultado_xml_his') begin
	  alter table cr_resultado_xml_his add rxh_fecha_ult_compl date
	  print 'Se crea el campo "rxh_fecha_ult_compl"'
end else begin
      print 'El campo "rxh_fecha_ult_compl" ya existe'
end
go

/*******************************************************************************************/
use cob_credito
go   

if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where column_name = 'rx_pago_compl' and table_name  = 'cr_resultado_xml') begin
	  alter table cr_resultado_xml add rx_pago_compl money
	  print 'Se crea el campo "rx_pago_compl"'
end else begin
      print  'El campo "rx_pago_compl" ya existe'
end
go

use cob_credito_his
go
if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where column_name = 'rxh_pago_compl' and table_name  = 'cr_resultado_xml_his') begin
	  alter table cr_resultado_xml_his add rxh_pago_compl money
	  print 'Se crea el campo "rxh_pago_compl"'
end else begin
      print 'El campo "rxh_pago_compl" ya existe'
end
go

/*******************************************************************************************/
use cob_credito
go

if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where column_name = 'rx_fecha_env_email' and table_name  = 'cr_resultado_xml') begin
	  alter table cr_resultado_xml add rx_fecha_env_email date
	  print 'Se crea el campo "rx_fecha_env_email"'
end else begin
      print 'El campo "rx_fecha_env_email" ya existe'
end
go

use cob_credito_his
go
if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where column_name = 'rxh_fecha_env_email' and table_name  = 'cr_resultado_xml_his') begin
	  alter table cr_resultado_xml_his add rxh_fecha_env_email date
	  print 'Se crea el campo "rxh_fecha_env_email"'
   end else begin
      print 'El campo "rxh_fecha_env_email" ya existe'
end
go
  
/*******************************************************************************************/
use cob_credito
go

if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where column_name = 'rx_tipo_operacion' and table_name  = 'cr_resultado_xml') begin
	  alter table cr_resultado_xml add rx_tipo_operacion varchar(10)
	  print 'Se crea el campo "rx_tipo_operacion"'
   end else begin
      print 'El campo "rx_tipo_operacion" ya existe'
end
go

use cob_credito_his
go
if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where column_name = 'rxh_tipo_operacion' and table_name  ='cr_resultado_xml_his') begin
	  alter table cr_resultado_xml_his add rxh_tipo_operacion varchar(10)
	  print 'Se crea el campo "rxh_tipo_operacion"'
   end else begin
      print 'El campo "rxh_tipo_operacion" ya existe'
end
go 
  
/*******************************************************************************************/
use cob_credito
go   
   if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where column_name = 'rx_total_saldo_ant' and table_name  = 'cr_resultado_xml') begin
	  alter table cr_resultado_xml add rx_total_saldo_ant money
	  print 'Se crea el campo "rx_total_saldo_ant"'
   end else begin
      print 'El campo "rx_total_saldo_ant" ya existe'
end
go

use cob_credito_his
go
if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where column_name = 'rxh_total_saldo_ant' and table_name  = 'cr_resultado_xml_his') begin
	  alter table cr_resultado_xml_his add rxh_total_saldo_ant money
	  print 'Se crea el campo "rxh_total_saldo_ant"'
   end else begin
      print 'El campo "rxh_total_saldo_ant" ya existe'
end
go
   
/*******************************************************************************************/
use cob_credito
go  
if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where column_name = 'rx_pago_compl_fin' and table_name  = 'cr_resultado_xml') begin
	alter table cob_credito..cr_resultado_xml add rx_pago_compl_fin money
	print 'Se crea el campo "rx_pago_compl_fin"'
end else begin
     print 'El campo "rx_pago_compl_fin" ya existe'
end
go

use cob_credito_his
go
if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where column_name = 'rxh_pago_compl_fin' and table_name  = 'cr_resultado_xml_his') begin
	  alter table cr_resultado_xml_his add rxh_pago_compl_fin money
	  print 'Se crea el campo "rxh_pago_compl_fin"'
   end else begin
      print 'El campo "rxh_pago_compl_fin" ya existe'
end
go

/*******************************************************************************************/
use cob_credito
go  
if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where column_name = 'rx_total_saldo_act' and table_name  = 'cr_resultado_xml') begin
	alter table cob_credito..cr_resultado_xml add rx_total_saldo_act money
	print 'Se crea el campo "rx_total_saldo_act"'
  end else begin
     print 'El campo "rx_total_saldo_act" ya existe'
end
go

use cob_credito_his
go
if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where column_name = 'rxh_total_saldo_act' and table_name  = 'cr_resultado_xml_his') begin
	alter table cr_resultado_xml_his add rxh_total_saldo_act money
	print 'Se crea el campo "rxh_total_saldo_act"'
  end else begin
     print 'El campo "rxh_total_saldo_act" ya existe'
end
go

/*******************************************************************************************/
use cob_credito
go  
if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where column_name = 'rx_pago_compl_efect' and table_name  =  'cr_resultado_xml') begin
	alter table cob_credito..cr_resultado_xml add rx_pago_compl_efect money
	print 'Se crea el campo "rx_pago_compl_efect"'
  end else begin
     print 'El campo "rx_pago_compl_efect" ya existe'
end
go

use cob_credito_his
go
if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where column_name = 'rxh_pago_compl_efect' and table_name  = 'cr_resultado_xml_his') begin
	alter table cr_resultado_xml_his add rxh_pago_compl_efect money
	print 'Se crea el campo "rxh_pago_compl_efect"'
  end else begin
     print 'El campo "rxh_pago_compl_efect" ya existe'
end
go 
 
/*******************************************************************************************/
use cob_credito
go  
if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where column_name = 'rx_iva_comision_pagada' and table_name  = 'cr_resultado_xml') begin
	alter table cob_credito..cr_resultado_xml add rx_iva_comision_pagada money
	print 'Se crea el campo "rx_iva_comision_pagada"'
  end else begin
     print 'El campo "rx_iva_comision_pagada" ya existe'
end
go

use cob_credito_his
go
if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where column_name = 'rxh_iva_comision_pagada' and table_name  =  'cr_resultado_xml_his') begin
	alter table cr_resultado_xml_his add rxh_iva_comision_pagada money
	print 'Se crea el campo "rxh_iva_comision_pagada"'
  end else begin
     print 'El campo "rxh_iva_comision_pagada" ya existe'
end
go
  
/*******************************************************************************************/
use cob_credito
go  
if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where column_name = 'rx_iva_int_ant' and table_name  = 'cr_resultado_xml') begin
	alter table cob_credito..cr_resultado_xml add rx_iva_int_ant money
	print 'Se crea el campo "rx_iva_int_ant"'
  end else begin
     print 'El campo "rx_iva_int_ant" ya existe'
end
go

use cob_credito_his
go
if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where column_name = 'rxh_iva_int_ant' and table_name  = 'cr_resultado_xml_his') begin
	alter table cr_resultado_xml_his add rxh_iva_int_ant money
	print 'Se crea el campo "rxh_iva_int_ant"'
  end else begin
     print 'El campo "rxh_iva_int_ant" ya existe'
end
go

/*******************************************************************************************/
--Creacion de Indices cr resultado_xml y la hist
/*******************************************************************************************/
use cob_credito
go
if not exists (SELECT 1  FROM sys.indexes WHERE Name = N'indx_cr_resultado_xml_fecha_fin_mes'  AND Object_ID = Object_ID(N'cob_credito..cr_resultado_xml'))
begin
    create index indx_cr_resultado_xml_fecha_fin_mes on cob_credito..cr_resultado_xml (rx_fecha_fin_mes)	
end
go


if not exists (SELECT 1  FROM sys.indexes WHERE Name = N'indx_cr_resultado_xml_operation_fin_mes'  AND Object_ID = Object_ID(N'cob_credito..cr_resultado_xml'))
begin
   create index indx_cr_resultado_xml_operation_fin_mes on cob_credito..cr_resultado_xml (num_operation, rx_fecha_fin_mes)	
end
go

update statistics cob_credito..cr_resultado_xml
go



use cob_credito_his
go

if not exists (SELECT 1  FROM sys.indexes WHERE Name = N'indx_cr_resultado_xml_his_fecha_fin_mes'  AND Object_ID = Object_ID(N'cob_credito_his..cr_resultado_xml_his'))
begin
   create index indx_cr_resultado_xml_his_fecha_fin_mes on cob_credito_his..cr_resultado_xml_his (rxh_fecha_fin_mes)	
end
go

if not exists (SELECT 1  FROM sys.indexes WHERE Name = N'indx_cr_resultado_xml_his_operation_fin_mes'  AND Object_ID = Object_ID(N'cob_credito_his..cr_resultado_xml_his'))
begin
   create index indx_cr_resultado_xml_his_operation_fin_mes on cob_credito_his..cr_resultado_xml_his (num_operation, rxh_fecha_fin_mes)	
end

go

   update statistics cob_credito_his..cr_resultado_xml_his
go

















   
 
  
  
 
   
  
   
   
  
   



go