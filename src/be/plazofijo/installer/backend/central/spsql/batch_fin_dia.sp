/*bt_fidia*/
/************************************************************************/
/*      Archivo:                bt_fidia.sp                             */
/*      Stored procedure:       sp_batch_fin_dia                        */
/*      Base de datos:          cob_pfijo                               */
/*      Producto:               Plazo Fijo                              */
/*      Disenado por:           Carolina Alvarado                       */
/*      Fecha de documentacion: 05/Oct/95                               */
/************************************************************************/
/*                              IMPORTANTE                              */
/*      Este programa es parte de los paquetes bancarios propiedad de   */
/*      'MACOSA', representantes exclusivos para el Ecuador de la       */
/*      'NCR CORPORATION'.                                              */
/*      Su uso no autorizado queda expresamente prohibido asi como      */
/*      cualquier alteracion o agregado hecho por alguno de sus         */
/*      usuarios sin el debido consentimiento por escrito de la         */
/*      Presidencia Ejecutiva de MACOSA o su representante.             */
/************************************************************************/
/*                              PROPOSITO                               */
/*      Este script crea los procedimientos para las Actualizaciones    */
/*      de fin de dia del modulo de Plazo Fijo.                         */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*      FECHA      AUTOR              RAZON                             */
/*   06-Abr-2000 Ximena Cartagena  Incluir prorroga automatica          */
/*   17-Mar-2005 N. Silva          Nuevo proceso de Provision y crr iden*/
/************************************************************************/
use cob_pfijo
go

SET NOCOUNT ON
go

SET ANSI_NULLS OFF
go

SET QUOTED_IDENTIFIER OFF
go

if exists (select 1 from sysobjects where name = 'sp_batch_fin_dia' and type = 'P')
   drop proc sp_batch_fin_dia
go

create proc sp_batch_fin_dia (
@s_ssn                  int         = NULL,
@s_user                 login       = NULL,
@s_term                 varchar(30) = NULL,
@s_date                 datetime    = NULL,
@s_srv                  varchar(30) = NULL,
@s_lsrv                 varchar(30) = NULL,
@s_ofi                  smallint    = NULL,
@s_rol                  smallint    = NULL,
@t_debug                char(1)     = NULL,
@t_file                 varchar(10) = NULL,
@t_trn                  int         = NULL,
@i_fecha_proceso        datetime,
@i_oficina		        catalogo    = 'T',
@i_fecha_corrida        datetime    = NULL, -- Control de Cambio para fecha Contable
@i_ciudad		        catalogo    = 'T',
@i_en_linea		        char(1)     = 'S',
@i_batch_inidia         char(1)     = 'N' )
with encryption
as

declare 
        @w_sp_name              descripcion,
        @w_return               int,
        @w_error                int,
        @w_secuencial           int,
	@w_ssn                  int,
	@w_fecha_hoy            datetime,
	@w_rc_fecha_inicio_dia  datetime,
	@w_rc_fecha_final_dia   datetime,
	@w_sgte_fecha_proceso   datetime,
	@w_fecha_proceso        datetime,
	@w_fecha_proceso_err    datetime,
	@w_fecha_proceso1       varchar(10),
        @w_of_oficina           int,
        @w_of_ciudad            int,
        @w_fecha_provision      datetime,
        @w_fecha_laborable      datetime,
	@w_fecha_laborable_out  datetime,
	@w_igual_mes            char(1),
	@w_fecha_contable       datetime,
	@w_inicio_dia           char(1),
	@w_dias_no_lab          tinyint,
	@w_debug                char(1)

select @w_debug = 'N'

/*---------*/
/*  DEBUG  */
/*---------*/
select @w_sp_name = 'sp_batch_fin_dia',
       @s_user    = isnull(@s_user,'sa'),
       @s_term    = isnull(@s_term,'CONSOLA'),
       @s_date    = isnull(@s_date,@i_fecha_proceso),
       @s_srv     = isnull(@s_srv,@@servername),
       @s_lsrv    = isnull(@s_lsrv,@@servername),
       @s_ofi     = isnull(@s_ofi,99),
       @s_rol     = isnull(@s_rol,1),
       @t_debug   = isnull(@t_debug,'N'),
       @t_file    = isnull(@t_file,'SQR'),
       @t_trn     = isnull(@t_trn,14999)

--------------------------------------------
-- Obtener datos de la tabla pf_reg_control
--------------------------------------------       
select @w_rc_fecha_final_dia   =  rc_fecha_final_dia,
       @w_rc_fecha_inicio_dia  =  rc_fecha_inicio_dia
from pf_reg_control

select @w_rc_fecha_final_dia    = convert(datetime,convert(varchar,@w_rc_fecha_final_dia,101)),
       @w_rc_fecha_inicio_dia = convert(datetime,convert(varchar,@w_rc_fecha_inicio_dia,101)),
       @w_fecha_proceso     = convert(datetime,convert(varchar,@i_fecha_proceso,101)),
       @w_fecha_proceso_err = convert(datetime,convert(varchar,@i_fecha_proceso,101))

if @w_debug = 'S' begin
   print 'EJECUTANDO CIERRE PARA FECHA ' + cast( @w_rc_fecha_inicio_dia as varchar)+' FECHA PROCESO ' + cast( @w_fecha_proceso as varchar)
end

if @w_rc_fecha_inicio_dia  <> @w_fecha_proceso
begin
  print 'FECHA PROCESO DE CIERRE DIFERENTE A LA FECHA DE CONTROL (FECHA PROCESO INCORRECTA)'
  select @w_error = 149027
  goto ERROR
end

if @w_rc_fecha_final_dia  >= @w_fecha_proceso
begin
  print 'FECHA DE FIN DE DIA MAYOR O IGUAL A FECHA DE PROCESO (YA SE EJECUTO EL CIERRE)'
  select @w_error = 149028
  goto ERROR
end

if @w_rc_fecha_inicio_dia  = @w_rc_fecha_final_dia
begin
  print 'YA SE EJECUTO EL CIERRE SEGUN TABLA PF_REG_CONTROL'
  select @w_error = 149029
  goto ERROR
end

select @w_fecha_proceso1 = convert(varchar(10),@w_fecha_proceso,101) 
select @w_error = 0




--I. CVA Jun-14-06 implementacion para obtener seqnos del kernel
exec @w_ssn = ADMIN...rp_ssn
select @w_secuencial = @w_ssn
--F. CVA Jun-14-06 implementacion para obtener seqnos del kernel


exec sp_anulacion_op_ren          ---rma eliminar instruccion de cancelacion
      @s_user          = @s_user,
      @s_term          = @s_term, 					
      @s_date          = @s_date, 
      @s_srv           = @s_srv,
      @s_lsrv          = @s_lsrv,
      @s_rol           = @s_rol,
     @t_debug         = @t_debug, 
     @t_file          = @t_file, 
     @t_from          = @w_sp_name,
     @i_en_linea     =  @i_en_linea

----------------------------------------------
-- Proceso para Inactivacion de Depositos
----------------------------------------------
exec @w_return = sp_actualizacion_localizacion
     @s_user          = @s_user,
     @s_date          = @s_date,
     @i_fecha         = @i_fecha_proceso
if @w_return <> 0 
begin 
  print 'bt_fidia Error inactivacion de depositos'
  select @w_error = 149049
  goto ERROR
end




---------------------------------------------
-- Proceso para ejecutar prorroga automatica
---------------------------------------------
--I. CVA Jun-14-06 implementacion para obtener seqnos del kernel
exec @w_ssn = ADMIN...rp_ssn
select @w_secuencial = @w_ssn
--F. CVA Jun-14-06 implementacion para obtener seqnos del kernel

exec @w_return=sp_renova_aut 
     @s_ssn           = @w_secuencial,
     @s_user          = @s_user,
     @s_term          = @s_term, 					
     @s_date          = @s_date, 
     @s_srv           = @s_srv,
     @s_lsrv          = @s_lsrv,
     @s_ofi           = @s_ofi,
     @s_rol           = @s_rol,
     @t_debug         = @t_debug, 
     @t_file          = @t_file, 
     @t_from          = @w_sp_name,		
     @t_trn           = 14947, 
     @i_fecha_proceso = @i_fecha_proceso
if @w_return <> 0 or @w_error <> 0
begin 
  print 'bt_fidia.sp RETORNA ERROR EN RENOVACION AUTOMATICA'
  select @w_error = 149049
  goto ERROR
end




-------------------------------------------
-- Proceso para vencimiento de operaciones
-------------------------------------------
--I. CVA Jun-14-06 implementacion para obtener seqnos del kernel
exec @w_ssn = ADMIN...rp_ssn
select @w_secuencial = @w_ssn
--F. CVA Jun-14-06 implementacion para obtener seqnos del kernel

exec @w_return = sp_batch_vencimiento 
     @s_ssn           = @w_secuencial, 	
     @s_user          = @s_user,
     @s_term          = @s_term, 				
     @s_date          = @s_date, 
     @s_srv           = @s_srv,						
     @s_lsrv          = @s_lsrv, 
     @s_ofi           = @s_ofi, 						
     @s_rol           = @s_rol,
     @t_debug         = @t_debug, 				
     @t_file          = @t_file, 
     @t_from          = @w_sp_name,				
     @t_trn           = 14925 , 
     @i_fecha_proceso = @w_fecha_proceso1,
     @i_oficina       = @i_oficina,
     @i_ciudad        = @i_ciudad,
     @i_hora          = 1,
     @i_en_linea      = @i_en_linea  
if @w_return <> 0 or @w_error <> 0
begin
  print 'bt_fidia.sp ERROR EN VENCIMIENTO'
  select @w_error = 149049
  goto ERROR
end



   -----------------------------------------------------------
   -- Anulaci¢n de las autorizaciones de spread pendientes
   -----------------------------------------------------------
   exec @w_return = sp_anula_autspread 
     @s_user          	     = @s_user,
     @i_fecha_proceso        = @i_fecha_proceso,
     @t_debug                = @t_debug,
     @t_file                 = @t_file
   if @w_return <> 0 or @w_error <> 0
   begin
      print 'bt_fidia.sp ERROR EN ANULACION DE SPREAD'
      select @w_error = @w_return
      goto ERROR
   end


-------------------------------    
-- Calculo diario de Intereses
-------------------------------
--I. CVA Jun-14-06 implementacion para obtener seqnos del kernel
exec @w_ssn = ADMIN...rp_ssn
select @w_secuencial = @w_ssn
--F. CVA Jun-14-06 implementacion para obtener seqnos del kernel



------------------------------------------ 
-- Proceso de Calculo de Provision Diaria
------------------------------------------
exec @w_return             = sp_provision 
	@s_ssn                = @s_ssn, 
	@s_user               = @s_user,
	@s_term               = @s_term,
	@s_date               = @s_date,
	@s_srv                = @s_srv,
	@s_lsrv               = @s_lsrv,
	@s_ofi                = @w_of_oficina,
	@s_rol                = @s_rol,
	@t_debug              = @t_debug, 
	@t_file               = @t_file,
	@t_from               = @w_sp_name,
	@t_trn                = 14926,
	@i_fecha_proceso      = @w_fecha_proceso1,
	@i_oficina            = @w_of_oficina,
	@i_fecha_corrida      = @i_fecha_corrida,
	@i_fecha_laborable    = @w_fecha_laborable,
	@o_fecha_contable     = @w_fecha_laborable_out out
if @w_return <> 0
begin
	Print 'bt_fidia.sp ERROR EN PROVISION '
	select @w_error = @w_return
	goto ERROR
end      

if @w_debug = 'S' begin
   print 'bt_fidia.sp ===> FINALIZO FIN DE DIA FECHA ' + cast( @w_fecha_proceso as varchar) 
end

update pf_reg_control 
set rc_fecha_final_dia = @w_fecha_proceso,
    rc_fecha_proc_cont = @w_fecha_laborable_out  --CVA Mar-01-06
if @w_error <> 0
begin
   print 'bt_fidia.sp ERROR EN ACTUALIZACION DE PF_REG_CONTROL'
   goto ERROR
end

--I. CVA Jun-13-06 Llamar a Inicio de Dia por d¡as no h biles del mismo mes de la fecha proceso
select @w_sgte_fecha_proceso = dateadd( dd,1,@w_fecha_proceso),
       @w_igual_mes 	     = 'S',
       @w_inicio_dia         = 'N',
       @w_dias_no_lab        = 0  

while exists(select 1 from cobis..cl_dias_feriados
	   where df_fecha  =  @w_sgte_fecha_proceso
	    and df_ciudad =  9999) and @w_igual_mes = 'S'
begin	
	select @w_inicio_dia   = 'S'

	exec @w_return         = sp_fecha_contable
	     @i_fecha_proceso  = @w_sgte_fecha_proceso, 
             @o_fecha_contable = @w_fecha_contable out

        if datepart(mm,@w_fecha_proceso) <> datepart(mm,@w_fecha_contable)
	begin
           select @w_igual_mes = 'N'
	   select @w_sgte_fecha_proceso = dateadd( dd,-1,@w_sgte_fecha_proceso)
           goto siguiente
	end

	select @w_sgte_fecha_proceso = dateadd( dd,1,@w_sgte_fecha_proceso)

       siguiente:
end

if @w_igual_mes = 'S'
	select @w_sgte_fecha_proceso = dateadd( dd,-1,@w_sgte_fecha_proceso)
else --CVA Set-29-06 Cuando se pase a otro mes entonces no debe ir a ejecutar el Inicio de Dia, esto solo aplica para fechas no laborables del mismo mes
begin
        if datepart(mm,@w_fecha_proceso) = datepart(mm,@w_sgte_fecha_proceso) and datepart(dd,@w_fecha_proceso) <> datepart(dd,@w_sgte_fecha_proceso) 
	begin
		select @w_dias_no_lab = datediff(dd,@w_fecha_proceso,@w_sgte_fecha_proceso)
		if @w_dias_no_lab > 0
		   select @w_inicio_dia = 'S'  
	end
	else
        	select @w_inicio_dia = 'N'
end

if @w_inicio_dia = 'S' and @i_batch_inidia = 'N'
begin
   if @w_debug = 'S' begin
      print '-------BATCH PARA DIAS NO LABORABLES-------'
      print 'EJECUTANDO INICIO DE DIA Y FIN DE DIA A FECHA ' + cast(  @w_sgte_fecha_proceso as varchar) 
   end

	exec @w_return        = sp_batch_inicio_dia 
	     @i_fin_dia       = 'S',
             @i_fecha_proceso = @w_sgte_fecha_proceso,
	     @s_date          = @w_sgte_fecha_proceso
	if @w_return <> 0
	begin
    if @w_debug = 'S' begin
		   print 'bt_fidia.sp ERROR EN SP_BATCH_INICIO_DIA DIAS NO LOBORABLES '
		end
		
		select @w_error = @w_return

		select @w_fecha_proceso_err = dateadd(dd,-1,@w_fecha_proceso_err)

		update pf_reg_control 
		set rc_fecha_final_dia = @w_fecha_proceso_err 

		goto ERROR
	end      
end
--F. CVA Jun-13-06 Llamar a Inicio de Dia por d¡as no h biles del mismo mes de la fecha proceso



if @w_debug = 'S' begin
   print 'bt_fidia.sp ===> FECHA CONTABLE CUADRE AUXILIAR ' + cast(  @w_fecha_laborable_out as varchar) 
end

delete from pf_cuadre_auxiliar where ca_fecha_proceso = @w_fecha_laborable_out

-- Llena Tabla de estado de capital e interes para operacion (REPORTE DE CUADRE)
insert into pf_cuadre_auxiliar
select 	@w_fecha_laborable_out,
	op_toperacion, 
	op_oficina, 
	op_moneda, 
	sum(isnull(op_monto,0)), 
	(sum(isnull(op_int_ganado,0)) - sum(isnull(op_int_pagados,0))),  --CVA ene-18-06 - Pagos Anticipados
	count(*)
from pf_operacion where op_estado in ('XACT','ACT','VEN')
group by op_toperacion, op_oficina, op_moneda


return 0

ERROR:
	print 'bt_fidia.sp ENTRA A BLOQUE DE ERROR ' + cast(  @w_error as varchar) 

	exec sp_errorlog 
	     @i_fecha    = @s_date,
	     @i_error    = @w_error, 
	     @i_usuario  = @s_user,
	     @i_tran     = @t_trn,
	     @i_cuenta   = ' '


return @w_error
go
