/****************************************************************************/
/*      Archivo           :  ahhismon.sp                                    */
/*      Base de datos     :  cob_ahorros                                    */
/*      Producto          :  Cuentas de Ahorros                             */
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
/*      Paso a historicos de las transacciones monetarias del dia           */
/****************************************************************************/
/*                            MODIFICACIONES                                */
/*      FECHA           AUTOR           RAZON                               */
/*      08/Feb/95     B.Mosquera        Emision Inicial                     */ 
/*      20/Jul/95     J. Bucheli        Incluir cursores SQL                */
/*      15/Aug/95     D Villafuete      Personalizacion Bco Prestamos       */
/*      24/Abr/2000     Maria Gracia      Eliminacion de mensajes           */
/*                                        Informativos                      */
/*      23/Jun/2016     P. Romero      Migracion de SQR a SP                */     
/****************************************************************************/

USE cob_ahorros
GO

if object_id('sp_ah_his_mon') is not null
begin
  drop procedure sp_ah_his_mon
  if object_id('sp_ah_his_mon') is not null
    print 'FAILED DROPPING PROCEDURE sp_ah_his_mon'  
end

go

create procedure  sp_ah_his_mon
(   @t_show_version     bit         = 0,
    @i_param1           int         = null,--@w_filial           int = null,
    @i_param2           datetime    = null--@w_fecha_proceso    datetime =null,    
)   
AS
DECLARE    
    @w_sp_name          varchar(30),       
    @w_filial           int = null,
    @w_fecha_proceso    datetime =null,
    @w_error            int,
    @w_msg              varchar(100)
    
select @w_filial        = @i_param1
select @w_fecha_proceso = @i_param2

select @w_sp_name = 'sp_ah_his_mon'

    if @t_show_version = 1
    begin
         print 'Stored procedure: %1/ Version: %2/'+ @w_sp_name + '4.0.0.0'
        return 0
    end

if not exists(select 1 
                from cobis..cl_filial 
                        where fi_filial=@w_filial)
begin
  select @w_error = 1,
           @w_msg = 'No Existe Filial'
    goto ERRORFIN
end


insert into cob_ahorros_his..ah_his_movimiento
    (hm_fecha,         hm_secuencial,      hm_ssn_branch,    hm_cod_alterno, 
     hm_tipo_tran,     hm_filial,          hm_oficina,       hm_usuario,   
     hm_terminal,      hm_correccion,      hm_sec_correccion,hm_origen, 
     hm_nodo,          hm_reentry,         hm_signo,         hm_fecha_ult_mov, 
     hm_cta_banco,     hm_valor,           hm_chq_propios,   hm_chq_locales, 
     hm_chq_ot_plazas, hm_remoto_ssn,      hm_moneda,        hm_efectivo, 
     hm_indicador,     hm_causa,           hm_departamento,  hm_saldo_lib, 
     hm_saldo_contable,hm_saldo_disponible,hm_saldo_interes, hm_fecha_efec, 
     hm_interes,       hm_control,         hm_ctadestino,    hm_tipo_xfer, 
     hm_estado,        hm_concepto,        hm_oficina_cta,   hm_hora, 
     hm_banco,         hm_valor_comision,  hm_prod_banc,     hm_categoria, 
     hm_monto_imp,     hm_tipo_exonerado_imp,hm_serial,      hm_tipocta_super, 
     hm_turno,         hm_cheque,            hm_stand_in,    hm_canal, 
     hm_oficial,       hm_clase_clte,        hm_cliente,     hm_base_gmf )
  select 
    tm_fecha,          tm_secuencial,        tm_ssn_branch,    tm_cod_alterno, 
    tm_tipo_tran,      tm_filial,            tm_oficina,       tm_usuario, 
    tm_terminal,       tm_correccion,        tm_sec_correccion,tm_origen, 
    tm_nodo,           tm_reentry,           tm_signo,         tm_fecha_ult_mov, 
    tm_cta_banco,      tm_valor,             tm_chq_propios,   tm_chq_locales, 
    tm_chq_ot_plazas,  tm_remoto_ssn,        tm_moneda,        tm_efectivo, 
    tm_indicador,      tm_causa,             tm_departamento,  tm_saldo_lib, 
    tm_saldo_contable, tm_saldo_disponible,  tm_saldo_interes, tm_fecha_efec, 
    tm_interes,        tm_control,           tm_ctadestino,    tm_tipo_xfer, 
    tm_estado,         tm_concepto,          tm_oficina_cta,   tm_hora, 
    tm_banco,          tm_valor_comision,    tm_prod_banc,     tm_categoria, 
    tm_monto_imp,      tm_tipo_exonerado_imp,tm_serial,        tm_tipocta_super, 
    tm_turno,          tm_cheque,            tm_stand_in,      tm_canal, 
    tm_oficial,        tm_clase_clte,        tm_cliente,       tm_base_gmf
     
 from cob_ahorros..ah_tran_monet
 order by tm_fecha, tm_hora, tm_secuencial, tm_cod_alterno
 if @@error <> 0
        begin        
           select @w_error = @@error,
                   @w_msg = 'Error al insertar registros en la tabla cob_ahorros_his..ah_his_movimiento'
            goto ERRORFIN 
        end
        
 return 0
 
 ERRORFIN:

  exec sp_errorlog
    @i_fecha       = @w_fecha_proceso,
    @i_error       = @w_error,
    @i_usuario     = 'batch',
    @i_tran        = 4012,
    @i_descripcion = @w_msg,
    @i_programa    = @w_sp_name

  return @w_error
  
 GO
 