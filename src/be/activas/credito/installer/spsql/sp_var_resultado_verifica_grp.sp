/************************************************************************/
/*  Archivo:                sp_var_resultado_verifica.sp                */
/*  Stored procedure:       sp_var_resultado_verifica_grp               */
/*  Base de Datos:          cob_credito                                 */
/*  Producto:               Credito                                     */
/*  Disenado por:           VBR                                         */
/*  Fecha de Documentacion: 17/Ago/2017                                 */
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
/* Procedure tipo Variable, Retorna SI si existe un cliente en el grupo */
/* cuyo puntaje en la verificaci�n de datos sea menor a 9               */
/************************************************************************/
/*          MODIFICACIONES                                              */
/*  FECHA       AUTOR           RAZON                                   */
/*  18/Ago/2017 VBR             Emision Inicial                         */
/* **********************************************************************/
USE cob_credito
GO

if exists(select 1 from sysobjects where name ='sp_var_resultado_verifica_grp')
	drop proc sp_var_resultado_verifica_grp
GO



CREATE PROC sp_var_resultado_verifica_grp
		(@s_ssn        int         = null,
	     @s_ofi        smallint = null,
	     @s_user       login = null,
         @s_date       datetime = null,
	     @s_srv		   varchar(30) = null,
	     @s_term	   descripcion = null,
	     @s_rol		   smallint    = null,
	     @s_lsrv	   varchar(30) = null,
	     @s_sesn	   int 	       = null,
	     @s_org		   char(1)     = NULL,
		�@s_org_err����int 	       = null,
���������@s_error������int 	       = null,
���������@s_sev        tinyint     = null,
         @s_msg        descripcion = null,
�������� @t_rty        char(1)     = null,
���������@t_trn        int         = null,
���������@t_debug      char(1)     = 'N',
���������@t_file       varchar(14) = null,
���������@t_from       varchar(30)  = null,
         --variables
		 @i_id_inst_proc int,    --codigo de instancia del proceso
		 @i_id_inst_act  int,    
		 @i_id_asig_act  int,
		 @i_id_empresa   int, 
		 @i_id_variable  smallint 
		 )
AS
DECLARE @w_sp_name       	varchar(32),
        @w_tramite         	int,
        @w_return        	INT,
        @w_grupal               char(1),
        @w_parametro_resultado tinyint,
        ---var variables	
        @w_asig_actividad 	int,
        @w_valor_ant      	varchar(255),
        @w_valor_nuevo    	varchar(255),
        @w_actividad      	catalogo  
       

SELECT @w_sp_name='sp_var_resultado_verifica_grp'

SELECT @w_tramite = convert(int,io_campo_3),
       @w_grupal = io_campo_7
FROM cob_workflow..wf_inst_proceso
where io_id_inst_proc = @i_id_inst_proc

select @w_tramite = isnull(@w_tramite,0)

if @w_tramite = 0 return 0

select @w_parametro_resultado = 10

if @w_grupal = 'S'
   select @w_parametro_resultado = pa_tinyint
   from cobis..cl_parametro
   where pa_nemonico = 'RVDGR'
   and pa_producto = 'CRE'
else 
   select @w_parametro_resultado = pa_tinyint
   from cobis..cl_parametro
   where pa_nemonico = 'RVDIN'
   and pa_producto = 'CRE'

if @w_grupal = 'S'
 begin
   
   if NOT EXISTS(SELECT 1 FROM cob_credito..cr_verifica_datos,cobis..cl_cliente_grupo cg,cob_credito..cr_tramite_grupal tg
            WHERE vd_tramite = @w_tramite
            AND cg.cg_ente=vd_cliente
            AND tg.tg_cliente=vd_cliente
            AND tg.tg_tramite=vd_tramite
            AND tg.tg_participa_ciclo='S'
            AND cg_estado = 'V'
                 )
      SELECT @w_valor_nuevo = 'SI'
   ELSE
      IF EXISTS(SELECT 1 FROM cob_credito..cr_verifica_datos,cobis..cl_cliente_grupo cg,cob_credito..cr_tramite_grupal tg
            WHERE vd_tramite = @w_tramite
            AND cg.cg_ente=vd_cliente
            AND tg.tg_cliente=vd_cliente
            AND tg.tg_tramite=vd_tramite
            AND tg.tg_participa_ciclo='S'
            AND cg_estado = 'V'
            AND vd_resultado < @w_parametro_resultado)
     SELECT @w_valor_nuevo = 'SI'
   ELSE
     SELECT @w_valor_nuevo = 'NO'
 end
else
 begin
    if NOT EXISTS(SELECT 1 FROM cob_credito..cr_verifica_datos,cob_credito..cr_tramite tr
            WHERE vd_tramite = @w_tramite
            AND tr.tr_tramite=vd_tramite
                 )
      SELECT @w_valor_nuevo = 'SI'
   ELSE
      IF EXISTS(SELECT 1 FROM cob_credito..cr_verifica_datos,cob_credito..cr_tramite tr
            WHERE vd_tramite = @w_tramite
            AND tr.tr_tramite=vd_tramite
            AND vd_resultado < @w_parametro_resultado)
     SELECT @w_valor_nuevo = 'SI'
   ELSE
     SELECT @w_valor_nuevo = 'NO'
 
 end

--insercion en estructuras de variables

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
              where mv_id_inst_proc = @i_id_inst_proc AND
                    mv_codigo_var= @i_id_variable AND
                    mv_id_asig_act = @i_id_asig_act)
BEGIN
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

END

return 0
go


