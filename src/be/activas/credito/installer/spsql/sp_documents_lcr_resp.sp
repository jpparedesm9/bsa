
/* ********************************************************************* */
/*      Archivo:                sp_documents_lcr_resp.sp                 */
/*      Stored procedure:       sp_documents_lcr_resp                    */
/*      Base de datos:          cob_credito                              */
/*      Producto:               Credito                                  */
/*      Disenado por:           Alexander Inca                           */
/*      Fecha de escritura:     14-Enero-2019                            */
/* ********************************************************************* */
/*                              IMPORTANTE                               */
/*      Este programa es parte de los paquetes bancarios propiedad de    */
/*      "MACOSA", representantes exclusivos para el Ecuador de la        */
/*      "NCR CORPORATION".                                               */
/*      Su uso no autorizado queda expresamente prohibido asi como       */
/*      cualquier alteracion o agregado hecho por alguno de sus          */
/*      usuarios sin el debido consentimiento por escrito de la          */
/*      Presidencia Ejecutiva de MACOSA o su representante.              */
/*                              PROPOSITO                                */
/*      Generar XML para la sincronizacion de la etapda de documentos LCR*/
/* ********************************************************************* */
/*                              MODIFICACIONES                           */
/*      FECHA           AUTOR                RAZON                       */
/*      14/01/2019     AINCA                 Version Inicial             */
/* ********************************************************************* */

USE cob_credito
GO

IF OBJECT_ID ('dbo.sp_documents_lcr_resp') IS NOT NULL
    DROP PROCEDURE dbo.sp_documents_lcr_resp
GO

CREATE proc sp_documents_lcr_resp (
    @s_ssn                int      = null,
    @s_user               login    = null,
    @s_sesn               int    = null,
    @s_term               descripcion = null,
    @s_date               datetime = null,
    @s_srv		 		  varchar(30) = null,
    @s_lsrv	  	 		  varchar(30) = null,
    @s_rol				  smallint = null,
    @s_ofi                smallint  = null,
    @s_org_err		      char(1) = null,
    @s_error		      int = null,
    @s_sev		          tinyint = null,
    @s_msg		          descripcion = null,
    @s_org		          char(1) = null,
    @t_rty                char(1)  = null,
    @t_trn                smallint = null,
    @t_debug              char(1)  = 'N',
    @t_file               varchar(14) = null,
    @t_from               varchar(30) = null,
    @i_operacion          char(1)  = null,
    @i_inst_proceso       INT,
    @i_inst_actividad     INT             = null,
    @i_id_document        INT             = null,
    @i_logginAsesor       varchar(15)     = null,
    @i_statusInterested   varchar(2)      = null,
    @i_catalogue          varchar(10)     = null,
    @i_description        varchar(500)    = null,
	@i_tipo_credito       varchar(50)     = 'LCR'
    
)
as

declare
@w_error_number    int,
@w_sp_name         varchar(100),
@w_ia_id_paso      int,
@w_aa_asig_act     int


select @w_sp_name = 'sp_documents_lcr_resp'

print 'ANTES DE INGRESAR A LA OPCION I'
if @i_operacion = 'I'
BEGIN
print 'INGRESO A LA OPERACION I'
   INSERT INTO cob_credito..cr_resp_documents_lcr(
      dc_lcr_inst_process,     dc_lcr_inst_actividad, 
      dc_lcr_loggin_user,      dc_lcr_resp_estatus, 
      dc_lcr_catalogo,         dc_lcr_description,
      dc_lcr_fecha_document
   ) 
   VALUES(
      @i_inst_proceso,         @i_inst_actividad,
      @i_logginAsesor,         @i_statusInterested, 
      @i_catalogue,            @i_description,
      getdate()
   )
   
   if @@error <> 0 
   begin
        set @w_error_number = 2109112        
        goto ERROR
   end

END

print 'ANTES DE INGRESAR A CONSULTAR LOS FALTANTES'

if @i_operacion = 'Q'

begin 
   
   SELECT td_codigo_tipo_doc 
   FROM cob_workflow..wf_tipo_documento 
   WHERE td_nombre_tipo_doc like '%'+@i_tipo_credito+'%'
   and td_codigo_tipo_doc not in (select ri_codigo_tipo_doc 
                                  from cob_workflow..wf_req_inst 
                                  where ri_id_inst_proc = @i_inst_proceso )
                                  
   
end

if @i_operacion = 'T'

begin

   SELECT ri_id_inst_proc,ri_codigo_tipo_doc,ri_nombre_doc
   FROM cob_workflow..wf_req_inst
   WHERE  ri_id_inst_proc = @i_inst_proceso

end

if @i_operacion = 'U'

begin
   print 'INGRESO A LA OPERACION U'
   select @w_ia_id_paso = ia_id_paso,
          @w_aa_asig_act = aa_id_asig_act 
   from cob_workflow..wf_inst_actividad,cob_workflow..wf_asig_actividad
   where ia_id_inst_act = aa_id_inst_act
   and ia_id_inst_proc = @i_inst_proceso
   and ia_id_inst_act = @i_inst_actividad
   
   IF NOT EXISTS
   (SELECT 1 FROM cob_workflow..wf_requisito_actividad
    WHERE rc_codigo_tipo_doc = @i_id_document
    AND   rc_id_inst_proceso = @i_inst_proceso
    AND   rc_inst_actividad  = @i_inst_actividad
    AND   rc_id_paso         = @w_ia_id_paso) begin
   
   
      INSERT INTO cob_workflow..wf_requisito_actividad (
      rc_codigo_tipo_doc,    rc_id_paso,         rc_id_inst_proceso,
      rc_inst_actividad,     rc_id_asig_act,     rc_texto,
      rc_terminado,          rc_cliente_proc,    rc_excepcionable)
      VALUES(
      @i_id_document,        @w_ia_id_paso,      @i_inst_proceso,
      @i_inst_actividad,     @w_aa_asig_act,     'OK',
      1,                     null,               0
      )
      
      if @@error <> 0 
      begin
           set @w_error_number = 2109112        
           goto ERROR
      END
      
   END

    
   IF NOT EXISTS
   (SELECT 1 FROM cob_workflow..wf_requisito_actividad_tmp
    WHERE rc_codigo_tipo_doc = @i_id_document
    AND   rc_id_inst_proceso = @i_inst_proceso
    AND   rc_inst_actividad  = @i_inst_actividad
    AND   rc_id_paso         = @w_ia_id_paso) begin
      INSERT INTO cob_workflow..wf_requisito_actividad_tmp (
      rc_codigo_tipo_doc,    rc_id_paso,         rc_id_inst_proceso,
      rc_inst_actividad,     rc_id_asig_act,     rc_texto,
      rc_terminado,          rc_cliente_proc,    rc_excepcionable)
      VALUES(
      @i_id_document,        @w_ia_id_paso,      @i_inst_proceso,
      @i_inst_actividad,     @w_aa_asig_act,     'OK',
      1,                     null,           0
      )
      
      if @@error <> 0 
      begin
           set @w_error_number = 2109112        
           goto ERROR
      END
   end
     

end


RETURN 0
ERROR:
   EXEC cobis..sp_cerror
        @t_from  = @w_sp_name,
        @i_num   = @w_error_number

    RETURN 1