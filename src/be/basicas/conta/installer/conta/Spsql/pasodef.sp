/************************************************************************/
/*   Stored procedure:     sp_paso_definitivas                               */
/*   Base de datos:        cob_conta                                  */
/************************************************************************/
/*                                  IMPORTANTE                          */
/*   Este programa es parte de los paquetes bancarios propiedad de      */
/*   'MACOSA'                                                           */
/*   Su uso no autorizado queda expresamente prohibido asi como         */
/*   cualquier alteracion o agregado hecho por alguno de sus            */
/*   usuarios sin el debido consentimiento por escrito de la            */
/*   Presidencia Ejecutiva de MACOSA o su representante.                */
/************************************************************************/
/*                            PROPOSITO                                 */
/************************************************************************/
 
use cob_conta
go
 
if exists (select 1 from sysobjects where name = 'sp_paso_definitivas')
   drop proc sp_paso_definitivas
go
 
create proc sp_paso_definitivas
(
@i_empresa      tinyint
)
as

declare
@w_numcomp           int,
@w_compt             int,
@w_comp_def          int,
@w_comp_orig         int,
@w_asiento_min       int,
@w_asiento_max       int,
@w_fecha             datetime,
@w_archivo           char(160),
@w_total             int,
@w_debito            money,
@w_credito           money,
@w_usuario           varchar(30),
@w_debito_comp       money,
@w_creedito_comp     money,
@w_debito_me_comp    money,
@w_creedito_me_comp  money


select @w_compt       = 0
select @w_numcomp     = 0
select @w_comp_def    = 0
select @w_comp_orig   = 0
select @w_asiento_min = 0
select @w_asiento_max = 0
select @w_usuario     = 'conbatch'


set rowcount 0

select distinct co_comprobante
into #comprob_mig
from cob_conta..cb_convivencia

delete from #comprob_mig
where co_comprobante in (select distinct ler_clave
                         from cob_conta..cb_log_errores_mig)


delete from #comprob_mig
where co_comprobante in (select distinct ler_clave
                         from cob_conta..cb_log_errores_mig)

select @w_compt = 0
select @w_numcomp = 0

Select
@w_archivo = em_archivo   
from cob_conta..cb_estado_mig

Select
@w_total = count(1)   
from cob_conta..cb_convivencia

Select
@w_debito  = sum(co_debito),
@w_credito = sum(co_credito)
from cob_conta..cb_convivencia

select 
@w_usuario = co_usuario_modulo,
@w_comp_orig = case when co_origen_mvto = 'D' then null else co_origen_mvto end
from cob_conta..cb_convivencia
group by co_usuario_modulo, co_origen_mvto


BEGIN TRAN    
while 1 = 1
begin

    set rowcount 1
    
    select @w_compt = co_comprobante from #comprob_mig
    
    if @@rowcount = 0
        break
    
    delete from #comprob_mig
    where co_comprobante = @w_compt 

    select @w_numcomp= @w_numcomp+ 1

    select @w_fecha = co_fecha_tran
    from cob_conta..cb_convivencia
    where co_comprobante = @w_compt
    
    select 
    @w_debito_comp      = sum(co_debito),
    @w_creedito_comp    = sum(co_credito),
    @w_debito_me_comp   = sum(co_debito_me),
    @w_creedito_me_comp = sum(co_credito_me)
    from cob_conta..cb_convivencia
    where co_comprobante = @w_compt    
    
    execute sp_cseqcomp
    @i_tabla   = 'cb_scomprobante',
    @i_empresa = @i_empresa,
    @i_fecha   = @w_fecha,
    @i_modulo  = 6,
    @i_modo    = 0,
    @o_siguiente = @w_comp_def OUTPUT

    INSERT into cob_conta_tercero..ct_scomprobante
    select
    6,                                                @w_comp_def,                            co_empresa,                            
    co_fecha_tran,                                    co_oficina_orig,                        co_area_orig,                         
    getdate(),                                        @w_usuario,                             co_descripcion,                                  
    '',                                               count(1),                               @w_debito_comp,                         
    @w_creedito_comp,                                 @w_debito_me_comp,                      @w_creedito_me_comp,
    co_automatico,                                    'N',                                    'B',
    'N',                                              null,                                   null,
    @w_usuario,                                       null,                                   co_comprobante,
    6,                                               'N'
    from cob_conta..cb_convivencia
    where co_comprobante = @w_compt
    group by co_comprobante,    co_empresa,        co_fecha_tran,
             co_oficina_orig,   co_area_orig,      co_descripcion, 
             co_automatico
             
    if @@error <> 0
    begin
        rollback tran
        print 'Error al insertar en ct_scomprobante'
        return 1
    end         

    print '@w_compt ' +cast(@w_compt as varchar)

    print '11'  

    select @w_asiento_min = 0
    select @w_asiento_max = 20000

    print '@w_comp_orig '+cast(@w_comp_orig as varchar)
    
    set rowcount 0
    
    print '@w_asiento_max: '+cast(@w_asiento_max as varchar)

    SET ROWCOUNT 0

    print '@w_compt '+ cast(@w_compt as varchar)

    insert into cob_conta_tercero..ct_sasiento (
    sa_producto,                      sa_comprobante,             sa_empresa,
    sa_fecha_tran,                    sa_asiento,                 sa_cuenta,
    sa_oficina_dest,                  sa_area_dest,               sa_credito,
    sa_debito,                        sa_concepto,                sa_credito_me,
    sa_debito_me,                     sa_cotizacion,              sa_tipo_doc,
    sa_tipo_tran,                     sa_moneda,                  sa_opcion,
    sa_ente,
    sa_con_rete,                      sa_base,
    sa_valret,                        sa_con_iva,                 sa_valor_iva,
    sa_iva_retenido,                  sa_con_ica,                 sa_valor_ica,
    sa_con_timbre,                    sa_valor_timbre,            sa_con_iva_reten,
    sa_con_ivapagado,                 sa_valor_ivapagado,         sa_documento,
    sa_mayorizado,                    sa_origen_mvto,             sa_con_dptales,
    sa_valor_dptales,                 sa_cheque,                  sa_doc_banco)
    
    select
    6,                                                                         @w_comp_def,                 co_empresa,         
    co_fecha_tran,                                                             co_asiento,                  co_cuenta,          
    co_oficina_dest,                                                           co_area_dest,                co_credito,
    co_debito,                                                                 co_concepto,                 co_credito_me,       
    co_debito_me,                                                              co_cotizacion,               isnull(co_tipo_doc,''),
    isnull(co_tipo_tran,''),                                                   co_moneda,                   NULL,
    case
    when co_origen_mvto = 'N' then dbo.funct_ente(co_identifica, co_tipo, 'N')
    when co_origen_mvto = 'D' then dbo.funct_ente(co_identifica, co_tipo, ' D')
    else
       dbo.funct_ente(co_identifica, co_tipo, ' ')
    end,
    co_concepto_imp,             co_base_imp,
    NULL,                                                                      NULL,                        NULL,
    NULL,                                                                      NULL,                        NULL,
    NULL,                                                                      NULL,                        NULL,
    NULL,                                                                      NULL,                        co_documento,
    'N',                                                                       case when co_origen_mvto = 'D' then null else co_origen_mvto end,              NULL,
    NULL,                                                                      co_cheque,                   co_documento
    from  cob_conta..cb_convivencia
    where co_comprobante  = @w_compt 

    if @@error <> 0
    begin
       rollback tran
       print 'Error al insertar en ct_sasiento'
       return 1
    end   
    
    select @w_asiento_min = 0
    select @w_asiento_max = 20000

end

select @w_fecha = getdate()

insert into cob_conta..cb_control_carga (cc_archivo, cc_fecha, cc_registros, cc_debito, cc_credito, cc_comp_orig)
values (@w_archivo, @w_fecha, @w_total, @w_debito, @w_credito, @w_comp_orig)

if @@error <> 0
begin
   rollback tran
   print 'Error al insertar en cb_control_carga'
   return 1
end 

COMMIT TRAN           

return 0


go