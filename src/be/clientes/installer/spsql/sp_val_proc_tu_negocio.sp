/************************************************************************/
/*  Archivo:                sp_val_proc_tu_negocio.sp                 */
/*  Stored procedure:       sp_val_proc_tu_negocio                    */
/*  Base de Datos:          cob_workflow                                */
/*  Producto:               Clientes                                    */
/*  Disenado por:           PRO                                         */
/*  Fecha de Documentacion: 24/01/2020                                 */
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
/* Valida el inicio de unavalidacion Tu Negocio                         */
/************************************************************************/
/*          MODIFICACIONES                                              */
/*  FECHA       AUTOR                   RAZON                           */
/*  24/01/2020   PRO           Emision Inicial                          */
/* **********************************************************************/
use cob_workflow
go
    
if exists (select 1 from sysobjects where name = 'sp_val_proc_tu_negocio')
begin      
    drop procedure sp_val_proc_tu_negocio    
end
go

create procedure sp_val_proc_tu_negocio
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
    @w_ttramite		     varchar(10),
	 @w_fecha_proceso      datetime,
	 @w_ofi_lcr            int,
	 @w_dias_vto           int,
	 @w_solicitante        varchar(255)
   
 
select @w_sp_name = 'sp_val_proc_tu_negocio'


select @w_fecha_proceso  = fp_fecha from cobis..ba_fecha_proceso

if @t_show_version = 1
begin
    print 'Stored procedure sp_val_proc_tu_negocio, Version 1.0.0.0'
    return 0
end

select @w_ttramite = @i_campo_4
select @w_solicitante = @i_campo_7
select @w_ente = @i_campo_1

if @w_solicitante <> 'P'
begin
	print 'Error: el solicitante debe ser Persona Natural.'
	return 103177
end
if exists( select 1 from cobis..cl_ente_aux where ea_ente = @w_ente and ea_estado <> 'A')
begin
	print 'Error: el solicitante no es un Cliente'
	return 103144
end

return 0
go