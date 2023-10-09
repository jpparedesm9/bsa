/************************************************************************/
/*  Archivo:            REM AHO-H79808.sql                              */
/*  Base de datos:      cobis                                           */
/*  Producto:           Cuentas de Ahorros                              */
/*  Disenado por:       Eduardo Williams                                */
/*  Fecha de escritura: 04-Ago-2016                                     */
/************************************************************************/
/*                       IMPORTANTE                                     */
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
/*                        PROPOSITO                                     */
/* Parametrizacion para historia de reverso de transacciones de ahorros */
/************************************************************************/
/*                      MODIFICACIONES                                  */
/************************************************************************/
/*  FECHA             AUTOR               RAZON                         */
/*  04/Ago/2016       Eduardo Williams    Emision inicial               */
/*  05/Ago/2016       Eduardo Williams    Cambio de nombre fisico de SP */
/************************************************************************/
use cobis
go

/****************************/
/*      TRANSACCIONES       */
/****************************/
declare @w_cod_trn int,
        @w_cod_sp  int,
        @w_rol     int
        
select @w_cod_trn = 500,
       @w_cod_sp  = 278

select @w_rol = ro_rol from ad_rol where ro_descripcion = 'MENU POR PROCESOS'

delete from ad_procedure       where pd_procedure = @w_cod_sp
delete from cl_ttransaccion    where tn_trn_code  = @w_cod_trn
delete from ad_pro_transaccion where pt_producto  = 4 and pt_tipo = 'R' and pt_moneda = 0 and pt_transaccion = @w_cod_trn
delete from ad_tr_autorizada   where ta_producto  = 4 and ta_tipo = 'R' and ta_moneda = 0 and ta_transaccion = @w_cod_trn and ta_rol = @w_rol

insert into ad_procedure       values (@w_cod_sp, 'sp_rev_tran_monet', 'cob_ahorros', 'V', getdate(), 'rev_tranmon.sp')
insert into cl_ttransaccion    values (@w_cod_trn, 'CONSULTA DE TRANSACCIONES MONETARIAS AHORROS PARA REVERSO', 'TMAHRE', 'CONSULTA DE TRANSACCIONES MONETARIAS AHORROS PARA REVERSO')
insert into ad_pro_transaccion values (4, 'R', 0, @w_cod_trn, 'V', getdate(), @w_cod_sp, null)
insert into ad_tr_autorizada   values (4, 'R', 0, @w_cod_trn, @w_rol, getdate(), 1, 'V', getdate())
go
print 'Transaccion...OK'
go

/****************************/
/*         ERRORES          */
/****************************/
delete from cl_errores where numero in (190033, 161724)
go
insert into cl_errores values (190033, 0, 'NO EXISTE EL FUNCIONARIO')
insert into cl_errores values (161724, 0, 'FONDOS DE LA CUENTA INSUFICIENTES')
go
print 'Errores...OK'
go

print 'Actualizacion OK'
go
