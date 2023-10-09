

/************************************************************************/
/*   Archivo:              sp_sync_solicitudes.sp                      */
/*   Stored procedure:     sp_sync_solicitudes.sp                      */
/*   Base de datos:        cob_credito                                  */
/*   Producto:             Credito                                      */
/*   Disenado por:         SMO                                          */
/*   Fecha de escritura:   22/12/2017                                   */
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
/*   El programa sincroniza las solicitudes que están en etapa de       */
/*   ingreso									                        */
/************************************************************************/
/*                               CAMBIOS                                */
/*      FECHA          AUTOR            CAMBIO                          */
/*      22/12/2017     SMO              Emision Inicial                 */
/*      15/03/2019     SRO              Corrección esquema secuenciales */
/*                                      en si_sincroniza                */
/*      30/06/2021     SRO              Error #161777                   */
/************************************************************************/
USE cob_credito
GO

if exists (select 1 from sysobjects where name = 'sp_sync_solicitudes')
drop proc sp_sync_solicitudes
go

CREATE proc sp_sync_solicitudes (
    @i_oficial 	INT
)

AS
DECLARE
@w_sp_name             VARCHAR(32),
@w_accion              VARCHAR(255),
@w_observacion         VARCHAR(255),
@w_num_det			   INT,
@w_cod_entidad		   SMALLINT,
@w_des_entidad         VARCHAR(64),
@w_fecha_proceso       DATETIME,
@w_actividad		   INT,
@w_user				   login,
@w_subalterno 		   INT,
@w_codigo              INT,
@w_grupo 			   INT,
@w_inst_proceso 	   INT,
@w_tramite             INT,
@w_cliente      	   INT,
@w_act_actual 		   INT,
@w_nombre_cl           varchar(64),
@w_error               INT,
@w_msg                 VARCHAR(100),
@w_filas               INT,
@w_param_ing_sol       varchar(64)


SET @w_sp_name='sp_sync_solicitudes'
SET @w_accion='COMPLETAR SOLICITUD'
SET @w_observacion='POR SINCRONIZACION DE DISPOSITIVO'
SET @w_cod_entidad = 3 --SOLICITUD GRUPAL
SET @w_num_det = 0

SELECT @w_des_entidad = valor
FROM cobis..cl_catalogo
WHERE tabla = ( SELECT codigo  FROM cobis..cl_tabla
                WHERE tabla = 'si_sincroniza') AND codigo = @w_cod_entidad

select @w_param_ing_sol = pa_char
from   cobis..cl_parametro
where  pa_nemonico = 'ETINGR'

if @@rowcount = 0 
begin
   select @w_error = 103192
   goto ERROR
end

SELECT @w_fecha_proceso = fp_fecha FROM cobis..ba_fecha_proceso
SELECT @w_actividad = ac_codigo_actividad 
FROM cob_workflow..wf_actividad 
WHERE ac_nombre_actividad = @w_param_ing_sol

select @w_user = fu_login
from  cobis..cl_funcionario, cobis..cc_oficial
where oc_oficial = @i_oficial 
and oc_funcionario = fu_funcionario

IF @w_user is not NULL BEGIN
	
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
	
   if not exists (select 1 from cob_sincroniza..si_sincroniza where si_secuencial = @w_codigo) begin
      -- Insert en si_sincroniza
      INSERT INTO cob_sincroniza..si_sincroniza 
      (si_secuencial,si_cod_entidad,si_des_entidad, si_usuario,si_estado,si_fecha_ing,si_fecha_sin,si_num_reg)
      VALUES 
      (@w_codigo,    @w_cod_entidad,@w_des_entidad, @w_user,   'P',      getdate(),   NULL,        1)
      
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
   
   
   SELECT @w_grupo=0
   WHILE 1=1 BEGIN--while para cada grupo del oficial
   
	 	SELECT @w_inst_proceso=NULL
	 	SELECT @w_tramite=NULL
	 			
		SELECT TOP 1 @w_grupo=gr_grupo 
		FROM cobis..cl_grupo 
		WHERE 
		gr_oficial = @i_oficial
		AND gr_grupo>@w_grupo
		ORDER BY gr_grupo
				
	  IF @@ROWCOUNT = 0 BREAK
			
		PRINT 'oficial>>'+convert(VARCHAR(10),@i_oficial)+' grupo >>'+convert(VARCHAR(10),@w_grupo)
		
	    SELECT TOP 1 
		@w_inst_proceso=io_id_inst_proc,
		@w_tramite = io_campo_3
		FROM cob_workflow..wf_inst_proceso 
		WHERE io_campo_1=@w_grupo 
		AND io_estado='EJE' 
		ORDER BY io_id_inst_proc DESC
				
      IF @w_inst_proceso IS NOT NULL BEGIN
      
			SELECT 
	       	@w_cliente    = op_cliente,
	       	@w_nombre_cl  = op_nombre
			FROM cob_cartera..ca_operacion OP 
			WHERE op_tramite = @w_tramite
		   
			SELECT TOP 1 @w_act_actual = ia_codigo_act FROM cob_workflow..wf_inst_actividad WHERE ia_id_inst_proc=@w_inst_proceso ORDER BY ia_id_inst_act DESC
			PRINT '@w_act_actual>>'+convert(VARCHAR(10),@w_act_actual)
				
         IF @w_act_actual = @w_actividad BEGIN
         --si el proceso est? en la actividad INGRESAR SOLICITUD
						
				IF @w_tramite<>0 
				  EXEC cob_credito..sp_grupal_xml_det
				   @i_inst_proc = @w_inst_proceso,
	    	   @i_secuencial = @w_codigo,
	    	   @i_tramite    = @w_tramite
				   
			END	--END si el proceso está en la actividad cuestionario grupal
		END
	END --end while para barrerse los oficiales
	
   SELECT @w_num_det =  count (sid_secuencial) 
   FROM cob_sincroniza..si_sincroniza_det
   WHERE sid_secuencial = @w_codigo
	
   IF @w_num_det >0		
      update cob_sincroniza..si_sincroniza set
      si_num_reg = @w_num_det
   	  where si_secuencial = @w_codigo
   ELSE
      DELETE FROM  cob_sincroniza..si_sincroniza
   	  WHERE si_secuencial = @w_codigo
END
RETURN 0

ERROR:
begin 
	exec cobis..sp_cerror
  		@t_debug = 'N',
   		@t_file  = 'S',
   		@t_from  = @w_sp_name,
   		@i_num   = @w_error,
      	@i_msg   = @w_msg
    return @w_error
END;
go
