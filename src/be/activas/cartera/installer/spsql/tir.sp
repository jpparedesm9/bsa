/************************************************************************/
/*      Archivo:                tir.sp                                  */
/*      Stored Procedure:       sp_tir                                  */
/*      Base de datos:          cob_cartera                             */
/*      Producto:               Cartera                                 */
/*      Disenado por:           Luis Castellanos                        */
/*      Fecha de escritura:     21/JUL/2007                            */
/************************************************************************/
/*                              IMPORTANTE                              */
/*      Este programa es parte de los paquetes bancarios propiedad de   */
/*      "MACOSA" del Ecuador.                                           */
/*      Su uso no autorizado queda expresamente prohibido asi como      */
/*      cualquier alteracion o agregado hecho por alguno de sus         */
/*      usuarios sin el debido consentimiento por escrito de la         */
/*      Presidencia Ejecutiva de MACOSA o su representante.             */
/************************************************************************/
/*                              PROPOSITO                               */
/*      Calculo de la Tasa Interna de Retorno (TIR)                     */
/************************************************************************/
/*                             MODIFICACION                             */
/*    FECHA                 AUTOR                 RAZON                 */
/*    21/Jul/07             LCA                   Emision Inicial       */
/*    08/Mar/19             SRO                   Mejoras y CrÃ©dito Rev */
/*    20/Sep/19             ACH                   ValCat en base a tabla*/
/*    05/Ago/2021           WCA                   Req #161141_2         */
/*    05/Oct/2021           DGA                   Req 142165            */
/************************************************************************/
use cob_cartera
go
 
if exists (select * from sysobjects where name = 'sp_tir')
   drop proc sp_tir
go
 
create proc sp_tir
   @i_operacionca         int         = null,
   @i_banco               varchar(32) = null,
   @i_desacumula          char(1)     = null,
   @i_id_inst_proc        int         = null,
   @i_considerar_iva      char(1)     = 'S',
   @i_tasa				  money		  = null,	--Req. 142165
   @o_cat                 float out,
   @o_tir                 float out,
   @o_tea                 float       = null out
as

declare
@w_sp_name              varchar(30),
@w_tir                  float,
@w_tir1                 float,
@w_tir2                 float,
@w_tir3                 float,
@w_saldo_desde          float,
@w_saldo_hasta          float,
@w_cap                  catalogo,
@w_tipo_rubro           char(1),
@w_monto                money,
@w_dividendo            smallint,
@w_cuota                money,
@w_periodo_dias         int,
@w_tasa                 float,
@w_sdg                  varchar(10),
@w_sho                  varchar(10),
@w_sag                  varchar(10),
@w_aad                  varchar(10),
@w_vpn1                 float,
@w_vpn2                 float,
@w_sumar                float,
@w_flag                 tinyint,
@w_intentos             int,
@w_seguro               money,
@w_seguro2              money,
@w_seguro3              money,
@w_solca                money,
@w_operacionca          int,
@w_desacumula_seg       char(1),
@w_deuda                money,
@w_tea                  float,
@w_monto_op             money,
@w_monto_sol            money,
@w_anticipados          money,
@w_financiados          money,
@w_int_anticipados      money,
@w_plazo_dias           money,
@w_valor_aad            money,
@w_sector               varchar(10),
@w_plazo_total          int, 
@w_periodica            char(1),
@w_pprom                int,
@w_fecha_desde          datetime,
@w_gracia_cap           smallint,
@w_gracia_int           smallint,
@w_var                  money ,
@w_periodo              float,
@w_toperacion           varchar(25),
@w_comisiones           money,
@w_fecha_proceso        datetime,
@w_plazo                int,
@w_tipo_plazo           char(4),
@w_tdividendo           char(4),
@w_periodo_cap          int,
@w_periodo_int          int,
@w_dia_pago             int,
@w_resultado_monto      varchar(255),
@w_tasa_int             varchar(255),
@w_tasa_com             varchar(255),
@w_periodicidad         char(4),
@w_error                int,
@w_msg                  varchar(255),
@w_valor_variable_regla varchar(255),
@w_tipo_amortizacion    varchar(10),
@w_es_lcr              char(1),
@w_com                float ,

-- Req. 161141 parametria ajustes regla --
@w_param_colectivo          varchar(30),  
@w_param_nivel_colectivos   varchar(30),
@w_tipo_mercado             varchar(30),
@w_nivel_cliente            varchar(30),



/* Parmetros por defecto Colectivo + nivel de colectivo */

@w_cliente                  int,

-- Req 142165 CAT 
@w_id_cliente			int, 			--Req. 142165
@w_tasa_lcr				money			--Req. 142165



select @w_param_colectivo =  pa_char from cobis..cl_parametro WHERE pa_nemonico = 'CDDFCL'
select @w_param_nivel_colectivos =  pa_char from cobis..cl_parametro WHERE pa_nemonico = 'CDDFNC'
select @w_cliente =  io_campo_1 from cob_workflow..wf_inst_proceso where io_id_inst_proc = @i_id_inst_proc

select 
@w_tipo_mercado = ea_colectivo ,
@w_nivel_cliente = ea_nivel_colectivo
from cobis..cl_ente_aux 
where ea_ente  = @w_cliente


select 
@w_sp_name        = 'sp_tir',
@w_intentos       = 0,
@w_tir1           = 0,
@w_tir2           = 1,
@w_tipo_rubro     = null,
@w_desacumula_seg = isnull(@i_desacumula,'S'),
@w_periodica      = 'S',
@w_var            = 1.0,
@w_comisiones     = 0,
 @w_es_lcr         ='N'

select @w_fecha_proceso  = fp_fecha
from cobis..ba_fecha_proceso




if @i_id_inst_proc is not null begin
   
   select @w_periodicidad =  tr_periodicidad_lcr
   from cob_workflow..wf_inst_proceso,  cob_credito..cr_tramite
   where io_campo_3 = tr_tramite
   and   io_campo_4 = 'REVOLVENTE' 
   and   io_id_inst_proc = @i_id_inst_proc
   
   if @@rowcount = 0 begin
      select 
      @w_error = 1111,
      @w_msg   = 'NO EXISTE LA INSTANCIA DE PROCESO'
      return @w_error
   end
   
   select 
   @w_plazo               =  52,
   @w_tipo_plazo          = 'W',
   @w_tdividendo          = 'W',
   @w_periodo_cap         =  1,
   @w_periodo_int         =  1,
   @w_dia_pago            =  2,
   @w_tipo_amortizacion   = 'ROTATIVA'
      
   if @w_periodicidad = 'BW' begin --BISEMANAL
      select 
      @w_plazo            =52,
      @w_tipo_plazo       ='W',
      @w_tdividendo       ='W',
      @w_periodo_cap      =2,
      @w_periodo_int      =2,
      @w_dia_pago         =2
   end 
   
   if @w_periodicidad = 'M' begin --MENSUAL
      select 
      @w_plazo            =12,
      @w_tipo_plazo       ='M',
      @w_tdividendo       ='M',
      @w_periodo_cap      =1,
      @w_periodo_int      =1,
      @w_dia_pago         =5
   end 
   
   select @w_plazo_dias = @w_plazo * td_factor
   from ca_tdividendo
   where td_tdividendo = @w_tipo_plazo

   select @w_periodo_dias = @w_periodo_int * td_factor
   from ca_tdividendo
   where td_tdividendo = @w_tdividendo

   exec @w_error       = cob_cartera..sp_ejecutar_regla
   @s_ssn              = 11111,
   @s_ofi              = 1,
   @s_user             = 'admuser',
   @s_date             = @w_fecha_proceso,
   @s_srv              = 'CTSSRV',
   @s_term             = 'TERM01',
   @s_rol              = 1,
   @s_lsrv             = 'CTSSRV',
   @s_sesn             =  11112,
   @i_regla            = 'LCRCUPINI',    
   @i_id_inst_proc     = @i_id_inst_proc,
   @o_resultado1       = @w_resultado_monto out    
   
   if @w_error <> 0 or @w_resultado_monto is null begin 
      select @w_msg = 'ERROR AL EJECUTAR REGLA DE MONTO INICIAL' 
      goto ERROR_FIN
   end 
   
   exec @w_error       = cob_cartera..sp_ejecutar_regla
   @s_ssn              = 11111,
   @s_ofi              = 1,
   @s_user             = 'admuser',
   @s_date             = @w_fecha_proceso,
   @s_srv              = 'CTSSRV',
   @s_term             = 'TERM01',
   @s_rol              = 1,
   @s_lsrv             = 'CTSSRV',
   @s_sesn             =  11112,
   @i_regla            = 'LCRTINT',    
   @i_id_inst_proc     = @i_id_inst_proc,
   @o_resultado1       = @w_tasa_int out 
   
   
   if @w_error <> 0  or @w_tasa_int is null begin
      select @w_msg = 'ERROR AL EJECUTAR REGLA DE TASA DE INTERES' 
      goto ERROR_FIN
   end 

   select @w_valor_variable_regla = isnull(@w_tipo_mercado, @w_param_colectivo) + '|' + isnull(@w_nivel_cliente, @w_param_nivel_colectivos ) + '|' + convert(varchar,@w_resultado_monto)

   --print 'Valor @w_valor_variable_regla >>'
   --print @w_valor_variable_regla

   exec @w_error           = cob_cartera..sp_ejecutar_regla
   @s_ssn                  = 11111,
   @s_ofi                  = 1,
   @s_user                 = 'admuser',
   @s_date                 = @w_fecha_proceso,
   @s_srv                  = 'CTSSRV',
   @s_term                 = 'TERM01',
   @s_rol                  = 1,
   @s_lsrv                 = 'CTSSRV',
   @s_sesn                 =  11112,
   @i_regla                = 'LCRPORCOM', 
   @i_tipo_ejecucion       = 'REGLA',	 
   @i_valor_variable_regla = @w_valor_variable_regla,
   @o_resultado1           = @w_tasa_com out 
   
   
   if @w_error <> 0  or @w_tasa_com is null begin
      select @w_msg = 'ERROR AL EJECUTAR REGLA PORCENTAJE DE COMISION' 
      goto ERROR_FIN
   end 
   
   --print ' Valor @w_tasa_com de la regla LCRPORCOM>>'
   --print @w_tasa_com
   

   /* DETERMIANAR SI EXISTE UN CAT PARA ESTA CONFIGURACI�N DE PRESTAMO */

   select @o_cat = ct_cat 
   from   ca_cat
   where  ct_tipo_tabla    = @w_tipo_amortizacion
   and    ct_tasa_interes  = @w_tasa_int
   and    ct_tasa_comision = @w_tasa_com
   and    ct_periodicidad  = @w_periodo_dias

   if @@rowcount <> 0 return 0  -- Si existe salir.
  
   
   select top 1 *
   into #tmp_prestamo
   from ca_operacion
   
   update #tmp_prestamo set 
   op_toperacion        = 'REVOLVENTE',
   op_plazo             = @w_plazo,
   op_tplazo            = @w_tipo_plazo,
   op_periodo_int       = @w_periodo_int,
   op_tdividendo        = @w_tdividendo ,
   op_monto_aprobado    = convert(money,@w_resultado_monto),
   op_fecha_ini         = @w_fecha_proceso,
   op_operacion         = (@i_id_inst_proc * -1),
   op_banco             = convert(varchar,(@i_id_inst_proc * -1)),
   op_monto             = 0.0,
   op_gracia_cap        = 0,
   op_gracia_int        = 0,
   op_tipo_amortizacion = @w_tipo_amortizacion
   
   select top 1 * 
   into #tmp_rubro_op
   from ca_rubro_op
   where ro_concepto = 'INT'
   
   update #tmp_rubro_op set
   ro_porcentaje = convert(float,@w_tasa_int),
   ro_operacion  = (@i_id_inst_proc * -1)   
   
   insert into #tmp_rubro_op
   select top 1 *
   from ca_rubro_op
   where ro_concepto = 'COM'
   
   update #tmp_rubro_op set
   ro_porcentaje = convert(float,@w_tasa_com),
   ro_operacion  = (@i_id_inst_proc * -1)
   where ro_concepto = 'COM'
   
   if @i_considerar_iva = 'S' begin
      insert into #tmp_rubro_op
      select top 1 *
      from ca_rubro_op
      where ro_concepto = 'IVA_COM'   
      
      update #tmp_rubro_op set
      ro_operacion  = (@i_id_inst_proc * -1)
      where ro_concepto = 'IVA_COM'   
   end
   
   delete ca_operacion where op_operacion = (@i_id_inst_proc * -1)
   delete ca_rubro_op  where ro_operacion = (@i_id_inst_proc * -1)
   
   insert into ca_operacion select * from #tmp_prestamo
   insert into ca_rubro_op  select * from #tmp_rubro_op
   
   select 
   @i_banco = null, 
   @i_operacionca = (@i_id_inst_proc * -1)
   
end


if @i_banco is null begin

   select 
   @w_monto_op    = op_monto,
   @w_monto_sol   = op_monto,
   @w_tipo_plazo  = op_tplazo,
   @w_tdividendo  = op_tdividendo,
   @w_plazo       = op_plazo,
   @w_periodo_cap = op_periodo_cap,
   @w_periodo_int = op_periodo_int,
   @w_operacionca = op_operacion,
   @w_deuda       = op_monto,
   @w_sector      = op_sector,
   @w_plazo_total = datediff(dd,op_fecha_ini,op_fecha_fin),
   @w_fecha_desde = op_fecha_ini,
   @w_gracia_cap  = op_gracia_cap,
   @w_gracia_int  = op_gracia_int,
   @w_toperacion  = op_toperacion,
   @w_tipo_amortizacion = op_tipo_amortizacion,
   @w_tdividendo  = op_tdividendo,
   @w_id_cliente  = op_cliente		--Req. 142165
   from ca_operacion
   where op_operacion    = @i_operacionca

end else begin

   select 
   @w_monto_op    = op_monto,
   @w_monto_sol   = op_monto,
   @w_tipo_plazo  = op_tplazo,
   @w_tdividendo  = op_tdividendo,
   @w_plazo       = op_plazo,
   @w_periodo_cap = op_periodo_cap,
   @w_periodo_int = op_periodo_int,
   @w_operacionca = op_operacion,
   @w_deuda       = op_monto,
   @w_sector      = op_sector,
   @w_plazo_total = datediff(dd,op_fecha_ini,op_fecha_fin),
   @w_fecha_desde = op_fecha_ini,
   @w_gracia_cap  = op_gracia_cap,
   @w_gracia_int  = op_gracia_int,
   @w_toperacion  = op_toperacion,
   @w_tipo_amortizacion = op_tipo_amortizacion,
   @w_tdividendo  = op_tdividendo,
   @w_id_cliente  = op_cliente	
   from ca_operacion
   where op_banco    = @i_banco

end

if @w_operacionca is null return 0

select @w_plazo_dias = @w_plazo * td_factor
from ca_tdividendo
where td_tdividendo = @w_tipo_plazo

select @w_periodo_dias = @w_periodo_int * td_factor
from ca_tdividendo
where td_tdividendo = @w_tdividendo


if @w_tipo_amortizacion = 'ROTATIVA' begin
   
  

   if @i_id_inst_proc is null begin

      select @w_tasa_int = ro_porcentaje 
      from   ca_rubro_op 
      where  ro_operacion = @w_operacionca
      and    ro_concepto = 'INT'
		
      select @w_com = ro_porcentaje 
      from   ca_rubro_op 
      where  ro_operacion = @w_operacionca
      and    ro_concepto = 'COM'
	  
	  select @w_tasa_com = @w_com
	  
	  if @w_com is null select @w_tasa_com = 3
	  
	 /*Req.142165 - Si la periodicidad @w_periodicidad es null*/
	  select @w_periodicidad = @w_tdividendo  

   end

   select @o_cat = ct_cat 
   from   ca_cat
   where  ct_tipo_tabla    = @w_tipo_amortizacion
   and    ct_tasa_interes  = @w_tasa_int
   and    ct_tasa_comision = @w_tasa_com
   and    ct_periodicidad  = @w_periodo_dias

   if @@rowcount <> 0 return 0
   select @w_tasa_com = isnull( @w_tasa_com,3)
  
  --Req. 142165

   if @w_tipo_mercado IS NULL BEGIN			--verificar si el cliente es independiente o candidato
	  IF EXISTS (select 1 from cob_cartera..ca_operacion where op_cliente = @w_id_cliente 
				and op_toperacion = 'REVOLVENTE')
	  OR EXISTs ( SELECT 1 FROM cob_credito..cr_tramite_grupal where tg_cliente = @w_id_cliente)
		SELECT @w_tipo_mercado = 'CC'
	  ELSE
		SELECT @w_tipo_mercado = 'I'
   END
   
   select @w_tasa_lcr = isnull(@i_tasa, @w_tasa_int) 
   --FIN Req. 142165
   
   exec @w_error = sp_crea_tab_americana
   @i_opcion      = 'I',
   @i_factor      = 'S',
   @i_comision    = @w_tasa_com,
   @i_operacionca = @w_operacionca,
   @i_tipo_mercado 		= @w_tipo_mercado,	--Req.142165
   @i_tasa_lcr			= @w_tasa_lcr,		--Req.142165
   @i_periodicidad_lcr 	= @w_periodicidad,	--Req.142165
   @o_operacionca = @w_operacionca out
    
   if @w_error <> 0  begin	 --Req.142165
      select @w_msg = 'ERROR AL EJECUTAR SP TABLA AMERICANA' 
      goto ERROR_FIN
   end
      
	
   select 
   @w_monto_op    = op_monto,
   @w_monto_sol   = op_monto,
   @w_periodo_dias= op_periodo_int * a.td_factor,
   @w_operacionca = op_operacion,
   @w_deuda       = op_monto,
   @w_plazo_dias  = op_plazo * b.td_factor,
   @w_sector      = op_sector,
   @w_plazo_total = datediff(dd,op_fecha_ini,op_fecha_fin),
   @w_fecha_desde = op_fecha_ini,
   @w_gracia_cap  = op_gracia_cap,
   @w_gracia_int  = op_gracia_int,
   @w_toperacion  = op_toperacion
   from ca_operacion, ca_tdividendo a, ca_tdividendo b
   where a.td_tdividendo = op_tdividendo
   and b.td_tdividendo = op_tplazo
   and   op_operacion  = @w_operacionca
   
	
   select @w_comisiones = @w_monto_op * ro_porcentaje/100
   from ca_rubro_op
   where ro_operacion = @w_operacionca
   and   ro_concepto  = 'COM'
	
	--no considerar 
   /*select @w_comisiones = @w_comisiones + (@w_comisiones*ro_porcentaje/100)
   from ca_rubro_op
   where ro_operacion = @w_operacionca
   and   ro_concepto  = 'IVA_COM'*/
   
   select @w_periodo = @w_plazo_dias / @w_periodo_dias
	
end else begin -- para las no rotativas

   select @o_cat = 128.738607654485 
   return 0

end

select @w_periodo = periodo
from tasas_periodos 
where tdivi = @w_periodo_dias
  

if (select count(1) from ca_dividendo where di_operacion = @w_operacionca) = 1 
   select @w_plazo_dias = @w_plazo_total, @w_periodo_dias = @w_plazo_total
else begin
   if exists (select 1 from ca_dividendo where di_operacion = @w_operacionca 
              and datediff(dd,di_fecha_ini,di_fecha_ven) <> @w_periodo_dias) 
   OR    (@w_gracia_cap > 0 or @w_gracia_int > 0)
      select @w_periodica = 'N', @w_var = 0.01 
end

/* BUSCAR RUBRO CAPITAL */
select @w_cap = ro_concepto
from ca_rubro_op
where ro_operacion  = @w_operacionca
and   ro_fpago      = 'P'
and   ro_tipo_rubro = 'C' 

/* BUSCAR RUBRO SDG */
select @w_sdg = ro_concepto
from ca_rubro_op
where ro_operacion  = @w_operacionca
and   ro_fpago      = 'F'
and   ro_concepto   = 'SDG' 

select @w_sho = ro_concepto
from ca_rubro_op
where ro_operacion  = @w_operacionca
and   ro_fpago      = 'F'
and   ro_concepto   = 'SEGHO' 

select @w_sag = ro_concepto
from ca_rubro_op
where ro_operacion  = @w_operacionca
and   ro_fpago      = 'F'
and   ro_concepto   = 'SEGAGRI' 

/* BUSCAR RUBRO AAD */
select @w_valor_aad = ro_valor
from ca_rubro_op
where ro_operacion  = @w_operacionca
and   ro_fpago      = 'L'
and   ro_concepto   = 'AAD' 

/* BUSCAR TASA INTERES */
select @w_tasa = ro_porcentaje
from ca_rubro_op
where ro_operacion  = @w_operacionca
and   ro_concepto   = 'INT' 

select @w_seguro = ro_valor
from ca_rubro_op
where ro_operacion = @w_operacionca
and ro_concepto  = @w_sdg
and ro_fpago     = 'F'

select @w_seguro2 = ro_valor
from ca_rubro_op
where ro_operacion = @w_operacionca
and ro_concepto    = @w_sho
and ro_fpago       = 'F'

select @w_seguro3 = ro_valor
from ca_rubro_op
where ro_operacion = @w_operacionca
and ro_concepto    = @w_sag
and ro_fpago       = 'F'

select @w_seguro = isnull(@w_seguro,0)+isnull(@w_seguro2,0)+isnull(@w_seguro3,0)

select @w_solca = ro_valor
from ca_rubro_op
where ro_operacion = @w_operacionca
and ro_concepto    = 'SOLCA'
and ro_fpago       = 'F'

select 
@w_seguro = isnull(@w_seguro,0),
@w_solca  = isnull(@w_solca,0)

select @w_financiados = isnull(sum(ro_valor),0)
from ca_rubro_op
where ro_operacion = @w_operacionca
and   ro_fpago     = 'F'

select @w_anticipados = isnull(sum(ro_valor) ,0)
from ca_rubro_op 
where ro_operacion = @w_operacionca 
and  ro_fpago      = 'L' 
and  ro_concepto   <> 'SOLCA'

select @w_int_anticipados = isnull(sum(am_cuota),0) 
from ca_amortizacion, ca_rubro_op 
where am_operacion =  @w_operacionca 
and ro_operacion   =  am_operacion
and ro_concepto    =  am_concepto 
and ro_concepto    =  'INT'
and ro_fpago       in ('T')
   
if @w_int_anticipados > 0 select @w_desacumula_seg = 'A'


select @w_monto = @w_monto_op - isnull(@w_anticipados,0) - isnull(@w_int_anticipados,0) - @w_financiados + isnull(@w_valor_aad,0) - @w_comisiones

if @w_plazo_dias = @w_periodo_dias and @w_periodo_dias <= 360 
BEGIN
	select @w_tir1 = convert(float,@w_tasa / (360/@w_periodo_dias*100.00))
END	
else
	if @w_periodica = 'S' 
	BEGIN
	
		select @w_tir1 = convert(float,@w_tasa / (@w_periodo*100.00))
		
	END
	else 
	BEGIN 
		select @w_tir1 = convert(float,@w_tasa / (360*100.00)) 
	END

delete ca_dividendo_concepto_tmp
where dct_operacion = @w_operacionca

insert into ca_dividendo_concepto_tmp
select 
di_dividendo,
di_fecha_ven,
am_concepto,
sum(am_cuota),
sum(am_gracia),
sum(am_pagado),
di_operacion
from  ca_amortizacion, ca_dividendo
where am_operacion = di_operacion
and   am_dividendo = di_dividendo 
and   am_operacion = @w_operacionca 
group by di_dividendo, di_fecha_ven, am_concepto,di_operacion
order by di_dividendo asc


select @w_seguro = @w_financiados + isnull(@w_anticipados,0) - isnull(@w_valor_aad,0)

/* SE OBTIENE EL VALOR PRESENTE NETO CON LA PRIMERA APROXIMACION */


exec sp_vpn
@i_operacionca = @w_operacionca,
@i_monto       = @w_monto,
@i_tdivi       = @w_periodo_dias,
@i_tasa        = @w_tir1,
@i_deuda       = @w_deuda,
@i_des_seg     = @w_desacumula_seg,
@i_seguro      = @w_seguro,
@i_periodica   = @w_periodica,
@i_fecha_desde = @w_fecha_desde,
@o_vpn         = @w_vpn1 out

if @w_vpn1 = 0 begin
   select @o_tir = @w_tasa
   goto SALIR
end


if @w_vpn1 > 0
   select @w_sumar =  0.0001*@w_var -- SUBIR LA TASA POR VPN1 POSITIVO
else
   select @w_sumar = -0.0001*@w_var -- BAJAR LA TASA POR VPN1 NEGATIVO

select @w_tir2 = @w_tir1

select @w_flag = 1



while @w_flag = 1  begin
  
   select
   @w_intentos = @w_intentos + 1,  
   @w_tir2     = @w_tir2 + @w_sumar

   exec sp_vpn
   @i_operacionca = @w_operacionca,
   @i_monto       = @w_monto,
   @i_tdivi       = @w_periodo_dias,
   @i_tasa        = @w_tir2,
   @i_des_seg     = @w_desacumula_seg,
   @i_deuda       = @w_deuda,
   @i_seguro      = @w_seguro,
   @i_periodica   = @w_periodica,
   @i_fecha_desde = @w_fecha_desde,
   @o_vpn         = @w_vpn2 out
   
   
   if @w_sumar > 0 and @w_vpn2 < 0  break
   if @w_sumar < 0 and @w_vpn2 > 0  break

   if abs(@w_tir2) = 1  break 
END



select @w_tir = @w_tir1 + (@w_tir2 - @w_tir1)/(@w_vpn1-@w_vpn2) * @w_vpn1

if @w_plazo_dias = @w_periodo_dias begin

   select 
   @o_tir   = @w_tir *100*360*1.0/@w_plazo_dias,
   @w_tir1  = @w_tir1*100*360*1.0/@w_plazo_dias, 
   @w_tir2  = @w_tir2*100*360*1.0/@w_plazo_dias,
   @w_pprom = @w_plazo_dias

end else begin

   if @w_periodica = 'S' begin  

      select 
      @o_tir  = @w_tir *100*periodo,
      @w_tir1 = @w_tir1*100*periodo, 
      @w_tir2 = @w_tir2*100*periodo
      from tasas_periodos
      where tdivi = @w_periodo_dias
   end else begin

      select 
      @o_tir   = @w_tir *100*360*1.0,
      @w_tir1  = @w_tir1*100*360*1.0, 
      @w_tir2  = @w_tir2*100*360*1.0
   end

   select @w_pprom = avg(datediff(dd,di_fecha_ini,di_fecha_ven))
   from ca_dividendo
   where di_operacion = @w_operacionca

end

SALIR: 
if @w_tipo_amortizacion = 'ROTATIVA' begin    
   exec sp_crea_tab_americana
   @i_opcion      = 'D',
   @i_operacionca = @w_operacionca,
   @o_operacionca = @w_operacionca out
end

exec sp_tea
@i_tir        = @o_tir,
@i_tdivi      = @w_periodo_dias,
@i_tplazo     = @w_plazo_dias,
@i_pprom      = @w_pprom,
@i_periodica  = @w_periodica,
@o_tasa       = @o_tea out

select @o_cat = (power(1+@o_tir/100/@w_periodo, @w_periodo) - 1)*100

insert into ca_cat (
ct_tipo_tabla       , ct_tasa_interes, ct_tasa_comision,	ct_periodicidad,  ct_cat)
values (
@w_tipo_amortizacion, @w_tasa_int    , @w_tasa_com,          @w_periodo_dias,  @o_cat
)
if @@error <> 0 begin 
   print 'ERROR...No se pudo registrar un valor CAT al CACHE'
   return 710004
end 


if @o_tea is null begin
   print 'ERROR...No se pudo obtener el TEA'
   return 710002
end



return 0

ERROR_FIN:

exec cobis..sp_cerror 
@t_from = @w_sp_name, 
@i_num = @w_error, 
@i_msg = @w_msg

return @w_error
go

