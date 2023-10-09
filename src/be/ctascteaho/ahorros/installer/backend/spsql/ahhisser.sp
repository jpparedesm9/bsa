/****************************************************************************/
/*      Archivo           :  ahhisser.sp                                    */
/*      Stored procedure  :  sp_ahupdini                                    */
/*      Base de datos     :  cob_ahorros                                    */
/*      Producto          :  Cuentas de Ahorro                              */
/*      Disenado por      :  Boris Mosquera                                 */
/*      Fecha de escritura:  08/Feb/95                                      */
/****************************************************************************/
/*                              IMPORTANTE                                  */
/*    Esta aplicacion es parte de los paquetes bancarios propiedad          */
/*    de COBISCorp.                                                         */
/*    Su uso no    autorizado queda  expresamente   prohibido asi como      */
/*    cualquier    alteracion o  agregado  hecho por    alguno  de sus      */
/*    usuarios sin el debido consentimiento por   escrito de COBISCorp.     */
/*    Este programa esta protegido por la ley de   derechos de autor        */
/*    y por las    convenciones  internacionales   de  propiedad inte-      */
/*    lectual.    Su uso no  autorizado dara  derecho a    COBISCorp para   */
/*    obtener ordenes  de secuestro o  retencion y para  perseguir          */
/*    penalmente a los autores de cualquier   infraccion.                   */
/****************************************************************************/
/*                              PROPOSITO                                   */
/*      Realiza el paso al historico de las transacciones de servicio       */
/*      del dia                                                             */
/****************************************************************************/
/*                            MODIFICACIONES                                */
/*      FECHA           AUTOR           RAZON                               */
/*      17/Aug/95     D Villafuerte    Inclusion de cursores de T-SQL       */
/*      28/Jun/16     I Yupa           Migracion de SQR a SP                */
/****************************************************************************/

use cob_ahorros
go

if exists (select 1
			from sysobjects
			where name = 'sp_ahhisser')
	drop proc sp_ahhisser
go

set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

create proc sp_ahhisser
(  
	@t_show_version     bit         = 0,
	@i_param1           int         = null,--@w_filial           int = null,
	@i_param2           datetime    = null--@w_fecha_proceso    datetime =null,
)
as

Declare    
		@w_sp_name          varchar(30),
		@w_filial           int = null,
		@w_fecha_proceso    datetime =null,
		@w_error            int,
		@w_msg              varchar(100)
    
select @w_filial        = @i_param1
select @w_fecha_proceso = @i_param2

select @w_sp_name = 'sp_ahhisser'

if @t_show_version = 1
begin
	print 'Stored procedure: %1/ Version: %2/'+ @w_sp_name + '4.0.0.0'
	return 0
end

if not exists(select 1 
                from cobis..cl_filial 
				where fi_filial = @w_filial)
begin
	select 	@w_error = 1,
			@w_msg = 'No Existe Filial'
	goto ERRORFIN
end
    
--delete cob_ahorros_his..ah_his_servicio
--if @@error <> 0
--begin        
--	select 	@w_error = @@error,
--			@w_msg = 'Error al eliminar la tabla cob_ahorros_his..ah_his_servicio'
--	goto ERRORFIN 
--end
        
insert into cob_ahorros_his..ah_his_servicio
    select 	ts_secuencial, ts_cod_alterno, ts_tipo_transaccion, ts_clase,
			ts_tsfecha, ts_tabla, ts_usuario, ts_terminal, ts_correccion,
			ts_ssn_corr, ts_reentry, ts_origen, ts_nodo, ts_remoto_ssn,
			ts_ctacte, ts_cta_banco, ts_filial, ts_oficina, ts_oficial,
			ts_fecha_aper, ts_cliente, ts_ced_ruc, ts_estado, ts_direccion_ec,
			ts_rol_ente, ts_descripcion_ec, ts_cheque_rec, ts_ciclo, ts_categoria,
			ts_producto, ts_tipo, ts_indicador, ts_moneda, ts_default, ts_tipo_def,
			ts_tipo_promedio, ts_capitalizacion, ts_tipo_interes, ts_numero,
			ts_fecha, ts_autorizante, ts_valor, ts_accion, ts_secuencia, ts_causa,
			ts_orden, ts_servicio, ts_saldo, ts_interes, ts_contrato, ts_fecha_uso,
			ts_monto, ts_fecha_ven, ts_filial_aut, ts_ofi_aut, ts_autoriz_aut,
			ts_filial_anula, ts_ofi_anula, ts_autoriz_anula, ts_cheque_desde,
			ts_cheque_hasta, ts_causa_np, ts_clase_np, ts_departamento,
			ts_causa_rev, ts_cta_gir, ts_endoso, ts_nro_cheque, ts_cod_banco,
			ts_corresponsal, ts_propietario, ts_carta, ts_sec_correccion,
			ts_cheque, ts_cta_banco_dep, ts_oficina_pago, ts_cta_funcionario,
			ts_mercantil, ts_tipocta, ts_numlib, ts_tasa, ts_oficina_cta, ts_hora,
			ts_prod_banc,ts_nombre1,ts_cedruc1,ts_observacion,ts_tipocta_super,ts_turno,
			ts_clase_clte, ts_nxmil, ts_marca_gmf, ts_fec_marca_gmf            
		from cob_ahorros..ah_tran_servicio

if @@error <> 0
begin        
	select 	@w_error = @@error,
			@w_msg = 'Error al insertar registros en la tabla cob_ahorros_his..ah_his_servicio'
	goto ERRORFIN 
end

delete cob_ahorros_his..ah_his_retiro_ofic
if @@error <> 0
begin
	select 	@w_error = @@error,
			@w_msg = 'Error al eliminar la tabla cob_ahorros_his..ah_his_retiro_ofic'
	goto ERRORFIN 
end
	
insert into cob_ahorros_his..ah_his_retiro_ofic
	select  ar_secuencial, ar_cta_banco,  ar_nombre,  ar_forma_pago,
			ar_valor,      ar_retiro_add, ar_login,   ar_fecha,     
			ar_hora,       ar_estado
	from cob_ahorros..ah_aut_retiro_ofic
	
if @@error <> 0
begin
	select 	@w_error = @@error,
			@w_msg = 'Error al insertar registros en la tabla cob_ahorros_his..ah_his_retiro_ofic'
	goto ERRORFIN 
end

Return 0

ERRORFIN:

exec sp_errorlog
	@i_fecha       = @w_fecha_proceso,
	@i_error       = @w_error,
	@i_usuario     = 'batch',
	@i_tran        = 4013,
	@i_descripcion = @w_msg,
	@i_programa    = @w_sp_name

return @w_error
  
GO
