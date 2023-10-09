/***********************************************************************/
/*  Archivo:            reporte_operativo_cb.sp                        */
/*  Stored procedure:   sp_reporte_operativo_cb                        */
/*  Base de datos:      cob_ahorros_his                                */
/*  Producto:           Cuentas de Ahorros                             */
/*  Disenado por:                                                      */
/*  Fecha de escritura:                                                */
/***********************************************************************/
/*                              IMPORTANTE                             */
/*  Esta aplicacion es parte de los paquetes bancarios propiedad       */
/*  de COBISCorp.                                                      */
/*  Su uso no    autorizado queda  expresamente   prohibido asi como   */
/*  cualquier    alteracion o  agregado  hecho por    alguno  de sus   */
/*  usuarios sin el debido consentimiento por   escrito de COBISCorp.  */
/*  Este programa esta protegido por la ley de   derechos de autor     */
/*  y por las    convenciones  internacionales   de  propiedad inte-   */
/*  lectual.    Su uso no  autorizado dara  derecho a    COBISCorp para*/
/*  obtener ordenes  de secuestro o  retencion y para  perseguir       */
/*  penalmente a los autores de cualquier   infraccion.                */
/***********************************************************************/
/*                              PROPOSITO                              */
/* Depuracion de los historiales de los saldos de AHORROS.             */
/***********************************************************************/
/*                          MODIFICACIONES                             */
/*  FECHA          AUTOR            RAZON                              */
/*  02/Mayo/2016   Walther Toledo   Migración a CEN                    */
/***********************************************************************/
USE cob_ahorros_his
go



SET ANSI_NULLS OFF
go


SET QUOTED_IDENTIFIER OFF
go



if exists (select
             1
           from   sysobjects
           where  name = 'sp_reporte_operativo_cb')
  drop proc sp_reporte_operativo_cb
go

create proc sp_reporte_operativo_cb(
   @i_param1   datetime,   -- FECHA TRANSACCION
   @t_show_version bit   = 0
)

as
declare
   @w_fecha_trn      datetime,
   @w_fecha_proceso  varchar(10),
   @w_fecha_trn2     varchar(10),
   @w_error          int,
   @w_msg            varchar(250),
   @w_sp_name        varchar(32),
   --PARAMETROS PARA BCP
   @w_s_app          varchar(50),
   @w_path           varchar(60),
   @w_cmd            varchar(255),
   @w_destino        varchar(255),
   @w_comando        varchar(5000),
   @w_errores        varchar(1500),
   @w_path_destino   varchar(255),
   @w_anio             varchar(4),
   @w_mes              varchar(2),
   @w_dia              varchar(2),
   @w_fecha1           varchar(50),
   @w_nombre           varchar(255),
   @w_columna          varchar(100),
   @w_nom_tabla    varchar(100),
   @w_col_id           int,
   @w_cabecera         varchar(5000),
   @w_nombre_cab       varchar(255),
   @w_nombre_plano  varchar(2500)


   /* INICIALIZACION DE VARIABLE */
select @w_fecha_trn     = @i_param1,
       @w_fecha_proceso = (select convert(varchar(10),fp_fecha,101) from cobis..ba_fecha_proceso),
       @w_sp_name       = 'sp_reporte_operativo_cb',
       @w_error         = 0,
       @w_msg           = '',
       @w_fecha_trn2    = convert(varchar(10),@w_fecha_trn,101)

                  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
    if @t_show_version = 1
    begin
        print 'Stored Procedure='+@w_sp_name+' Version=4.0.0.0'
        return 0
    end

/*** PARAMETROS GENERALES ***/
--PATH DE UBICACION
select @w_s_app = pa_char
from   cobis..cl_parametro
where  pa_producto = 'ADM'
and    pa_nemonico = 'S_APP'

/*** RUTA GENERACIËN DE LOS LISTADO ***/
select @w_path = pp_path_destino
from   cobis..ba_path_pro
where  pp_producto = 4

-----------------------------------------------------------------------
--GENERANDO BCP
-----------------------------------------------------------------------
select @w_anio    = substring(@w_fecha_trn2,7,10),
       @w_mes     = substring(@w_fecha_trn2,1,2),
       @w_dia     = substring(@w_fecha_trn2,4,5)

select @w_fecha1  = (right('00' + @w_mes,2) + right('00'+ @w_dia,2) +  @w_anio)

----------------------------------------
--Generar Archivo de Cabeceras
----------------------------------------
select
@w_nombre       = 'reporte_operativo_cb',
@w_nom_tabla    = 'ah_reporte_op_tmp',
@w_col_id       = 0,
@w_columna      = '',
@w_cabecera     = convert(varchar(1000), ''),
@w_nombre_cab   = @w_nombre

select @w_nombre_plano = @w_path + @w_nombre_cab + '_' + @w_fecha1 + '.txt'

if exists (select 1 from sysobjects where name = 'ah_reporte_op_tmp')
begin
   drop table ah_reporte_op_tmp

   if @@error <> 0
   begin
      select @w_msg   = 'ERROR ELIMINANDO TABLA DE GENERACION DE PLANO TEMPORAL',
             @w_error = 1

      goto ERROR
   end
end

select
FECHA_REP     = @w_fecha_proceso,
FECHA_TRN     = convert(varchar(10),hm_fecha,101),
HORA_TRN      = hm_hora,
CORRESPONSAL  = convert(varchar,upper(of_nombre)),
TIPO_TRN      = case when hm_tipo_tran = 253 and hm_causa = '260' then 'RECAUDO DE CUPO'
                     when hm_tipo_tran = 253 and hm_causa = '261' then 'AJUSTE CREDITO AL CUPO'
                     when hm_tipo_tran = 264 and hm_causa = '260' then 'USO DEL DISPONIBLE DE LA CUENTA'
                     when hm_tipo_tran = 264 and hm_causa = '261' then 'AJUSTE DEBITO AL CUPO'
                     else 'N/A'
                end,
CUENTA        = hm_cta_banco,
VALOR         = convert(varchar,hm_valor)
INTO ah_reporte_op_tmp
FROM cob_ahorros_his..ah_his_movimiento, cobis..cl_oficina
WHERE hm_fecha     = @w_fecha_trn
and   hm_tipo_tran in (253,264)
and   hm_causa     in ('260','261')
and   hm_oficina   in (select ac_codigo from cobis..cl_asoc_clte_serv where ac_tipo_cb = 'O')
and   hm_oficina   = of_oficina
UNION ALL
select
FECHA_REP     = @w_fecha_proceso,
FECHA_TRN     = convert(varchar(10),hs_tsfecha,101),
HORA_TRN      = hs_hora,
CORRESPONSAL  = convert(varchar,upper(of_nombre)),
TIPO_TRN      = case hs_tipo_transaccion when 303 then 'CANCELACION DE VALORES EN SUSPENSO' when 258 then 'GENERACION DE VALORES EN SUSPENSO' else 'NA'end,
CUENTA        = hs_cta_banco,
VALOR         = convert(varchar,hs_valor)
FROM cob_ahorros_his..ah_his_servicio, cobis..cl_oficina
WHERE hs_tsfecha          = @w_fecha_trn
and   hs_tipo_transaccion in (258,303)
and   hs_causa            = '260'
and   hs_oficina          in (select ac_codigo from cobis..cl_asoc_clte_serv where ac_tipo_cb = 'O')
and   hs_oficina          = of_oficina
ORDER BY HORA_TRN

if @@error <> 0
begin
   select @w_msg = 'ERROR CONSULTANDO TRANSACCIONES CB PARA REPORTE OPERATIVO',
          @w_error = 1
   goto ERROR
end

while 1 = 1
begin
   set rowcount 1
   select
   @w_columna = c.name,
   @w_col_id  = c.colid
   from cob_ahorros_his..sysobjects o, cob_ahorros_his..syscolumns c
   where o.id    = c.id
   and   o.name  = @w_nom_tabla
   and   c.colid > @w_col_id
   order by c.colid

   if @@rowcount = 0
   begin
       set rowcount 0
       break
   end

   select @w_cabecera = @w_cabecera + @w_columna + '^|'
end

select @w_cabecera = left(@w_cabecera, datalength(@w_cabecera) - 2)

--Escribir Cabecera
select @w_comando = 'echo ' + @w_cabecera + ' > ' + @w_nombre_plano

exec @w_error = xp_cmdshell @w_comando

if @w_error <> 0
begin
   select @w_error = 2902797, @w_msg = 'EJECUCION COMANDO BCP FALLIDA. REVISAR ARCHIVOS DE LOG GENERADOS.'
   goto ERROR
end

--EJECUCION PARA GENERAR ARCHIVO DATOS
select @w_comando = @w_s_app + 's_app bcp -auto -login cob_ahorros_his..ah_reporte_op_tmp out '

select
@w_destino  = @w_path + 'reporte_operativo_cb.txt',
@w_errores  = @w_path + 'reporte_operativo_cb.err'

select @w_comando = @w_comando + @w_destino + ' -b5000 -c -e' + @w_errores + ' -t"|" ' + '-config '+ @w_s_app + 's_app.ini'


exec @w_error = xp_cmdshell @w_comando

if @w_error <> 0
begin
   select @w_msg = 'ERROR GENERANDO ARCHIVO REPORTE OPERATIVO CB'
   goto ERROR
end

----------------------------------------
--Union de archivos (cab) y (dat)
----------------------------------------

select @w_comando = 'copy ' + @w_nombre_plano + ' + ' + @w_path + 'reporte_operativo_cb.txt' + ' ' + @w_nombre_plano

exec @w_error = xp_cmdshell @w_comando

select @w_cmd = 'del ' + @w_destino
exec xp_cmdshell @w_cmd

if @w_error <> 0
begin
   select @w_msg = 'EJECUCION COMANDO BCP FALLIDA. ELIMINACION DE ARCHIVO, REVISAR ARCHIVOS DE LOG GENERADOS'
   goto ERROR
end

RETURN 0

ERROR:

   print @w_msg
   return @w_error


go

