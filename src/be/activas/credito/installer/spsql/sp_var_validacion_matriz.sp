
/************************************************************************/
/*  Archivo:                sp_var_validacion_matriz.sp                 */
/*  Stored procedure:       sp_var_validacion_matriz                    */
/*  Base de Datos:          cob_credito                                 */
/*  Producto:               Credito                                     */
/*  Disenado por:           P. Samueza                                  */
/*  Fecha de Documentacion: 17/Oct/2018                                 */
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
/* o alg�n integrante del grupo no es un cliente                        */
/************************************************************************/
/*          MODIFICACIONES                                              */
/*  FECHA       AUTOR                   RAZON                           */
/* 17/Oct/2018    P. Samueza    Emision Inicial                         */
/* 30/Sep/2021    ACH           ERR#168924,se toma el parametro de ingre*/
/* **********************************************************************/

USE cob_credito
go
IF OBJECT_ID ('dbo.sp_var_validacion_matriz') IS NOT NULL
	DROP PROCEDURE dbo.sp_var_validacion_matriz
GO

create proc sp_var_validacion_matriz(
        @s_ssn             int            = null,
        @s_ofi             smallint       = null,
        @s_user            login          = null,
        @s_date            datetime       = null,
        @s_srv             varchar(30)    = null,
        @s_term            descripcion    = null,
        @s_rol             smallint       = null,
        @s_lsrv            varchar(30)    = null,
        @s_sesn            int            = null,
        @s_org             char(1)        = null,
        @s_org_err         int            = null,
		@s_error           int            = null,
		@s_sev             tinyint        = null,
        @s_msg             descripcion    = null,
        @t_rty             char(1)        = null,
        @t_trn             int            = null,
        @t_debug           char(1)        = 'N',
        @t_file            varchar(14)    = null,
        @t_from            varchar(30)    = null,
         --variables
         @i_id_inst_proc    int,    --codigo de instancia del proceso
         @i_id_inst_act     int,    
         @i_id_asig_act     int,
         @i_id_empresa      int, 
         @i_id_variable     smallint 
)
as
declare @w_sp_name          varchar(32),
        @w_tramite          int,
        @w_return           int,
        @w_monto_tr         money,
        @w_integrantes      int,
        @w_num_sexo_feme    int,
        ---var variables    
        @w_asig_actividad   int,
        @w_valor_ant        varchar(255),
        @w_valor_nuevo      varchar(255),
        @w_actividad        catalogo,
        @w_grupo            int,
        @w_ttramite         varchar(255),
        @w_asig_act         int, 
        @w_tramite_ant      int,
        @w_ente             int,
        @w_comentario       VARCHAR(1000),
        @w_resultado        CHAR(2),
        @w_proceso          varchar(5),
        @w_id_observacion   SMALLINT,
        @w_numero           INT,
        @w_usuario          varchar(64),
        @w_ea_nivel_riesgo  VARCHAR(50),
        @w_ea_puntaje_riesgo INT
        
       

select @w_sp_name='sp_var_validacion_matriz'

select @w_grupo       = convert(int,io_campo_1),
	   @w_tramite     = convert(int,io_campo_3),
	   @w_ttramite    = io_campo_4,
       @w_asig_act = convert(int,@i_id_asig_act),--io_campo_2
	   @w_tramite_ant = convert(int,io_campo_5)
from cob_workflow..wf_inst_proceso
where io_id_inst_proc = @i_id_inst_proc
and   io_campo_7 = 'S'

select @w_tramite = isnull(@w_tramite,0)

if @w_tramite = 0 return 0

SET @w_resultado='SI'

select @w_proceso = pa_int from cobis..cl_parametro where pa_nemonico = 'OAA'

if @w_ttramite = 'GRUPAL'
BEGIN

SET @w_comentario='Los Siguientes Clientes no tiene generado la Matriz de Riesgo'

select @w_ente = 0
while 1 = 1
BEGIN

    select  @w_ente=tg_cliente 
    from cob_credito..cr_tramite_grupal 
    where tg_tramite = @w_tramite 
    and tg_monto>0
    and tg_participa_ciclo = 'S'
    and tg_cliente > @w_ente
   order by tg_cliente desc
    
	if @@rowcount = 0
		BREAK
		
		SELECT @w_ea_nivel_riesgo=ea_nivel_riesgo,
               @w_ea_puntaje_riesgo=ea_puntaje_riesgo 
        FROM cobis..cl_ente_aux WHERE ea_ente = @w_ente
        
        PRINT'@w_ea_nivel_riesgo'+   @w_ea_nivel_riesgo
        
        PRINT'@w_ea_puntaje_riesgo'+ convert(VARCHAR(50),@w_ea_puntaje_riesgo)
                  
	    IF ( @w_ea_nivel_riesgo IS NULL AND @w_ea_puntaje_riesgo IS NULL)
                  BEGIN
                  
                  SET @w_comentario=@w_comentario +':'+ convert (VARCHAR(50),@w_ente)
                  
                  SET @w_resultado='NO'
                  
                  END  
                  	
END

select @w_id_observacion = ol_observacion from  cob_workflow..wf_ob_lineas 
        		where ol_id_asig_act = @w_asig_act 
        		and ol_texto like 'Los Siguientes Clientes no tiene generado la Matriz de Riesgo%'
        		
delete cob_workflow..wf_observaciones 
      		where ob_id_asig_act = @w_asig_act
        		and ob_numero = @w_id_observacion  
        		
delete cob_workflow..wf_ob_lineas 
		where ol_id_asig_act = @w_asig_act 
		and ol_observacion = @w_id_observacion

IF(@w_resultado='NO')
BEGIN
        SET @w_comentario= @w_comentario
        
        PRINT '@w_comentario:'+ @w_comentario
        

		
		
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
		--Obtengo el nombre de usuario
		select @w_usuario = fu_nombre from cobis..cl_funcionario where fu_login = @s_user 
		
		-- Inserta observaciones y lineas 
	    insert into cob_workflow..wf_observaciones (ob_id_asig_act, ob_numero, ob_fecha, ob_categoria, ob_lineas, ob_oficial, ob_ejecutivo)
		values (@w_asig_act, @w_numero, getdate(), @w_proceso, 1, 'N', @w_usuario)
			
		insert into cob_workflow..wf_ob_lineas (ol_id_asig_act, ol_observacion, ol_linea, ol_texto)
		values (@w_asig_act, @w_numero, 1, @w_comentario)				

END

end

select @w_valor_nuevo = @w_resultado


--insercion en estrucuturas de variables

if @i_id_asig_act is null
  select @i_id_asig_act = 0

-- valor anterior de variable tipo en la tabla cob_workflow..wf_variable
select @w_valor_ant    = isnull(va_valor_actual, '')
  from cob_workflow..wf_variable_actual
 where va_id_inst_proc = @i_id_inst_proc
   and va_codigo_var   = @i_id_variable

if @@rowcount > 0  --ya existe
begin
  --print '@i_id_inst_proc %1! @w_asig_actividad %2! @w_valor_ant %3!',@i_id_inst_proc, @w_asig_actividad, @w_valor_ant
  update cob_workflow..wf_variable_actual
     set va_valor_actual = @w_valor_nuevo 
   where va_id_inst_proc = @i_id_inst_proc
     and va_codigo_var   = @i_id_variable    
end
else
begin
  insert into cob_workflow..wf_variable_actual
         (va_id_inst_proc, va_codigo_var, va_valor_actual)
  values (@i_id_inst_proc, @i_id_variable, @w_valor_nuevo )

end
--print '@i_id_inst_proc %1! @w_asig_actividad %2! @w_valor_ant %3!',@i_id_inst_proc, @w_asig_actividad, @w_valor_ant
if not exists(select 1 from cob_workflow..wf_mod_variable
              where mv_id_inst_proc = @i_id_inst_proc and
                    mv_codigo_var= @i_id_variable and
                    mv_id_asig_act = @i_id_asig_act)
begin
    insert into cob_workflow..wf_mod_variable
           (mv_id_inst_proc, mv_codigo_var, mv_id_asig_act,
            mv_valor_anterior, mv_valor_nuevo, mv_fecha_mod)
    values (@i_id_inst_proc, @i_id_variable, @i_id_asig_act,
            @w_valor_ant, @w_valor_nuevo , getdate())

    if @@error > 0
    begin
            --registro ya existe
          exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file = @t_file, 
          @t_from = @t_from,
          @i_num = 2101002
    return 1
    end 
end

return 0                                                                                                                                                                                               


GO