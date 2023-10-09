/************************************************************************/
/*  Archivo:                        cancelcta.sp                        */
/*  Stored procedure:               sp_cancela_cta                      */
/*  Base de datos:                  cob_conta                           */
/*  Producto:                       contabilidad                        */
/*  Disenado por:                   Doris Lozano                        */
/*  Fecha de escritura:             21-mayo-2014                        */
/************************************************************************/
/*                     IMPORTANTE                                       */
/*  Este programa es parte de los paquetes bancarios propiedad de       */
/*  "MACOSA", representantes exclusivos para el Ecuador de la           */
/*  "NCR CORPORATION".                                                  */
/*  Su uso no autorizado queda expresamente prohibido asi como          */
/*  cualquier alteracion o agregado hecho por alguno de sus             */
/*  usuarios sin el debido consentimiento por escrito de la             */
/*  Presidencia Ejecutiva de MACOSA o su representante.                 */
/*               PROPOSITO                                              */
/*  Este programa procesa las transacciones de:                         */
/*     Inicio de corte                                                  */
/*                 MODIFICACIONES                                       */
/*  FECHA                  AUTOR                 RAZON                  */
/*  21/May/2014        D. lozano           Emision Inicial              */
/************************************************************************/
use cob_conta
go

set nocount on

if exists (select * from sysobjects where name = 'sp_cancela_cta')
   drop proc sp_cancela_cta
go

create proc sp_cancela_cta (
   @i_param1   tinyint,
   @i_param2   varchar(24),
   @i_param3   varchar(24),
   @i_param4   datetime,
   @i_param5   datetime
)
as
declare @w_fecha     		varchar(10),
        @w_empresa      	tinyint,
        @w_cuenta_orig  	varchar(24),
        @w_cuenta_dest  	varchar(24),
        @w_periodo      	int,
        @w_corte        	int,
        @w_comprob      	int,
        @w_campo     		varchar(50),
        @w_comando   		varchar(255),
        @w_tabla1    		varchar(50),
        @w_path_lis  		varchar(100),
        @w_ruta      		varchar(100),
        @w_s_app     		varchar(100),
        @w_destino   		varchar(100),
        @w_errores   		varchar(100),
        @w_error     		int,
        @w_anio      		int,
        @w_mes       		int,
        @w_dia       		int,
        @w_oficina_orig 	smallint,     
        @w_area_orig    	smallint, 
        @w_observacion      varchar(64),
        @w_observaciond     varchar(64),       
        @w_asiento          int,   
        @w_comprobante      int,
        @w_credito          money,
        @w_debito           money,
        @w_usuario          varchar(20),
        @w_tipo_doc         varchar(2),
        @w_ident            varchar(30),
        @w_imp              varchar(4),
        @w_ente             int,
        @w_credito_d        money,
        @w_debito_d         money,
        @w_ente_d           int,
        @w_imp_d            varchar(4),
        @w_oficina_ant      smallint,
        @w_fecha_conta      datetime


select   @w_empresa      = @i_param1,
         @w_cuenta_orig  = @i_param2,
         @w_cuenta_dest  = @i_param3,
         @w_fecha        = convert(varchar(10), @i_param4, 101),
         @w_fecha_conta  = convert(varchar(10), @i_param5, 101),
         @w_comprobante  = 0,
         @w_asiento      = 1,
         @w_usuario      = 'conta_batch',
         @w_imp_d        = '    ',
         @w_imp          = '    '
         
         
select   @w_observacion  = 'CANCELACION DE CUENTA ' + @w_cuenta_orig

select   @w_observaciond  = 'CANCELACION DE CUENTA A CUENTA DESTINO  ' + @w_cuenta_dest

truncate table  cb_cuentas_canc_tmp

select @w_path_lis = pp_path_destino
from cobis..ba_path_pro  
where pp_producto = 6

if @@rowcount = 0
begin
  print 'No existe path de listados'
  return 1
end

select @w_ruta = pa_char
from cobis..cl_parametro
where pa_producto = 'ADM'
and   pa_nemonico = 'S_APP'
if @@rowcount = 0
begin
  print 'No existe ruta de s_app'
  return 1
end

select @w_area_orig  = pa_smallint
from cobis..cl_parametro
where pa_nemonico = 'ARC'
and   pa_producto = 'CCA'

if @@rowcount = 0
begin
  print 'No existe parametro ARC'
  return 1
end

--Hallar corte
select @w_periodo = co_periodo,
       @w_corte   = co_corte
from cob_conta..cb_corte
where co_empresa    = @w_empresa
and   co_fecha_ini  = @w_fecha

if @@rowcount = 0
begin
  print 'No existe periodo para la fecha dada'
  return 1
end

select 
'oficina_org' = st_oficina,
'area_org' = st_area,
'credito'  = case when (sum(isnull(st_saldo,0)) > 0) then abs(sum(isnull(st_saldo,0))) else 0 end,
'debito'   = case when (sum(isnull(st_saldo,0)) <  0) then abs(sum(isnull(st_saldo,0))) else 0 end,
'tipo_doc' = (select en_tipo_ced from cobis..cl_ente with (nolock) where en_ente = st_ente),
'id'       = (select en_ced_ruc from cobis..cl_ente with (nolock) where en_ente = st_ente),
'imp'      = (select top 1 isnull(cp_condicion,'    ') from cb_cuenta_proceso where  cp_cuenta = @w_cuenta_orig and (cp_proceso = 6004 or  cp_proceso = 6095)),
'ente'     = st_ente
into #origen
from cob_conta_tercero..ct_saldo_tercero
where st_periodo = @w_periodo
and   st_corte   = @w_corte
and   st_cuenta =  @w_cuenta_orig
and   st_saldo  <> 0
group by st_oficina, st_ente, st_area
if @@error <> 0
begin
  print 'Error en insercion tabla origen'
  return 1
end

select 
'oficina_org_d' = st_oficina,
'credito_d'     = case when (sum(isnull(st_saldo,0)) > 0) then 0  else abs(sum(isnull(st_saldo,0))) end,
'debito_d'      = case when (sum(isnull(st_saldo,0)) <  0) then 0  else abs(sum(isnull(st_saldo,0))) end,
'imp_d'         = (select top 1 isnull(cp_condicion,'    ') from cb_cuenta_proceso where  cp_cuenta =@w_cuenta_dest and (cp_proceso = 6004 or  cp_proceso = 6095)),
'ente_d'        = st_ente
into #destino
from cob_conta_tercero..ct_saldo_tercero
where st_periodo = @w_periodo
and   st_corte   = @w_corte
and   st_cuenta  =   @w_cuenta_orig
and   st_saldo  <> 0
group by st_oficina, st_ente 
if @@error <> 0
begin
  print 'Error en insercion tabla destino'
  return 1
end

select @w_oficina_ant = 0

while 1 = 1 
begin
    set rowcount 1
    select
       @w_oficina_orig  = oficina_org, 
       @w_area_orig     = area_org,
       @w_credito       = credito,
       @w_debito        = debito,
       @w_tipo_doc      = tipo_doc,
       @w_ident         = id,
       @w_imp           = imp,
       @w_ente          = ente
    from #origen
    order by oficina_org, ente
    if @@rowcount = 0
       break
    
    if @w_oficina_ant <> @w_oficina_orig
    begin
       select @w_asiento = 1

    select @w_comprobante = @w_comprobante + 1
    end

   insert into cb_cuentas_canc_tmp
   (
    cc_comprobante, 	cc_empresa, 	  cc_fecha_tran,            
   	cc_oficina_orig, 	cc_area_orig, 	  cc_descripcion,           
   	cc_automatico,   	cc_estado,   	  cc_asiento,               
   	cc_cuenta,      	cc_oficina_dest,  cc_area_dest,             
   	cc_credito,         cc_debito,        cc_concepto,              
   	cc_tipo_doc,    	cc_moneda,        cc_usuario_modulo,        
   	cc_credito_me,      cc_debito_me,     cc_cotizacion,            
   	cc_tipo_tran,       cc_tipo,          cc_identifica,            
   	cc_concepto_imp,    cc_base_imp,      cc_documento,             
   	cc_oper_banco,      cc_cheque,        cc_origen_mvto         
   	)
   	select 
   	@w_comprobante,     @w_empresa,       @w_fecha_conta,
   	@w_oficina_orig,    @w_area_orig,     @w_observacion,
   	0,                  0,                @w_asiento,
   	@w_cuenta_orig,     @w_oficina_orig,  @w_area_orig, 
   	@w_credito,         @w_debito,        @w_observacion,
   	0,                  0,                @w_usuario,
   	0,                  0,                null,
   	null,               @w_tipo_doc,      @w_ident,
   	@w_imp,             null,             null, 
   	null,               null,             null
   	from #origen
   	
   if @@error <> 0
   begin
     print 'Error en insercion tabla cb_cuentas_canc_tmp origen'
     return 1
   end

   select
   @w_credito_d       = credito_d,
   @w_debito_d        = debito_d,
   @w_imp_d           = imp_d,
   @w_ente_d          = ente_d
   from #destino
   where oficina_org_d =  @w_oficina_orig 
   and  ente_d = @w_ente

  select @w_asiento = @w_asiento + 1
  	
   insert into cb_cuentas_canc_tmp
   (
   cc_comprobante,   cc_empresa,       cc_fecha_tran,            
   cc_oficina_orig,  cc_area_orig, 	   cc_descripcion,           
   cc_automatico,    cc_estado,   	   cc_asiento,               
   cc_cuenta,        cc_oficina_dest,  cc_area_dest,             
   cc_credito,       cc_debito,        cc_concepto,              
   cc_tipo_doc,    	 cc_moneda,        cc_usuario_modulo,        
   cc_credito_me,    cc_debito_me,     cc_cotizacion,            
   cc_tipo_tran,     cc_tipo,          cc_identifica,            
   cc_concepto_imp,  cc_base_imp,      cc_documento,             
   cc_oper_banco,    cc_cheque,        cc_origen_mvto           
   )
   select 
   @w_comprobante,     @w_empresa,       @w_fecha_conta,
   @w_oficina_orig,    @w_area_orig,     @w_observaciond,
   0,                  0,                @w_asiento,
   @w_cuenta_dest,     @w_oficina_orig,  @w_area_orig, 
   @w_credito_d,       @w_debito_d,      @w_observaciond,
   0,                  0,                @w_usuario,
   0,                  0,                null,
   null,               null,             null,
   @w_imp,             null,             null, 
   null,               null,             null
   from #destino

   if @@error <> 0
   begin
     print 'Error en insercion tabla cb_cuentas_canc_tmp destino'
     return 1
   end
	
   delete #origen 
   where oficina_org = @w_oficina_orig 
   and ente = @w_ente
   if @@error <> 0
   begin
     print 'Error en eliminacion  tabla #origen'
     return 1
   end

   delete #destino 
   where oficina_org_d = @w_oficina_orig 
   and ente_d = @w_ente

   if @@error <> 0
   begin
     print 'Error en eliminacion tabla #destino'
     return 1
   end

   select @w_asiento = @w_asiento + 1

   select @w_oficina_ant =  @w_oficina_orig
end

set rowcount 0

select @w_anio = datepart(yy, convert(datetime,@w_fecha))
select @w_mes  = datepart(mm, convert(datetime,@w_fecha))
select @w_dia  = datepart(dd, convert(datetime,@w_fecha))

select @w_s_app =  's_app bcp -auto -login cob_conta..cb_cuentas_canc_tmp out '
select @w_destino  = 'cancela_ctas_'+ convert(varchar, @w_anio)+ convert(varchar, @w_mes) + convert(varchar, @w_dia) + '.txt',
       @w_errores  = @w_path_lis + 'cancela_ctas' + '.err'
select @w_comando = @w_ruta + @w_s_app + @w_path_lis + @w_destino + ' -b5000 -c -e' + @w_errores + ' -t"&&" ' + '-config '+  + @w_ruta + 's_app.ini'

exec @w_error = xp_cmdshell @w_comando
if @w_error <> 0 begin
   print 'Error Generando archivo plano'
   print @w_comando
   return 1
end

return 0

go
