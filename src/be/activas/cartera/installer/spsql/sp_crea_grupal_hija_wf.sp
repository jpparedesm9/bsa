use cob_workflow
go

if object_id ('sp_crea_grupal_hija_wf') is not null
   drop procedure sp_crea_grupal_hija_wf
go
/*************************************************************************/
/*   Archivo:            sp_crea_grupal_hija_wf.sp                       */
/*   Stored procedure:   sp_crea_grupal_hija_wf                          */
/*   Base de datos:      cob_workflow                                    */
/*   Producto:           Originacion                                     */
/*   Disenado por:       VBR                                             */
/*   Fecha de escritura: 09/01/2017                                      */
/*************************************************************************/
/*                                  IMPORTANTE                           */
/*   Este programa es parte de los paquetes bancarios propiedad de       */
/*   "MACOSA", representantes exclusivos para el Ecuador de NCR          */
/*   Su uso no autorizado queda expresamente prohibido asi como          */
/*   cualquier acion o agregado hecho por alguno de sus                  */
/*   usuarios sin el debido consentimiento por escrito de la             */
/*   Presidencia Ejecutiva de MACOSA o su representante.                 */
/*************************************************************************/
/*                                  PROPOSITO                            */
/*   Este procedimiento almacenado, cambia el estado del tramite  a A    */
/*   en una actividad automatica                                         */
/*************************************************************************/
/*                                MODIFICACIONES                         */
/*   FECHA               AUTOR                       RAZON               */
/*   27-01-2017          VBR                   Emision Inicial           */
/*   19-05-2017          Jorge Salazar         CGS-S112643               */
/*   07-01-2019          MTA                   Validacion de of. mobil   */
/*   29-11-2022          ACH                   #194284 Dia de Pago       */
/*************************************************************************/
create procedure sp_crea_grupal_hija_wf
(
   @s_ssn            int           = null,
   @s_ofi            smallint,
   @s_user           login,
   @s_date           datetime,
   @s_srv            varchar(30)   = null,
   @s_term           descripcion   = null,
   @s_rol            smallint      = null,
   @s_lsrv           varchar(30)   = null,
   @s_sesn           int           = null,
   @s_org            char(1)       = null,
   @s_org_err        int           = null,
   @s_error          int           = null,
   @s_sev            tinyint       = null,
   @s_msg            descripcion   = null,
   @t_rty            char(1)       = null,
   @t_trn            int           = null,
   @t_debug          char(1)       = 'N',
   @t_file           varchar(14)   = null,
   @t_from           varchar(30)   = null,
   --variables
   @i_id_inst_proc   int,    --codigo de instancia del proceso
   @i_id_inst_act    int,
   @i_id_empresa     int,
   @i_etapa_flujo      varchar(10)  = 'FIN',-- LGU 2017-07-13: para ver en que momento se ccrea el DES y LIQ del prestamo
                                            -- (1) IMP: impresion: solo crear OP hijas
                                            -- (2) FIN: al final del flujo: crea DES y LIQ de OP hijas
   @o_id_resultado   smallint out
)
as
declare
   @w_return            int,
   @w_sp_name           varchar(30),
   @w_resultado         smallint,
   @w_oficial           login,
   @w_cod_oficial       int,
   @w_ofi_def_app_movil smallint,
   @w_tramite           int,
   @w_fecha_ini         datetime,
   @w_respuesta         varchar(10)

select @w_sp_name = 'sp_crea_grupal_hija_wf'

select @o_id_resultado = 2 -- DEVOLVER

exec cob_credito..sp_eje_calendario_dia_pago
@i_id_inst_proc = @i_id_inst_proc,
@o_respuesta    = @w_respuesta out

print 'sp_eje_calendario_dia_pago-->>@w_respuesta: ' + @w_respuesta
if @w_respuesta = 'NO'
begin
   return 0
end

select @w_oficial     = fu_login,
       @w_cod_oficial = oc_oficial
from cob_workflow..wf_inst_proceso
inner join cob_credito..cr_tramite on io_campo_3 = tr_tramite
inner join cobis..cc_oficial on oc_oficial = tr_oficial
inner join cobis..cl_funcionario on oc_funcionario = fu_funcionario
where io_id_inst_proc = @i_id_inst_proc

select @w_tramite = convert(int, io_campo_3)
from cob_workflow..wf_inst_proceso
where io_id_inst_proc = @i_id_inst_proc

select @w_fecha_ini = op_fecha_ini
from cob_cartera..ca_operacion
where op_tramite = @w_tramite

-- PRINT 'NUMERO DE OFICINA POR DEFECTO DEL APP MOVIL'
select @w_ofi_def_app_movil = pa_smallint 
from   cobis..cl_parametro 
where  pa_nemonico = 'OFIAPP' 
and    pa_producto = 'CRE'

if(@s_ofi = @w_ofi_def_app_movil)
begin
	select @s_ofi = fu_oficina	
	from   cobis..cl_funcionario, 
	       cobis..cc_oficial
	where  oc_oficial     = @w_cod_oficial
	and    oc_funcionario = fu_funcionario
end

exec @w_return = sp_pasa_cartera_wf
   @s_ssn            = @s_ssn          ,
   @s_ofi            = @s_ofi          ,
   @s_user           = @w_oficial      ,
   @s_date           = @s_date         ,
   @s_srv            = @s_srv          ,
   @s_term           = @s_term         ,
   @s_rol            = @s_rol          ,
   @s_lsrv           = @s_lsrv         ,
   @s_sesn           = @s_sesn         ,
   @s_org            = @s_org          ,
   @s_org_err        = @s_org_err      ,
   @s_error          = @s_error        ,
   @s_sev            = @s_sev          ,
   @s_msg            = @s_msg          ,
   @t_rty            = @t_rty          ,
   @t_trn            = @t_trn          ,
   @t_debug          = @t_debug        ,
   @t_file           = @t_file         ,
   @t_from           = @t_from         ,
   @i_id_inst_proc   = @i_id_inst_proc ,
   @i_id_inst_act    = @i_id_inst_act  ,
   @i_id_empresa     = @i_id_empresa   ,
   @i_etapa_flujo    = 'IMP',
   @i_fecha_ini      =  @w_fecha_ini   ,
   @o_id_resultado   = @w_resultado out

if @w_return <> 0
begin
    select @o_id_resultado = 3 -- Error
    goto ERROR
end

select @o_id_resultado = 1 --OK

return 0
ERROR:
return @w_return
GO
