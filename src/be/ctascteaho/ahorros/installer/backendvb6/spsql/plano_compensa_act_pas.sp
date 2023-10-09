/************************************************************************/
/*      Archivo:                plano_compensa_act_pas.sp               */
/*      Stored procedure:       sp_plano_compensa_act_pas               */
/*      Base de datos:          cob_ahorros                             */
/*      Producto:               Cuentas de Ahorros                      */
/*      Disenado por:                                                   */
/*      Fecha de escritura:                                             */
/************************************************************************/
/*                               IMPORTANTE                             */
/*  Esta aplicacion es parte de los paquetes bancarios propiedad        */
/*  de COBISCorp.                                                       */
/*  Su uso no    autorizado queda  expresamente   prohibido asi como    */
/*  cualquier    alteracion o  agregado  hecho por    alguno  de sus    */
/*  usuarios sin el debido consentimiento por  escrito de COBISCorp.    */
/*  Este programa esta  protegido  por la ley de   derechos de autor    */
/*  y por las    convenciones  internacionales   de  propiedad inte-    */
/*  lectual.    Su uso no  autorizado dara  derecho a COBISCorp para    */
/*  obtener ordenes  de secuestro o  retencion y para  perseguir        */
/*  penalmente a los autores de cualquier   infraccion.                 */
/************************************************************************/
/*                              PROPOSITO                               */
/*    Generar BCP Universo de Compensacion                              */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*    FECHA         AUTOR              RAZON                            */
/*  03/May/2016   Juan Tagle         Migración a CEN                    */
/************************************************************************/
use cob_ahorros
go

if exists (select 1 from sysobjects where name = 'sp_plano_compensa_act_pas')
   drop proc sp_plano_compensa_act_pas
go

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO


create proc sp_plano_compensa_act_pas(
     @t_show_version  bit = 0
)

as
declare @w_fecha     datetime,
        @w_return               int,
        @w_sp_name              varchar(100),
        @w_s_app                varchar(100),
        @w_path                 varchar(100),
        @w_cmd                  varchar(255),
        @w_comando              varchar(255),
        @w_nombre_archivo       varchar(255),
        @w_error                int,
        @w_msg                  varchar(100),
        @w_reg                  int

/*  Captura nombre de Stored Procedure  */
select @w_sp_name    = 'sp_plano_compensa_act_pas'

---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
if @t_show_version = 1
begin
 print 'Stored Procedure= ' + @w_sp_name +  ' Version= ' + '4.0.0.0'
 return 0
end

select @w_fecha = fp_fecha
from cobis..ba_fecha_proceso

select @w_path = ba_path_destino
from cobis..ba_batch
where ba_arch_fuente = 'cob_ahorros..sp_plano_compensa_act_pas'

if @w_path is null
begin
   select
      @w_error = 101270,
      @w_msg   = 'NO EXISTE LA RUTA DESTINO'
      GOTO ERRORFIN
end

select
@w_s_app = pa_char
from  cobis..cl_parametro
where pa_producto = 'ADM'
and   pa_nemonico = 'S_APP'

if @w_s_app is null
begin
   select
      @w_error  = 101270,
      @w_msg    = 'NO EXISTE LA RUTA S_APP'
      GOTO ERRORFIN
end

select @w_reg = count(1) from  cob_ahorros..ah_compensacion_actpas
if @w_reg  = 0
begin
      select
      @w_error       = 141080,
      @w_msg         = 'NO HAY REGISTRO EN cob_ahorros..ah_compensacion_actpas PARA GENERAR EL PLANO'
      GOTO ERRORFIN
end

if exists (select 1 from sysobjects where name = 'tmp_compensacion')
   drop table tmp_compensacion

create table tmp_compensacion(reg varchar(5000))

insert into tmp_compensacion(reg)
values ('TIPO DOC|NUM DOC|NOMBRE CLIENTE|OFICINA|DESC OFICINA|TIPO CTA AHO|CUENTA AHORRO|TIPO OBLIGACION|OBLIGACION|VALOR APLICADO|OBSERVACION')

if @@ROWCOUNT = 0
begin
      select
      @w_error       = 141080,
      @w_msg         = 'NO SE PUDO INSERTAR CABECERA'
      GOTO ERRORFIN
end
---REGISTRO DE LOS PAGOS APLICADOS REALMENTE

insert into tmp_compensacion(reg)
select
convert(varchar(2),   co_tipo_doc)        + '|' +
convert(varchar(30),  co_identificacion ) + '|' +
convert(varchar(100), co_nombre)          + '|' +
convert(varchar(4),   co_oficina)         + '|' +
convert(varchar(100), co_desc_oficina)    + '|' +
convert(varchar(100), (select pb_descripcion
                       from cob_remesas..pe_pro_bancario
                       where pb_pro_bancario = co_tipo_prod))       + '|' +
convert(varchar(24),  co_num_producto)    + '|' +
convert(varchar(10),  co_tipo_obligacion) + '|' +
convert(varchar(24),  co_operacion)       + '|' +
convert(varchar(100), co_valor_aplicado)  + '|' +
convert(varchar(250), co_observacion)
from  cob_ahorros..ah_compensacion_actpas
where co_estado_registro ='P'

if @@ERROR <> 0
begin
   select @w_error = 101272,
      @w_msg   = 'ERROR AL INSERTAR EN  tmp_compensacion'
      GOTO ERRORFIN
end

select @w_nombre_archivo = @w_path + 'compensacionActPas' + replace(convert (varchar(10), @w_fecha, 103), '/', '') + '.txt'
select @w_cmd     = @w_s_app + 's_app bcp -auto -login cob_ahorros..tmp_compensacion out '
select @w_comando = @w_cmd + @w_nombre_archivo + ' -b5000 -c -e ' + 'Universo_Compensacion_.err' + ' -config '+ @w_s_app + 's_app.ini'

exec @w_error = xp_cmdshell @w_comando

if @w_error <> 0
begin
      select
      @w_error = '22454',
      @w_msg   = 'Error Generando BCP Universo de Compensacion'
      GOTO ERRORFIN
end


return 0

ERRORFIN:
begin
     print  @w_msg
    exec sp_errorlog
    @i_fecha   = @w_fecha,
    @i_error   = @w_error,
    @i_usuario =  'opbatch' ,
    @i_tran    = 0,
    @i_cuenta  = '',
    @i_descripcion = @w_msg

 return 1
end

go

