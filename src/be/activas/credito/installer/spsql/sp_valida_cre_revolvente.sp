/************************************************************************/
/*  Archivo:                sp_valida_cre_revolvente.sp                 */
/*  Stored procedure:       sp_valida_cre_revolvente                    */
/*  Base de Datos:          cob_workflow                                */
/*  Producto:               Credito                                     */
/*  Disenado por:           E. Báez                                     */
/*  Fecha de Documentacion: 08/Nov/2018                                 */
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
/* Procedure programa de arranque, no inicia el flujo si el solicitante,*/
/* no ha tenido un credito anteriormente                                */
/************************************************************************/
/*          MODIFICACIONES                                              */
/*  FECHA       AUTOR                   RAZON                           */
/*  08/Nov/2018 E. Báez           Valida numero de ciclos de un cliente */
/*  17/Abr/2019 P. Ortiz             Validacion inicio cliente/grupo    */
/*  23/Ago/2021 S. Rojas             161141 Fase 2                      */
/* **********************************************************************/
use cob_workflow
go
    
if exists (select 1 from sysobjects where name = 'sp_valida_cre_revolvente')
begin      
    drop procedure sp_valida_cre_revolvente    
end
go

create procedure sp_valida_cre_revolvente
(
    @s_ssn                int          = null,
    @s_user               varchar(30)  = null,
    @s_sesn               int          = null,
    @s_term               varchar(30)  = null,
    @s_date               datetime     = null,
    @s_srv                varchar(30)  = null,
    @s_lsrv               varchar(30)  = null,
    @s_ofi                smallint     = null,
    @t_trn                int          = null,
    @t_debug              char(1)      = 'N',
    @t_file               varchar(14)  = null,
    @t_from               varchar(30)  = null,
    @s_rol                smallint     = null,
    @s_org_err            char(1)      = null,
    @s_error              int          = null,
    @s_sev                tinyint      = null,
    @s_msg                descripcion  = null,
    @s_org                char(1)      = null,
    @t_show_version       bit          = 0, -- Mostrar la version del programa
    @t_rty                char(1)      = null,        
    @i_operacion          char(1)      = 'I',
    @i_login              NOMBRE       = null,
    @i_id_proceso         smallint     = null,
    @i_version            smallint     = null,
    @i_nombre_proceso     NOMBRE       = null,
    @i_id_actividad       int          = null,
    @i_campo_1            int          = null,
    @i_campo_2            varchar(255) = null,
    @i_campo_3            int          = null,
    @i_campo_4            varchar(10)  = null,
    @i_campo_5            int          = null,
    @i_campo_6            money        = null,  
    @i_campo_7            varchar(255) = null,
    @i_ruteo              char(1)      = 'M',
    @i_ofi_inicio         smallint     = null,
    @i_ofi_entrega        smallint     = null,
    @i_ofi_asignacion     smallint     = null,
    @i_id_inst_act_padre  int          = null,
    @i_comentario         varchar(255) = null,
    @i_id_usuario         int          = null,
    @i_id_rol             int          = null,
    @i_id_empresa         smallint     = null,
    @i_inst_padre         int          = null,
    @i_inst_inmediato     int          = null,
    @i_vinculado          char(1)      = null,
    @o_siguiente          int          = null out

)As 
declare
@w_sp_name            varchar(64),
@w_id_proceso         smallint,
@w_version            smallint,        
@w_ente               int,
@w_ttramite		      varchar(10),
@w_fecha_proceso      datetime,
@w_ofi_lcr            int,
@w_dias_vto           int,
@w_solicitante        varchar(255),
@w_oficial_ente       int,
@w_oficial_solicitud  int,
@w_ofi_cons           varchar(20)
   
 
select @w_sp_name = 'sp_valida_cre_revolvente'


select @w_fecha_proceso  = fp_fecha from cobis..ba_fecha_proceso

if @t_show_version = 1
begin
    print 'Stored procedure sp_valida_cre_revolvente, Version 1.0.0.0'
    return 0
end

-- Si no se envian ni el id, ni la version del proceso.

if (@i_id_proceso is null) and (@i_version is null)
begin
     -- Por lo menos se debio haber enviado el nombre del mismo.     
	if @i_nombre_proceso is not null
    begin
        select @w_id_proceso = pr_codigo_proceso,
               @w_version    = pr_version_prd
        from wf_proceso
        where pr_nombre_proceso = @i_nombre_proceso
    end
    else
    begin
        -- Pero como no se envio ni el id, ni la version y tampoco
        -- el nombre, entonces se despliega un mensaje de error y se
        -- sale del stored procedure.
      /*  exec cobis..sp_cerror
             @i_num  = 3107525,
             @t_from = @w_sp_name*/
        return 3107525
    end
end
else
begin    
    -- Se almacenan tanto el id como la version en variables de trabajo.
    select @w_id_proceso = @i_id_proceso
    select @w_version    = pr_version_prd
    from wf_proceso
    where pr_codigo_proceso = @i_id_proceso
end



select @w_ttramite = @i_campo_4
select @w_solicitante = @i_campo_7

/* Oficina defecto lcr */
select @w_ofi_lcr = pa_smallint from cobis..cl_parametro where pa_nemonico = 'OFILCR'
--DIAS VENCIMIENTO OPERACION REVOLVENTE
select @w_dias_vto = pa_tinyint from cobis..cl_parametro with (nolock) where pa_producto = 'CCA' and pa_nemonico = 'DVOR'

print 'Tipo de tramite:  ' + convert(varchar(10), @w_ttramite) 
print '@i_ofi_inicio: ' + convert(varchar(10), @i_ofi_inicio)
print 'Tipo de solicitante: ' + @w_solicitante


select @w_ente   = convert(int,@i_campo_1)
if @w_solicitante <> 'P'
begin
	print 'Error: el solicitante debe ser Persona Natural.'
	
	/*exec cobis..sp_cerror
	  @i_num  = 103144,
	  @t_from = @w_sp_name*/
	return 103177
end

--LCR V2.0 FASE 2, VALIDACION OFICIAL IGUAL AL DEL CLIENTE CUANDO ES DIFERENTE DE CLIENTE CANDIDATO
if exists(select 1 from cobis..cl_ente_aux where ea_ente = @w_ente and ea_colectivo <> 'CC') begin
   /* Oficial diferente al del cliente ***/
   select @w_oficial_ente = en_oficial
   from cobis..cl_ente
   where en_ente = @w_ente
   -- 
   SELECT @w_ofi_cons = cc_asesor
   FROM cob_cartera..ca_lcr_candidatos 
   WHERE cc_cliente = @w_ente
   and cc_gerente = @s_user
   
   select @w_oficial_solicitud = oc_oficial
   from cobis..cc_oficial,cobis..cl_funcionario
   where oc_funcionario = fu_funcionario
   and fu_login = @w_ofi_cons

   if @w_oficial_ente <> @w_oficial_solicitud
   begin
      print 'La solicitud tiene otro oficial diferente al del cliente'     
      return 2108089
   end
end

--Req.161141
/*if exists(select 1 from cobis..cl_ente_aux where ea_ente = @w_ente and ea_colectivo is not null)
begin
	print 'Error: el solicitante no puede ser un cliente colectivo.'
	
	exec cobis..sp_cerror
	  @i_num  = 103144,
	  @t_from = @w_sp_name
	return 109003
end
*/

if exists( select 1 from cobis..cl_ente_aux where ea_ente = @w_ente and ea_estado <> 'A')
begin
	print 'Error: el solicitante no es un Cliente'
	
	/*exec cobis..sp_cerror
	  @i_num  = 103144,
	  @t_from = @w_sp_name*/
	return 103144
end

if exists (select 1 from cob_workflow..wf_inst_proceso 
       where io_campo_1 = @w_ente 
       and io_campo_4 = 'REVOLVENTE'
       and io_estado = 'EJE')
begin
    print 'Error al iniciar el flujo, el solicitante ya cuenta con una Línea de Crédito Revolvente abierta.'
    /*exec cobis..sp_cerror
    @i_num  = 2109110,
    @t_from = @w_sp_name     */
    return 2109111
end

--VALIDACION DE EXISTENCIA DE UNA LCR DENTRO DEL PERIODO
if exists (select 1 from cob_cartera..ca_operacion where op_cliente = @w_ente  and op_toperacion = 'REVOLVENTE' and @w_fecha_proceso between op_fecha_ini and op_fecha_fin)
begin 
	if(dateadd(dd,@w_dias_vto,@w_fecha_proceso) <> (select op_fecha_fin from cob_cartera..ca_operacion 
				where op_cliente = @w_ente  and op_toperacion = 'REVOLVENTE'))
	begin 
		print  'ERROR: EL CLIENTE TIENE UNA LCR EN CURSO'
		return 70067
	end
end

if(@w_ofi_lcr <> @i_ofi_inicio)
begin
	if exists (select 1 from cob_cartera..ca_operacion where op_cliente = @w_ente and op_estado <> 3) --Req.161141 (Validar)
	begin
		print 'Error al inciar el flujo, por favor inicie desde la pantalla: Autorizar Promoción Crédito Revolvente.'
		return 710607
	end
end

/*if not exists (select 1 from cob_cartera..ca_operacion where op_cliente = @w_ente)
begin
	print 'No se puede iniciar Línea de Crédito Revolvente para un cliente de mercado abierto'
	return 710609
end*/



return 0
go