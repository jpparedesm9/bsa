/************************************************************************/
/*  Archivo:                regtrapisr.sp                               */
/*  Stored procedure:       sp_tran_prod_isr                            */
/*  Base de datos:          cob_conta_super                             */
/*  Producto:               Regulatorios                                */
/************************************************************************/
/*                              IMPORTANTE                              */
/*  Esta aplicacion es parte de los paquetes bancarios propiedad        */
/*  de COBISCorp.                                                       */
/*  Su uso no    autorizado queda  expresamente   prohibido asi como    */
/*  cualquier    alteracion o  agregado  hecho por    alguno  de sus    */
/*  usuarios sin el debido consentimiento por   escrito de COBISCorp.   */
/*  Este programa esta protegido por la ley de   derechos de autor      */
/*  y por las    convenciones  internacionales   de  propiedad inte-    */
/*  lectual.    Su uso no  autorizado dara  derecho a    COBISCorp para */
/*  obtener ordenes  de secuestro o  retencion y para  perseguir        */
/*  penalmente a los autores de cualquier   infraccion.                 */
/************************************************************************/
/*                              PROPOSITO                               */
/*  Funcionalidad que consulta las retenciones(ISR) generadas por todos */
/*  los productos COBIS.                                                */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*  FECHA         AUTOR           RAZON                                 */
/*  06/Sep/2016   Jorge Salazar   Migracion a CEN                       */
/************************************************************************/

use cob_conta_super
go
if exists (select 1 from sysobjects where name = 'sp_tran_prod_isr')
   drop proc sp_tran_prod_isr
go

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

create procedure sp_tran_prod_isr 
(
    @s_ssn           int         = null,
    @s_ssn_branch    int         = null,
    @s_srv           varchar(30) = null,
    @s_lsrv          varchar(30) = null,
    @s_user          varchar(30) = null,
    @s_sesn          int         = null,
    @s_term          varchar(10) = null,
    @s_date          datetime    = null,
    @s_ofi           smallint    = null,
    @s_rol           smallint    = 1,
    @s_org_err       char(1)     = null,
    @s_error         int         = null,
    @s_sev           tinyint     = null,
    @s_msg           varchar(64) = null,
    @s_org           char(1)     = null,
    @t_debug         char(1)     = 'N',
    @t_file          varchar(14) = null,
    @t_from          varchar(32) = null,
    @t_rty           char(1)     = 'N',
    @t_show_version  bit         = 0,  
    @t_trn           int         = null,
    @i_fecha_desde   datetime,
    @i_fecha_hasta   datetime,
    @i_producto      smallint    = null,
    @i_codcliente    int         = null,
    @i_operacion     char(1)     = 'Q',
    @i_formato_fecha int         = 101
)
as
declare
    @w_sp_name      varchar(30),
    @w_error        int,
    @w_msg          varchar(60)
    
/* Captura del nombre del Store Procedure */
select @w_sp_name = 'sp_tran_prod_isr'

---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
if @t_show_version = 1
begin
 print 'Stored Procedure= ' + @w_sp_name +  ' Version= ' + '4.0.0.0'
 return 0
end

if @t_trn <> 36003
begin
  -- TIPO DE TRANSACCION NO CORRESPONDE
  select @w_error = 2902501,
         @w_msg   = 'TIPO DE TRANSACCION NO CORRESPONDE'
  goto ERROR
end

if @i_operacion = 'S'
begin
    if @i_codcliente is null and @i_producto is null
    begin
       select @w_error = 2902502,
              @w_msg   = 'NO SE ENVIO EL CODIGO DEL CLIENTE O CODIGO DEL PRODUCTO'
       goto ERROR
    end
    
    if (@i_producto in (4) or @i_producto is null)
	begin
	   select '508949'        = dt_aplicativo,
              '600010'        = dt_banco,
              '508953'        = dp_cliente,
              '502473'        = case dc_subtipo when 'P'
                                                then dc_nombre + ' ' + dc_p_apellido + ' ' + dc_s_apellido
	   					    				    else dc_nombre
                                end,
              '508884'        = dd_concepto,
              '503196'        = (select eq_descripcion
                                   from cob_conta_super..sb_equivalencias
                                  where eq_valor_arch = convert(varchar, dt_aplicativo)
                                    and eq_valor_cat  = dd_concepto
                                    and eq_catalogo   = 'CONCON_PRO'),
              '9028'          = dd_monto,
              '9002'          = convert(varchar, dt_fecha_trans, @i_formato_fecha)
         from cob_conta_super..sb_dato_transaccion,
              cob_conta_super..sb_dato_transaccion_det,
              cob_conta_super..sb_dato_pasivas,
              cob_conta_super..sb_dato_cliente
        where dt_banco      = dd_banco
          and dt_toperacion = dd_toperacion
          and dt_aplicativo = dd_aplicativo
          and dt_secuencial = dd_secuencial
          and dt_fecha      = dd_fecha
          and dp_banco      = dt_banco
          and dp_aplicativo = dt_aplicativo
          and dp_toperacion = dt_toperacion
          and dt_tipo_trans = (select eq_valor_cat
                                 from cob_conta_super..sb_equivalencias
                                where eq_valor_arch = convert(varchar, dt_aplicativo)
                                  and eq_catalogo   = 'TRN_PERFIL')
          and dd_concepto   = (select eq_valor_cat
                                 from cob_conta_super..sb_equivalencias
                                where eq_valor_arch = convert(varchar, dt_aplicativo)
                                  and eq_catalogo   = 'CONCON_PRO')
          and dp_fecha      = (select max(dp_fecha)
                                 from cob_conta_super..sb_dato_pasivas
                                where dp_banco = dt_banco)
          and dc_cliente    = dp_cliente
          and dc_fecha      = (select max(dc_fecha)
                                 from cob_conta_super..sb_dato_cliente
                                where dc_cliente = dp_cliente)
          and dt_fecha_trans between @i_fecha_desde and @i_fecha_hasta
          and (dt_aplicativo = @i_producto or @i_producto is null)
          and (dp_cliente    = @i_codcliente or @i_codcliente is null)
       
       if @@rowcount = 0
       begin
           select @w_error = 208158 --NO EXISTEN REGISTROS
           select @w_msg = 'NO EXISTEN REGISTROS'
           goto ERROR
       end
    end
end

return 0

ERROR:
exec cobis..sp_cerror
     @t_debug = @t_debug,
     @t_file  = @t_file,
     @t_from  = @w_sp_name,
     @i_num   = @w_error,
     @i_msg   = @w_msg,
     @i_sev   = 0

return @w_error

go

