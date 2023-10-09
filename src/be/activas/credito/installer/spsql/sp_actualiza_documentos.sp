/************************************************************************/
/*   Archivo:              sp_actualiza_documentos.sp                   */
/*   Stored procedure:     sp_actualiza_documentos.sp                   */
/*   Base de datos:        cob_credito                                  */
/*   Producto:             Credito                                      */
/*   Disenado por:         Alexander Llandán                            */
/*   Fecha de escritura:   Noviembre 2022                               */
/************************************************************************/
/*                                  IMPORTANTE                          */
/*   Este programa es parte de los paquetes bancarios propiedad de      */
/*   'COBIS'.                                                           */
/*   Su uso no autorizado queda expresamente prohibido asi como         */
/*   cualquier alteracion o agregado hecho por alguno de sus            */
/*   usuarios sin el debido consentimiento por escrito de la            */
/*   Presidencia Ejecutiva de COBIS o su representante legal.           */
/************************************************************************/
/*                                   PROPOSITO                          */
/*   Actualizar en COBIS la información de los documentos               */
/*                              CAMBIOS                                 */
/*   25/11/2022               A. Llandán          Versión Inicial       */
/************************************************************************/

use cob_credito
go

if exists (select 1 from sysobjects where name = 'sp_actualiza_documentos')
   drop proc sp_actualiza_documentos
go

CREATE  PROCEDURE [dbo].[sp_actualiza_documentos](
    @i_id_inst_proc 	int 		 = null,   
    @i_id_inst_act  	int 		 = null,
    @i_tipo_doc        	varchar(5)			 = null,
    @i_nombre_doc       varchar(150) = null,
    @i_ente             int          = null,
    @i_grupo            int          = null,
    @i_ext_doc          varchar(5)   = null,
	@i_tipo             varchar(50)  = null,
    @i_tipo_doc_cstmr   varchar(10)  = null
)
as
declare
    @w_error_number    int,
    @w_sp_name         varchar(100),
    @w_cod_act      int,
    @w_id_asig_act  int,
    @w_id_paso      int


select @w_sp_name = 'sp_actualiza_documentos'


if lower(@i_tipo) = 'inbox'
begin

    select @w_cod_act = ia_codigo_act 
    from cob_workflow..wf_inst_actividad 
    where ia_id_inst_act = @i_id_inst_act
    and ia_id_inst_proc = @i_id_inst_proc

    select @w_id_paso = ia_id_paso,
          @w_id_asig_act = aa_id_asig_act 
   from cob_workflow..wf_inst_actividad,cob_workflow..wf_asig_actividad
   where ia_id_inst_act = aa_id_inst_act
   and ia_id_inst_proc = @i_id_inst_proc
   and ia_id_inst_act = @i_id_inst_act
   
    delete from cob_workflow..wf_req_inst 
    where ri_id_inst_proc = @i_id_inst_proc 
    and ri_codigo_act = @w_cod_act
    and ri_codigo_tipo_doc = @i_tipo_doc
   
        insert into cob_workflow..wf_req_inst 
        (ri_id_inst_proc,   ri_codigo_act,      ri_codigo_tipo_doc,
        ri_nombre_doc,      ri_observacion,     ri_fecha_registro,
        ri_excepcionable)
        values
        (@i_id_inst_proc,   @w_cod_act,         @i_tipo_doc,
        @i_nombre_doc,      'OK',               getdate(),
        0)

        if @@error <> 0 
          begin
               set @w_error_number = 2109112        
               goto ERROR
          END

    delete from cob_workflow..wf_requisito_actividad 
    where rc_inst_actividad = @i_id_inst_act 
    and rc_id_inst_proceso= @i_id_inst_proc
    and rc_codigo_tipo_doc = @i_tipo_doc

    insert into cob_workflow..wf_requisito_actividad
    (rc_codigo_tipo_doc,    rc_id_paso,         rc_id_inst_proceso,
     rc_inst_actividad,     rc_id_asig_act,     rc_texto,
     rc_terminado,          rc_cliente_proc,    rc_excepcionable)
    values
    (@i_tipo_doc,           @w_id_paso,              @i_id_inst_proc,
     @i_id_inst_act,        @w_id_asig_act,              'OK',
     1,                     null,               0)

     if @@error <> 0 
      begin
           set @w_error_number = 2109112        
           goto ERROR
      END

    delete from cob_workflow..wf_requisito_actividad_tmp 
    where rc_inst_actividad = @i_id_inst_act 
    and rc_id_inst_proceso= @i_id_inst_proc 
    and rc_codigo_tipo_doc = @i_tipo_doc

    insert into cob_workflow..wf_requisito_actividad_tmp
    (rc_codigo_tipo_doc,    rc_id_paso,         rc_id_inst_proceso,
     rc_inst_actividad,     rc_id_asig_act,     rc_texto,
     rc_terminado,          rc_cliente_proc,    rc_excepcionable)
    values
    (@i_tipo_doc,           @w_id_paso,              @i_id_inst_proc,
     @i_id_inst_act,        @w_id_asig_act,              'OK',
     1,                     null,               0)

    if @@error <> 0 
      begin
           set @w_error_number = 2109112        
           goto ERROR
      END
end

if lower(@i_tipo) = 'customer'
begin
    
    delete from cob_credito..cr_documento_digitalizado 
    where dd_inst_proceso = @i_id_inst_proc 
    and dd_cliente = @i_ente 
    and dd_grupo = @i_grupo
    and dd_tipo_doc = @i_tipo_doc_cstmr


    insert into cob_credito..cr_documento_digitalizado
    (dd_inst_proceso,       dd_cliente,         dd_grupo,
     dd_fecha,              dd_tipo_doc,        dd_cargado,
     dd_extension)
    values
    (@i_id_inst_proc,       @i_ente,            @i_grupo,
     getdate(),             @i_tipo_doc_cstmr,        'S',
     @i_ext_doc)

     if @@error <> 0 
      begin
           set @w_error_number = 2109112        
           goto ERROR
      END
    
end

return 0

ERROR:
   EXEC cobis..sp_cerror
        @t_from  = @w_sp_name,
        @i_num   = @w_error_number

    RETURN 1