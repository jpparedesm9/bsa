/************************************************************************/
/*  Archivo:                sp_var_continua_cuestionario.sp             */
/*  Stored procedure:       sp_var_continua_cuestionario                */
/*  Base de Datos:          cob_credito                                 */
/*  Producto:               Credito                                     */
/*  Disenado por:           JRO                                         */
/*  Fecha de Documentacion: 23/Feb/2023                                 */
/************************************************************************/
/*                           IMPORTANTE                                 */
/*  Este programa es parte de los paquetes bancarios propiedad de       */
/*  "MACOSA",representantes exclusivos para el Ecuador de la            */
/*  AT&T                                                                */
/*  Su uso no autorizado queda expresamente prohibido asi como          */
/*  cualquier autorizacion o agregado hecho por alguno de sus           */
/*  usuario sin el debido consentimiento por escrito de la              */
/*  Presidencia Ejecutiva de MACOSA o su representante                  */
/************************************************************************/
/*                            PROPOSITO                                 */
/* Procedure tipo Variable retorna SI, si se cumple con la regla del    */
/* caso#200142 APLCUES. Si se llama a sps de variables estas deben ser  */
/* agregadas al flujo.                                                  */
/* Variable tambiEn usada para la regla                                 */
/************************************************************************/
/*                         MODIFICACIONES                               */
/*  FECHA          AUTOR                   RAZON                        */
/************************************************************************/
use cob_credito
go

if exists(select 1 from sysobjects where name ='sp_var_continua_cuestionario')
   drop proc sp_var_continua_cuestionario
go

create proc sp_var_continua_cuestionario(
    @s_ssn     int         = null,
    @s_ofi     smallint    = null,
    @s_user    login       = null,
    @s_date    datetime    = null,
    @s_srv     varchar(30) = null,
    @s_term    descripcion = null,
    @s_rol     smallint    = null,
    @s_lsrv    varchar(30) = null,
    @s_sesn    int         = null,
    @s_org     char(1)     = null,
    @s_org_err int         = null,
    @s_error   int         = null,
    @s_sev     tinyint     = null,
    @s_msg     descripcion = null,
    @t_rty     char(1)     = null,
    @t_trn     int         = null,
    @t_debug   char(1)     = 'N',
    @t_file    varchar(14) = null,
    @t_from    varchar(30) = null,
    --variables
    @i_id_inst_proc int, --codigo de instancia del proceso
    @i_id_inst_act  int,
    @i_id_asig_act  int,
    @i_id_empresa   int,
    @i_id_variable  smallint
)
as
declare
@w_sp_name              varchar(32),
@w_asig_actividad       int,
@w_valor_ant            varchar(255),
@w_mensaje              varchar(255),
@w_return               int,
@w_fecha_proceso        datetime,
@w_tramite              int,
@w_orden                int,
@w_continua_cuestionario  char(2),
@w_tproducto            varchar(255),
@w_valor_nuevo          varchar(255),
@w_op_anterior          varchar(24),
@w_cliente              int,
@w_orden_rol            int,
@w_valor_nuevo_rol      int,
@w_id_variable_rol      int,
@w_valor_ant_rol        varchar(256)

select @w_sp_name = 'sp_var_continua_cuestionario'
print @w_sp_name

select @w_tramite  = convert(int, io_campo_3),
       @w_tproducto = io_campo_4
  from cob_workflow..wf_inst_proceso
 where io_id_inst_proc = @i_id_inst_proc

select @w_tramite = isnull(@w_tramite, 0)

select @w_continua_cuestionario = 'SI'

select @w_orden = 0

select @w_orden = er_orden 
from cr_ej_regla_aplica_cuest 
where er_id_inst_proc = @i_id_inst_proc
and er_in_etapa = 'S'

select @w_orden = @w_orden + 1

if not exists (select 1 from cr_ej_regla_aplica_cuest where er_orden = @w_orden and er_in_etapa = 'N')
    select @w_continua_cuestionario = 'NO'

----------**********----------**********----------**********----------**********----------**********----------**********
select @w_valor_nuevo = @w_continua_cuestionario

--VARIABLE PRINCIPAL
--insercion en estrucuturas de variables
if @i_id_asig_act is null
begin
   select @i_id_asig_act = 0
end

-- valor anterior de variable tipo en la tabla cob_workflow..wf_variable
select @w_valor_ant = isnull(va_valor_actual, '')
  from cob_workflow..wf_variable_actual
 where va_id_inst_proc = @i_id_inst_proc
   and va_codigo_var   = @i_id_variable

if @@rowcount > 0 --ya existe
begin
   --print '@i_id_inst_proc %1! @w_asig_actividad %2! @w_valor_ant %3!',@i_id_inst_proc, @w_asig_actividad, @w_valor_ant
   update cob_workflow..wf_variable_actual
      set va_valor_actual = @w_valor_nuevo
    where va_id_inst_proc = @i_id_inst_proc
      and va_codigo_var   = @i_id_variable
end
else
begin
   insert into cob_workflow..wf_variable_actual
          (va_id_inst_proc, va_codigo_var,  va_valor_actual)
   values (@i_id_inst_proc, @i_id_variable, @w_valor_nuevo)
end

--print '@i_id_inst_proc %1! @w_asig_actividad %2! @w_valor_ant %3!',@i_id_inst_proc, @w_asig_actividad, @w_valor_ant
if not exists(select 1
                from cob_workflow..wf_mod_variable
               where mv_id_inst_proc = @i_id_inst_proc
                 and mv_codigo_var   = @i_id_variable
                 and mv_id_asig_act  = @i_id_asig_act)
begin
   insert into cob_workflow..wf_mod_variable
          (mv_id_inst_proc,   mv_codigo_var,  mv_id_asig_act,
           mv_valor_anterior, mv_valor_nuevo, mv_fecha_mod)
   values (@i_id_inst_proc,   @i_id_variable, @i_id_asig_act,
           @w_valor_ant,      @w_valor_nuevo, getdate())

   if @@error > 0
   begin
      --registro ya existe
      select @w_return = 2101002
      goto ERROR
   end
end

return 0

ERROR:
   exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = @w_return,
      @i_msg   = @w_mensaje
   return @w_return
go
