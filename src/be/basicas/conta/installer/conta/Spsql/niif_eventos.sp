/**************************************************************************/
/*   Archivo:                niif_posterior.sp                            */
/*   Stored Procedure:       sp_niif_eventos                              */
/*   Producto:               Contabilidad                                 */
/**************************************************************************/
/*                            IMPORTANTE                                  */
/*   Este programa es parte de los paquetes bancarios propiedad de        */
/*   "COBISCORP S.A".                                                     */
/*   Su uso no autorizado queda expresamente prohibido asi como           */
/*   cualquier alteracion o agregado hecho por alguno de sus              */
/*   usuarios sin el debido consentimiento por escrito de la              */
/*   Presidencia Ejecutiva de COBISCORP S.A o su representante.           */
/**************************************************************************/
/*                            PROPOSITO                                   */
/*   Genera los asientos y comprobante contables cuando se presentan      */
/*   inconsistecias en la reclasificacion de terceros de desmebolsos      */
/*   de alianzas.                                                         */
/**************************************************************************/
/*                           MODIFICACION                                 */
/*    FECHA             AUTOR             RAZON                           */
/*    09/09/2014        ALEJANDRA CELIS   NR429 INTERFAZ CORVUS PROCESOS  */
/*                                              POSTERIORES               */
/**************************************************************************/
use cob_conta
go

SET ANSI_NULLS ON
GO

SET ANSI_WARNINGS OFF
GO

SET QUOTED_IDENTIFIER ON
GO

if exists (select 1 from sysobjects where name = 'sp_niif_eventos')
   drop proc sp_niif_eventos
go

create proc sp_niif_eventos
  @i_param1 as varchar(12),
  @i_param2 as varchar(12)
  as
declare 
@w_msg  varchar(200),
@w_fecha datetime,
@w_fecha_fin  datetime,
@w_ano_ini    smallint,
@w_ano_fin    smallint

select @w_fecha = convert(datetime, @i_param1)
select @w_fecha_fin = convert(datetime, @i_param2)

if (@w_fecha > @w_fecha_fin)
begin
  print 'LA FECHA INICIAL NO PUEDE SER MAYOR QUE LA FECHA FINAL '
  return 1
end  

select @w_ano_ini = datepart(yyyy,@w_fecha)
select @w_ano_fin = datepart(yyyy,@w_fecha_fin)

if (datediff(mm,@w_fecha, @w_fecha_fin) + 1) > 3
begin
  print 'LAS FECHAS DEBEN SER DEL MISMO TRIMESTRE'
  return 1
end  

if (@w_ano_ini <> @w_ano_fin)
begin
  print 'LAS FECHAS DEBEN SER DEL MISMO AÑO'
  return 1
end  



truncate table cob_externos..ex_niif_objeto


select *
into #param
from cob_conta..cb_relparam,  cob_conta..cb_det_perfil
where  re_producto  = 14
and    re_parametro = dp_cuenta
and    re_empresa = 1
order by re_substring

while (@w_fecha <= @w_fecha_fin) begin
   print 'FECHA DE PROCESO ES  ' + convert(varchar, @w_fecha)

   insert into cob_externos..ex_niif_objeto
      (no_fecha,
   	   no_comprobante,  
   	   no_cod_instrumento, 
	   no_ide_ope, 
	   no_cod_evento,   	no_cod_concepto,   	monto_debe, 
	   monto_haber,    	monto_debe_imp,  	monto_haber_imp)    
   select 
   distinct    convert(varchar(10),sc_fecha_tran,111) fecha,
      convert(varchar, sc_comprobante) + convert(varchar(10), sc_fecha_tran, 112)+ convert(varchar, sc_producto) comprobante ,
      sc_producto ,
      substring( (substring(sa_concepto, charindex(':', sa_concepto)+1, len(sa_concepto))),1,charindex(' ', substring(sa_concepto, charindex(':', sa_concepto)+1, len(sa_concepto)))-1) operacion,
      sc_perfil perfil, 
      convert(varchar(200),sa_cuenta) cuenta,
      sa_debito debito,          sa_credito credito,         sa_debito debito1,
      sa_credito credito1 
   from cob_conta_tercero..ct_sasiento,
     cob_conta_tercero..ct_scomprobante,cob_conta..cb_perfil
   where sc_comprobante = sa_comprobante
   and   sc_fecha_tran  = sa_fecha_tran
   and   sc_producto = sa_producto
   and   sc_producto =14
   and   sc_empresa = 1
   and   sa_empresa = 1
   and   sc_fecha_gra>=  @w_fecha
   and   sc_fecha_gra < dateadd(dd,1,@w_fecha)
   and   sc_perfil  =  pe_perfil 
   and   pe_producto = 14
   and   pe_perfil = 'CAN_DPF'
   order by operacion, perfil
   if @@error <> 0 begin
      print 'ERROR AL CREAR LOS EVENTOS-CONCEPTOS  '
      goto ERROR1
   end
   


   update cob_externos..ex_niif_objeto
   set    no_cod_instrumento = (case when  op_plazo_ant < 180  then 31 
                   when (op_plazo_ant >= 180 and op_plazo_ant < 360) then 32
                   when (op_plazo_ant >= 360 and op_plazo_ant < 540) then 33
                   else 34 end )
   from cob_pfijo..pf_operacion                   
   where  no_cod_instrumento = 14
   and    no_ide_ope = op_num_banco

   update  cob_externos..ex_niif_objeto set
   no_cod_instrumento  = (case
                 when (no_cod_instrumento = 31 and  (case isnull(c_tipo_compania, '') when '' then 'PA' else c_tipo_compania end)  = 'PA'  ) then 301
                 when (no_cod_instrumento = 31 and  (case isnull(c_tipo_compania, '') when '' then 'PA' else c_tipo_compania end)  <>'PA'  ) then 302
                 when (no_cod_instrumento = 32 and  (case isnull(c_tipo_compania, '') when '' then 'PA' else c_tipo_compania end)  = 'PA'  ) then 303
                 when (no_cod_instrumento = 32 and  (case isnull(c_tipo_compania, '') when '' then 'PA' else c_tipo_compania end)  <>'PA'  ) then 304
                 when (no_cod_instrumento = 33 and  (case isnull(c_tipo_compania, '') when '' then 'PA' else c_tipo_compania end)  = 'PA'  ) then 305
                 when (no_cod_instrumento = 33 and  (case isnull(c_tipo_compania, '') when '' then 'PA' else c_tipo_compania end)  <>'PA'  ) then 306
                 when (no_cod_instrumento = 34 and  (case isnull(c_tipo_compania, '') when '' then 'PA' else c_tipo_compania end)  = 'PA'  ) then 307
                 when (no_cod_instrumento = 34 and  (case isnull(c_tipo_compania, '') when '' then 'PA' else c_tipo_compania end)  <>'PA'  ) then 308 
                 else null end) 
   from  cob_pfijo..pf_operacion  , cobis..cl_ente
   where no_cod_instrumento in (14,31,32,33,34)
   and   no_ide_ope = op_num_banco
   and   op_ente = en_ente

   update cob_externos..ex_niif_objeto
   set    no_cod_concepto =  re_parametro  + '-' + convert(varchar,dp_codval) +   (case when substring(dp_cuenta,7,4) = 'PAGO' then '-' + re_substring else '' end ) 
   from   #param
   where  no_cod_concepto = re_substring
   and    dp_debcred = (case when monto_debe <> 0 then 1  else 2 end)
   and    no_cod_evento = dp_perfil
   
   
   insert into cob_externos..ex_control_corvus
   select getdate(),'PROCESO EXITOS0 INTERFACE EVENTOS-CONCEPTOS ' ,'sp_niif_eventos', 'P','N','FECHA PROCESO: ' + convert(varchar(10),@w_fecha,112)
   
   select @w_fecha  = dateadd(dd,1,@w_fecha)
   
end --while mayor               

return 0

ERROR1:
   insert into cob_externos..ex_control_corvus
   select getdate(),'PROCESO CON ERROR EN EVENTOS-CONCEPTOS' ,'sp_niif_eventos', 'E','N','FECHA PROCESO: ' + convert(varchar(10),@w_fecha,112)
   return 1
go

/*
delete cob_externos..ex_control_corvus
exec  sp_niif_eventos
@i_param1='01/14/2014',
@i_param2='01/14/2014'
select * from cob_externos..ex_control_corvus
select * from cob_externos..ex_niif_objeto
*/