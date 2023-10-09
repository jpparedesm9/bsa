/*************************************************************************/
/*   Archivo:            sp_concentracion_cap_vinc.sp                    */
/*   Stored procedure:   sp_concentracion_cap_vinc                       */
/*   Base de datos:      cob_workflow                                    */
/*   Producto:           Originación			                         */
/*   Disenado por:       VBR                                             */
/*   Fecha de escritura: 22/12/2016                                      */
/*************************************************************************/
/*                                  IMPORTANTE                           */
/*   Este programa es parte de los paquetes bancarios propiedad de       */
/*   "MACOSA", representantes exclusivos para el Ecuador de NCR          */
/*   Su uso no autorizado queda expresamente prohibido asi como          */
/*   cualquier acion o agregado hecho por alguno de sus                  */
/*   usuarios sin el debido consentimiento por escrito de la             */
/*   Presidencia Ejecutiva de MACOSA o su representante.                 */
/*************************************************************************/
/*                                  PROPOSITO                            */
/*   Este procedimiento almacenado, cálculo de la concentración de       */
/*   capital.de vinculados                                               */
/*************************************************************************/
/*                                MODIFICACIONES                         */
/*   FECHA               AUTOR                       RAZON               */
/*   22-12-2016          VBR                   Emision Inicial           */
/*************************************************************************/
USE cob_workflow
GO

if exists(select 1 from sysobjects where name ='sp_concentracion_cap_vinc')
	drop proc sp_concentracion_cap_vinc
GO


CREATE PROC sp_concentracion_cap_vinc
		(@s_ssn        int         = null,
	     @s_ofi        smallint,
	     @s_user       login,
         @s_date       DATETIME = NULL,
	     @s_srv		   varchar(30) = null,
	     @s_term	   descripcion = null,
	     @s_rol		   smallint    = null,
	     @s_lsrv	   varchar(30) = null,
	     @s_sesn	   int 	       = null,
	     @s_org		   char(1)     = NULL,
		 @s_org_err    int 	       = null,
         @s_error      int 	       = null,
         @s_sev        tinyint     = null,
         @s_msg        descripcion = null,
         @t_rty        char(1)     = null,
         @t_trn        int         = null,
         @t_debug      char(1)     = 'N',
         @t_file       varchar(14) = null,
         @t_from       varchar(30)  = null,
         --variables
		 @i_id_inst_proc int,    --codigo de instancia del proceso
		 @i_id_inst_act  int,    
		 @i_id_asig_act  int,
		 @i_id_empresa   int, 
		 @i_id_variable  smallint 
		 )

AS
DECLARE @w_sp_name       	varchar(32),
        @w_tramite       	int,
        @w_return        	INT,
        @w_error            INT,
        @w_retorno          INT,
        @w_valor_ant      	varchar(255),
        @w_valor_nuevo    	varchar(255),
        @w_actividad      	catalogo,
        @w_codigo_proceso   INT,
        @w_version_proceso  INT,
        @w_operacion        INT,
        @w_moneda_UDIS            INT,
        @w_microcredito           CHAR(24),
        @w_lim_aprobado_vinculados   MONEY,
        @w_lim_vinculados         MONEY,
        @w_grupal                 CHAR(1),
        @w_param_porc_lim_vinculados FLOAT,
        @w_param_porc_lim_vinculados_apr FLOAT,
        @w_param_limite_vinculados   FLOAT,
        @w_tipo_persona           CHAR(1),
        @w_saldo_capital          MONEY,
        @w_nro_operaciones        INT,
        @w_monto_operaciones      MONEY,
        @w_vinculado              CHAR(10),
        @w_param_tipo_vinc        CHAR(10)
        
       
SELECT @w_sp_name='sp_concentracion_cap_vinc'

SELECT @w_tramite = convert(int,io_campo_3),
	   @w_codigo_proceso = io_codigo_proc,
	   @w_version_proceso = io_version_proc
FROM cob_workflow..wf_inst_proceso
where io_id_inst_proc = @i_id_inst_proc

select @w_tramite = isnull(@w_tramite,0)

if @w_tramite = 0 return 0
/*
INSERT INTO cobis..cl_parametro (pa_parametro,pa_nemonico,pa_tipo,pa_float, pa_producto)
VALUES ('PORCENTAJE LIM VINCULADOS', 'PLVIN','F',10,'CRE')

INSERT INTO cobis..cl_parametro (pa_parametro,pa_nemonico,pa_tipo,pa_float, pa_producto)
VALUES ('PORC LIM VINCULADOS-APROB', 'PLVAP','F',2,'CRE')

INSERT INTO cobis..cl_parametro (pa_parametro,pa_nemonico,pa_tipo,pa_money, pa_producto)
VALUES ('MONTO LIM VINCULADOS', 'MLVIN','M',100000,'CRE')

INSERT INTO cobis..cl_parametro (pa_parametro,pa_nemonico,pa_tipo,pa_char, pa_producto)
VALUES ('TIPO VINCULADO', 'TPVIN','C','001','CRE')
*/

select @w_sp_name = 'sp_concentracion_cap_vinc'


--	Solicitante del crédito que estamos aprobando
--	Padres del Solicitante.
--	Hijos del Solicitante.
--  Cónyuge o Pareja del Solicitante.


SELECT @w_operacion = op_operacion
FROM cob_cartera..ca_operacion
WHERE op_tramite = @w_tramite


SELECT @w_moneda_UDIS = pa_int 
FROM cobis..cl_parametro
WHERE pa_nemonico = 'MUDIS'
AND pa_producto = 'CRE'


SELECT @w_param_porc_lim_vinculados = pa_float
FROM cobis..cl_parametro
WHERE pa_nemonico = 'PLVIN'
AND pa_producto = 'CRE'

SELECT @w_param_porc_lim_vinculados_apr = pa_float
FROM cobis..cl_parametro
WHERE pa_nemonico = 'PLVAP'
AND pa_producto = 'CRE'

SELECT @w_param_limite_vinculados= pa_money
FROM cobis..cl_parametro
WHERE pa_nemonico = 'MLVIN'
AND pa_producto = 'CRE'

SELECT @w_param_tipo_vinc = pa_char
FROM cobis..cl_parametro
WHERE pa_nemonico = 'TPVIN'
AND pa_producto = 'CRE'

SELECT @w_param_limite_vinculados= @w_param_limite_vinculados --* cz_valor
--FROM cob_credito..cr_cotizacion
--WHERE cz_moneda = @w_moneda_UDIS

--Es una operacion Microcrédito normal
SELECT @w_microcredito = op_subtipo_linea 
FROM cob_cartera..ca_operacion
WHERE op_tramite = @w_tramite

SELECT @w_grupal = oe_char
FROM cob_cartera..ca_operacion_ext  
WHERE oe_operacion = @w_operacion
AND oe_columna = 'opt_grupal'

SELECT @w_tipo_persona = en_subtipo,
@w_vinculado = isnull(en_tipo_vinculacion,'0')
FROM cob_credito..cr_deudores DEU, cobis..cl_ente
WHERE de_tramite = @w_tramite
AND de_rol = 'D'
AND de_cliente = en_ente

SELECT @w_tipo_persona = en_subtipo,
@w_vinculado = isnull(en_tipo_vinculacion,'0')
FROM cob_credito..cr_deudores DEU, cobis..cl_ente
WHERE de_tramite = @w_tramite
AND de_rol = 'D'
AND de_cliente = en_ente

IF @w_vinculado <> '0'
BEGIN


SELECT @w_saldo_capital = 0,
@w_nro_operaciones = 0

    EXEC @w_error = cob_credito..sp_saldo_capital_concentracion
			@t_debug       	= 'N',
			@t_file         	= @t_file,
			@t_from         	= @t_from,
            @s_rol              = @s_rol,
            @i_grupal           = @w_grupal,
            @i_tramite          = @w_tramite,
            @i_microcredito     = @w_microcredito,
            @i_tipo_persona     = @w_tipo_persona,            
            @o_saldo_capital    = @w_saldo_capital OUT,
            @o_nro_operaciones  = @w_nro_operaciones OUT
    
    if @w_error <> 0
	    goto ERROR
       
    
    SELECT @w_lim_aprobado_vinculados = @w_saldo_capital*@w_param_porc_lim_vinculados_apr/100
    SELECT @w_lim_vinculados = @w_saldo_capital*@w_param_porc_lim_vinculados/100
    
    --- CONDICION VINCULADOS
    IF @w_lim_vinculados > @w_saldo_capital
          SELECT @w_valor_nuevo = 'RE'
    ELSE	
         IF @w_lim_aprobado_vinculados > @w_saldo_capital
             SELECT @w_valor_nuevo = 'NO'
         ELSE 
           IF @w_param_limite_vinculados > @w_saldo_capital
             SELECT @w_valor_nuevo = 'NO'
           ELSE	
             SELECT @w_valor_nuevo = 'SI'
END
ELSE
  SELECT @w_valor_nuevo = 'NO'
  
            
-- valor anterior de variable tipo en la tabla cob_workflow..wf_variable
select @w_valor_ant    = isnull(va_valor_actual, '')
  from cob_workflow..wf_variable_actual
 where va_id_inst_proc = @i_id_inst_proc
   and va_codigo_var   = @i_id_variable

if @@rowcount > 0  --ya existe
begin
  --print '@i_id_inst_proc %1! @i_id_asig_act %2! @w_valor_ant %3!',@i_id_inst_proc, @i_id_asig_act, @w_valor_ant
  update cob_workflow..wf_variable_actual
     set va_valor_actual = @w_valor_nuevo 
   where va_id_inst_proc = @i_id_inst_proc
     and va_codigo_var   = @i_id_variable    
end
else
BEGIN
  insert into cob_workflow..wf_variable_actual
         (va_id_inst_proc, va_codigo_var, va_valor_actual)
  values (@i_id_inst_proc, @i_id_variable, @w_valor_nuevo )
  
  PRINT @@ERROR
end
--print '@i_id_inst_proc %1! @i_id_asig_act %2! @w_valor_ant %3!',@i_id_inst_proc, @i_id_asig_act, @w_valor_ant
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
ERROR:
    exec cobis..sp_cerror @t_from = @w_sp_name, @i_num = @w_error
    return @w_error
GO

