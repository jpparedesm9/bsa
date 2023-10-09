/**************************************************************************/
/*      Archivo:                        consulta_monetaria.sp             */
/*      Stored procedure:               sp_consulta_monetarias            */
/*      Base de Datos:                  cob_conta_super                   */
/*      Producto:                       Clientes                          */
/**************************************************************************/
/*                      IMPORTANTE                                        */
/*  Esta aplicacion es parte de los paquetes bancarios propiedad          */
/*  de COBISCorp.                                                         */
/*  Su uso no    autorizado queda  expresamente   prohibido asi como      */
/*  cualquier    alteracion o  agregado  hecho por    alguno  de sus      */
/*  usuarios sin el debido consentimiento por   escrito de COBISCorp.     */
/*  Este programa esta protegido por la ley de   derechos de autor        */
/*  y por las    convenciones  internacionales   de  propiedad inte-      */
/*  lectual.    Su uso no  autorizado dara  derecho a    COBISCorp para   */
/*  obtener ordenes  de secuestro o  retencion y para  perseguir          */
/*  penalmente a los autores de cualquier   infraccion.                   */
/**************************************************************************/
/*                      PROPOSITO                                         */
/* Realiza la carga de clientes para el envio de notificacion             */
/* al oficial de cumplimiento                                             */
/**************************************************************************/
/*                            MODIFICACIONES                              */
/*      FECHA           AUTOR                   RAZON                     */
/*      25/08/2016      Ignacio Yupa            Emision Inicial           */  
/*      02/12/2016      Ignacio Yupa            Paso de todos los modulos */  
/**************************************************************************/

use cob_conta_super
go

if exists(select * from sysobjects where name = 'sp_consulta_monetarias')
   drop proc sp_consulta_monetarias
go

create proc sp_consulta_monetarias(   
	@i_param1         datetime    = null--, -- i_fecha
	--@i_param2	 smallint    = null     --i_aplicativo
    

)
 as declare

@w_fecha_proceso    datetime,
@w_pais             int,
@w_id_mon_dolar     int,
@w_val_conv_pesos   money,
@w_tot_val_aho    money,
@w_maximo_aho     money,
@w_sp_name          varchar(255),
@w_dia             char(2),
@w_anio            char(4),
@w_mes             char(2),
@w_fec_inicial     datetime,
@w_fec_i           varchar(12),
@w_maximo          int, 
@w_max_registro    int,
@w_registro        int,
@w_contador          int,
@w_fecha   datetime,
@w_tot_val_cca      money,
@w_maximo_cca       money

select
    @w_sp_name = 'sp_consulta_monetarias',
    @w_fecha = getdate()
  
  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  -- if @t_show_version = 1
  -- begin
    -- print 'Stored Procedure = ' + @w_sp_name + 'Version = ' + '4.0.0.0'
    -- return 0
  -- end
  
select @w_mes       = datepart ( month,   @i_param1 )
select @w_anio      = datepart ( year ,   @i_param1  )
select @w_dia       = '01'
select @w_fec_i = convert(varchar(2),@w_mes) + '/' + @w_dia + '/' + convert(varchar(4),@w_anio)
select @w_fec_inicial=  convert( datetime,@w_fec_i,101)

delete from cob_conta_super..sb_consulta_transacciones 
where ct_fecha = @i_param1
and ct_causa <> 'OPPR'
--and ct_usuario is null

select @w_id_mon_dolar = mo_moneda 
from  cobis..cl_moneda
WHERE  mo_nemonico ='USD' 

--Factor Conversión Pesos
SELECT @w_val_conv_pesos= ct_valor 
      FROM cob_conta..cb_cotizacion 
	  WHERE ct_moneda = @w_id_mon_dolar
	  AND ct_fecha=(select max(ct_fecha)
                      FROM cob_conta..cb_cotizacion
            where ct_moneda = @w_id_mon_dolar)
						
if @@rowcount <> 1
begin 
  exec cobis..sp_cerror
    @i_num = 111020,
    @i_msg = 'ERROR EN PARAMETRO CONVERSION PESOS'
  return 111020
end 

--MONTO MAXIMO AHORROS
SELECT @w_maximo_aho= pa_money 
      FROM cobis..cl_parametro  
	  WHERE pa_nemonico ='MAXVM'
      AND   pa_producto = 'AHO'

if @@rowcount <> 1
begin 
  exec cobis..sp_cerror
    @i_num = 111020,
    @i_msg = 'ERROR EN PARAMETRO SALDO MAXIMO CONVERSION PESOS'
  return 111020
end 	  

--MONTO MAXIMO CARTERA
SELECT @w_maximo_cca= pa_money 
      FROM cobis..cl_parametro  
	  WHERE pa_nemonico ='MAXVM'
      AND   pa_producto = 'CCA'

if @@rowcount <> 1
begin 
  exec cobis..sp_cerror
    @i_num = 111020,
    @i_msg = 'ERROR EN PARAMETRO SALDO MAXIMO CONVERSION PESOS'
  return 111020
end 	  

	     
 select @w_tot_val_aho  = @w_maximo_aho * @w_val_conv_pesos 
 select @w_tot_val_cca  = @w_maximo_cca * @w_val_conv_pesos 
 
 --fecha proceso
if @i_param1  is null 
  begin
    select @i_param1  = fp_fecha FROM cobis..ba_fecha_proceso
 end



create table #tmp_consultatransacciones (
        Secuencial          int IDENTITY(1,1),
        Codigo              int,          
		Nombre              varchar(35),    
	    Apellido            varchar(35),    
		Cuenta              varchar(16),    
        Saldo               money,    
	    Fecha               datetime,    
		Causa              varchar(10) ,   
		monto_transaccion   money,
        estado              char(1),
        origen              varchar(10),
        aplicativo          smallint,
        secuencial          int
		)
		
--TRANSACCIONES DE APERTURA DE CLIENTES CON REFERENCIAS INHIBITORIAS
insert into #tmp_consultatransacciones
 select	   dc_cliente, 		
           dc_nombre, 		
           dc_p_apellido, 		
           dp_banco,		
           dp_saldo_disponible, 		
           @i_param1,		
           'APER',
           null,
           null,
           in_origen,
           dp_aplicativo,
           null
FROM    cobis..cl_refinh, 
        cob_conta_super..sb_dato_cliente,
        cob_conta_super..sb_dato_pasivas	
where   dp_cliente         = dc_cliente
and     dc_ced_ruc         = in_ced_ruc
and     dc_tipo_ced        = in_tipo_ced
and     dp_fecha_apertura  = @i_param1
and		dp_fecha		   = @i_param1
--and     dp_aplicativo      = @i_param2
and  	((dc_fecha	 	   = @i_param1)
		or (dc_fecha=(select max(dc_fecha) from cob_conta_super..sb_dato_cliente where dc_cliente=dp_cliente)))         
if @@error <> 0
begin
exec cobis..sp_errorlog
   @i_param1       = @w_fecha,
   @i_error       = @@error,
   @i_usuario     = 'admuser',     
   @i_descripcion = 'ERROR EN TRANSACCIONES DE APERTURA DE CLIENTES CON REFERENCIAS INHIBITORIAS',
   @i_rollback    = 'S',
   @i_tran        = 0,
   @i_tran_name   = 'sp_consulta_monetarias'  
end

--TRANSACCIONES MONETARIAS DE DEPOSITO MAYOR AL PARAMETRO MAXVM
insert into #tmp_consultatransacciones
 select	   dc_cliente, 		
           dc_nombre, 		
           dc_p_apellido, 		
           dp_banco,		
           dp_saldo_disponible, 		
           @i_param1,		
           'OPRE',
           dd_monto,
           null,
           null,
           dp_aplicativo,
           dd_secuencial
FROM    cob_conta_super..sb_dato_cliente,
        cob_conta_super..sb_dato_pasivas,
		cob_conta_super..sb_dato_transaccion,		 
	    cob_conta_super..sb_dato_transaccion_det		
where   dp_cliente         = dc_cliente

and     dt_toperacion      = dd_toperacion
and     dt_banco           = dd_banco
and     dt_secuencial      = dd_secuencial
and     dd_banco           = dp_banco
and		((dp_fecha		   = @i_param1) 
		or (dp_fecha=(select max(dp_fecha) from sb_dato_pasivas where dp_banco=dd_banco)))
and  	((dc_fecha	 	   = @i_param1)
		or (dc_fecha=(select max(dc_fecha) from sb_dato_cliente where dc_cliente=dp_cliente))) 		
and     dd_toperacion      = dp_toperacion   
and     ((dt_tipo_trans      IN ('DEP') and dd_concepto = 'CAP') -- AHO
         or (dt_tipo_trans   IN ('APE', 'REN', 'INC') and dd_concepto in('EFMN'))) -- DPF
--and     dd_monto           > @w_tot_val_aho
and     dd_monto           > ( case dd_moneda when 2 then @w_maximo_cca  else @w_tot_val_aho end)
and     dd_fecha		   = dt_fecha_trans
and     dd_fecha           = @i_param1
--and     dp_aplicativo      = @i_param2
and     dp_banco           not in (select distinct Cuenta from #tmp_consultatransacciones)

if @@error <> 0
begin
exec cobis..sp_errorlog
   @i_param1       = @w_fecha,
   @i_error       = @@error,
   @i_usuario     = 'admuser',     
   @i_descripcion = 'ERROR EN TRANSACCIONES MONETARIAS DE DEPOSITO MAYOR AL PARAMETRO MAXVM',
   @i_rollback    = 'S',
   @i_tran        = 0,
   @i_tran_name   = 'sp_consulta_monetarias'  
end

--TRANSACCIONES PAGOS MAYORES 
insert into #tmp_consultatransacciones
 select	   dc_cliente, 		
           dc_nombre, 		
           dc_p_apellido, 		
           do_banco,		
           do_valor_cuota, 		
           @i_param1,		
           'OPRE',
           dd_monto,
           null,
           null,
           do_aplicativo,
           dd_secuencial
FROM    cob_conta_super..sb_dato_cliente,
        cob_conta_super..sb_dato_operacion,
		cob_conta_super..sb_dato_transaccion,		 
	    cob_conta_super..sb_dato_transaccion_det		
where   do_codigo_cliente  = dc_cliente
and     dt_tipo_trans      IN ('PAG')
and     dt_toperacion      = dd_toperacion
and     dt_banco           = dd_banco
and     dt_secuencial      = dd_secuencial
and     dd_banco           = do_banco
and		((do_fecha		   = @i_param1) 
		or (do_fecha=(select max(do_fecha) from sb_dato_operacion where do_banco=dd_banco)))
and  	((dc_fecha	 	   = @i_param1)
		or (dc_fecha=(select max(dc_fecha) from sb_dato_cliente where dc_cliente=do_codigo_cliente))) 		
and     dd_toperacion      = do_tipo_operacion   
and		dd_concepto		   = 'EFMN'
and     dd_monto           > ( case dd_moneda when 2 then @w_maximo_cca  else @w_tot_val_cca end)
--and     dd_monto           > @w_tot_val_cca
and     (dd_fecha		   = dt_fecha_trans or  dd_fecha = do_fecha)
--and     dd_fecha		   = dt_fecha_trans
and     dd_fecha           = @i_param1
--and     dp_aplicativo      = @i_param2
and     do_banco           not in (select distinct Cuenta from #tmp_consultatransacciones)
if @@error <> 0
begin
exec cobis..sp_errorlog
   @i_param1       = @w_fecha,
   @i_error       = @@error,
   @i_usuario     = 'admuser',     
   @i_descripcion = 'ERROR EN TRANSACCIONES MONETARIAS DE PAGO MAYOR AL PARAMETRO MAXVM',
   @i_rollback    = 'S',
   @i_tran        = 0,
   @i_tran_name   = 'sp_consulta_monetarias'  
end

--TRANSACCIONES MONETARIAS DE DEPOSITO DE CLIENTE INVOLUCRADO SE ENCUENTRA REGISTRADO EN LISTAS NEGRAS 
--O ES PEP(PERSONA POLITICAMENTE EXPUESTA)
insert into #tmp_consultatransacciones
 select	   dc_cliente, 		
           dc_nombre, 		
           dc_p_apellido, 		
           dp_banco,		
           dp_saldo_disponible, 		
           @i_param1,		
           'TRIN',
           dd_monto,
           null,
           in_origen,
           dp_aplicativo,
           dd_secuencial
FROM    cobis..cl_refinh,
        cob_conta_super..sb_dato_cliente,
        cob_conta_super..sb_dato_pasivas,
		cob_conta_super..sb_dato_transaccion,		 
	    cob_conta_super..sb_dato_transaccion_det		
where   dc_ced_ruc         = in_ced_ruc
and     dc_tipo_ced        = in_tipo_ced
and     dp_cliente         = dc_cliente
and     dt_toperacion      = dd_toperacion
and     dt_banco           = dd_banco
and     dt_secuencial      = dd_secuencial
and     dd_banco           = dp_banco
and		((dp_fecha		   = @i_param1) 
		or (dp_fecha=(select max(dp_fecha) from sb_dato_pasivas where dp_banco=dd_banco)))
and  	((dc_fecha	 	   = @i_param1)
		or (dc_fecha=(select max(dc_fecha) from sb_dato_cliente where dc_cliente=dp_cliente))) 		
and     dd_toperacion      = dp_toperacion   
and     ((dt_tipo_trans      IN ('DEP') and dd_concepto = 'CAP') -- AHO
         or (dt_tipo_trans   IN ('APE', 'REN', 'INC') and dd_concepto in('EFMN'))) -- DPF
--and     dd_monto           <= @w_tot_val_aho
and     dd_monto            <= ( case dd_moneda when 2 then @w_maximo_cca  else @w_tot_val_aho end)
and     dd_fecha		   = dt_fecha_trans
and     dd_fecha           = @i_param1
--and     dp_aplicativo      = @i_param2
and     dp_banco           not in (select distinct Cuenta from #tmp_consultatransacciones)
if @@error <> 0
begin
exec cobis..sp_errorlog
   @i_param1       = @w_fecha,
   @i_error       = @@error,
   @i_usuario     = 'admuser',     
   @i_descripcion = 'ERROR EN TRANSACCIONES MONETARIAS DE DEPOSITO MAYOR AL PARAMETRO MAXVM',
   @i_rollback    = 'S',
   @i_tran        = 0,
   @i_tran_name   = 'sp_consulta_monetarias'  
end

--TRANSACCIONES MONETARIAS DE PAGO DE CLIENTE INVOLUCRADO SE ENCUENTRA REGISTRADO EN LISTAS NEGRAS 
--O ES PEP(PERSONA POLITICAMENTE EXPUESTA)
insert into #tmp_consultatransacciones
 select	   dc_cliente, 		
           dc_nombre, 		
           dc_p_apellido, 		
           do_banco,		
           do_valor_cuota, 		
           @i_param1,		
           'TRIN',
           dd_monto,
           null,
           in_origen,
           do_aplicativo,
           dd_secuencial
FROM    cobis..cl_refinh,
        cob_conta_super..sb_dato_cliente,
        cob_conta_super..sb_dato_operacion,
		cob_conta_super..sb_dato_transaccion,		 
	    cob_conta_super..sb_dato_transaccion_det		
where   dc_ced_ruc         = in_ced_ruc
and     dc_tipo_ced        = in_tipo_ced
and     do_codigo_cliente         = dc_cliente
and     dt_tipo_trans      IN ('PAG')
and     dt_toperacion      = dd_toperacion
and     dt_banco           = dd_banco
and     dt_secuencial      = dd_secuencial
and     dd_banco           = do_banco
and		((do_fecha		   = @i_param1) 
		or (do_fecha=(select max(do_fecha) from sb_dato_operacion where do_banco=dd_banco)))
and  	((dc_fecha	 	   = @i_param1)
		or (dc_fecha=(select max(dc_fecha) from sb_dato_cliente where dc_cliente=do_codigo_cliente))) 		
and     dd_toperacion      = do_tipo_operacion   
and		dd_concepto		   =  'EFMN'
and     dd_monto           < ( case dd_moneda when 2 then @w_maximo_cca  else @w_tot_val_cca end)
--and     dd_monto           <= @w_tot_val_cca
and     (dd_fecha		   = dt_fecha_trans or  dd_fecha = do_fecha)
--and     dd_fecha		   = dt_fecha_trans
and     dd_fecha           = @i_param1
--and     dp_aplicativo      = @i_param2
and     do_banco           not in (select distinct Cuenta from #tmp_consultatransacciones)
if @@error <> 0
begin
exec cobis..sp_errorlog
   @i_param1       = @w_fecha,
   @i_error       = @@error,
   @i_usuario     = 'admuser',     
   @i_descripcion = 'ERROR EN TRANSACCIONES MONETARIAS DE PAGO MAYOR AL PARAMETRO MAXVM',
   @i_rollback    = 'S',
   @i_tran        = 0,
   @i_tran_name   = 'sp_consulta_monetarias'  
end

create table #tran_mon (          
		tm_banco              varchar(24),    
        tm_monto               money  
		)
--Se obtienen las transacciones sumarizadas del mes por cuenta
insert into #tran_mon
select	dp_banco,sum(dd_monto)       	
FROM    cob_conta_super..sb_dato_cliente,
        cob_conta_super..sb_dato_pasivas,
		cob_conta_super..sb_dato_transaccion,		 
	    cob_conta_super..sb_dato_transaccion_det
where   dp_cliente         = dc_cliente
and     dt_toperacion      = dd_toperacion
and     dt_banco           = dd_banco
and     dt_secuencial      = dd_secuencial
and     dd_banco           = dp_banco
and		((dp_fecha		   = @i_param1) 
		or (dp_fecha=(select max(dp_fecha) from sb_dato_pasivas where dp_banco=dd_banco)))
and  	((dc_fecha	 	   = @i_param1)
		or (dc_fecha=(select max(dc_fecha) from sb_dato_cliente where dc_cliente=dp_cliente))) 		
and     dd_toperacion      = dp_toperacion   
and     ((dt_tipo_trans      IN ('DEP') and dd_concepto = 'CAP') -- AHO
         or (dt_tipo_trans   IN ('APE', 'REN', 'INC') and dd_concepto in('EFMN'))) -- DPF
and     dd_fecha		   = dt_fecha_trans
--and     dd_fecha           > = @w_fec_i
and     dd_fecha           = @i_param1
--and     dd_fecha           <=  @i_param1
--and     dd_monto           < @w_tot_val_aho
and     dd_monto            < ( case dd_moneda when 2 then @w_maximo_cca  else @w_tot_val_aho end)
group by dp_banco
if @@error <> 0
begin
exec cobis..sp_errorlog
   @i_param1       = @w_fecha,
   @i_error       = @@error,
   @i_usuario     = 'admuser',     
   @i_descripcion = 'ERROR EN TRANSACCIONES SUMARIZADAS DEL MES POR CUENTA',
   @i_rollback    = 'S',
   @i_tran        = 0,
   @i_tran_name   = 'sp_consulta_monetarias'  
end

--Se obtienen las transacciones sumarizadas del mes por cuenta
insert into #tran_mon
select	do_banco,sum(dd_monto)       	
FROM    cob_conta_super..sb_dato_cliente,
        cob_conta_super..sb_dato_operacion,
		cob_conta_super..sb_dato_transaccion,		 
	    cob_conta_super..sb_dato_transaccion_det
where   do_codigo_cliente         = dc_cliente
and     dt_tipo_trans      IN ('PAG')
and     dt_toperacion      = dd_toperacion
and     dt_banco           = dd_banco
and     dt_secuencial      = dd_secuencial
and     dd_banco           = do_banco
and		((do_fecha		   = @i_param1) 
		or (do_fecha=(select max(do_fecha) from sb_dato_operacion where do_banco=dd_banco)))
and  	((dc_fecha	 	   = @i_param1)
		or (dc_fecha=(select max(dc_fecha) from sb_dato_cliente where dc_cliente=do_codigo_cliente))) 		
and     dd_toperacion      = do_tipo_operacion   
and		dd_concepto		   = 'EFMN'
and     (dd_fecha		   = dt_fecha_trans or  dd_fecha = do_fecha)
--and     dd_fecha		   = dt_fecha_trans
--and     dd_fecha           > = @w_fec_i
--and     dd_fecha           <=  @i_param1
and     dd_fecha           =  @i_param1
and     dd_monto           < ( case dd_moneda when 2 then @w_maximo_aho  else @w_tot_val_cca end)
--and     dd_monto           < @w_tot_val_cca
group by do_banco

if @@error <> 0
begin
exec cobis..sp_errorlog
   @i_param1       = @w_fecha,
   @i_error       = @@error,
   @i_usuario     = 'admuser',     
   @i_descripcion = 'ERROR EN TRANSACCIONES SUMARIZADAS DEL MES POR CUENTA',
   @i_rollback    = 'S',
   @i_tran        = 0,
   @i_tran_name   = 'sp_consulta_monetarias'  
end

--TRANSACCIONES DE DEPOSITO TOTALIZADAS POR MES MAYORES AL PARAMETRO
insert into #tmp_consultatransacciones
 select	   dc_cliente, 		
           dc_nombre, 		
           dc_p_apellido, 		
           dp_banco,		
           null, 		
           @i_param1,		
           'OPRF',
          tm_monto,
           null,
           null,
           dp_aplicativo,
           NULL
FROM    cob_conta_super..sb_dato_cliente,
        cob_conta_super..sb_dato_pasivas,
		#tran_mon
where   dp_cliente         = dc_cliente
and 	dp_banco			= tm_banco
and     tm_monto			> @w_tot_val_aho
--and     tm_monto			< @w_tot_val_aho
--and     dp_aplicativo      = @i_param2
and     dp_banco           not in (select distinct Cuenta from #tmp_consultatransacciones)
group by dp_banco, dc_cliente, dc_nombre, dc_p_apellido, tm_monto ,dp_aplicativo
if @@error <> 0
begin
exec cobis..sp_errorlog
   @i_param1       = @w_fecha,
   @i_error       = @@error,
   @i_usuario     = 'admuser',     
   @i_descripcion = 'ERROR EN TRANSACCIONES DE DEPOSITO TOTALIZADAS POR MES MAYORES AL PARAMETRO',
   @i_rollback    = 'S',
   @i_tran        = 0,
   @i_tran_name   = 'sp_consulta_monetarias'  
end

--TRANSACCIONES DE PAGO TOTALIZADAS POR MES MAYORES AL PARAMETRO
insert into #tmp_consultatransacciones
 select	   dc_cliente, 		
           dc_nombre, 		
           dc_p_apellido, 		
           do_banco,		
           null, 		
           @i_param1,		
           'OPRF',
          tm_monto,
           null,
           null,
           do_aplicativo,
           NULL
FROM    cob_conta_super..sb_dato_cliente,
        cob_conta_super..sb_dato_operacion,
		#tran_mon
where   do_codigo_cliente         = dc_cliente
and 	do_banco			= tm_banco
and     tm_monto			> @w_tot_val_cca
--and     tm_monto			< @w_tot_val_aho
--and     dp_aplicativo      = @i_param2
and     do_banco           not in (select distinct Cuenta from #tmp_consultatransacciones)
group by do_banco, dc_cliente, dc_nombre, dc_p_apellido, tm_monto ,do_aplicativo
if @@error <> 0
begin
exec cobis..sp_errorlog
   @i_param1       = @w_fecha,
   @i_error       = @@error,
   @i_usuario     = 'admuser',     
   @i_descripcion = 'ERROR EN TRANSACCIONES DE PAGO TOTALIZADAS POR MES MAYORES AL PARAMETRO',
   @i_rollback    = 'S',
   @i_tran        = 0,
   @i_tran_name   = 'sp_consulta_monetarias'  
end


--TRANSACCIONES DE DEPOSITO TOTALIZAS POR EL VALOR DEL PERFIL TRANSACCIONAL
insert into #tmp_consultatransacciones
 select	   dc_cliente, 		
           dc_nombre, 		
           dc_p_apellido, 		
           dp_banco,		
           null, 		
           @i_param1,		
           'OPIN',
          tm_monto,
           null,
           null,
           dp_aplicativo,
           null
FROM    cob_conta_super..sb_dato_cliente,
        cob_conta_super..sb_dato_pasivas,
		#tran_mon
where   dp_cliente         = dc_cliente
and 	dp_banco			= tm_banco
and     tm_monto			> dc_perf_tran
--and     dp_aplicativo      = @i_param2
and     dp_banco           not in (select distinct Cuenta from #tmp_consultatransacciones)
group by dp_banco, dc_cliente, dc_nombre, dc_p_apellido, tm_monto, dp_aplicativo
if @@error <> 0
begin
exec cobis..sp_errorlog
   @i_param1       = @w_fecha,
   @i_error       = @@error,
   @i_usuario     = 'admuser',     
   @i_descripcion = 'ERROR EN TRANSACCIONES DE DEPOSITO TOTALIZAS POR EL VALOR DEL PERFIL TRANSACCIONAL',
   @i_rollback    = 'S',
   @i_tran        = 0,
   @i_tran_name   = 'sp_consulta_monetarias'  
end

--TRANSACCIONES DE PAGO TOTALIZAS POR EL VALOR DEL PERFIL TRANSACCIONAL
insert into #tmp_consultatransacciones
 select	   dc_cliente, 		
           dc_nombre, 		
           dc_p_apellido, 		
           do_banco,		
           null, 		
           @i_param1,		
           'OPIN',
          tm_monto,
           null,
           null,
           do_aplicativo,
           null
FROM    cob_conta_super..sb_dato_cliente,
        cob_conta_super..sb_dato_operacion,
		#tran_mon
where   do_codigo_cliente         = dc_cliente
and 	do_banco			= tm_banco
and     tm_monto			> dc_perf_tran
--and     dp_aplicativo      = @i_param2
and     do_banco           not in (select distinct Cuenta from #tmp_consultatransacciones)
group by do_banco, dc_cliente, dc_nombre, dc_p_apellido, tm_monto, do_aplicativo
if @@error <> 0
begin
exec cobis..sp_errorlog
   @i_param1       = @w_fecha,
   @i_error       = @@error,
   @i_usuario     = 'admuser',     
   @i_descripcion = 'ERROR EN TRANSACCIONES DE PAGO TOTALIZAS POR EL VALOR DEL PERFIL TRANSACCIONAL',
   @i_rollback    = 'S',
   @i_tran        = 0,
   @i_tran_name   = 'sp_consulta_monetarias'  
end

select @w_maximo = count(*) from #tmp_consultatransacciones
select @w_contador = 0

while @w_maximo <> @w_contador
begin
select @w_max_registro = isnull(max(ct_secuencial),0) + 1 from sb_consulta_transacciones 

select @w_registro = Secuencial from #tmp_consultatransacciones where estado is null

insert into sb_consulta_transacciones
select  @w_max_registro, --indice
        Codigo,
		Nombre,
	    Apellido,
		Cuenta,--indice
        Saldo,
	    Fecha,--indice
		Causa,
		isnull(monto_transaccion,0),
        'G',
        NULL,
        NULL,
        'N',
        NULL,
        origen,
        aplicativo,
        secuencial
		from #tmp_consultatransacciones
        Where Secuencial = @w_registro
if @@error <> 0
begin
exec cobis..sp_errorlog
   @i_fecha       = @w_fecha,
   @i_error       = @@error,
   @i_usuario     = 'admuser',     
   @i_descripcion = 'ERROR EN INSERCCION TABLA SB_CONSULTA_TRANSACCIONES',
   @i_rollback    = 'N',
   @i_tran        = 0,
   @i_tran_name   = 'sp_consulta_monetarias'  

update #tmp_consultatransacciones set estado = 'E'
where Secuencial = @w_registro
   
end        

update #tmp_consultatransacciones set estado = 'F'
where Secuencial = @w_registro
        
select @w_contador = @w_contador + 1        
end       

return 0
go

