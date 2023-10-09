/************************************************************************/
/*   Archivo:              boc.sp                                       */
/*   Stored procedure:     sp_boc                                       */
/*   Base de datos:        cob_cartera                                  */
/*   Producto:             Cartera                                      */
/*   Disenado por:         FdlT                                         */
/*   Fecha de escritura:   Jul/2009                                     */
/************************************************************************/
/*                              IMPORTANTE                              */
/*   Este programa es parte de los paquetes bancarios propiedad de      */
/*   'MACOSA'.                                                          */
/*   Su uso no autorizado queda expresamente prohibido asi como         */
/*   cualquier alteracion o agregado hecho por alguno de sus            */
/*   usuarios sin el debido consentimiento por escrito de la            */
/*   Presidencia Ejecutiva de MACOSA o su representante.                */
/************************************************************************/
/*                               PROPOSITO                              */
/*   Balance Operativo Contable de Cartera                              */
/************************************************************************/
/*                               CAMBIOS                                */
/*   FECHA     AUTOR          CAMBIO                                    */
/*   Nov-2010  Elcira Pelaez  NR-0059 Parte del Diferido en transaccion */
/*                            de reestructuracion RES                   */
/*   Feb-2011  Elcira Pelaez  Inc-16421 Incluir seleccion Origen Fondos */
/*   Ago-2012  Luis C. Moreno Req 293 Incluye valores por Reconocimiento*/
/*   Sep-2017  Tania Baidal   Modificacion a vertical de estructura     */
/*                            sb_dato_operacion_rubro y programacion    */
/*                            de llenado en vertical de las tablas tmp  */
/*   Jun-2019  Dario Cumbal   Cambios BOC garantias                     */
/*   Dic-2019  Dario Cumbal   Cambios caso 131325, tomar parametro fecha*/
/*   Ene-2021  Dario Cumbal   Cambios caso 170130                       */
/*   Mar-2022  Dario Cumbal   Cambios caso:179643                       */ 
/************************************************************************/
use cob_cartera
go

if exists (select 1 from sysobjects where name = 'sp_boc')
   drop proc sp_boc
go
---iNC.114979 MAR.06.2014
create procedure sp_boc
(
   @i_param1             varchar(255),
   @i_param2             varchar(255),
   @i_param3             varchar(255),
   @i_cliente            int  = null
)
as

declare
@w_est_vigente        int,
@w_est_suspenso       int,
@w_est_castigado      int,
@w_est_diferido       int,
@w_secuencial         int,
@w_producto           int,
@w_sp_name            varchar(20),
@w_area_cartera       smallint,
@w_fecha_proceso      datetime,
@w_error              int,
@w_cont               int,
@w_perfil             varchar(20),
@w_mensaje            varchar(100),
@w_sarta              int,
@w_bancamia           varchar(24),
@i_empresa            tinyint,
@i_fecha              datetime,
@i_historico          char(1),
@w_codval_altfng      varchar(20),
@w_s_app              varchar(255),
@w_path               varchar(255),
@w_cmd                varchar(5000),
@w_destino            varchar(255),
@w_destino2           varchar(255),
@w_errores            varchar(255),
@w_comando            varchar(6000),
@w_columna            varchar(50),
@w_col_id             int,
@w_cabecera           varchar(5000),
@w_moneda_nacional    tinyint,
@w_num_dec            int,
@w_vlr_despreciable   float,
@w_cuenta             varchar(100),
@w_fecha_fm           datetime, 
@w_corte              int ,
@w_periodo            int ,
@w_cta_gar_liq        cuenta 


/* INICIO DE VARIABLES DE TRABAJO */
select
@w_producto = 7,
@w_sp_name  = 'sp_boc'

select  @i_empresa      = convert(tinyint,  @i_param1)
select  @i_fecha        = convert(datetime, @i_param2)
select  @i_historico    = convert(char(1),  @i_param3)


/* DETERMINAR CODIGO DE BANCAMIA PARA EMPLEADOS */
select @w_bancamia  = convert(varchar(24),en_ente)
from cobis..cl_ente 
where en_ced_ruc  = '9002150711'
and   en_tipo_ced = 'N'

/* BUSCANDO AREA DE CARTERA */
select @w_area_cartera = pa_smallint
from   cobis..cl_parametro
where  pa_producto = 'CCA'
and    pa_nemonico = 'ARC'

/* BUSCANDO CODIGO VALOR PARA ALT_FNG */
select @w_codval_altfng = pa_char
from   cobis..cl_parametro
where  pa_producto = 'CCA'
and    pa_nemonico = 'CVAFNG'

/* DETERMINAR LA FECHA DE PROCESO */
select @w_fecha_proceso = fc_fecha_cierre
from cobis..ba_fecha_cierre
where fc_producto = 7


/* ESTADOS DE CARTERA */
exec @w_error = cob_cartera..sp_estados_cca
@o_est_vigente    = @w_est_vigente   out,
@o_est_castigado  = @w_est_castigado out,
@o_est_diferido   = @w_est_diferido  out,
@o_est_suspenso   = @w_est_suspenso  out

-- CODIGO DE LA MONEDA LOCAL
select @w_moneda_nacional = pa_tinyint
from   cobis..cl_parametro with (nolock)
where  pa_producto = 'ADM'
and    pa_nemonico = 'MLO'

--CUENTA PARA  PROCESAR GARANTIAS

select @w_cta_gar_liq = pa_char
from   cobis..cl_parametro with (nolock)
where  pa_producto = 'CCA'
and    pa_nemonico = 'CTGARL'
 

/* DECIMALES DE LA MONEDA NACIONAL */
exec @w_error   = sp_decimales
@i_moneda       = @w_moneda_nacional,
@o_decimales    = @w_num_dec out

select @w_vlr_despreciable = isnull(1.0 / power(10, @w_num_dec + 2),0)

/*CREAR TABLAS DE TRABAJO*/
create table #dato_operacion(
do_banco             varchar(24)   not null,
do_toperacion        varchar(10)   not null,
do_moneda            smallint      not null,
do_tgarantia         varchar(10)   not null,
do_calificacion      varchar(10)   not null,
do_clase_cartera     varchar(10)   not null,
do_oficina           smallint      not null,
do_cliente           int           not null,
do_fuente_recurso    varchar(10)   not null,
do_ent_convenio      varchar(1)    not null,
do_tipo_cartera      varchar(10)   not null,
do_subtipo_cartera   varchar(10)   not null)

create index idx1 on #dato_operacion(do_banco)

create table #perfil_boc(
pb_concepto        catalogo     not null,
pb_codigo          int          not null,
pb_codvalor        int          not null,
pb_parametro       varchar(11)  not null,
pb_tparametro      varchar(20)  not null
)


create table #dato_rubro(
dr_banco            varchar(24)  not null,
dr_toperacion       varchar(20)  not null,
dr_cliente          int          not null,
dr_oficina          smallint     not null,
dr_concepto         catalogo     not null,
dr_estado           int          not null,
dr_exigible         int          not null,
dr_parametro        varchar(40)  not null,
dr_clave            varchar(40)  not null,
dr_valor            money        not null
)

create index idx1 on #dato_rubro(dr_banco)

create table #cuentas_boc(
parametro     varchar(11) not null,
clave         varchar(40) not null,
cuenta        varchar(40) not null,
tercero       char(1)     not null,
naturaleza    char(1)     not null)

create index idx1 on #cuentas_boc(parametro, clave)


create table #boc(
bo_cuenta      varchar(40) not null,
bo_oficina     smallint    not null,
bo_cliente     int         not null,
bo_banco       cuenta      not null,
bo_concepto    catalogo    not null,
bo_val_opera   money       not null,
bo_val_conta   money       not null)

create index idx1 on #boc (bo_cuenta, bo_oficina, bo_cliente)


select @w_cont = 0

while @w_cont < 3 begin  -- cambiar a contador < 3 cuando este listo pasivas y administradas

   truncate table #dato_operacion
   truncate table #cuentas_boc
   truncate table #perfil_boc
   truncate table #dato_rubro

   select @w_cont = @w_cont + 1

   if @w_cont = 1 select @w_perfil = 'BOC_ACT'
   if @w_cont = 2 select @w_perfil = 'BOC_PAS'
   if @w_cont = 3 select @w_perfil = 'BOC_ADM'

   insert into #dato_operacion
   select
   do_banco            = do_banco,
   do_toperacion       = ltrim(rtrim(do_tipo_operacion)),
   do_moneda           = do_moneda,
   do_tgarantia        = case when do_tipo_garantias in ('H','I','A','E') then 'I' else 'O' end,
   do_calificacion     = isnull(do_calificacion, 'A'),
   do_clase_cartera    = ltrim(rtrim(do_clase_cartera)),
   do_oficina          = do_oficina,
   do_cliente          = do_codigo_cliente,
   do_fuente_recurso   = isnull(do_fuente_recurso,''),
   do_ent_convenio     = case when do_entidad_convenio = @w_bancamia then '1' else '0' end,
   do_tipo_cartera     = ltrim(rtrim(do_tipo_cartera)),
   do_subtipo_cartera  = ltrim(rtrim(do_subtipo_cartera))
   from cob_conta_super..sb_dato_operacion
   where do_fecha       = @i_fecha
   and   do_aplicativo  = @w_producto
   and   do_estado_contable in (1,12,2,3)
   and   do_codigo_cliente = isnull(@i_cliente, do_codigo_cliente)
   and   do_naturaleza     = @w_cont
 

   if @@error <> 0 begin
      select 
      @w_mensaje = ' ERROR AL CARGAR OPERACIONES A PROCESAR ',
      @w_error   = 710001
      goto ERRORFIN
   end


   /* CARGAR SALDOS CONTABLES A LA FECHA */
   exec @w_error  = cob_conta..sp_boc_ini
   @i_empresa     = 1,
   @i_fecha       = @i_fecha,
   @i_perfil      = @w_perfil,
   @i_producto    = @w_producto,
   @o_msg         = @w_mensaje out

   if @w_error <> 0 goto ERRORFIN


   insert into #cuentas_boc
   select distinct
   parametro  = re_parametro,
   clave      = re_clave,
   cuenta     = re_substring,
   tercero    = 'N',
   naturaleza = ''
   from cob_conta..cb_relparam, cob_conta..cb_det_perfil
   where dp_perfil    = @w_perfil
   and   re_empresa   = dp_empresa
   and   re_producto  = dp_producto
   and   re_parametro = dp_cuenta

   update #cuentas_boc set 
   naturaleza = cu_categoria
   from cob_conta..cb_cuenta
   where cu_cuenta = cuenta


   /* DETERMINO SI ES CUENTA DE TERCERO */
   update #cuentas_boc set
   tercero = 'S'
   from cob_conta..cb_cuenta_proceso 
   where cp_proceso in (6003, 6095) 
   and   cp_cuenta = cuenta

   insert into #perfil_boc(
   pb_concepto,       pb_codigo,         pb_codvalor,
   pb_parametro,      pb_tparametro)
   select distinct
   co_concepto,      co_codigo,          dp_codval,
   dp_cuenta,        ''
   from cob_conta..cb_det_perfil, cob_cartera..ca_concepto
   where dp_perfil = @w_perfil 
   and   co_codigo = dp_codval / 1000


   update #perfil_boc set
   pb_tparametro = pa_stored
   from cob_conta..cb_parametro
   where pa_parametro = pb_parametro


   insert into #dato_rubro
   select
   dr_banco       = do_banco,
   dr_toperacion  = do_toperacion,
   dr_cliente     = do_cliente,
   dr_oficina     = do_oficina,
   dr_concepto    = dr_concepto,
   dr_estado      = dr_estado,
   dr_exigible    = dr_exigible,
   dr_parametro   = pb_parametro,
   dr_clave       = case pb_tparametro
                    when 'sp_ca01_pf' then rtrim(ltrim(do_tipo_cartera)) +'.'+ rtrim(ltrim(do_clase_cartera)) +'.'+ rtrim(ltrim(isnull(do_subtipo_cartera, '99'))) +'.'+ rtrim(ltrim(isnull(do_toperacion, ''))) 
                    when 'sp_ca02_pf' then convert(varchar,do_moneda)
                    when 'sp_ca03_pf' then rtrim(ltrim(do_clase_cartera)) +'.'+ rtrim(ltrim(do_tipo_cartera))
                    when 'sp_ca04_pf' then rtrim(ltrim(dr_concepto))
                    end,
   dr_valor       = isnull(dr_valor,0)
   from #perfil_boc, #dato_operacion, cob_conta_super..sb_dato_operacion_rubro
   where dr_fecha      = @i_fecha
   and   dr_aplicativo = @w_producto
   and   dr_banco      = do_banco
   and   dr_codvalor   = pb_codvalor

   insert into #boc
   select
   bo_cuenta      = cuenta,
   bo_oficina     = dr_oficina,
   bo_cliente     = case tercero when 'S' then dr_cliente else 0 end,
   bo_banco       = dr_banco,
   bo_concepto    = dr_concepto,
   bo_val_opera   = case naturaleza when 'D' then dr_valor else dr_valor * -1 end,
   bo_val_conta   = 0
   from #dato_rubro, #cuentas_boc
   where dr_clave     = clave
   and   dr_parametro = parametro
   and   abs(isnull(dr_valor,0)) > @w_vlr_despreciable

end --while


/* ENTRAR BORRANDO */
delete cob_conta..cb_boc with (rowlock)
where bo_producto = @w_producto

if @@error <> 0 begin
   select 
   @w_mensaje = 'ERROR AL BORRAR LA TABLA DEL BOC',
   @w_error   = 710003
   goto ERRORFIN
end

delete cob_conta..cb_boc_det with (rowlock)
where bod_producto = @w_producto

if @@error <> 0 begin
   select 
   @w_mensaje = 'ERROR AL BORRAR LA TABLA DE DETALLES DEL BOC',
   @w_error   = 710003
   goto ERRORFIN
end

insert into cob_conta..cb_boc
select  
bo_fecha       = @i_fecha,
bo_cuenta      = bo_cuenta,
bo_oficina     = bo_oficina,
bo_cliente     = bo_cliente,
bo_val_opera   = sum(bo_val_opera),
bo_val_conta   = sum(bo_val_conta),
bo_diferencia  = sum(bo_val_opera - bo_val_conta),
bo_producto    = @w_producto 
from #boc
group by bo_cuenta, bo_oficina, bo_cliente

if @@error <> 0 begin
   select 
   @w_mensaje = 'ERROR AL INSERTAR VALORES OPERATIVOS BOC',
   @w_error   = 710001
   goto ERRORFIN
end


insert into cob_conta..cb_boc_det
select
@i_fecha,     bo_cuenta,   bo_oficina,
bo_cliente,   bo_banco,    bo_concepto,
'',           '',          '',
sum(bo_val_opera), @w_producto
from #boc
where bo_banco <> ''
group by bo_cuenta,   bo_oficina, bo_cliente,   bo_banco,    bo_concepto

if @@error <> 0 begin
   select 
   @w_mensaje = 'ERROR AL INSERTAR DETALLE DE VALORES OPERATIVOS BOC',
   @w_error   = 710001
   goto ERRORFIN
end


--BOC GARANTIAS 


--Cuenta de garantías  --'240190'--CUENTA DE LA CONTABILIDAD GESBAN
--crear cuenta hermana 240191  CONTROL OPERATIVO CONTABLE DE GARANTIAS  
--


select @w_cuenta =  @w_cta_gar_liq  

select @w_fecha_proceso = isnull(@i_fecha,fp_fecha)
from cobis..ba_fecha_proceso

while exists( select 1 from cobis..cl_dias_feriados where df_ciudad = 999 and df_fecha = @w_fecha_proceso) 
select @w_fecha_proceso =dateadd(dd,-1,@w_fecha_proceso)

select @w_fecha_fm = dateadd(dd,1-datepart(dd,@w_fecha_proceso),@w_fecha_proceso)
select @w_fecha_fm = dateadd(mm,1,@w_fecha_fm)
select @w_fecha_fm = dateadd(dd,-1,@w_fecha_fm)

select @w_corte = co_corte,
@w_periodo = co_periodo
from cob_conta..cb_corte
where co_fecha_ini = @w_fecha_fm

select 
'cliente'         = st_ente ,
'oficina'         = st_oficina,
'saldo_contable'  = st_saldo * (-1),
'saldo_operativo' = convert(money,0),
'marca' = 'C'
into #saldos_cuentas_garantias 
from cob_conta_tercero..ct_saldo_tercero
where st_cuenta   = @w_cuenta
and   st_periodo  = @w_periodo
and   st_corte    = @w_corte

insert into #saldos_cuentas_garantias 
select 
'cliente'        = dc_cliente, 
'oficina'        = convert(int, 0),
'saldo_contable' = convert(money,0),
'saldo_operativo'= sum(isnull(dc_gl_pag_valor,0)),
'marca' = 'O'
from cob_conta_super..sb_dato_custodia
where dc_fecha = @i_fecha
and   dc_gl_pag_estado             = 'CB'
and   isnull(dc_gl_dev_estado,'X') <> 'D'
and   dc_gl_pag_fecha              <= @w_fecha_proceso
group by dc_cliente

select 
mcliente      = op_cliente ,
max_operacion = max(op_operacion) 
into #max_operaciones 
from cob_cartera..ca_operacion a,
     cob_credito..cr_tramite_grupal
where op_cliente in ( select cliente from #saldos_cuentas_garantias )
and   op_operacion = tg_operacion
and   tg_referencia_grupal <> tg_prestamo
and   tg_monto  > 0
group by op_cliente

update #saldos_cuentas_garantias set 
oficina = op_oficina 
from cob_cartera..ca_operacion , #max_operaciones 
where cliente    = mcliente 
and op_operacion = max_operacion 
and marca = 'O'


delete cob_conta..cb_boc where bo_producto = 19


insert into cob_conta..cb_boc( 
bo_fecha       , 
bo_cuenta      ,
bo_oficina     ,
bo_cliente     ,
bo_val_opera   ,
bo_val_conta   ,
bo_diferencia  ,
bo_producto )   
select 
'fecha'           = @w_fecha_proceso,
'cuenta'          = @w_cuenta,
'oficina'         = oficina,
'cliente'         = cliente,
'saldo_operativo' = sum(saldo_operativo),
'saldo_contable'  = sum(saldo_contable),
'diferencia'      = sum(saldo_contable) - sum(saldo_operativo),
'producto'        = 19
from #saldos_cuentas_garantias
group by cliente,oficina
--having sum(saldo_contable) - sum(saldo_operativo)<>0
order by abs(sum(saldo_contable) - sum(saldo_operativo)) desc

if @@error <> 0 begin
   select 
   @w_mensaje = 'ERROR AL INSERTAR VALORES OPERATIVOS BOC GAR',
   @w_error   = 710001
   goto ERRORFIN
end



if @i_historico = 'S' begin

   exec @w_secuencial= cob_cartera..sp_gen_sec
   @i_operacion= -999

   insert into cob_conta..cb_boc_respaldo
   select @w_secuencial ,*
   from cob_conta..cb_boc
   where bo_producto = @w_producto

   if @@error <> 0  begin
      insert into cob_conta..cb_boc_log values (@i_fecha, 'ERROR AL PASAR BOC A HISTORICO: ', @w_producto)
      return 1
   end

   insert into cob_conta..cb_boc_det_respaldo
   select @w_secuencial ,*
   from cob_conta..cb_boc_det
   where bod_producto = @w_producto

   if @@error <> 0  begin
      insert into cob_conta..cb_boc_log values (@i_fecha, 'ERROR AL PASAR DETALLE BOC A HISTORICO: ', @w_producto)
      return 1
   end

   insert into cob_conta..cb_boc_log_respaldo
   select @w_secuencial ,*
   from cob_conta..cb_boc_log
   where bl_producto = @w_producto

   if @@error <> 0  begin
      insert into cob_conta..cb_boc_log values (@i_fecha, 'ERROR AL LOG DE SECUENCIALES A HISTORICO: ', @w_producto)
      return 1
   end
end


----------------------------------------
--Generar Archivo Plano
----------------------------------------
select @w_s_app = pa_char
from cobis..cl_parametro
where pa_producto = 'ADM'
and   pa_nemonico = 'S_APP'

select @w_path = ba_path_destino
from cobis..ba_batch
where ba_batch = 28794

select @w_cmd = @w_s_app + 's_app bcp -auto -login cob_conta..cb_boc out '

select @w_destino  = @w_path + 'boc_' + replace(convert(varchar, @i_fecha, 102), '.', '') + '_' + replace(convert(varchar, getdate(), 108), ':', '') + '.txt',
      @w_destino2 = @w_path + 'lineas_boc_'      + replace(convert(varchar, @i_fecha, 102), '.', '') + '_' + replace(convert(varchar, getdate(), 108), ':', '') + '.txt',
       @w_errores  = @w_path + 'boc_' + replace(convert(varchar, @i_fecha, 102), '.', '') + '_' + replace(convert(varchar, getdate(), 108), ':', '') + '.err'

select @w_comando = @w_cmd + @w_path + 'boc -b5000 -c -T -e ' + @w_errores + ' -t"\t" ' + '-config ' + @w_s_app + 's_app.ini'

exec @w_error = xp_cmdshell @w_comando

if @w_error <> 0 begin
   select
   @w_error = 2108046,
   @w_mensaje = 'Error generando Reporte de Provisiones'
   goto ERRORFIN
end

----------------------------------------
--Generar Archivo de Cabeceras
----------------------------------------
select @w_col_id   = 0,
       @w_columna  = '',
       @w_cabecera = ''

while 1 = 1 begin
   set rowcount 1
   select @w_columna = replace(c.name, 'bo_', ''),
          @w_col_id  = c.colid
   from cob_conta..sysobjects o, cob_conta..syscolumns c
   where o.id    = c.id
   and   o.name  = 'cb_boc'
   and   c.colid > @w_col_id
   order by c.colid

   if @@rowcount = 0 begin
      set rowcount 0
      break
   end

   select @w_cabecera = @w_cabecera + @w_columna + char(9)
end


--Escribir Cabecera
select @w_comando = 'echo ' + @w_cabecera + ' > ' + @w_destino2

exec @w_error = xp_cmdshell @w_comando

if @w_error <> 0 begin
   select
   @w_error = 2108048,
   @w_mensaje = 'Error generando Archivo de Cabeceras'
   goto ERRORFIN
end

select @w_comando = 'copy ' + @w_destino2 + ' + ' + @w_path + 'boc ' + @w_destino

exec @w_error = xp_cmdshell @w_comando

if @w_error <> 0 begin
   select
   @w_error = 2108049,
   @w_mensaje = 'Error generando Archivo de  mas cabeceras'
   goto ERRORFIN
end

return 0

ERRORFIN:

exec cob_cartera..sp_errorlog
@i_fecha       = @w_fecha_proceso,
@i_error       = @w_error,
@i_usuario     = 'OPERADOR',
@i_tran        = @w_sarta,
@i_tran_name   = @w_sp_name,
@i_rollback    = 'N',
@i_cuenta      = 'CONTABILIDAD',
@i_descripcion = @w_mensaje

return @w_error
go

