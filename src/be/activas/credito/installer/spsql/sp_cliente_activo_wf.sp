/************************************************************************/
/*  Archivo:                sp_cliente_activo_wf.sp                     */
/*  Stored procedure:       sp_cliente_activo_wf                        */
/*  Base de Datos:          cob_workflow                                */
/*  Producto:               Credito                                     */
/*  Disenado por:           P. Ortiz                                    */
/*  Fecha de Documentacion: 25/Jul/2017                                 */
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
/* o algún integrante del grupo no es un cliente                        */
/************************************************************************/
/*          MODIFICACIONES                                              */
/*  FECHA       AUTOR                   RAZON                           */
/*  25/Jul/2017 P. Ortiz             Emision Inicial                    */
/*  13/Oct/2017 Ma. Jose Taco        Validacion de solicitud rechazada  */
/*  14/Nov/2017 P. Ortiz             Agregar validacion vinculado       */
/*  17/Abr/2019 P. Ortiz             Validacion inicio cliente/grupo    */
/*  29/Jun/2023 KVI                  Error.209995-Remov OpeGru en OpeInd*/
/* **********************************************************************/
use cob_workflow
go
    
if exists (select 1 from sysobjects where name = 'sp_cliente_activo_wf')
begin      
    drop procedure sp_cliente_activo_wf    
end
go

create procedure sp_cliente_activo_wf
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
    @w_tipo               varchar(30),
    @w_grupo              int,
    @w_ente               int,
    @w_ttramite		     varchar(10),
    @w_return             int,
    @w_reunion            varchar(125),
    @w_oficial            int,
    @w_oficial_grupo      int,
    @w_oficial_solicitud  int,
    @w_ecasado            catalogo,
    @w_eunion             catalogo,
    @w_rcony              smallint,
    @w_inst_proc_rech     int,
    @w_etapa_cancelado    varchar(50),
    @w_max_tramite_grupal int,
	 @w_solicitante        varchar(255)


select @w_sp_name = 'sp_cliente_activo_wf'

if @t_show_version = 1
begin
    print 'Stored procedure sp_cliente_activo_wf, Version 1.0.0.0'
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
print 'Tipo de solicitante: ' + @w_solicitante

/*
select @w_ttramite = isnull(@w_ttramite, '')
if @w_ttramite = '' return 0
*/

if @w_ttramite = 'GRUPAL'
begin	
	select @w_grupo   = convert(int, @i_campo_1)
	
	if @w_solicitante <> 'S'
	begin
		print 'Error: el solicitante no es un Grupo'
		/*exec cobis..sp_cerror
		   @i_num  = 103144,
		   @t_from = @w_sp_name*/
		return 103176
	end
	
	select @w_max_tramite_grupal = max(tg_tramite)
	from cob_credito..cr_tramite_grupal
	where tg_grupo = @w_grupo
		
	print 'ULTIMO TRAMITE ' + convert(varchar(10), @w_max_tramite_grupal) 

	if exists (select 1 from cob_credito..cr_tramite where tr_tramite = @w_max_tramite_grupal and tr_estado in ('X','Z'))
    begin --si la solicitud anterior fue rechazada
       print 'ULTIMO TRAMITE fue rechazado' 
       select @w_inst_proc_rech = io_id_inst_proc 
       from cob_workflow..wf_inst_proceso  
       where io_campo_3 = @w_max_tramite_grupal
       
       select @w_etapa_cancelado = pa_char
       from cobis..cl_parametro 
       where pa_nemonico = 'ETCAN'
       and pa_producto = 'CCA'
       
       -- si el tramite fue rechazado y no paso por la etapa de CANCELACION, no deja continuar. Los que pasaron por etapa de CANCELACION si pueden pasar 
       if not exists(select 1 from cob_workflow..wf_inst_actividad where ia_nombre_act= @w_etapa_cancelado and ia_id_inst_proc = @w_inst_proc_rech) 
	   and not exists(select 1 from cob_workflow..wf_inst_proceso  where io_estado = 'CAN' and io_campo_3 = @w_max_tramite_grupal)
	   begin
          print 'Error: No se puede crear una solicitud de un grupo con solicitud previa rechazada'
		  return 70011016
	   end	    
    end
	    
	
	
	if exists( select 1 from cobis..cl_grupo where gr_grupo=@w_grupo and gr_estado='C')
       begin
         print 'Error: El Grupo tiene estado Cancelado'

         /*exec cobis..sp_cerror
            @i_num  = 103147,
            @t_from = @w_sp_name*/
        return 103147
         
       end

    exec @w_return = cob_pac..sp_grupo_busin
    @i_operacion ='V',
    @i_grupo    = @w_grupo,
	@t_trn      = 800
	
    if @w_return <> 0
    begin
        /* exec cobis..sp_cerror
            @i_num  = 208925, --VALIDACION COMITE
            @t_from = @w_sp_name*/
        return 208925
    end
	
	/* Oficial diferente al del grupo ***/
	select @w_oficial_grupo = gr_oficial
	from cobis..cl_grupo
	where gr_grupo = @w_grupo
	
	select @w_oficial_solicitud = oc_oficial
	from cobis..cc_oficial,cobis..cl_funcionario
	where oc_funcionario = fu_funcionario
	and fu_login = @s_user
	
	if @w_oficial_grupo <> @w_oficial_solicitud
	begin
	   print 'La solicitud tiene otro oficial diferente al del grupo'
	   /*exec cobis..sp_cerror
            @i_num  = 101115,
            @t_from = @w_sp_name*/
       return 101115
	end
	
	select @w_ente = 0
	WHILE 1 = 1
	begin
	   
		select TOP 1 @w_ente = cg_ente from cobis..cl_cliente_grupo 
		where cg_grupo = @w_grupo and cg_estado='V'
		and cg_ente > @w_ente
		ORDER BY cg_ente ASC 
		
		if @@ROWCOUNT = 0
			BREAK
		
		if exists( select 1 from cobis..cl_ente_aux where ea_ente = @w_ente and ea_estado <> 'A')
			begin
			print 'Error: un integrante del grupo no es un Cliente'
			
			/*exec cobis..sp_cerror
			@i_num  = 103145,
			@t_from = @w_sp_name*/
			return 103145
		 
		end
		
		if exists(select 1 from cobis..cl_ente where en_ente = @w_ente and en_oficial <> @w_oficial_grupo)
		begin
			print 'Error: un integrante tiene un oficial diferente al del grupo.'
			return 103191
		end
		
		select @i_vinculado = en_vinculacion from cobis..cl_ente where en_ente = @w_ente
	   
		if (@i_vinculado = 'S')
		begin
			/* Error, uno de los integrantes del grupo es Vinculado */
			return 103158
			
		end
	   
	end
	
	select @w_reunion = gr_dir_reunion from cobis..cl_grupo where gr_grupo = @w_grupo
    
    if ((@w_reunion IS NULL) or (@w_reunion = ' '))    -- Lugar de reunion
    begin
    --print'VALIDAR Lugar de Reunion.'+CONVERT(VARCHAR(30),@w_porcentaje)
      /*exec cobis..sp_cerror
            @i_num  = 208933, --EL GRUPO NO CUENTA CON LUGAR DE REUNION, POR FAVOR INGRESE
            @t_from = @w_sp_name*/
        return 208933
    end
	
	if exists (select 1 from cob_workflow..wf_inst_proceso where io_campo_1 = @w_grupo and io_estado = 'EJE' and io_campo_7 = 'S')
	begin
		print 'Error el grupo tiene un trámite en ejecución.'
	   /*	exec cobis..sp_cerror
            @i_num  = 103156,
            @t_from = @w_sp_name*/
        return 103156
	end
	
	/********* Cliente casado y sin conyugue ********/
	select @w_ecasado = pa_char from cobis..cl_parametro where pa_nemonico = 'CDA' and pa_producto='CLI'
	select @w_eunion = pa_char from cobis..cl_parametro where pa_nemonico = 'UNL' and pa_producto='CLI'
	select @w_rcony = pa_tinyint from cobis..cl_parametro where pa_nemonico = 'CONY' and pa_producto='CLI'
	
	if exists (select 1 from cobis..cl_ente CL
	           where en_ente in (select cg_ente from cobis..cl_cliente_grupo where cg_grupo = @w_grupo and cg_estado = 'V')
	           and p_estado_civil in (@w_ecasado, @w_eunion)
	           and en_ente not in (select co_ente from cobis..cl_conyuge
	                               where co_ente in (select cg_ente from cobis..cl_cliente_grupo where cg_grupo = @w_grupo and cg_estado = 'V')))
	                               
	 begin
	   print 'Existe un Cliente casado y sin datos de Conyugue'
	   /*exec cobis..sp_cerror
            @i_num  = 103157,
            @t_from = @w_sp_name*/
       return 103157
	 end
	     
	
end
else
begin
	
	select @w_ente   = convert(int,@i_campo_1)
	
	if @w_solicitante <> 'P'
	begin
		print 'Error: el solicitante debe ser Persona Natural.'
		/*exec cobis..sp_cerror
		   @i_num  = 103144,
		   @t_from = @w_sp_name*/
		return 103177
	end
	if exists(select 1 from cobis..cl_ente_aux where ea_ente = @w_ente and ea_estado <> 'A')
	begin
		print 'Error: el solicitante no es un Cliente'
		/*exec cobis..sp_cerror
		   @i_num  = 103144,
		   @t_from = @w_sp_name*/
		return 103144
	end
	
	/* Oficial diferente al del cliente ***/
	select @w_oficial = en_oficial
	from cobis..cl_ente
	where en_ente = @w_ente
	
	select @w_oficial_solicitud = oc_oficial
	from cobis..cc_oficial,cobis..cl_funcionario
	where oc_funcionario = fu_funcionario
	and fu_login = @s_user
	
	if @w_oficial <> @w_oficial_solicitud
	begin
	   print 'La solicitud tiene un oficial diferente al del cliente.'
      return 103198
	end
	
	if exists (select 1 from cob_workflow..wf_inst_proceso where io_campo_1 = @w_ente and io_estado = 'EJE' and io_campo_7 = 'P' and io_campo_4 = 'INDIVIDUAL')
	begin
		print 'Error, el cliente tiene un trámite en ejecución.'
	   /*	exec cobis..sp_cerror
            @i_num  = 103156,
            @t_from = @w_sp_name*/
        return 103196
	end
	
	select @i_vinculado = en_vinculacion from cobis..cl_ente where en_ente = @w_ente
	   
	if (@i_vinculado = 'S')
	begin
		/* Error, el cliente es Vinculado */
		return 103159
	end
	
   /*if exists(select 1 from cob_cartera..ca_operacion, cob_credito..cr_tramite_grupal
      where op_banco = tg_prestamo and op_cliente = @w_ente and op_estado not in (0,99,3))
   begin
      return 103160
   end*/-- Se comenta en Error.209995
	
end

/*
--VALIDA EL INICIO  DE FLUJOS DE MODIFICACION DE SOBREGIROS

if exists (select 1 from cob_workflow..wf_proceso where pr_codigo_proceso = @w_id_proceso and  pr_producto in('CRE','CTE'))
begin
    if exists (select 1 from cob_credito..cr_tramite,cob_credito..cr_linea where li_tramite = tr_tramite and tr_toperacion <> 'SGC' and li_num_banco = @i_campo_2)
     begin
        exec cobis..sp_cerror
            @i_num  = 2107048,
            @t_from = @w_sp_name
        return 1
    end    
end

*/

--Validación de la oficina del grupo



return 0
GO
