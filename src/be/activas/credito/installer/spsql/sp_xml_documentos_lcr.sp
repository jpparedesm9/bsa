/************************************************************************/
/*   Archivo:              sp_xml_documentos_lcr.sp                     */
/*   Stored procedure:     sp_xml_documentos_lcr                        */
/*   Base de datos:        cob_credito                                  */
/*   Producto:             Credito                                      */
/*   Disenado por:         AINCA                                        */
/*   Fecha de escritura:   14/01/2019                                   */
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
/* Registra informacion de los documentos  en las tablas                */
/* cob_sincroniza, si_sincroniza y genera el XML si_sincroniza_det      */
/************************************************************************/
/*                               CAMBIOS                                */
/*      FECHA          AUTOR            CAMBIO                          */
/*      11/01/2019     AINCA             Emision Inicial                */
/*      15/03/2019     SRO              Corrección esquema secuenciales */
/*                                      en si_sincroniza                */
/*      30/06/2021     SRO              Error #161777                   */
/************************************************************************/
USE cob_credito
GO

if exists (select 1 from sysobjects where name = 'sp_xml_documentos_lcr')
drop proc sp_xml_documentos_lcr
go

create proc sp_xml_documentos_lcr (
   -- variables
   @i_inst_proc  int
   
   
)
as
declare
    @w_tramite             INT,
    @w_cod_entidad         VARCHAR(10),
    @w_codigo              INT,
    @w_fecha_proceso       DATETIME,
    @w_des_entidad         VARCHAR(64),
    @w_accion              VARCHAR(255),
    @w_observacion         VARCHAR(255),
    @w_error               INT,
    @w_sp_name             VARCHAR(32),
    @w_msg                 VARCHAR(100),
    @w_user                login,
	@w_toperacion          catalogo,
	@w_cliente             int,
	@w_nombre_cl           varchar(64),
	@w_filas               int,
	@w_oficial             smallint,
	@w_inst_actividad      INT

select @w_sp_name = 'sp_xml_documentos_lcr'

SET ROWCOUNT 0

--Fecha de Proceso
SELECT @w_fecha_proceso = fp_fecha FROM cobis..ba_fecha_proceso

--Codigo de la actividad
print 'Seccion busqueda de la instancia de la actividad'
select @w_inst_actividad = ia_id_inst_act 
from cob_workflow..wf_inst_actividad 
where ia_id_inst_proc =  @i_inst_proc

if @@rowcount = 0
begin
    select @w_error = 150000 -- ERROR EN INSERCION,
    select @w_msg = 'No existe informacion para esa instancia de proceso'
    goto ERROR
end

--Tramite
print 'Seccion busqueda del tramite'
SELECT @w_tramite = io_campo_3 
FROM cob_workflow..wf_inst_proceso
WHERE io_id_inst_proc =  @i_inst_proc
if @@rowcount = 0
begin
    select @w_error = 150000 -- ERROR EN INSERCION,
    select @w_msg = 'No existe informacion para esa instancia de proceso'
    goto ERROR
end

-- busqueda del oficial que incio el proceso
print 'Seccion busqueda del oficial del tramite'
select @w_oficial  = tr_oficial
from cob_credito..cr_tramite
where tr_tramite = @w_tramite

print 'Seccion busqueda del login del oficial'
--Toma el login del oficial
select @w_user = fu_login
from  cobis..cl_funcionario, cobis..cc_oficial
where oc_oficial = @w_oficial 
and oc_funcionario = fu_funcionario

if @w_user is null
begin
    select @w_error = 150000 -- ERROR EN INSERCION,
    select @w_msg = 'No existe el Oficial'
    goto ERROR
   
end

-- Comentarios
SELECT @w_accion = 'INGRESAR'
-- Observaciones
declare @w_aa_id_asig_act int, @w_texto varchar(max) = ''
select @w_aa_id_asig_act = io_campo_5
from cob_workflow..wf_inst_proceso where io_id_inst_proc =  @i_inst_proc

select @w_observacion = @w_observacion + ' ' + ol_texto
from cob_workflow..wf_observaciones OB, cob_workflow..wf_ob_lineas OL
where OB.ob_id_asig_act = OL.ol_id_asig_act
and ob_id_asig_act = @w_aa_id_asig_act

SELECT @w_observacion = isnull(@w_observacion,'DOCUMENTOS DIGITALIZADOS LCR')



print 'seccion para la obtencion de la entidad'
SELECT @w_des_entidad = valor , @w_cod_entidad = codigo
FROM cobis..cl_catalogo
WHERE tabla = ( SELECT codigo  FROM cobis..cl_tabla
                WHERE tabla = 'si_sincroniza') AND valor = 'DOCUMENTOS DIGITALIZADOS LCR'

if @w_des_entidad is null
begin
    select @w_error = 150000 -- ERROR EN INSERCION,
    select @w_msg = 'Tipo de operacion no corresponde a GRUPAL/INDIVIDUAL'
    goto ERROR
end

--Secuencial
exec 
@w_error     = cobis..sp_cseqnos
@t_debug     = 'N',
@t_file      = null,
@t_from      = @w_sp_name,
@i_tabla     = 'si_sincroniza',
@o_siguiente = @w_codigo out

if @w_error <> 0 begin
   goto ERROR
end

print 'seccion ingreso en la tabla de si_sincroniza'

if not exists (select 1 from cob_sincroniza..si_sincroniza where si_secuencial = @w_codigo) begin
   -- Insert en si_sincroniza
   INSERT INTO cob_sincroniza..si_sincroniza 
   (si_secuencial,           si_cod_entidad, si_des_entidad,
   si_usuario,               si_estado,      si_fecha_ing,
   si_fecha_sin,             si_num_reg)
   VALUES                             
   (@w_codigo,               @w_cod_entidad, @w_des_entidad,
   @w_user,                  'P',            @w_fecha_proceso,
   NULL,                     1)
   if @@error <> 0
   begin
       select @w_error = 150000 -- ERROR EN INSERCION
       select @w_msg = 'Insertar en si_sincroniza'
       goto ERROR
   end
end else begin
   select @w_error = 2108087, @w_msg = 'ERROR: YA EXISTE UNA SINCRONIZACION CON ESTE SECUENCIAL ' + convert(varchar, @w_codigo)
   print @w_msg
   goto ERROR	
end

print 'seccion ejecucion del sp que genera el xml'
-- Insert en si_sincroniza_det
exec @w_error = sp_xml_documentos_lcr_det
    @i_max_si_sincroniza = @w_codigo,
    @i_inst_proc         = @i_inst_proc,
    @i_tramite           = @w_tramite,
    @i_accion            = @w_accion,
    @i_observacion       = @w_observacion,
    @i_inst_actividad    = @w_inst_actividad


if @w_error <> 0
begin
    select @w_error = 150000 -- ERROR EN INSERCION,
    select @w_msg = 'Al ejecutra sp_xml_documentos_lcr_det'
    goto ERROR
end

return 0

ERROR:
begin --Devolver mensaje de Error
    exec cobis..sp_cerror
         @t_debug = 'N',
         @t_file  = 'S',
         @t_from  = @w_sp_name,
         @i_num   = @w_error,
         @i_msg   = @w_msg
    return @w_error
end

go
