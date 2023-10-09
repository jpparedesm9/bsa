/***********************************************************************/
/*      Archivo:                        ConsultaTransMonetarias.sql    */
/*      Stored procedure:               sp_consulta_monetarias         */
/*      Base de Datos:                  cob_externos                   */
/*      Producto:                       Clientes                       */
/***********************************************************************/
/*                      IMPORTANTE                                     */
/*      Este programa es parte de los paquetes bancarios propiedad de  */
/*      "MACOSA",representantes exclusivos para el Ecuador de la       */
/*      AT&T                                                           */
/*      Su uso no autorizado queda expresamente prohibido asi como     */
/*      cualquier autorizacion o agregado hecho por alguno de sus      */
/*      usuario sin el debido consentimiento por escrito de la         */
/*      Presidencia Ejecutiva de MACOSA o su representante             */
/***********************************************************************/
/*                      PROPOSITO                                      */
/* Realiza consulta de transacciones monetarias y clientes con ref     */
/* Inhibitorias                                                         */
/***********************************************************************/

use cob_externos
go

if exists(select * from sysobjects where name = 'sp_consulta_monetarias')
   drop proc sp_consulta_monetarias
go

create proc sp_consulta_monetarias(
    @s_ssn           int         = null,
    @s_ssn_branch    int         = null,
    @s_srv           varchar(30) = null,
    @s_lsrv          varchar(30) = null,
    @s_user          varchar(30) = null,
    @s_sesn          int         = null,
    @s_term          varchar(10) = null,
    @s_date          datetime    = null,
    @s_ofi           smallint    = null,
    @s_rol           smallint    = 1,
    @s_org_err       char(1)     = null,
    @s_error         int         = null,
    @s_sev           tinyint     = null,
    @s_msg           varchar(64) = null,
    @s_org           char(1)     = null,
    @t_debug         char(1)     = 'N',
    @t_file          varchar(14) = null,
    @t_from          varchar(32) = null,
    @t_rty           char(1)     = 'N',
    @t_show_version  bit         = 0,  
    @t_trn           smallint    = null,
	@i_fecha         datetime    = null,
	@i_aplicativo	 smallint    = null

)
 as declare

@w_fecha_proceso    datetime,
@w_pais             int,
@w_id_mon_dolar     int,
@w_val_conv_pesos   money,
@w_tot_val_total    money,
@w_monto_maximo     money,
@w_sp_name          varchar(255),
@w_dia             char(2),
@w_anio            char(4),
@w_mes             char(2),
@w_fec_inicial     datetime,
@w_fec_i           varchar(12)


select
    @w_sp_name = 'sp_consulta_monetarias'
  
  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure = ' + @w_sp_name + 'Version = ' + '4.0.0.0'
    return 0
  end
  
select @w_mes       = datepart ( month,   @i_fecha )
select @w_anio      = datepart ( year ,   @i_fecha  )
select @w_dia       = '01'
select @w_fec_i = convert(varchar(2),@w_mes) + '/' + @w_dia + '/' + convert(varchar(4),@w_anio)
select @w_fec_inicial=  convert( datetime,@w_fec_i,101)


select @w_id_mon_dolar = mo_moneda 
from  cobis..cl_moneda
WHERE  mo_nemonico ='USD' 

--Factor Conversión Pesos
SELECT @w_val_conv_pesos= ct_factor1 
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

--MONTO MAXIMO
SELECT @w_monto_maximo= pa_money 
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
	     
 select @w_tot_val_total  = @w_monto_maximo * @w_val_conv_pesos 
 
 --fecha proceso
if @i_fecha  = null 
  begin
    select @i_fecha  = fp_fecha FROM cobis..ba_fecha_proceso
 end



create table #tmp_consultatransacciones (
        Codigo              int,          
		Nombre              varchar(35),    
	    Apellido            varchar(35),    
		Cuenta              varchar(16),    
        Saldo               money,    
	    Fecha               datetime,    
		Causa              varchar(10) ,   
		monto_transaccion   money  
		)
		
--TRANSACCIONES DE APERTURA DE CLIENTES CON REFERENCIAS Inhibitorias
insert into #tmp_consultatransacciones
 select	   dc_cliente, 		
           dc_nombre, 		
           dc_p_apellido, 		
           dp_banco,		
           dp_saldo_disponible, 		
           @i_fecha,		
           'APER',
           null		       		
FROM    cob_externos..cl_refinh_mig, 
        cob_conta_super..sb_dato_cliente,
        cob_conta_super..sb_dato_pasivas	
where   dp_cliente         = dc_cliente
and     dc_ced_ruc         = in_ced_ruc
and     dc_tipo_ced        = in_tipo_ced
and     dp_fecha_apertura  = @i_fecha

--TRANSACCIONES MONETARIAS DE DEPOSITO MAYOR AL PARAMETRO MAXVM
insert into #tmp_consultatransacciones
 select	   dc_cliente, 		
           dc_nombre, 		
           dc_p_apellido, 		
           dp_banco,		
           dp_saldo_disponible, 		
           @i_fecha,		
           dt_tipo_trans,
           dd_monto	       		
FROM    cob_conta_super..sb_dato_cliente,
        cob_conta_super..sb_dato_pasivas,
		cob_conta_super..sb_dato_transaccion,		 
	    cob_conta_super..sb_dato_transaccion_det		
where   dp_cliente         = dc_cliente
and     dt_tipo_trans      IN ('DEP')
and     dt_toperacion      = dd_toperacion
and     dt_banco           = dd_banco
and     dt_secuencial      = dd_secuencial
and     dd_banco           = dp_banco
and     dd_toperacion      = dp_toperacion   
and		dd_concepto		   ='CAP'
and     dd_monto           > @w_tot_val_total
and     dd_fecha		   = dt_fecha_trans
and     dd_fecha           = @i_fecha


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
and     dt_tipo_trans      IN ('DEP')
and     dt_toperacion      = dd_toperacion
and     dt_banco           = dd_banco
and     dt_secuencial      = dd_secuencial
and     dd_banco           = dp_banco
and     dd_toperacion      = dp_toperacion   
and		dd_concepto		   ='CAP'
and     dd_fecha		   = dt_fecha_trans
and     dd_fecha           > = @w_fec_i
and     dd_fecha           <=  @i_fecha
group by dp_banco

--TRANSACCIONES DE DEPOSITO TOTALIZADAS POR MES MAYORES AL PARAMETRO
insert into #tmp_consultatransacciones
 select	   dc_cliente, 		
           dc_nombre, 		
           dc_p_apellido, 		
           dp_banco,		
           null, 		
           @i_fecha,		
           'OPRE',
          tm_monto	       		
FROM    cob_conta_super..sb_dato_cliente,
        cob_conta_super..sb_dato_pasivas,
		#tran_mon
where   dp_cliente         = dc_cliente
and 	dp_banco			= tm_banco
and     tm_monto			> @w_tot_val_total
group by dp_banco, dc_cliente, dc_nombre, dc_p_apellido, tm_monto


----TRANSACCIONES DE DEPOSITO TOTALIZAS POR EL VALOR DEL PERFIL TRANSACCIONAL
insert into #tmp_consultatransacciones
 select	   dc_cliente, 		
           dc_nombre, 		
           dc_p_apellido, 		
           dp_banco,		
           null, 		
           @i_fecha,		
           'OPIN',
          tm_monto	       		
FROM    cob_conta_super..sb_dato_cliente,
        cob_conta_super..sb_dato_pasivas,
		#tran_mon
where   dp_cliente         = dc_cliente
and 	dp_banco			= tm_banco
and     tm_monto			> dc_perf_tran
group by dp_banco, dc_cliente, dc_nombre, dc_p_apellido, tm_monto

select  Codigo,
		Nombre,
	    Apellido,
		Cuenta,
        Saldo,
	    Fecha,
		Causa,
		monto_transaccion
		from #tmp_consultatransacciones
      
return 0
go

