/************************************************************************/
/*      Archivo:                ahpasdef.sp                             */
/*      Stored procedure:       sp_ahpasdef                             */
/*      Base de datos:          cob_ahorros                             */
/*      Producto:                 Cuentas Ahorros                       */
/*      Disenado por:              Juan Carlos Gordillo                 */
/*      Fecha de escritura:     30-Nov-1999                             */
/************************************************************************/
/*                              IMPORTANTE                              */
/*   Esta aplicacion es parte de los paquetes bancarios propiedad       */
/*   de COBISCorp.                                                      */
/*   Su uso no autorizado queda expresamente prohibido asi como         */
/*   cualquier alteracion o agregado  hecho por alguno de sus           */
/*   usuarios sin el debido consentimiento por escrito de COBISCorp.    */
/*   Este programa esta protegido por la ley de derechos de autor       */
/*   y por las convenciones  internacionales   de  propiedad inte-      */
/*   lectual.    Su uso no  autorizado dara  derecho a COBISCorp para   */
/*   obtener ordenes  de secuestro o retencion y para  perseguir        */
/*   penalmente a los autores de cualquier infraccion.                  */
/************************************************************************/
/*    Paso definitivo de las tablas temporales a la tablas reales       */
/*    Actualizacion de los seqnos de linea pendiente                    */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*      FECHA            AUTOR                 RAZON                    */ 
/*    30/Nov/1999    J.C. Gordillo        Emision Inicial               */
/*  26 Mayo 2000    Yenny Rivero    Se cambio la programacion para      */
/*                                    que guarde la hora de las tran--  */
/*                                    sacciones monetarias de fin de    */
/*                                    mes                               */
/*  02/May/2016     J. Calderon      Migración a CEN                    */
/************************************************************************/

USE cob_ahorros
GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

if exists (select 1 from sysobjects where name = 'sp_ahpasdef')
        drop proc sp_ahpasdef
go

create proc sp_ahpasdef(
     @t_show_version bit= 0
)
as
declare @w_error    tinyint,
    @w_lp_sec    int,
    @w_sp_name  varchar(30)


select @w_sp_name = 'sp_ahpasdef'

---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
if @t_show_version = 1
begin
    print 'Stored Procedure = '+ @w_sp_name + 'Version = ' + '4.0.0.0'
    return 0
end

select @w_error = 0

begin tran

/**** Notas de Debito ****/
/*insert into cob_ahorros..ah_notcredeb
select * from ah_notcredeb1*/

insert into cob_ahorros..ah_tran_monet
        (tm_secuencial, tm_ssn_branch, tm_cod_alterno,tm_tipo_tran,tm_oficina,
         tm_usuario,tm_terminal,tm_correccion,
         tm_sec_correccion,tm_reentry,tm_origen,
         tm_nodo,tm_fecha,tm_cta_banco,tm_signo,
         tm_indicador,tm_remoto_ssn,tm_moneda,tm_causa,tm_interes,
         tm_valor,tm_saldo_contable,
         tm_saldo_disponible,tm_oficina_cta,tm_filial,
         tm_prod_banc,tm_categoria,tm_monto_imp,tm_tipo_exonerado_imp,tm_hora,
             tm_tipocta_super, tm_turno)
select       secuencial,ssn_branch,alterno,tipo_tran,oficina,
         usuario,terminal,correccion,
         sec_correccion,reentry,origen,
         nodo,fecha,cta_banco,signo,
         indicador,remoto_ssn,moneda,causa,interes,
         valor,saldocont,
         saldodisp,oficina_cta,filial,
         prod_banc,categoria,monto_imp,tipo_exonerado,hora,
             tipocta_super, turno
from cob_ahorros..ah_notcredeb1
          
select @w_error = @@error
if @w_error <> 0
begin
    select @w_error = @w_error
    goto ERROR
end

commit tran

begin tran

/*insert into cob_ahorros..ah_notcredeb
select * from ah_notcredeb2*/

insert into cob_ahorros..ah_tran_monet
        (tm_secuencial,tm_ssn_branch,tm_cod_alterno,tm_tipo_tran,tm_oficina,
         tm_usuario,tm_terminal,tm_correccion,
         tm_sec_correccion,tm_reentry,tm_origen,
         tm_nodo,tm_fecha,tm_cta_banco,tm_signo,
         tm_indicador,tm_remoto_ssn,tm_moneda,tm_causa,tm_interes,
         tm_valor,tm_saldo_contable,
         tm_saldo_disponible,tm_oficina_cta,tm_filial,
         tm_prod_banc,tm_categoria,tm_monto_imp,tm_tipo_exonerado_imp,tm_hora,
             tm_tipocta_super, tm_turno)
select       secuencial,ssn_branch,alterno,tipo_tran,oficina,
         usuario,terminal,correccion,
         sec_correccion,reentry,origen,
         nodo,fecha,cta_banco,signo,
         indicador,remoto_ssn,moneda,causa,interes,
         valor,saldocont,
         saldodisp,oficina_cta,filial,
         prod_banc,categoria,monto_imp,tipo_exonerado,hora,
             tipocta_super, turno
from cob_ahorros..ah_notcredeb2
          
 
if @@error <> 0
begin
    select @w_error = 2
    goto ERROR
end

commit tran

begin tran

/*insert into cob_ahorros..ah_notcredeb
select * from ah_notcredeb3*/

  insert into cob_ahorros..ah_tran_monet
        (tm_secuencial,tm_ssn_branch,tm_cod_alterno,tm_tipo_tran,tm_oficina,
         tm_usuario,tm_terminal,tm_correccion,
         tm_sec_correccion,tm_reentry,tm_origen,
         tm_nodo,tm_fecha,tm_cta_banco,tm_signo,
         tm_indicador,tm_remoto_ssn,tm_moneda,tm_causa,tm_interes,
         tm_valor,tm_saldo_contable,
         tm_saldo_disponible,tm_oficina_cta,tm_filial,
         tm_prod_banc,tm_categoria,tm_monto_imp,tm_tipo_exonerado_imp,tm_hora,
             tm_tipocta_super, tm_turno)
select       secuencial,ssn_branch,alterno,tipo_tran,oficina,
         usuario,terminal,correccion,
         sec_correccion,reentry,origen,
         nodo,fecha,cta_banco,signo,
         indicador,remoto_ssn,moneda,causa,interes,
         valor,saldocont,
         saldodisp,oficina_cta,filial,
         prod_banc,categoria,monto_imp,tipo_exonerado,hora,
             tipocta_super, turno
from cob_ahorros..ah_notcredeb3
          

if @@error <> 0
begin
    select @w_error = 3
    goto ERROR
end

commit tran

begin tran

/*insert into cob_ahorros..ah_notcredeb
select * from ah_notcredeb4*/

insert into cob_ahorros..ah_tran_monet
        (tm_secuencial,tm_ssn_branch,tm_cod_alterno,tm_tipo_tran,tm_oficina,
         tm_usuario,tm_terminal,tm_correccion,
         tm_sec_correccion,tm_reentry,tm_origen,
         tm_nodo,tm_fecha,tm_cta_banco,tm_signo,
         tm_indicador,tm_remoto_ssn,tm_moneda,tm_causa,tm_interes,
         tm_valor,tm_saldo_contable,
         tm_saldo_disponible,tm_oficina_cta,tm_filial,
         tm_prod_banc,tm_categoria,tm_monto_imp,tm_tipo_exonerado_imp,tm_hora,
             tm_tipocta_super, tm_turno)
select       secuencial,ssn_branch,alterno,tipo_tran,oficina,
         usuario,terminal,correccion,
         sec_correccion,reentry,origen,
         nodo,fecha,cta_banco,signo,
         indicador,remoto_ssn,moneda,causa,interes,
         valor,saldocont,
         saldodisp,oficina_cta,filial,
         prod_banc,categoria,monto_imp,tipo_exonerado,hora,
             tipocta_super, turno
from cob_ahorros..ah_notcredeb4
          

if @@error <> 0
begin
    select @w_error = 4
    goto ERROR
end

commit tran

begin tran

/**** Linea Pendiente ****/
insert into cob_ahorros..ah_linea_pendiente
select * from ah_linea_pendiente1

if @@error <> 0
begin
    select @w_error = 11
    goto ERROR
end

commit tran

begin tran

insert into cob_ahorros..ah_linea_pendiente
select * from ah_linea_pendiente2

if @@error <> 0
begin
    select @w_error = 12
    goto ERROR
end

commit tran

begin tran

insert into cob_ahorros..ah_linea_pendiente
select * from ah_linea_pendiente3

if @@error <> 0
begin
    select @w_error = 13
    goto ERROR
end

commit tran

begin tran

insert into cob_ahorros..ah_linea_pendiente
select * from ah_linea_pendiente4

if @@error <> 0
begin
    select @w_error = 14
    goto ERROR
end

commit tran

/* 10/01/2002

begin tran
/**** Retencion ****/

insert into cobis..cl_retencion
select * from cl_retencion1

if @@error <> 0
begin
    select @w_error = 21
    goto ERROR
end

commit tran

begin tran

insert into cobis..cl_retencion
select * from cl_retencion2

if @@error <> 0
begin
    select @w_error = 22
    goto ERROR
end

commit tran

begin tran

insert into cobis..cl_retencion
select * from cl_retencion3

if @@error <> 0
begin
    select @w_error = 23
    goto ERROR
end

commit tran

begin tran

insert into cobis..cl_retencion
select * from cl_retencion4

if @@error <> 0
begin
    select @w_error = 24
    goto ERROR
end

commit tran
*/

begin tran

/**** Acumulador ****/
insert into cob_ahorros..ah_acumulador
select * from ah_acumulador1

if @@error <> 0
begin
    select @w_error = 31
    goto ERROR
end

commit tran

begin tran

insert into cob_ahorros..ah_acumulador
select * from ah_acumulador2

if @@error <> 0
begin
    select @w_error = 32
    goto ERROR
end

commit tran

begin tran

insert into cob_ahorros..ah_acumulador
select * from ah_acumulador3

if @@error <> 0
begin
    select @w_error = 33
    goto ERROR
end

commit tran

begin tran

insert into cob_ahorros..ah_acumulador
select * from ah_acumulador4

if @@error <> 0
begin
    select @w_error = 34
    goto ERROR
end

commit tran

/**** Valor en Suspenso ****/
insert into cob_ahorros..ah_val_suspenso
select * from ah_val_suspenso1

if @@error <> 0
begin
    select @w_error = 41
    goto ERROR
end

commit tran

begin tran

insert into cob_ahorros..ah_val_suspenso
select * from ah_val_suspenso2

if @@error <> 0
begin
    select @w_error = 42
    goto ERROR
end

commit tran

begin tran

insert into cob_ahorros..ah_val_suspenso
select * from ah_val_suspenso3

if @@error <> 0
begin
    select @w_error = 43
    goto ERROR
end

commit tran

begin tran

insert into cob_ahorros..ah_val_suspenso
select * from ah_val_suspenso4

if @@error <> 0
begin
    select @w_error = 44
    goto ERROR
end

commit tran

begin tran

/**** Transaccion de Servicio de Valor en Suspenso ****/
insert into cob_ahorros..ah_tsval_suspenso(secuencial, ssn_branch, tipo_tran, oficina,   usuario, 
                                           terminal,   correccion, reentry,   origen,    nodo,   
                                           fecha,      cta_banco,  valor,     interes,   indicador, 
                                           servicio,   remoto_ssn, moneda,    ssn_corr,  alterno,   
                                           oficina_cta,hora,       prod_banc, categoria, tipocta_super,
                                           turno,      serial,     cliente)
select * from ah_tsval_suspenso1

if @@error <> 0
begin
    select @w_error = 51
    goto ERROR
end

commit tran

begin tran

insert into cob_ahorros..ah_tsval_suspenso(secuencial, ssn_branch, tipo_tran, oficina,   usuario, 
                                           terminal,   correccion, reentry,   origen,    nodo,   
                                           fecha,      cta_banco,  valor,     interes,   indicador, 
                                           servicio,   remoto_ssn, moneda,    ssn_corr,  alterno,   
                                           oficina_cta,hora,       prod_banc, categoria, tipocta_super,
                                           turno,      serial,     cliente)
select * from ah_tsval_suspenso2

if @@error <> 0
begin
    select @w_error = 52
    goto ERROR
end

commit tran

begin tran

insert into cob_ahorros..ah_tsval_suspenso(secuencial, ssn_branch, tipo_tran, oficina,   usuario, 
                                           terminal,   correccion, reentry,   origen,    nodo,   
                                           fecha,      cta_banco,  valor,     interes,   indicador, 
                                           servicio,   remoto_ssn, moneda,    ssn_corr,  alterno,   
                                           oficina_cta,hora,       prod_banc, categoria, tipocta_super,
                                           turno,      serial,     cliente)
select * from ah_tsval_suspenso3

if @@error <> 0
begin
    select @w_error = 53
    goto ERROR
end

commit tran

begin tran

insert into cob_ahorros..ah_tsval_suspenso(secuencial, ssn_branch, tipo_tran, oficina,   usuario, 
                                           terminal,   correccion, reentry,   origen,    nodo,   
                                           fecha,      cta_banco,  valor,     interes,   indicador, 
                                           servicio,   remoto_ssn, moneda,    ssn_corr,  alterno,   
                                           oficina_cta,hora,       prod_banc, categoria, tipocta_super,
                                           turno,      serial,     cliente)
select * from ah_tsval_suspenso4

if @@error <> 0
begin
    select @w_error = 54
    goto ERROR
end

commit tran

begin tran

/**** Transaccion de Servicio ****/
insert into cob_ahorros..ah_tran_servicio
select * from ah_tran_servicio1

if @@error <> 0
begin
    select @w_error = 61
    goto ERROR
end

commit tran

begin tran

insert into cob_ahorros..ah_tran_servicio
select * from ah_tran_servicio2

if @@error <> 0
begin
    select @w_error = 62
    goto ERROR
end

commit tran

begin tran

insert into cob_ahorros..ah_tran_servicio
select * from ah_tran_servicio3

if @@error <> 0
begin
    select @w_error = 63
    goto ERROR
end

commit tran

begin tran

insert into cob_ahorros..ah_tran_servicio
select * from ah_tran_servicio4

if @@error <> 0
begin
    select @w_error = 64
    goto ERROR
end

commit tran

begin tran

/**** Inmovilizadas ****/
insert into cob_ahorros..ah_his_inmovilizadas
select * from ah_his_inmovilizadas1

if @@error <> 0
begin
    select @w_error = 71
    goto ERROR
end

commit tran

begin tran

insert into cob_ahorros..ah_his_inmovilizadas
select * from ah_his_inmovilizadas2

if @@error <> 0
begin
    select @w_error = 72
    goto ERROR
end

commit tran

begin tran

insert into cob_ahorros..ah_his_inmovilizadas
select * from ah_his_inmovilizadas3

if @@error <> 0
begin
    select @w_error = 73
    goto ERROR
end

commit tran

begin tran

insert into cob_ahorros..ah_his_inmovilizadas
select * from ah_his_inmovilizadas4

if @@error <> 0
begin
    select @w_error = 74
    goto ERROR
end

commit tran

begin tran

/**** Saldos Diarios ****/
insert into cob_ahorros_his..ah_saldo_diario
select * from ah_saldo_diario1

if @@error <> 0
begin
    select @w_error = 81
    goto ERROR
end

commit tran

begin tran

insert into cob_ahorros_his..ah_saldo_diario
select * from ah_saldo_diario2

if @@error <> 0
begin
    select @w_error = 82
    goto ERROR
end

commit tran

begin tran

insert into cob_ahorros_his..ah_saldo_diario
select * from ah_saldo_diario3

if @@error <> 0
begin
    select @w_error = 83
    goto ERROR
end

commit tran

begin tran

insert into cob_ahorros_his..ah_saldo_diario
select * from ah_saldo_diario4

if @@error <> 0
begin
    select @w_error = 84
    goto ERROR
end

commit tran

begin tran

/**** Saldos Rep ****/
insert into cob_ahorros..ah_saldos_rep
select * from ah_saldos_rep1

if @@error <> 0
begin
    select @w_error = 91
    goto ERROR
end

commit tran

begin tran

insert into cob_ahorros..ah_saldos_rep
select * from ah_saldos_rep2

if @@error <> 0
begin
    select @w_error = 92
    goto ERROR
end

commit tran

begin tran

insert into cob_ahorros..ah_saldos_rep
select * from ah_saldos_rep3

if @@error <> 0
begin
    select @w_error = 93
    goto ERROR
end

commit tran

begin tran

insert into cob_ahorros..ah_saldos_rep
select * from ah_saldos_rep4

if @@error <> 0
begin
    select @w_error = 94
    goto ERROR
end

commit tran

begin tran

/**** Error Batch ****/
insert into cob_ahorros..re_error_batch
select * from re_error_batch1

if @@error <> 0
begin
    select @w_error = 101
    goto ERROR
end

commit tran

begin tran

insert into cob_ahorros..re_error_batch
select * from re_error_batch2

if @@error <> 0
begin
    select @w_error = 102
    goto ERROR
end

commit tran

begin tran

insert into cob_ahorros..re_error_batch
select * from re_error_batch3

if @@error <> 0
begin
    select @w_error = 103
    goto ERROR
end

commit tran

begin tran

insert into cob_ahorros..re_error_batch
select * from re_error_batch4

if @@error <> 0
begin
    select @w_error = 104
    goto ERROR
end

commit tran

ERROR:
if @w_error <> 0
begin
    rollback tran
    print 'Procesando ... ' + convert (varchar(10), @w_error)     --'Procesando ...%1!', @w_error

    insert into cob_ahorros..re_error_batch
    values ('0', 'ERROR EN PASO DEFINITIVO DE TABLAS TEMPORALES')

    if @@error  <> 0
    begin
        exec cobis..sp_cerror
            @i_num = 203056        

        return 203056
    end

    return @w_error
end

select @w_lp_sec = max(rb_lp_sec)
  from cob_ahorros..ah_rango_oficina_batch

if @w_lp_sec is null
begin
    print 'Procesando ...Actualizacion de Secuencial'

    insert into cob_ahorros..re_error_batch
    values ('0', 'ERROR EN LECTURA DE SECUENCIAL DE LINEA PENDIENTE')

    if @@error  <> 0
    begin
        exec cobis..sp_cerror
            @i_num = 203056        

        return 203056
    end

    return 1
end

begin tran 

update cobis..cl_seqnos
   set siguiente = @w_lp_sec
 where tabla = 'ah_lpendiente'

if @@error <> 0
begin
    rollback tran
    print 'Procesando ...Actualizacion de Secuencial'

    insert into cob_ahorros..re_error_batch
    values ('0', 'ERROR EN ACTUALIZACION DE SECUENCIAL DE LINEA PENDIENTE')

    if @@error  <> 0
    begin
        exec cobis..sp_cerror
            @i_num = 203056        

        return 203056
    end

    return 1
end

update cobis..cl_seqnos
   set siguiente = @w_lp_sec % 10000
 where tabla = 'ah_control'

if @@error <> 0
begin
    rollback tran
    print 'Procesando ...Actualizacion de Secuencial'

    insert into cob_ahorros..re_error_batch
    values ('0', 'ERROR EN ACTUALIZACION DE NUMERO DE CONTROL')

    if @@error  <> 0
    begin
        exec cobis..sp_cerror
            @i_num = 203056        

        return 203056
    end

    return 1
end

commit tran
return 0

go

