/************************************************************************/
/*   Archivo:              ahboc.sp                                     */
/*   Stored procedure:     sp_boc                                       */
/*   Base de datos:        cob_ahorros                                  */
/*   Producto:             Ahorros                                      */
/*   Disenado por:         FDLT                                         */
/*   Fecha de escritura:   Jul/2010                                     */
/************************************************************************/
/*                              IMPORTANTE                              */
/*   Esta aplicacion es parte de los paquetes bancarios propiedad       */
/*   de COBISCorp.                                                      */
/*   Su uso no autorizado queda expresamente prohibido asi como         */
/*   cualquier alteracion o agregado  hecho por alguno de sus           */
/*   usuarios sin el debido consentimiento por escrito de COBISCorp.    */
/*   Este programa esta protegido por la ley de derechos de autor       */
/*   y por las convenciones  internacionales   de  propiedad inte-      */
/*   lectual.    Su uso no  autorizado dara  derecho a COBISCorp para   */
/*   obtener ordenes  de secuestro o retencion y para  perseguir        */
/*   penalmente a los autores de cualquier infraccion.                  */
/************************************************************************/
/*                               PROPOSITO                              */
/*   Balance Operativo Contable de Ahorros.                             */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*      FECHA       AUTOR           RAZON                               */
/*  02/May/2016     J. Calderon     Migración a CEN                     */
/************************************************************************/

USE cob_ahorros
GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

if exists (select 1 from sysobjects where name = 'sp_boc')
   drop proc sp_boc
go

create procedure sp_boc(
   @t_show_version       bit = 0,
   @i_param1             varchar(255), --EMPRESA
   @i_param2             varchar(255), --FECHA
   @i_param3             varchar(255), --HISTORICO
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
@w_fecha_proceso      datetime,
@w_error              int,
@w_perfil             varchar(20),
@w_mensaje            varchar(100),
@w_sarta              int,
@i_empresa            tinyint,
@i_fecha              datetime,
@i_historico          char(1)


/* INICIO DE VARIABLES DE TRABAJO */
select 
@w_producto = 4,
@w_sp_name  = 'sp_boc',
@w_perfil   = 'BOC_AHO'

select  @i_empresa      = convert(tinyint,  @i_param1)
select  @i_fecha        = convert(datetime, @i_param2)
select  @i_historico    = convert(char(1),  @i_param3)


---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
if @t_show_version = 1
begin
    print 'Stored Procedure = '+ @w_sp_name + 'Version = ' + '4.0.0.0'
    return 0
end 


/* DETERMINAR LA FECHA DE PROCESO */
select @w_fecha_proceso = fc_fecha_cierre
from   cobis..ba_fecha_cierre
where  fc_producto = @w_producto


/*CREAR TABLAS DE TRABAJO*/
create table #dato_operacion_rubro(
do_banco           varchar(24)   not null,
do_toperacion      varchar(10)   not null,
do_moneda          smallint      not null,
do_tpersona        varchar(10)   not null,
do_estado_cta      char(1)       not null,
do_en_tesoro       char(1)       null,
do_oficina         smallint      not null,
do_cliente         int           not null,
do_concepto        varchar(10)   not null,
do_codvalor        int           not null,
do_parametro       varchar(20)   not null,
do_clave           varchar(30)   not null,
do_saldo           money         not null,
do_clase_clte      char(1)       null,
do_prod_banc       tinyint       null,
do_causa           char(1)       null)

create index idx1 on #dato_operacion_rubro(do_banco)


create table #cuentas_boc(
parametro     varchar(10) not null,
clave         varchar(20) not null,
cuenta        varchar(40) not null,
tercero       char(1)     not null,
naturaleza    char(1)     not null)

create index idx1 on #cuentas_boc(parametro, clave)


create table #boc(
bo_cuenta      varchar(40) not null,
bo_oficina     smallint    not null,
bo_cliente     int         not null,
bo_banco       varchar(24) not null,
bo_concepto    varchar(10) not null,
bo_val_opera   money       not null,
bo_val_conta   money       not null)

create index idx1 on #boc (bo_cuenta, bo_oficina, bo_cliente)



/* CARGAR SALDOS CONTABLES A LA FECHA (BOC DE DOBLE VIA) */  
exec @w_error  = cob_conta..sp_boc_ini
@i_empresa     = 1,
@i_fecha       = @i_fecha,
@i_perfil      = @w_perfil,
@i_producto    = @w_producto,
@o_msg         = @w_mensaje out

if @w_error <> 0 goto ERRORFIN


/* CARGA DE LOS SALDOS DE CAPITAL DE LAS OPERACIONES DE AHORROS*/   
insert into #dato_operacion_rubro
select
do_banco           = dp_banco,
do_toperacion      = rtrim(dp_toperacion),
do_moneda          = dp_moneda,
do_tpersona        = dp_naturaleza_cliente,
do_estado_cta      = Case dp_estado when '1' then 'A' when '2' then 'I' else 'C' end,
do_tesoro_nacional = dp_tesoro_nacional,
do_oficina         = dp_oficina,
do_cliente         = dp_cliente,
do_concepto        = 'CAP',
do_codvalor        = 10,
do_parametro       = '',
do_clave           = '',
do_saldo           = dp_saldo_disponible + dp_saldo_camara12h + dp_saldo_camara24h, 
do_clase_clte      = null,
do_prod_banc       = 0,
do_causa           = null 
from cob_conta_super..sb_dato_pasivas
where dp_fecha       = @i_fecha
and   dp_aplicativo  = @w_producto
and   dp_cliente = isnull(@i_cliente, dp_cliente)

if @@error <> 0 begin
   select 
   @w_mensaje = ' ERROR AL CARGAR OPERACIONES A PROCESAR ' ,
   @w_error   = 253015
   goto ERRORFIN
end


/* CARGA DE LOS SALDOS DE INTERES CAUSADO DE LAS OPERACIONES DE AHORROS*/   
insert into #dato_operacion_rubro
select
do_banco           = dp_banco,
do_toperacion      = rtrim(dp_toperacion),
do_moneda          = dp_moneda,
do_tpersona        = dp_naturaleza_cliente,
do_estado_cta      = Case dp_estado when '1' then 'A' when '2' then 'I' else 'C' end,
do_tesoro_nacional = dp_tesoro_nacional,
do_oficina         = dp_oficina,
do_cliente         = dp_cliente,
do_concepto        = 'INT',
do_codvalor        = 20,
do_parametro       = '',
do_clave           = '',
do_saldo           = dp_saldo_int, 
do_clase_clte      = null,
do_prod_banc       = 0,
do_causa           = null
from cob_conta_super..sb_dato_pasivas
where dp_fecha       = @i_fecha
and   dp_aplicativo  = @w_producto
and   dp_cliente = isnull(@i_cliente, dp_cliente)

if @@error <> 0 begin
   select 
   @w_mensaje = ' ERROR AL CARGAR OPERACIONES A PROCESAR ' ,
   @w_error   = 253015
   goto ERRORFIN
end

update #dato_operacion_rubro
set    do_estado_cta = 'T'
where  do_estado_cta = 'I'
and    do_en_tesoro = 'S'

if @@error <> 0 begin
   select 
   @w_mensaje = ' ERROR AL ACTUALIZAR ESTADO A CUENTAS TRASLADADAS ' ,
   @w_error   = 253015
   goto ERRORFIN
end


update #dato_operacion_rubro
set    do_estado_cta = 'X'
where  do_estado_cta  = 'C'
and    do_en_tesoro   = 'S'

if @@error <> 0 begin
   select 
   @w_mensaje = ' ERROR AL ACTUALIZAR ESTADO A CUENTAS TRASLADADAS ' ,
   @w_error   = 253015
   goto ERRORFIN
end

if @i_cliente is not null
   SELECT * FROM #dato_operacion_rubro

print ' Revision #dato_operacion_rubro 1 OK'


/* DETERMINAR EL PARAMETRO Y CLAVE CONTABLE */
update #dato_operacion_rubro set
do_parametro = dp_cuenta,
do_clave     = case pa_stored
               when 'sp_ah01_pf' then convert(varchar,do_moneda) +'.'+ do_tpersona +'.'+ convert(varchar,do_toperacion)+'.'+do_estado_cta 
               when 'sp_ah02_pf' then convert(varchar,do_moneda) +'.'+ do_concepto
               when 'sp_ah03_pf' then convert(varchar,do_moneda) +'.'+ do_estado_cta
               when 'sp_ah04_pf' then convert(varchar,do_moneda) +'.'+ do_clase_clte +'.'+ convert(varchar,do_prod_banc)+'.'+ do_estado_cta+'.'+ do_concepto
               when 'sp_ah05_pf' then convert(varchar,do_moneda) +'.'+ do_clase_clte +'.'+ do_estado_cta
               else 'n/a' 
               end
from cob_conta..cb_det_perfil, cob_conta..cb_parametro
where dp_perfil   = @w_perfil
and   dp_empresa  = @i_empresa
and   dp_cuenta   = pa_parametro
and   dp_codval   = do_codvalor

if @@error <> 0 begin
   select
   @w_error = 141054,
   @w_mensaje = 'ERROR AL DETERMINAR EL PARAMETRO Y CLAVE CONTABLE'
   goto ERRORFIN 
end

if @i_cliente is not null
   SELECT * FROM #dato_operacion_rubro

print '#dato_operacion_rubro 2 OK'


/* DETERMINAR LAS CUENTAS CONTROLADAS POR EL BOC, SU PARAMETRO Y CRITERIO CONTABLE */
insert into #cuentas_boc
select distinct
parametro  = re_parametro,
clave      = re_clave,
cuenta     = re_substring,
tercero    = 'S',
naturaleza = ''
from cob_conta..cb_relparam, cob_conta..cb_det_perfil
where dp_perfil    = @w_perfil
and   re_empresa   = dp_empresa
and   re_producto  = dp_producto
and   re_parametro = dp_cuenta

/* DETERMINAR LA CATEGORIA DE LAS CUENTAS */
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

print '#cuentas_boc 3.1 OK '

insert into #boc
select
bo_cuenta      = cuenta,            
bo_oficina     = do_oficina,
bo_cliente     = case tercero when 'S' then do_cliente else 0 end,
bo_banco       = do_banco,
bo_concepto    = do_concepto,
bo_val_opera   = case naturaleza when 'D' then do_saldo else do_saldo * -1 end, 
bo_val_conta   = 0
from #dato_operacion_rubro, #cuentas_boc
where do_clave     = clave
and   do_parametro = parametro
and   abs(isnull(do_saldo,0)) > 0.01

print ' - tabla #boc - 5 OK'


/* ENTRAR BORRANDO */
delete cob_conta..cb_boc with (rowlock)
where bo_producto = @w_producto

if @@error <> 0 begin
   select 
   @w_mensaje = 'ERROR AL BORRAR LA TABLA DEL BOC' ,
   @w_error   = 257006
   goto ERRORFIN
end

delete cob_conta..cb_boc_det with (rowlock)
where bod_producto = @w_producto

if @@error <> 0 begin
   select 
   @w_mensaje = 'ERROR AL BORRAR LA TABLA DE DETALLES DEL BOC' ,
   @w_error   = 257005
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
   @w_mensaje = 'ERROR AL INSERTAR VALORES OPERATIVOS BOC' ,
   @w_error   = 353016 /** ERROR AL INSERTAR TRANSACCION A CONTABILIZAR **/
   goto ERRORFIN
end


insert into cob_conta..cb_boc_det
select
@i_fecha,     bo_cuenta,   bo_oficina,
bo_cliente,   bo_banco,    bo_concepto,
'',           '',          '',
bo_val_opera, @w_producto 
from #boc
where bo_banco <> ''

if @@error <> 0 begin
   select 
   @w_mensaje = 'ERROR AL INSERTAR DETALLE DE VALORES OPERATIVOS BOC' ,
   @w_error   = 353016 /** ERROR AL INSERTAR TRANSACCION A CONTABILIZAR **/
   goto ERRORFIN
end

if @i_historico = 'S' begin

   update cobis..cl_seqnos
   set    siguiente = siguiente + 1
   where  tabla     = 'ah_boc'
   
   select @w_secuencial = siguiente
   from   cobis..cl_seqnos
   where  tabla = 'ah_boc'
   
   if @w_secuencial > 2147483640
   begin
      update cobis..cl_seqnos
      set siguiente = 0 
      where tabla   = 'ah_boc'
   end

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
end

return 0

ERRORFIN:

print @w_mensaje
return @w_error


go

