
/*******************************************************************************************/
--eliminacion de Indices cr resultado_xml y la hist
/*******************************************************************************************/
use cob_credito
go
if  exists (SELECT 1  FROM sys.indexes WHERE Name = N'indx_cr_resultado_xml_fecha_fin_mes'  AND Object_ID = Object_ID(N'cob_credito..cr_resultado_xml'))
begin
    drop index cr_resultado_xml.indx_cr_resultado_xml_fecha_fin_mes
end
go


if  exists (SELECT 1  FROM sys.indexes WHERE Name = N'indx_cr_resultado_xml_operation_fin_mes'  AND Object_ID = Object_ID(N'cob_credito..cr_resultado_xml'))
begin
   drop index cr_resultado_xml.indx_cr_resultado_xml_operation_fin_mes
end
go



use cob_credito_his
go

if  exists (SELECT 1  FROM sys.indexes WHERE Name = N'indx_cr_resultado_xml_his_fecha_fin_mes'  AND Object_ID = Object_ID(N'cob_credito_his..cr_resultado_xml_his'))
begin
   drop index cr_resultado_xml_his.indx_cr_resultado_xml_his_fecha_fin_mes 
end
go

if  exists (SELECT 1  FROM sys.indexes WHERE Name = N'indx_cr_resultado_xml_his_operation_fin_mes'  AND Object_ID = Object_ID(N'cob_credito_his..cr_resultado_xml_his'))
begin
   drop index cr_resultado_xml_his.indx_cr_resultado_xml_his_operation_fin_mes 
end

go

use cob_credito
go

if exists (SELECT 1  FROM sys.columns WHERE Name = N'rx_folio_ref' AND Object_ID = Object_ID(N'cob_credito..cr_resultado_xml'))
begin
   ALTER TABLE cob_credito..cr_resultado_xml drop column  rx_folio_ref 
end
go

use cob_credito_his
go
if exists (SELECT 1  FROM sys.columns WHERE Name = N'rxh_folio_ref'  AND Object_ID = Object_ID(N'cob_credito_his..cr_resultado_xml_his'))
begin
   ALTER TABLE cob_credito_his..cr_resultado_xml_his  drop column  rxh_folio_ref 
end
go

/*******************************************************************************************/
use cob_credito
go
if exists (SELECT 1 FROM sys.columns WHERE Name = N'rx_deuda_pagar' AND Object_ID = Object_ID(N'cob_credito..cr_resultado_xml'))
begin
   ALTER TABLE cob_credito..cr_resultado_xml drop column  rx_deuda_pagar 
end
go   

use cob_credito_his
go
if exists (SELECT 1  FROM sys.columns WHERE Name = N'rxh_deuda_pagar'  AND Object_ID = Object_ID(N'cob_credito_his..cr_resultado_xml_his'))
begin
   ALTER TABLE cob_credito_his..cr_resultado_xml_his  drop column  rxh_deuda_pagar 
end
go
/*******************************************************************************************/
use cob_credito
go
if exists (SELECT 1  FROM sys.columns WHERE Name = N'rx_total_saldo'  AND Object_ID = Object_ID(N'cob_credito..cr_resultado_xml'))
begin
   ALTER TABLE cob_credito..cr_resultado_xml drop column  rx_total_saldo 
end
go

use cob_credito_his
go

if  exists (SELECT 1  FROM sys.columns WHERE Name = N'rxh_total_saldo'  AND Object_ID = Object_ID(N'cob_credito_his..cr_resultado_xml_his'))
begin
   ALTER TABLE cob_credito_his..cr_resultado_xml_his  drop column  rxh_total_saldo 
end
go

/*******************************************************************************************/
use cob_credito
go
if  exists (SELECT 1  FROM sys.columns WHERE Name = N'rx_fecha_fin_mes'  AND Object_ID = Object_ID(N'cob_credito..cr_resultado_xml'))
begin
   ALTER TABLE cob_credito..cr_resultado_xml drop column  rx_fecha_fin_mes 
end
go

use cob_credito_his
go

if  exists (SELECT 1  FROM sys.columns WHERE Name = N'rxh_fecha_fin_mes'  AND Object_ID = Object_ID(N'cob_credito_his..cr_resultado_xml_his'))
begin
   ALTER TABLE cob_credito_his..cr_resultado_xml_his  drop column  rxh_fecha_fin_mes 
end
go

/*******************************************************************************************/
use cob_credito
go
if  exists (SELECT 1  FROM sys.columns WHERE Name = N'rx_pago_mes'  AND Object_ID = Object_ID(N'cob_credito..cr_resultado_xml'))
begin
   ALTER TABLE cob_credito..cr_resultado_xml drop column  rx_pago_mes 
end
go

use cob_credito_his
go

if  exists (SELECT 1  FROM sys.columns WHERE Name = N'rxh_pago_mes'  AND Object_ID = Object_ID(N'cob_credito_his..cr_resultado_xml_his'))
begin
   ALTER TABLE cob_credito_his..cr_resultado_xml_his drop column  rxh_pago_mes
end
go

/*******************************************************************************************/
use cob_credito
go
if  exists (SELECT 1  FROM sys.columns WHERE Name = N'rx_pago_mes_ant'  AND Object_ID = Object_ID(N'cob_credito..cr_resultado_xml'))
begin
   ALTER TABLE cob_credito..cr_resultado_xml drop column  rx_pago_mes_ant 
end
go

use cob_credito_his
go

if  exists (SELECT 1  FROM sys.columns WHERE Name = N'rxh_pago_mes_ant'  AND Object_ID = Object_ID(N'cob_credito_his..cr_resultado_xml_his'))
begin
   ALTER TABLE cob_credito_his..cr_resultado_xml_his drop column  rxh_pago_mes_ant
end
go

/*******************************************************************************************/
use cob_credito
go
if  exists (SELECT 1  FROM sys.columns WHERE Name = N'rx_pag_compl_ant'  AND Object_ID = Object_ID(N'cob_credito..cr_resultado_xml'))
begin
   ALTER TABLE cob_credito..cr_resultado_xml  drop column  rx_pag_compl_ant 
end

use cob_credito_his
go

if  exists (SELECT 1  FROM sys.columns WHERE Name = N'rxh_pag_compl_ant'  AND Object_ID = Object_ID(N'cob_credito_his..cr_resultado_xml_his'))
begin
   ALTER TABLE cob_credito_his..cr_resultado_xml_his drop column  rxh_pag_compl_ant
end
go

/*******************************************************************************************/
use cob_credito
go
if  exists (SELECT 1  FROM sys.columns WHERE Name = N'rx_com_acum'  AND Object_ID = Object_ID(N'cob_credito..cr_resultado_xml'))
begin
print 'A'
   ALTER TABLE cob_credito..cr_resultado_xml drop column  rx_com_acum 
end

use cob_credito_his
go
if  exists (SELECT 1  FROM sys.columns WHERE Name = N'rxh_com_acum'  AND Object_ID = Object_ID(N'cob_credito_his..cr_resultado_xml_his'))
begin
print 'A'
   ALTER TABLE cob_credito_his..cr_resultado_xml_his drop column  rxh_com_acum
end
go

/*******************************************************************************************/
use cob_credito
go
if  exists (SELECT 1  FROM sys.columns WHERE Name = N'rx_sec_id'  AND Object_ID = Object_ID(N'cob_credito..cr_resultado_xml'))
begin
print 'A'
   ALTER TABLE cob_credito..cr_resultado_xml drop column  rx_sec_id 
end
go

use cob_credito_his
go
if  exists (SELECT 1  FROM sys.columns WHERE Name = N'rxh_sec_id'  AND Object_ID = Object_ID(N'cob_credito_his..cr_resultado_xml_his'))
begin
print 'A'
   ALTER TABLE cob_credito_his..cr_resultado_xml_his drop column  rxh_sec_id
end
go

/*******************************************************************************************/
use cob_credito
go
if  exists (SELECT 1  FROM sys.columns WHERE Name = N'rx_genera_cmpl'  AND Object_ID = Object_ID(N'cob_credito..cr_resultado_xml'))
begin
print 'A'
   ALTER TABLE cob_credito..cr_resultado_xml drop column  rx_genera_cmpl 
end
go

use cob_credito_his
go
if  exists (SELECT 1  FROM sys.columns WHERE Name = N'rxh_genera_cmpl'  AND Object_ID = Object_ID(N'cob_credito_his..cr_resultado_xml_his'))
begin
print 'A'
   ALTER TABLE cob_credito_his..cr_resultado_xml_his  drop column  rxh_genera_cmpl
end
go

/*******************************************************************************************/
use cob_credito
go
if  exists (select 1 from INFORMATION_SCHEMA.COLUMNS where column_name = 'rx_cuota_desde' and table_name  = 'cr_resultado_xml') begin
      alter table cr_resultado_xml drop column  rx_cuota_desde
      print 'Se elimina el campo "rx_cuota_desde"'
end else begin
      print 'El campo "rx_cuota_desde" no existe'
end
go

use cob_credito_his
go
if  exists (select 1 from INFORMATION_SCHEMA.COLUMNS where column_name = 'rxh_cuota_desde' and table_name  = 'cr_resultado_xml_his') begin
    alter table cr_resultado_xml_his drop column  rxh_cuota_desde
      print 'Se elimina el campo "rxh_cuota_desde"'
end else begin
      print 'El campo "rxh_cuota_desde" no existe'
end
go

/*******************************************************************************************/
use cob_credito
go
if  exists (select 1 from INFORMATION_SCHEMA.COLUMNS where column_name = 'rx_cuota_hasta' and table_name  = 'cr_resultado_xml') begin
	  alter table cr_resultado_xml drop column  rx_cuota_hasta
	  print 'Se elimina el campo "rx_cuota_hasta"'
end else begin
      print  'El campo "rx_cuota_hasta" no existe'
end
go

use cob_credito_his
go
if  exists (select 1 from INFORMATION_SCHEMA.COLUMNS where column_name = 'rxh_cuota_hasta' and table_name  = 'cr_resultado_xml_his') begin
	  alter table cr_resultado_xml_his drop column  rxh_cuota_hasta
	  print 'Se elimina el campo "rxh_cuota_hasta"'
end else begin
      print 'El campo "rxh_cuota_hasta" no existe'
end
go

/*******************************************************************************************/
use cob_credito
go
if  exists (select 1 from INFORMATION_SCHEMA.COLUMNS where column_name = 'rx_int_rep' and table_name  = 'cr_resultado_xml') begin
	  alter table cr_resultado_xml drop column  rx_int_rep
	  print 'Se elimina el campo "rx_int_rep"'
end else begin
      print 'El campo "rx_int_rep" no existe'
end
go

use cob_credito_his
go
if  exists (select 1 from INFORMATION_SCHEMA.COLUMNS where column_name = 'rxh_int_rep' and table_name  = 'cr_resultado_xml_his') begin
	  alter table cr_resultado_xml_his drop column  rxh_int_rep
	  print 'Se elimina el campo "rxh_int_rep"'
end else begin
      print 'El campo "rxh_int_rep" no existe'
end
go

/*******************************************************************************************/
use cob_credito
go
if  exists (select 1 from INFORMATION_SCHEMA.COLUMNS where column_name = 'rx_com_rep' and table_name  = 'cr_resultado_xml') begin
	  alter table cr_resultado_xml drop column  rx_com_rep 
	  print 'Se elimina el campo "rx_com_rep"'
end else begin
      print 'El campo "rx_com_rep" no existe'
end
go

use cob_credito_his
go
if  exists (select 1 from INFORMATION_SCHEMA.COLUMNS where column_name = 'rxh_com_rep' and table_name  = 'cr_resultado_xml_his') begin
	  alter table cr_resultado_xml_his drop column  rxh_com_rep 
	  print 'Se elimina el campo "rxh_com_rep"'
end else begin
      print 'El campo "rxh_com_rep" no existe'
end
go
   
/*******************************************************************************************/
use cob_credito
go

if  exists (select 1 from INFORMATION_SCHEMA.COLUMNS where column_name = 'rx_int_ant' and table_name  = 'cr_resultado_xml') begin
	  alter table cr_resultado_xml drop column  rx_int_ant 
	  print 'Se elimina el campo "rx_int_ant"'
end else begin
      print 'El campo "rx_int_ant" no existe'
end
go

use cob_credito_his
go
if  exists (select 1 from INFORMATION_SCHEMA.COLUMNS where column_name = 'rxh_int_ant' and table_name  = 'cr_resultado_xml_his') begin
	  alter table cr_resultado_xml_his drop column  rxh_int_ant 
	  print 'Se elimina el campo "rxh_int_ant"'
end else begin
      print  'El campo "rxh_int_ant" no existe'
end
go
   
/*******************************************************************************************/
use cob_credito
go
if  exists (select 1 from INFORMATION_SCHEMA.COLUMNS where column_name = 'rx_iva' and table_name  = 'cr_resultado_xml') begin
	  alter table cr_resultado_xml drop column  rx_iva 
	  print 'Se elimina el campo "rx_iva"'
end else begin
      print 'El campo "rx_iva" no existe'
end
go

use cob_credito_his
go
if  exists (select 1 from INFORMATION_SCHEMA.COLUMNS where column_name = 'rxh_iva' and table_name  = 'cr_resultado_xml_his') begin
	  alter table cr_resultado_xml_his drop column  rxh_iva 
	  print 'Se elimina el campo "rxh_iva"'
end else begin
      print 'El campo "rxh_iva" no existe'
end
go
   
/*******************************************************************************************/
use cob_credito
go

if  exists (select 1 from INFORMATION_SCHEMA.COLUMNS where column_name = 'rx_met_fact' and table_name  = 'cr_resultado_xml') begin
	  alter table cr_resultado_xml drop column  rx_met_fact 
	  print 'Se elimina el campo "rx_met_fact"'
end else begin
      print 'El campo "rx_met_fact" no existe'
end
go

use cob_credito_his
go
if  exists (select 1 from INFORMATION_SCHEMA.COLUMNS where column_name = 'rxh_met_fact' and table_name  = 'cr_resultado_xml_his') begin
	  alter table cr_resultado_xml_his drop column  rxh_met_fact 
	  print 'Se elimina el campo "rxh_met_fact"'
end else begin
      print 'El campo "rxh_met_fact" no existe'
end
go
   
/*******************************************************************************************/
use cob_credito
go   
if  exists (select 1 from INFORMATION_SCHEMA.COLUMNS where column_name = 'rx_form_pag' and table_name  = 'cr_resultado_xml') begin
	  alter table cr_resultado_xml drop column  rx_form_pag 
	  print 'Se elimina el campo "rx_form_pag"'
end else begin
      print  'El campo "rx_form_pag" no existe'
end   
go

use cob_credito_his
go
if  exists (select 1 from INFORMATION_SCHEMA.COLUMNS where column_name = 'rxh_form_pag' and table_name  = 'cr_resultado_xml_his') begin
	  alter table cr_resultado_xml_his drop column  rxh_form_pag 
	  print 'Se elimina el campo "rxh_form_pag"'
   end else begin
      print 'El campo "rxh_form_pag" no existe'
end
go

/*******************************************************************************************/
use cob_credito
go   

if  exists (select 1 from INFORMATION_SCHEMA.COLUMNS where column_name = 'rx_fecha_ult_compl' and table_name  = 'cr_resultado_xml') begin
	  alter table cr_resultado_xml drop column  rx_fecha_ult_compl 
	  print 'Se elimina el campo "rx_fecha_ult_compl"'
end else begin
      print 'El campo "rx_fecha_ult_compl" no existe'
end
go

use cob_credito_his
go
if  exists (select 1 from INFORMATION_SCHEMA.COLUMNS where column_name = 'rxh_fecha_ult_compl' and table_name  = 'cr_resultado_xml_his') begin
	  alter table cr_resultado_xml_his drop column  rxh_fecha_ult_compl 
	  print 'Se elimina el campo "rxh_fecha_ult_compl"'
end else begin
      print 'El campo "rxh_fecha_ult_compl" no existe'
end
go

/*******************************************************************************************/
use cob_credito
go   

if  exists (select 1 from INFORMATION_SCHEMA.COLUMNS where column_name = 'rx_pago_compl' and table_name  = 'cr_resultado_xml') begin
	  alter table cr_resultado_xml drop column  rx_pago_compl 
	  print 'Se elimina el campo "rx_pago_compl"'
end else begin
      print  'El campo "rx_pago_compl" no existe'
end
go

use cob_credito_his
go
if  exists (select 1 from INFORMATION_SCHEMA.COLUMNS where column_name = 'rxh_pago_compl' and table_name  = 'cr_resultado_xml_his') begin
	  alter table cr_resultado_xml_his drop column  rxh_pago_compl 
	  print 'Se elimina el campo "rxh_pago_compl"'
end else begin
      print 'El campo "rxh_pago_compl" no existe'
end
go

/*******************************************************************************************/
use cob_credito
go

if  exists (select 1 from INFORMATION_SCHEMA.COLUMNS where column_name = 'rx_fecha_env_email' and table_name  = 'cr_resultado_xml') begin
	  alter table cr_resultado_xml drop column  rx_fecha_env_email 
	  print 'Se elimina el campo "rx_fecha_env_email"'
end else begin
      print 'El campo "rx_fecha_env_email" no existe'
end
go

use cob_credito_his
go
if  exists (select 1 from INFORMATION_SCHEMA.COLUMNS where column_name = 'rxh_fecha_env_email' and table_name  = 'cr_resultado_xml_his') begin
	  alter table cr_resultado_xml_his drop column  rxh_fecha_env_email 
	  print 'Se elimina el campo "rxh_fecha_env_email"'
   end else begin
      print 'El campo "rxh_fecha_env_email" no existe'
end
go
  
/*******************************************************************************************/
use cob_credito
go

if  exists (select 1 from INFORMATION_SCHEMA.COLUMNS where column_name = 'rx_tipo_operacion' and table_name  = 'cr_resultado_xml') begin
	  alter table cr_resultado_xml drop column  rx_tipo_operacion 
	  print 'Se elimina el campo "rx_tipo_operacion"'
   end else begin
      print 'El campo "rx_tipo_operacion" no existe'
end
go

use cob_credito_his
go
if  exists (select 1 from INFORMATION_SCHEMA.COLUMNS where column_name = 'rxh_tipo_operacion' and table_name  ='cr_resultado_xml_his') begin
	  alter table cr_resultado_xml_his drop column  rxh_tipo_operacion 
	  print 'Se elimina el campo "rxh_tipo_operacion"'
   end else begin
      print 'El campo "rxh_tipo_operacion" no existe'
end
go 
  
/*******************************************************************************************/
use cob_credito
go   
   if  exists (select 1 from INFORMATION_SCHEMA.COLUMNS where column_name = 'rx_total_saldo_ant' and table_name  = 'cr_resultado_xml') begin
	  alter table cr_resultado_xml drop column  rx_total_saldo_ant 
	  print 'Se elimina el campo "rx_total_saldo_ant"'
   end else begin
      print 'El campo "rx_total_saldo_ant" no existe'
end
go

use cob_credito_his
go
if  exists (select 1 from INFORMATION_SCHEMA.COLUMNS where column_name = 'rxh_total_saldo_ant' and table_name  = 'cr_resultado_xml_his') begin
	  alter table cr_resultado_xml_his drop column  rxh_total_saldo_ant 
	  print 'Se elimina el campo "rxh_total_saldo_ant"'
   end else begin
      print 'El campo "rxh_total_saldo_ant" no existe'
end
go
   
/*******************************************************************************************/
use cob_credito
go  
if  exists (select 1 from INFORMATION_SCHEMA.COLUMNS where column_name = 'rx_pago_compl_fin' and table_name  = 'cr_resultado_xml') begin
	alter table cob_credito..cr_resultado_xml drop column  rx_pago_compl_fin 
	print 'Se elimina el campo "rx_pago_compl_fin"'
end else begin
     print 'El campo "rx_pago_compl_fin" no existe'
end
go

use cob_credito_his
go
if  exists (select 1 from INFORMATION_SCHEMA.COLUMNS where column_name = 'rxh_pago_compl_fin' and table_name  = 'cr_resultado_xml_his') begin
	  alter table cr_resultado_xml_his drop column  rxh_pago_compl_fin 
	  print 'Se elimina el campo "rxh_pago_compl_fin"'
   end else begin
      print 'El campo "rxh_pago_compl_fin" no existe'
end
go

/*******************************************************************************************/
use cob_credito
go  
if  exists (select 1 from INFORMATION_SCHEMA.COLUMNS where column_name = 'rx_total_saldo_act' and table_name  = 'cr_resultado_xml') begin
	alter table cob_credito..cr_resultado_xml drop column  rx_total_saldo_act 
	print 'Se elimina el campo "rx_total_saldo_act"'
  end else begin
     print 'El campo "rx_total_saldo_act" no existe'
end
go

use cob_credito_his
go
if  exists (select 1 from INFORMATION_SCHEMA.COLUMNS where column_name = 'rxh_total_saldo_act' and table_name  = 'cr_resultado_xml_his') begin
	alter table cr_resultado_xml_his drop column  rxh_total_saldo_act 
	print 'Se elimina el campo "rxh_total_saldo_act"'
  end else begin
     print 'El campo "rxh_total_saldo_act" no existe'
end
go

/*******************************************************************************************/
use cob_credito
go  
if  exists (select 1 from INFORMATION_SCHEMA.COLUMNS where column_name = 'rx_pago_compl_efect' and table_name  =  'cr_resultado_xml') begin
	alter table cob_credito..cr_resultado_xml drop column  rx_pago_compl_efect 
	print 'Se elimina el campo "rx_pago_compl_efect"'
  end else begin
     print 'El campo "rx_pago_compl_efect" no existe'
end
go

use cob_credito_his
go
if  exists (select 1 from INFORMATION_SCHEMA.COLUMNS where column_name = 'rxh_pago_compl_efect' and table_name  = 'cr_resultado_xml_his') begin
	alter table cr_resultado_xml_his drop column  rxh_pago_compl_efect 
	print 'Se elimina el campo "rxh_pago_compl_efect"'
  end else begin
     print 'El campo "rxh_pago_compl_efect" no existe'
end
go 
 
/*******************************************************************************************/
use cob_credito
go  
if  exists (select 1 from INFORMATION_SCHEMA.COLUMNS where column_name = 'rx_iva_comision_pagada' and table_name  = 'cr_resultado_xml') begin
	alter table cob_credito..cr_resultado_xml drop column  rx_iva_comision_pagada 
	print 'Se elimina el campo "rx_iva_comision_pagada"'
  end else begin
     print 'El campo "rx_iva_comision_pagada" no existe'
end
go

use cob_credito_his
go
if  exists (select 1 from INFORMATION_SCHEMA.COLUMNS where column_name = 'rxh_iva_comision_pagada' and table_name  =  'cr_resultado_xml_his') begin
	alter table cr_resultado_xml_his drop column  rxh_iva_comision_pagada 
	print 'Se elimina el campo "rxh_iva_comision_pagada"'
  end else begin
     print 'El campo "rxh_iva_comision_pagada" no existe'
end
go
  
/*******************************************************************************************/
use cob_credito
go  
if  exists (select 1 from INFORMATION_SCHEMA.COLUMNS where column_name = 'rx_iva_int_ant' and table_name  = 'cr_resultado_xml') begin
	alter table cob_credito..cr_resultado_xml drop column  rx_iva_int_ant 
	print 'Se elimina el campo "rx_iva_int_ant"'
  end else begin
     print 'El campo "rx_iva_int_ant" no existe'
end
go

use cob_credito_his
go
if  exists (select 1 from INFORMATION_SCHEMA.COLUMNS where column_name = 'rxh_iva_int_ant' and table_name  = 'cr_resultado_xml_his') begin
	alter table cr_resultado_xml_his drop column  rxh_iva_int_ant 
	print 'Se elimina el campo "rxh_iva_int_ant"'
  end else begin
     print 'El campo "rxh_iva_int_ant" no existe'
end
go

