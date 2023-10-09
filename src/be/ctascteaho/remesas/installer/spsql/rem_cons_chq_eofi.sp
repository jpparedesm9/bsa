/****************************************************************************/
/*     Archivo:     rem_cons_chq_eofi.sp                                    */
/*     Stored procedure: sp_rem_cons_chq_eofi                               */
/*     Base de datos: cob_remesas                                           */
/*     Producto: Personalizacion                                            */
/*     Disenado por:    Jorge Baque                                         */
/*     Fecha de escritura: 13/May/2016                                      */
/****************************************************************************/
/*                            IMPORTANTE                                    */
/*    Esta aplicacion es parte de los paquetes bancarios propiedad          */
/*    de COBISCorp.                                                         */
/*    Su uso no    autorizado queda  expresamente   prohibido asi como      */
/*    cualquier    alteracion o  agregado  hecho por    alguno  de sus      */
/*    usuarios sin el debido consentimiento por   escrito de COBISCorp.     */
/*    Este programa esta protegido por la ley de   derechos de autor        */
/*    y por las    convenciones  internacionales   de  propiedad inte-      */
/*    lectual.    Su uso no  autorizado dara  derecho a    COBISCorp para   */
/*    obtener ordenes  de secuestro o  retencion y para  perseguir          */
/*    penalmente a los autores de cualquier   infraccion.                   */
/****************************************************************************/
/*                           PROPOSITO                                      */
/*                                                                          */
/****************************************************************************/
/*                           MODIFICACIONES                                 */
/*       FECHA          AUTOR           RAZON                               */
/*     13/May/2016     Jorge Baque     Migracion a CEN                      */
/****************************************************************************/
use cob_remesas
go

if exists (select
             1
           from   sysobjects
           where  name = 'sp_rem_cons_chq_eofi')
  drop proc sp_rem_cons_chq_eofi
go

SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER OFF
GO

CREATE proc sp_rem_cons_chq_eofi (
    @s_ssn      	int,
    @s_srv      	varchar(30),
    @s_lsrv     	varchar(30),
    @s_user     	varchar(30),
    @s_sesn     	int=null,
    @s_term     	varchar(10),
    @s_date     	datetime,
    @s_ofi      	smallint,   /* Localidad origen transaccion */
    @s_rol      	smallint,
    @s_org_err  	char(1) = null, /* Origen de error: [A], [S] */
    @s_error    	int = null,
    @s_sev      	tinyint = null,
    @s_msg      	mensaje = null,
    @s_org      	char(1),
    @t_corr     	char(1) = 'N',
    @t_ssn_corr 	int = null, /* Trans a ser reversada */
    @t_debug    	char(1) = 'N',
    @t_file     	varchar(14) = null,
    @t_from     	varchar(32) = null,
    @t_rty      	char(1) = 'N',
    @t_trn      	smallint,
    @p_lssn     	int = null,
    @p_rssn     	int = null,
    @p_rssn_corr    int = null,
    @p_envio    	char(1) = 'N',
    @p_rpta         char(1) = 'N',
    @i_mon          tinyint,
    @i_fecha    	datetime,
    @i_carta        int = 0,
    @i_sec          int = 0,
    @i_tipo_of  	char(1)  = 'O',
    @i_oficon   	smallint = 0
)
as
declare @w_return   int,
    @w_sp_name  	varchar(30),
    @w_des_corr 	varchar(30),
    @w_des_prop 	varchar(30),
    @w_des_emi  	varchar(30),
    @w_dias_ret 	tinyint,
    @w_corres   	char(12),
    @w_propie   	char(12),
    @w_emisor   	char(12),
    @w_estado   	char(1),
    @w_fecha_emi    smalldatetime,
    @w_fecha_efe    smalldatetime,
    @w_oficina  	int,
    @w_ofi_bco  	smallint,
    @w_banco    	smallint,
    @w_parroquia    int,
    @w_num_cheques  tinyint,
    @w_valor    	money,
    @w_bco_p    	smallint,
    @w_ofi_p    	smallint,
    @w_par_p    	int,
    @w_bco_c    	smallint,
    @w_ofi_c    	smallint,
    @w_par_c    	int,
    @w_prod_desc    char(3),
    @w_producto 	tinyint,
    @w_ctadep   	varchar(24),
    @w_cta      	int,
    @w_cheque_rec   int,
    @w_codigo       smallint,
    @w_ciudad_ofi   int,
    @w_ciudad       int,
    @w_confirmar    char(1),
    @w_sucursal     int,
    @w_temporal     int,
    @w_fecha        smalldatetime,
    @w_cont         int,
    @w_codbco       tinyint
        
/*  Captura nombre de Stored Procedure  */
select  @w_sp_name = 'sp_rem_cons_chq_eofi'

/* Chequeo de errores generados remotamente */
if @s_org_err is not null           /*  Error del Sistema  */
begin
   exec cobis..sp_cerror
   @t_debug        = @t_debug,
   @t_file         = @t_file,
   @t_from         = @w_sp_name,
   @i_num          = @s_error,
   @i_sev          = @s_sev,
   @i_msg          = @s_msg
   return 1
end

--Codigo propio de compensacion
select @w_codbco = pa_tinyint
from   cobis..cl_parametro 
where  pa_nemonico = 'CBCO' 
and    pa_producto = 'CTE'

if @@rowcount <> 1
begin
   exec cobis..sp_cerror
   @t_from         = @w_sp_name,
   @i_num          = 201196
   return 201196
end

-- Determinar la ciudad de la oficina
select @w_ciudad = of_ciudad
from   cobis..cl_oficina
where  of_oficina = @s_ofi

-- Determinar dia habil anterior a la fecha de consulta
select @w_fecha = dateadd(dd,-1,@i_fecha)
select @w_cont = 0
while 1=1
begin
  if exists (select df_fecha
               from cobis..cl_dias_feriados
              where df_ciudad = @w_ciudad
                and df_fecha = @w_fecha)
    select @w_fecha = dateadd(dd,-1,@w_fecha),
           @w_cont  = @w_cont + 1
  else
    break
end

if @w_cont = 0
   select @w_fecha = @i_fecha
   
/* Tabla temporal para almacenar nuevos estados */
create table #ing_chq_prod(
es_secuencial      int,       
es_tipo_tran       smallint,       
es_oficina         smallint,       
es_fecha           smalldatetime,     
es_cta_banco_dep   varchar(24),     
es_valor           money,     
es_cta_gir         varchar(24),     
es_nro_cheque      int,
es_cod_banco       char(12),     
es_moneda          tinyint,     
es_producto        tinyint,     
es_cheque_rec      int,    
es_alterno         int,     
es_oficina_cta     smallint,     
es_hora            smalldatetime,     
es_estado          char(1)     null,     
es_bco_corr        smallint,     
es_carta           int,     
es_suc_destino     int,     
es_cod_corres      varchar(12)
)           
/*
/*Insercion de ctas Corrientes*/  
insert into  #ing_chq_prod
select 
secuencial,     tipo_tran,           oficina,      fecha,        cta_banco_dep, valor,     
cta_gir,        nro_cheque,          cod_banco,    moneda,       producto,      cheque_rec,    
alterno,        oficina_cta,         hora,         estado,       bco_corr,      carta,          
suc_destino,    cod_corres
from cob_cuentas..cc_tsrem_ingresochq 
where estado is null   

/*Insercion de ctas Corrientes Transacciones de servicio dia anterior*/ 
insert into  #ing_chq_prod
select 
ts_secuencial,  ts_tipo_transaccion, ts_oficina,   ts_tsfecha,   ts_cta_banco,   ts_saldo,       
ts_cta_gir,     ts_cheque,           ts_cod_banco, ts_moneda,    ts_producto,    ts_cheque_rec, 
ts_cod_alterno, ts_oficina_cta,      ts_hora,      ts_estado,    ts_banco,       ts_carta,       
ts_endoso,      ts_corresponsal
from   cob_cuentas..cc_tran_servicio_tmp
where  ts_tipo_transaccion in (401, 486)
and ts_estado is null 
*/
/*Insercion de ctas Ahorros*/

insert into  #ing_chq_prod
select  
secuencial,     tipo_tran,           oficina,      fecha,        cta_banco_dep,  isnull(valor,0),
cta_gir,        nro_cheque,          cod_banco,    moneda,       producto,       cheque_rec,
alterno,        oficina_cta,         hora,         estado,       bco_corr,       carta,
suc_destino,    cod_corres
from cob_ahorros..ah_tsrem_ingresochq
where estado_trn is null


/*Insercion de Ctas Ahorro Transacciones de servicio dia anterior*/ 

insert into  #ing_chq_prod
select 
ts_secuencial,  ts_tipo_transaccion, ts_oficina,    ts_tsfecha,     ts_cta_banco,    isnull(ts_saldo,0),      
ts_cta_gir,     ts_nro_cheque,       ts_cod_banco,  ts_moneda,      ts_producto,     ts_cheque_rec,
ts_cod_alterno, ts_oficina_cta,      ts_hora,       ts_estado,      ts_numero,       ts_numlib,
ts_endoso,      ts_corresponsal
from   cob_ahorros..ah_tran_servicio_tmp
where  ts_tipo_transaccion = 401
and    ts_estado is null

select @w_temporal = count(*) from #ing_chq_prod

if @i_tipo_of = 'S'
begin
set rowcount 20
   select  
   'OFICINA'           = es_oficina,
   'DESCRIPC. OFIC.'   = of_nombre,
   'CANT. CHEQUES'     = count(es_nro_cheque),
   'VALOR'             = sum(es_valor)
   from  #ing_chq_prod,
         cobis..cl_oficina
   where es_oficina      = of_oficina
   and   es_bco_corr    != @w_codbco
   and   es_suc_destino  = @s_ofi
   and   es_fecha        = @i_fecha
   and   es_oficina      > @i_oficon
   and   es_estado       is null
   group by es_oficina, of_nombre

   if @@rowcount = 0
   begin   
       exec cobis..sp_cerror
       @t_from         = @w_sp_name,
       @i_num          = 351003,
       @i_msg      = 'NO EXISTEN REMESAS GENERADAS PARA ESTA SUCURSAL'
       return 1
   end

set rowcount 0

   select  
   count(es_nro_cheque),
   sum(es_valor)
   from  #ing_chq_prod
   where es_bco_corr    != @w_codbco
   and   es_suc_destino  = @s_ofi
   and   es_fecha        = @i_fecha
   and   es_estado       is null
end
else
begin
set rowcount 20
   select  
   'CTA. DEPOS.'   = es_cta_banco_dep,
   'CTA. GIRADA'   = es_cta_gir,
   'CHEQUE'        = es_nro_cheque,
   'VALOR'         = es_valor,
   'BCO. GIRADO'   = substring(es_cod_banco,1,4),
   'DESC. BANCO'   = substring(ba_descripcion,1,25),
   'CIUDAD GIRADA' = substring(es_cod_banco,9,4),
   'DESC. CIUDAD ' = substring(ci_descripcion,1,20),
   'DEPARTAMENTO'  = substring(pv_descripcion,1,15),
   'No. CARTA '    = es_carta,
   'No. REMESA'    = es_cheque_rec
   from   #ing_chq_prod,
         cobis..cl_ciudad,
         cobis..cl_provincia,
         cob_remesas..re_banco
   where es_bco_corr   != @w_codbco
   and   es_oficina    = @s_ofi
   and   es_fecha      = @i_fecha
   and   convert(int,substring(es_cod_banco,9,4)) = ci_cod_remesas
   and   ci_provincia  = pv_provincia
   and   convert(int,substring(es_cod_banco,1,4)) = ba_banco
   and   es_cheque_rec > @i_sec
   and   es_estado     is null
   order  by es_cta_banco_dep

   if @@rowcount = 0
   begin
      exec cobis..sp_cerror
      @t_from         = @w_sp_name,
      @i_num          = 351003,
      @i_msg     = 'NO EXISTEN REMESAS INGRESADAS POR ESTA OFICINA'
      return 1
   end
set rowcount 0
end 
return 0


GO


