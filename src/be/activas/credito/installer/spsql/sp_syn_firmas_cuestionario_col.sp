/************************************************************************/
/*   Archivo:              sp_syn_firmas_cuestionario_col.sp            */
/*   Stored procedure:     sp_syn_firmas_cuestionario_col.sp            */
/*   Base de datos:        cob_credito                                  */
/*   Producto:             Credito                                      */
/*   Disenado por:         NME                                          */
/*   Fecha de escritura:   03/09/2019                                   */
/************************************************************************/
/*                               IMPORTANTE                             */
/*   Este programa es parte de los paquetes bancarios propiedad de      */
/*   'MACOSA'.                                                          */
/*   Su uso no autorizado queda expresamente prohibido asi como         */
/*   cualquier alteracion o agregado hecho por alguno de sus            */
/*   usuarios sin el debido consentimiento por escrito de la            */
/*   Presidencia Ejecutiva de MACOSA o su representante.                */
/************************************************************************/
/*                                PROPOSITO                             */
/*   El programa genera XML para documentos COLECTIVOS                  */
/************************************************************************/
/*                               CAMBIOS                                */
/*      FECHA          AUTOR            CAMBIO                          */
/*      03/09/2019     NME              Emision Inicial                 */
/*      06/09/2019     NME              Se modifica estructura de xml   */
/*      30/06/2021     SRO              Error #161777                   */
/************************************************************************/
use cob_credito
go

if OBJECT_ID ('dbo.sp_syn_firmas_cuestionario_col') is not null
	drop procedure dbo.sp_syn_firmas_cuestionario_col
go

create proc sp_syn_firmas_cuestionario_col(
   @s_ssn            int         = null,
   @s_ofi            smallint,
   @s_user           login,
   @s_date           datetime,
   @s_srv            varchar(30) = null,
   @s_term           descripcion = null,
   @s_rol            smallint    = null,
   @s_lsrv           varchar(30) = null,
   @s_sesn           int         = null,
   @s_org            char(1)     = null,
   @s_org_err        int         = null,
   @s_error          int         = null,
   @s_sev            tinyint     = null,
   @s_msg            descripcion = null,
   @t_rty            char(1)     = null,
   @t_trn            int         = null,
   @t_debug          char(1)     = 'N',
   @t_file           varchar(14) = null,
   @t_from           varchar(30) = null,
   --variables
   @i_id_inst_proc   int,    --codigo de instancia del proceso
   @i_id_inst_act    int,    
   @i_id_empresa     int, 
   @o_id_resultado   smallint  out
)as
declare
@w_error               int,
@w_sp_name             varchar(30),
@w_tramite             int,
@w_nombre_actividad    varchar(30)     = null,
@w_toperacion          catalogo,
@w_cod_entidad         varchar(10),----NME 05/09/2019
@w_max_si_sincroniza   int,
@w_fecha_proceso       datetime,
@w_des_entidad         varchar(64),
@w_accion              varchar(255),
@w_observacion         varchar(255),
@w_msg                 varchar(100),
@w_user                login,
@w_cliente             int,
@w_filas               int,
@w_oficial             smallint,
@w_aa_id_asig_act      int,
@w_texto               varchar(max) = '',
@w_str                 nvarchar(max),
@w_str_result          nvarchar(max),
@w_nombre_act          VARCHAR(50),
@w_id_inst_act_parent  int

select @w_sp_name = 'sp_syn_firmas_cuestionario_col'

--Fecha de Proceso
select @w_fecha_proceso = fp_fecha from cobis..ba_fecha_proceso

--Tramite 
print 'Seccion información instancia de proceso'
select @w_cliente        = io_campo_1, -- Obtencion del id cliente
       @w_tramite        = io_campo_3  -- Obtencion del tramite
from cob_workflow..wf_inst_proceso
where io_id_inst_proc =  @i_id_inst_proc

if @@rowcount = 0
begin
    select @w_error = 2108060 -- ERROR EN INSERCION,
    select @w_msg = 'ERROR: NO EXISTE ENTE/TRAMITE ASOCIADO A LA INSTANCIA DE PROCESO'
    goto ERROR
end

select @w_id_inst_act_parent = id_inst_act_parent 
from cob_workflow..wf_inst_actividad 
where ia_id_inst_act = @i_id_inst_act

select @w_aa_id_asig_act  = aa_id_asig_act
from cob_workflow..wf_asig_actividad
where  aa_id_inst_act     = @w_id_inst_act_parent

/************** DEBE SER ASESOR EXTERNO*****************/
-- busqueda del oficial que incio el proceso
print 'Seccion busqueda del oficial del tramite'
select @w_oficial = ea_asesor_ext 
from cobis..cl_ente_aux 
where ea_ente = @w_cliente
/******************************************************/

print 'Seccion busqueda del login del oficial'
--Toma el login del oficial
select @w_user = fu_login
from  cobis..cl_funcionario, cobis..cc_oficial
where oc_oficial = @w_oficial 
and oc_funcionario = fu_funcionario

if @w_user is null
begin
    select @w_error = 151091 -- ERROR EN INSERCION,
    select @w_msg = 'No existe el Oficial'
    goto ERROR
   
end

-- Entidad
print 'seccion para la obtencion de la entidad'
select @w_des_entidad = valor , @w_cod_entidad = codigo
from cobis..cl_catalogo
where tabla = ( select codigo  from cobis..cl_tabla
                where tabla = 'si_sincroniza') and valor =  'FIRMAS Y CUESTIONARIO COLECTIVO'

if @w_des_entidad is null
begin
    select @w_error = 109004 -- ERROR EN INSERCION,
    select @w_msg = 'No existe el catálogo FIRMAS Y CUESTIONARIO COLECTIVO'
    goto ERROR
end

-- Seqnos
exec 
@w_error     = cobis..sp_cseqnos
@t_debug     = 'N',
@t_file      = null,
@t_from      = @w_sp_name,
@i_tabla     = 'si_sincroniza',
@o_siguiente = @w_max_si_sincroniza out
   

if @w_error <> 0
begin
    select @w_error = 109005 -- ERROR EN INSERCION,
    select @w_msg = 'No existe secuencial para la tabla si_sincroniza'
    goto ERROR
end

print 'secuencial sinc '+ convert(varchar,@w_max_si_sincroniza)

if not exists (select 1 from cob_sincroniza..si_sincroniza where si_secuencial = @w_max_si_sincroniza) begin
   -- Insert en si_sincroniza
   print 'seccion ingreso en la tabla de si_sincroniza'
   insert into cob_sincroniza..si_sincroniza 
   (si_secuencial,           si_cod_entidad, si_des_entidad,
   si_usuario,               si_estado,      si_fecha_ing,
   si_fecha_sin,             si_num_reg)
   values                             
   (@w_max_si_sincroniza,     @w_cod_entidad, @w_des_entidad,
   @w_user,                  'P',             getdate(),
   null,                     1)
   
   if @@error <> 0
   begin
       select @w_error = 150000 -- ERROR EN INSERCION
       select @w_msg = 'Insertar en si_sincroniza'
       goto ERROR
   end
end else begin
   select @w_error = 2108087, @w_msg = 'ERROR: YA EXISTE UNA SINCRONIZACION CON ESTE SECUENCIAL ' + convert(varchar, @w_max_si_sincroniza)
   print @w_msg
   goto ERROR	
end

-- Observaciones
select @w_observacion = @w_observacion + ' ' + ol_texto
from cob_workflow..wf_observaciones OB, cob_workflow..wf_ob_lineas OL
where OB.ob_id_asig_act = OL.ol_id_asig_act
and ob_id_asig_act      = @w_aa_id_asig_act

select @w_observacion = isnull(@w_observacion,'FIRMAS Y CUESTIONARIO COLECTIVO')
-- seccion xml documentos
print 'seccion ejecucion del sp que genera el xml documentos'
exec @w_error      = sp_xml_doc_cuest_col_det
@i_id_inst_proc    = @i_id_inst_proc,
@i_id_inst_act     = @i_id_inst_act,
@i_secuencial      = @w_max_si_sincroniza,
@i_observacion     = @w_observacion,
@t_debug           = @t_debug,
@t_file            = @t_file

if @w_error <> 0
begin
   select 
   @w_msg = 'Al ejecutra sp_xml_documentos_col_det'
   goto  ERROR
end

select @o_id_resultado = 1
return 0

ERROR:
return @w_error

GO
