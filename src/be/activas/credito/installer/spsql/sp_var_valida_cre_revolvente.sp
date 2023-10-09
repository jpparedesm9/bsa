/************************************************************************/
/*  Archivo:                sp_var_valida_cre_revolvente.sp             */
/*  Stored procedure:       sp_var_valida_cre_revolvente                */
/*  Base de Datos:          cob_credito                                 */
/*  Producto:               Credito                                     */
/*  Disenado por:           E. Báez                                     */
/*  Fecha de Documentacion: 24/Abr/2017                                 */
/************************************************************************/
/*          IMPORTANTE                                                  */
/*  Este programa es parte de los paquetes bancarios propiedad de       */
/*  "MACOSA",representantes exclusivos para el Ecuador de la            */
/*  AT&T                                                                */
/*  Su uso no autorizado queda expresamente prohibido asi como          */
/*  cualquier autorizacion o agregado hecho por alguno de sus           */
/*  usuario sin el debido consentimiento por escrito de la              */
/*  Presidencia Ejecutiva de MACOSA o su representante                  */
/************************************************************************/
/*          PROPOSITO                                                   */
/*  Permite determinar si el cliente cumple con todas las validaciones  */
/*  requeridas para acceder a un crédito revolvente                     */
/************************************************************************/
/*          MODIFICACIONES                                              */
/*  FECHA         AUTOR                   RAZON                         */
/* 13/Nov/2018   E. Báez              Emision Inicial                   */
/* 15/Dic/2021   KVI               Req.173886 Quitar valid.Cli.Amarillos*/
/* **********************************************************************/

use cob_credito
go

if exists(select 1 from sysobjects where name ='sp_var_valida_cre_revolvente')
	drop proc sp_var_valida_cre_revolvente
GO


CREATE PROC sp_var_valida_cre_revolvente
            (@s_ssn          int         = null,
	         @s_ofi          smallint    = null,
	         @s_user         login       = null,
             @s_date         datetime    = null,
	         @s_srv          varchar(30) = null,
	         @s_term	     descripcion = null,
	         @s_rol          smallint    = null,
	         @s_lsrv	     varchar(30) = null,
	         @s_sesn	     int 	       = null,
	         @s_org          char(1)     = null,
             @s_org_err      int 	       = null,
             @s_error        int 	       = null,
             @s_sev          tinyint     = null,
             @s_msg          descripcion = null,
             @t_rty          char(1)     = null,
             @t_trn          int         = null,
             @t_debug        char(1)     = 'N',
             @t_file         varchar(14) = null,
             @t_from         varchar(30) = null,
             --variables
             @i_id_inst_proc int,    --codigo de instancia del proceso
             @i_id_inst_act  int         = null,    
             @i_id_empresa   int, 
		     @o_id_resultado  smallint  out
			 
)
AS
DECLARE @w_sp_name       	    varchar(32),
        @w_tramite       	    int,
        @w_return        	    INT,
        ---var variables	
        @w_asig_actividad 	    int,
        @w_valor_ant      	    varchar(255),
        @w_valor_nuevo    	    varchar(255),
        @w_id_inst_act          int,
        @w_asig_act             int,
        @w_numero               int,
        @w_proceso			    varchar(5),
        @w_usuario			    varchar(64),
        @w_ente                 int,
        @w_observaciones        varchar(255),
        @w_fecha                datetime,
        @w_nombre               varchar(64),
        @w_p_apellido           varchar(64),
        @w_s_apellido           varchar(64),
        @w_correo               varchar(64),
        @w_correo_defecto       varchar(64),
        @w_error                int,
        @w_msg                  varchar(1000)
	    
       
print 'Inicio'

select @w_sp_name='sp_var_valida_cre_revolvente'
select @w_observaciones = ''
select @w_ente       = convert(int,io_campo_1),
	   @w_tramite     = convert(int,io_campo_3)
from cob_workflow..wf_inst_proceso
where io_id_inst_proc = @i_id_inst_proc
and   io_campo_4 = 'REVOLVENTE'
and   io_campo_7 = 'P' 

print 'Despues de select'

print 'EJECUTA CALCULO DE CALIFICACION:'
exec @w_error       = sp_regla_matriz_riesgo
@i_operacion        = 'I',
@i_ente             = @w_ente
print 'FIN CALCULO CALIFICACION'

--PARAMETROS
select @w_correo_defecto = pa_char from cobis..cl_parametro where pa_nemonico = 'CPDSAN'
select @w_proceso = pa_int from cobis..cl_parametro where pa_nemonico = 'OAA'

-- Validación de listas negras ea_lista_negra
if exists (select 1 from cobis..cl_ente_aux where ea_ente = @w_ente and ea_lista_negra = 'S')
begin
    print 'Listas Negras'
    select @w_observaciones = @w_observaciones + ' ' + 'Cliente esta en listas negras, '
end
-- Validación Negative FILE ea_negative_file
if exists (select 1 from cobis..cl_ente_aux where ea_ente = @w_ente and ea_negative_file = 'S')
begin
    print 'Negative File'
    select @w_observaciones = @w_observaciones + ' ' + 'Cliente esta en negative file, '
end
-- Validación Riesgo individual Externo ea_nivel_riesgo_cg
/*if exists (select 1 from cobis..cl_ente_aux where ea_ente = @w_ente and ea_nivel_riesgo_cg = 'E')--Req.173886
begin
    --cliente condicionado
    print 'Riesgo categoria E'
    select @w_observaciones = @w_observaciones + ' ' + 'Cliente condicionado, '
end*/
else if exists (select 1 from cobis..cl_ente_aux where ea_ente = @w_ente and ea_nivel_riesgo_cg = 'F')
begin
    --cliente rechazado
    print 'Riesgo categoria F'
    select @w_observaciones = @w_observaciones + ' ' + 'Cliente rechazado por Riesgo Individual Externo, '
end
-- Validación Matriz de Riesgo ea_nivel_riesgo
if exists (select 1 from cobis..cl_ente_aux where ea_ente = @w_ente and ea_nivel_riesgo in ('A3 Bloqueante', 'A3 CCC','A3 DR'))
begin
    --cliente rechazado
    print 'Matriz de Reisgo'
    select @w_observaciones = @w_observaciones + ' ' + 'Cliente rechazado por Matriz de Riesgo, '
end

--Extraer coma de la observacion
if ((@w_observaciones is not null) and (@w_observaciones<>''))
	select @w_observaciones = substring(@w_observaciones,0,len(@w_observaciones)) + '.'

print 'Motivo de rechazo: ' + @w_observaciones
if ((@w_observaciones is not null) and (@w_observaciones<>''))
begin
    print 'Antes de insertar cr_ns_rechaza_lcr'
    
    select @w_fecha = fp_fecha from cobis..ba_fecha_proceso
    
    select 	@w_nombre		= en_nombre,
			@w_p_apellido	= p_p_apellido,
			@w_s_apellido   = p_s_apellido
    from cobis..cl_ente
    where en_ente = @w_ente
    
    select top 1 @w_correo = mf_descripcion 
    from cobis..cl_medios_funcio, cobis..cc_oficial, cob_credito..cr_tramite
    where tr_tramite = @w_tramite
    and tr_oficial = oc_oficial
    and mf_funcionario = oc_funcionario
    and mf_tipo = 0 --0 es E-MAIL
    and mf_estado = 'V'
    
    if(@w_correo is null)
    begin
    	select @w_correo = @w_correo_defecto
    end
    
    insert into cob_credito..cr_ns_rechaza_lcr
           (nl_tramite, nl_fecha_reg, nl_cliente, nl_nombre, nl_apellido_paterno, nl_apellido_materno, nl_correo, nl_observaciones, nl_estado)
    values (@w_tramite, @w_fecha, @w_ente, @w_nombre, @w_p_apellido, @w_s_apellido,@w_correo, @w_observaciones, 'P')
    if(@@error <> 0)
		return 2109113
    
    
    /* Actualizo el estado del trámite */
    update cob_credito..cr_tramite
    set tr_estado = 'Z'
    where tr_tramite = @w_tramite
    if(@@error <> 0)
		return 2109113
    
    
    select @w_observaciones = 'La línea ha sido rechazada por las siguientes razones: ' + @w_observaciones
	
	select top 1 @w_id_inst_act = ia_id_inst_act
	from cob_workflow..wf_inst_actividad 
	where ia_id_inst_proc = @i_id_inst_proc
	and ia_tipo_dest is null
	order by ia_id_inst_act desc 
	
	select @w_asig_act = aa_id_asig_act 
	from cob_workflow..wf_asig_actividad 
	where aa_id_inst_act = @w_id_inst_act
	--select * from cob_workflow..wf_ob_lineas where ol_texto like '%do rechazada por las siguientes razones:%'
	delete cob_workflow..wf_observaciones 
	where ob_id_asig_act = @w_asig_act
	and ob_numero in (select ol_observacion from  cob_workflow..wf_ob_lineas 
	where ol_id_asig_act = @w_asig_act 
	and ol_texto like '%La línea ha sido rechazada por las siguientes razones:%')
	if(@@error <> 0)
		return 2109113
	
	delete cob_workflow..wf_ob_lineas 
	where ol_id_asig_act = @w_asig_act 
	and ol_texto like '%La línea ha sido rechazada por las siguientes razones:%'
	if(@@error <> 0)
		return 2109113
	
	select top 1 @w_numero = ob_numero from cob_workflow..wf_observaciones 
	where ob_id_asig_act = @w_asig_act
	order by ob_numero desc
	
	if (@w_numero is not null)
	begin
		select @w_numero = @w_numero + 1 --aumento en uno el maximo
	end
	else
	begin
		select @w_numero = 1
	end
	
	select @w_usuario = fu_nombre from cobis..cl_funcionario where fu_login = @s_user
	
	insert into cob_workflow..wf_observaciones (ob_id_asig_act, ob_numero, ob_fecha, ob_categoria, ob_lineas, ob_oficial, ob_ejecutivo)
	values (@w_asig_act, @w_numero, getdate(), @w_proceso, 1, 'a', @w_usuario)
	if(@@error <> 0)
		return 2109113
	
	insert into cob_workflow..wf_ob_lineas (ol_id_asig_act, ol_observacion, ol_linea, ol_texto)
	values (@w_asig_act, @w_numero, 1, @w_observaciones)
    if(@@error <> 0)
		return 2109113
    
	select @o_id_resultado = 3
    --select @w_valor_nuevo = '3'
end
else
begin
    select @o_id_resultado = 1
end


return 0
go

