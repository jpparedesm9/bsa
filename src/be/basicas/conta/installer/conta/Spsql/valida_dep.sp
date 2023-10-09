/************************************************************************/
/*   Stored procedure:     sp_valida_mig                               */
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
 
if exists (select 1 from sysobjects where name = 'sp_valida_dep')
   drop proc sp_valida_dep
go
 
create proc sp_valida_dep

(
   @i_empresa        tinyint      = NULL,
   @o_archivo        varchar(100) = NULL  out,
   @i_valautomatica  char(1)      = 'S'
)
as
declare
   @w_mensaje          varchar(100),
   @w_debito           money,
   @w_credito          money,
   @w_errores          int,
   @w_comp_orig        int,
   @w_empresa          tinyint,
   @w_fecha_tran       datetime,
   @w_oficina_orig     smallint,
   @w_area_orig        smallint,
   @w_descripcion      varchar(250),
   @w_automatico       int,   
   @w_usuario          varchar(250),
   @w_conteo           smallint,
   @w_debito_me        money,
   @w_credito_me       money,
   @w_error            int,
   @w_numcomp          int,
   @w_numasien         int,
   @w_archivo          varchar(240),
   @w_asiento_min      int,
   @w_asiento_max      int,
   @w_compt            int,
   @w_asientos         int,
   @w_rowcount         int,
   @w_comp_max         int,
   @w_asi_max          int,
   @w_contador         int,
   @w_compmin          int,
   @w_compmax          int,
   @w_fecha            datetime,
   @w_comp_def         int,
   @w_maximo           int,
   @w_param_max        int,
   @w_usuario_arch     varchar(20),
   @w_dia              varchar(2),
   @w_mes              varchar(2),
   @w_anio             varchar(4),
   @w_fechav           varchar(8),
   @w_comp_ini        int
   
select @w_error       = 0
select @w_rowcount    = 0
select @w_comp_max    = 0
select @w_asiento_min = 0
select @w_asiento_max = 20000
select @w_asi_max     = 0
select @w_maximo      = 0
select @w_param_max   = 8 
       
select @w_archivo = em_archivo
from cob_conta..cb_estado_mig
where em_empresa = 1
and   em_estado = 'I'

select distinct ct_usuario_modulo, ct_fecha_tran
into #datos_arch
from cob_conta..cb_convivencia_tmp

select @w_usuario_arch = ct_usuario_modulo
from #datos_arch

select @w_fecha = ct_fecha_tran
from #datos_arch

select 
@w_dia = convert(varchar, datepart(dd, @w_fecha)),
@w_mes = convert(varchar, datepart(mm, @w_fecha)),
@w_anio = convert(varchar, datepart(yy, @w_fecha))

select @w_fechav = @w_anio+@w_mes+@w_dia

if exists (select 1 from cobis..cl_tabla T (nolock), cobis..cl_catalogo C (nolock)
           where T.tabla = 'cb_interfaz'
           and   T.codigo = C.tabla
           and   C.valor like '%' + @w_usuario_arch + '%') begin

   print 'existe catalogo'
   
   select distinct @w_comp_ini = ct_origen_mvto
   from cob_conta..cb_convivencia_tmp
   
   select 
   @w_dia = convert(varchar, datepart(dd, @w_fecha)),
   @w_mes = convert(varchar, datepart(mm, @w_fecha)),
   @w_anio = convert(varchar, datepart(yy, @w_fecha))

   select @w_fechav = @w_anio+@w_mes+@w_dia

   select 1
   from cob_conta..cb_control_carga
   where cc_archivo like '%' + @w_usuario_arch + '%' + @w_fechav + '%'
   and   (cc_comp_orig = @w_comp_ini or  @w_comp_ini is null)

   if @@rowcount > 0 begin
      INSERT into cb_log_errores_mig 
      (ler_fuente,        ler_fila,          ler_campo, 
      ler_dato,           ler_referencia,    ler_clave, 
      ler_producto)
      values( 
      @w_archivo,         0,                 'INTERFACE YA FUE CARGADA (1)', 
      @w_archivo,         0,                 0, 
      6)
      return 1
   end
end

--IF @@rowcount = 0
--begin
--   print 'NO EXISTEN ARCHIVOS A PROCESAR...'
--   return 0
--end      
truncate table cob_conta..cb_convivencia
truncate table cob_conta..cb_sasiento_mig
truncate table cob_conta..cb_scomprobante_mig

/**** VALIDA ARCHIVO SI YA FUE CARGADO *******/

INSERT into cb_log_errores_mig 
(ler_fuente,        ler_fila,          ler_campo, 
ler_dato,           ler_referencia,    ler_clave, 
ler_producto)
select 
@w_archivo,         0,                 'ARCHIVO YA FUE CARGADO', 
@w_archivo,         0,                 0, 
6
from cob_conta..cb_control_carga
where cc_archivo = @w_archivo

if @@error <> 0
begin
    select @w_mensaje = 'ERROR EN INSERCION DE TABLA ERRORES ARCHIVO CARGADO'
    GOTO ERROR
End


/**** VALIDA CANTIDAD DE DECIMALES ****/
select 1
from cob_conta..cb_convivencia_tmp
where abs(round(ct_debito, 2) - ct_debito) > 0
or   abs(round(ct_credito, 2) - ct_credito) > 0

if @@rowcount > 0 begin
   INSERT into cb_log_errores_mig 
   (ler_fuente,     ler_fila,        ler_campo, 
    ler_dato,       ler_referencia,  ler_clave, 
    ler_producto)
   values( 
   @w_archivo,      0,               'COMPROBANT CON + DE 3 DECIM',
   '0',             '0',              0,
   6)
end

SELECT ct_comprobante, ct_oficina_orig, ct_cantidad = count(1)
into #registros_comp
FROM cob_conta..cb_convivencia_tmp
group by ct_comprobante, ct_oficina_orig

INSERT into cb_log_errores_mig 
(ler_fuente,     ler_fila,        ler_campo, 
 ler_dato,       ler_referencia,  ler_clave, 
 ler_producto)
select 
@w_archivo,      0,               'COMPROBANT CON + DE 1 OFIORIG',
convert(varchar(10), ct_comprobante) + convert(varchar(10), count(1)), 0, 0,
6
from #registros_comp 
group by ct_comprobante 
having count(1) > 1

SELECT ct_comprobante, ct_oficina_orig, ct_oficina_dest, ct_cantidad = count(1)
into #registros
FROM cob_conta..cb_convivencia_tmp
group by ct_comprobante, ct_oficina_orig, ct_oficina_dest

select *
into #comp_mayor
from #registros_comp
where ct_cantidad > 40000

select catidad = COUNT(1), A.ct_comprobante 
into #comp_max
from #registros A
where ct_comprobante in (select B.ct_comprobante from #comp_mayor B)
GROUP BY ct_comprobante

select @w_maximo = max(catidad)
from #comp_max

if @w_maximo > @w_param_max begin
   INSERT into cb_log_errores_mig 
   (ler_fuente,     ler_fila,        ler_campo, 
    ler_dato,       ler_referencia,  ler_clave, 
    ler_producto)
    values(
    @w_archivo,      0,               'COMPROBANT + DE 8 REG X OFIC',
    @w_archivo,      0,                 0, 
    6)
end
    
select empresa= iva_empresa, codigo = iva_codigo, tipo= 'I',afectacion = iva_debcred
into #conceptos_imp
from cob_conta..cb_iva
union
select ic_empresa, ic_codigo,'C',ic_debcred
from cob_conta..cb_ica
union
select ip_empresa, ip_codigo,'P',ip_debcred
from cob_conta..cb_iva_pagado
union
select cr_empresa, cr_codigo ,'T',cr_debcred
from cob_conta..cb_conc_retencion
where cr_tipo = 'T'
union
select cr_empresa, cr_codigo, 'R',cr_debcred
from cob_conta..cb_conc_retencion
where cr_tipo = 'R'

--select co_secuencial, co_tipo, co_identifica, co_comprobante 
--into #cliente_convivencia
--from cob_conta..cb_convivencia
--where 1 = 2
        
insert into cb_log_errores_mig (ler_fuente, ler_fila, ler_campo, ler_dato, ler_referencia, ler_clave, ler_producto)
select @w_archivo, co_secuencial, 'FECHA CONTABLE CERRADA', isnull(cast(co_fecha_tran as varchar),'NULO'), 600101,co_comprobante,6
from cob_conta..cb_convivencia 
where co_secuencial     >  @w_asiento_min
and   co_secuencial     <= @w_asiento_max
and   co_empresa = @i_empresa
and   co_fecha_tran not in (select co_fecha_ini from cob_conta..cb_corte
                             where co_estado in ('A', 'V')
                             and   co_empresa = @i_empresa)
                             
if @@error <> 0
begin
    select @w_mensaje = 'ERROR EN INSERCION DE TABLA ERRORES ARCHIVO CARGADO'
    GOTO ERROR
End                             

while 1 = 1
begin

    print 'inserta en cb_convivencia'
    print '@w_comp_max '+ cast(@w_comp_max as varchar)
    set rowcount 20000
    
    insert into cob_conta..cb_convivencia 
                  (co_comprobante,              co_empresa,              co_fecha_tran,              co_oficina_orig,  
                   co_area_orig,                co_descripcion,          co_automatico,              co_estado,        
                   co_asiento,                  co_cuenta,               co_oficina_dest,            co_area_dest,     
                   co_credito,                  co_debito,               co_concepto,                co_tipo_doc,      
                   co_moneda,                   co_usuario_modulo,       co_credito_me,              co_debito_me,     
                   co_cotizacion,               co_tipo_tran,            co_tipo,                    co_identifica,    
                   co_concepto_imp,             co_base_imp,             co_documento,               co_oper_banco,    
                   co_cheque,                   co_origen_mvto)   
    select 
                   ct_comprobante,              ct_empresa,              ct_fecha_tran,              ct_oficina_orig,  
                   ct_area_orig,                ct_descripcion,          ct_automatico,              ct_estado,        
                   ct_asiento,                  ct_cuenta,               ct_oficina_dest,            ct_area_dest,     
                   isnull(ct_credito,0),        isnull(ct_debito,0),     ct_concepto,                ct_tipo_doc,      
                   ct_moneda,                   ct_usuario_modulo,       isnull(ct_credito_me,0),    isnull(ct_debito_me,0),     
                   ct_cotizacion,               ct_tipo_tran,            ct_tipo,                    ct_identifica,    
                   ct_concepto_imp,             ct_base_imp,             ct_documento,               ct_oper_banco,    
                   ct_cheque,                   ct_origen_mvto   
    from cob_conta..cb_convivencia_tmp
    where ((ct_comprobante > @w_comp_max)  or  (ct_comprobante >= @w_comp_max and ct_asiento >= @w_asi_max))
    order by ct_comprobante, ct_asiento

    select @w_error = @@error,
           @w_rowcount = @@rowcount
    
    if @w_error <> 0
    begin
         select @w_mensaje = 'ERROR EN INSERCION DE TABLA TEMPORAL'
         GOTO ERROR
    End

    select @w_comp_max = max(co_comprobante)
    from cob_conta..cb_convivencia
    
    select @w_asi_max = max(co_asiento)
    from cob_conta..cb_convivencia
    where co_comprobante = @w_comp_max
            
    delete from cob_conta..cb_convivencia_tmp
    where ((ct_comprobante < @w_comp_max)  or  (ct_comprobante = @w_comp_max and ct_asiento <= @w_asi_max))


    if @w_rowcount = 0
        break

   
    print '@w_comp_max '+ cast(@w_comp_max as varchar)
    print '@w_asi_max '+  cast(@w_asi_max as varchar)
    
end

set rowcount 0

select @w_contador = count(1)
from cob_conta..cb_convivencia

if @w_contador = 0
begin
    print 'No existen datos a procesar'
    return 0
end

select @w_asiento_min = 0
select @w_asiento_max = 20000
set rowcount 0

while 1 = 1
begin    
    /*** VALIDA EMPRESA ***/
    
    insert into cb_log_errores_mig (ler_fuente, ler_fila, ler_campo, ler_dato, ler_referencia, ler_clave, ler_producto)
    select @w_archivo, co_secuencial, 'EMPRESA NO EXISTE', isnull(cast(co_empresa as varchar),'NULO'), 600100,co_comprobante,6

   from cob_conta..cb_convivencia
    where co_empresa not in (select em_empresa
                             from   cob_conta..cb_empresa)
    and   co_secuencial     >  @w_asiento_min
    and   co_secuencial     <= @w_asiento_max
    
    if @@error <> 0
    begin
         select @w_mensaje = 'ERROR EN INSERCION DE TABLA ERRORES EMPRESA'
         GOTO ERROR
    End
    /*** VALIDA CORTES DE CONTABILIDAD ***/

    insert into cb_log_errores_mig (ler_fuente, ler_fila, ler_campo, ler_dato, ler_referencia, ler_clave, ler_producto)
    select @w_archivo, co_secuencial, 'FECHA CONTABLE CERRADA', isnull(cast(co_fecha_tran as varchar),'NULO'), 600101,co_comprobante,6
    from cob_conta..cb_convivencia 
    where co_secuencial     >  @w_asiento_min
    and   co_secuencial     <= @w_asiento_max
    and   co_empresa = @i_empresa
    and   co_fecha_tran not in (select co_fecha_ini from cob_conta..cb_corte
                                 where co_estado in ('A', 'V')
                                 and   co_empresa = @i_empresa)
        
    if @@error <> 0
    begin
         select @w_mensaje = 'ERROR EN INSERCION DE TABLA ERRORES FECHA CONTABLE'
         GOTO ERROR
    End
    
    /*** VALIDA OFICINAS DE MOVIMIENTO ***/

    insert into cb_log_errores_mig (ler_fuente, ler_fila, ler_campo, ler_dato, ler_referencia, ler_clave, ler_producto)
    select @w_archivo, co_secuencial, 'OFICINA DE MOVIMIENTO', isnull(cast(co_oficina_orig as varchar),'NULO'), 600102,co_comprobante,6        
    from cob_conta..cb_convivencia
    where co_secuencial     >  @w_asiento_min
    and   co_secuencial     <= @w_asiento_max
    and   ((co_oficina_orig is null ) or 
           co_oficina_orig not in (select of_oficina
                                        from cob_conta..cb_oficina
                                        where of_estado = 'V' and of_movimiento = 'S'
                                         and  of_empresa = @i_empresa))
    and  co_empresa = @i_empresa        
    
    if @@error <> 0
    begin
         select @w_mensaje = 'ERROR EN INSERCION DE TABLA OFICINA ORIGEN'
         GOTO ERROR
    End
    
   /*** VALIDA AREAS ***/
    insert into cb_log_errores_mig (ler_fuente, ler_fila, ler_campo, ler_dato, ler_referencia, ler_clave, ler_producto)
    select @w_archivo, co_secuencial, 'AREA_ORIG', isnull(cast(co_area_orig as varchar),'NULO'), 600103,co_comprobante,6
    from cob_conta..cb_convivencia
    where co_secuencial     >  @w_asiento_min
    and   co_secuencial     <= @w_asiento_max
    and   ((co_area_orig is null ) or 
           co_area_orig not in (select ar_area
                               from   cob_conta..cb_area
                               where ar_estado = 'V'  and    ar_movimiento = 'S'
                               and   ar_empresa = co_empresa))
    and  co_empresa = @i_empresa 
            
    if @@error <> 0
    begin
         select @w_mensaje = 'ERROR EN INSERCION DE TABLA ERRORES AREA ORIGEN'
         GOTO ERROR
    End
    
    /***** VALIDA CODIGO AUTOMATICO *********/
    
    
    /****************************************/
    

    /********* MODIFICACION PARCIAL ***********/        

    /*** VALIDA MONEDAS ***/
    insert into cb_log_errores_mig (ler_fuente, ler_fila, ler_campo, ler_dato, ler_referencia, ler_clave, ler_producto)
    select @w_archivo, co_secuencial, 'MONEDA', isnull(cast(co_moneda as varchar),'NULO'), 600100,co_comprobante,6
    from cob_conta..cb_convivencia
    where co_secuencial     >  @w_asiento_min
    and   co_secuencial     <= @w_asiento_max
    and   ((co_moneda is null ) or 
           co_moneda not in (select mo_moneda
                            from   cobis..cl_moneda))
    and   co_empresa = @i_empresa
    
    if @@error <> 0
    begin
         select @w_mensaje = 'ERROR EN INSERCION DE TABLA ERRORES MONEDA'
         GOTO ERROR
    End

    /*** VALIDA CUENTAS DE MOVIMIENTO ***/
    insert into cb_log_errores_mig (ler_fuente, ler_fila, ler_campo, ler_dato, ler_referencia, ler_clave, ler_producto)
    select @w_archivo, co_secuencial, 'CUENTA CONTABLE', isnull(cast(co_cuenta as varchar),'NULO'), 600100,co_comprobante,6
    from cob_conta..cb_convivencia
    where co_secuencial     >  @w_asiento_min
    and   co_secuencial     <= @w_asiento_max
    and   co_cuenta not in (select cu_cuenta 
                            from cob_conta..cb_cuenta 
                            where cu_estado = 'V' 
                            and   cu_movimiento = 'S'
                            and   cu_empresa = @i_empresa)
    and  co_empresa = @i_empresa
    
    if @@error <> 0
    begin
         select @w_mensaje = 'ERROR EN INSERCION DE TABLA ERRORES CUENTA CONTABLE'
         GOTO ERROR
    End
    
    /**** VALIDAR MONEDA DE CUENTA ************/
    
    
    /******************************************/
    
    /*** VALIDA CUENTAS DE PROCESO ***/ 
    insert into cb_log_errores_mig (ler_fuente, ler_fila, ler_campo, ler_dato, ler_referencia, ler_clave, ler_producto)
    select @w_archivo, co_secuencial, 'FALTA TERCERO', isnull(cast(co_cuenta as varchar),'NULO'), 600100,co_comprobante,6
    from cob_conta..cb_convivencia, 
         cob_conta..cb_cuenta_proceso
    where co_secuencial     >  @w_asiento_min
    and   co_secuencial     <= @w_asiento_max
    and   cp_proceso in (6003,6095)
    and   cp_cuenta = co_cuenta
    and   isnull(co_identifica, '')  = ''
    
    if @@error <> 0
    begin
         select @w_mensaje = 'ERROR EN INSERCION DE TABLA ERRORES CUENTA PROCESO'
         GOTO ERROR
    End
    
    insert into cb_log_errores_mig (ler_fuente, ler_fila, ler_campo, ler_dato, ler_referencia, ler_clave, ler_producto)
    select @w_archivo, co_secuencial, 'FALTA OPERACION PARA BANCO', isnull(cast(co_oper_banco as varchar),'NULO'), 600103,co_comprobante,6
    from cob_conta..cb_convivencia,
         cob_conta..cb_banco
    where co_secuencial     >  @w_asiento_min
    and   co_secuencial     <= @w_asiento_max
    and   ba_empresa = @i_empresa
    and   ba_banco > ''
    and   ba_cuenta > ''
    and   ba_cuenta = co_cuenta
    and   co_oper_banco = ''
    
    if @@error <> 0
    begin
         select @w_mensaje = 'ERROR EN INSERCION DE TABLA ERRORES OPERACION BANCO'
         GOTO ERROR
    End

    /***************************************/
    
    /*** VALIDA OFICINAS DESTINO DE MOVIMIENTO ***/
    
    insert into cb_log_errores_mig (ler_fuente, ler_fila, ler_campo, ler_dato, ler_referencia, ler_clave, ler_producto)
    select @w_archivo, co_secuencial, 'OFICINA DESTINO', isnull(cast(co_oficina_dest as varchar),'NULO'), 600100,co_comprobante,6
    from cob_conta..cb_convivencia
    where co_secuencial     >  @w_asiento_min
    and   co_secuencial     <= @w_asiento_max
    and   ((co_oficina_dest is null ) or 
           co_oficina_dest not in (select of_oficina
                                        from cob_conta..cb_oficina
                                        where of_estado = 'V' and of_movimiento = 'S'
                                         and  of_empresa = @i_empresa))
    and  co_empresa = @i_empresa

            
    if @@error <> 0
    begin
         select @w_mensaje = 'ERROR EN INSERCION DE TABLA ERRORES OFICINA DESTINO'
         GOTO ERROR
    End

    /*** VALIDA AREAS DESTINO ***/
    
    insert into cb_log_errores_mig (ler_fuente, ler_fila, ler_campo, ler_dato, ler_referencia, ler_clave, ler_producto)
    select @w_archivo, co_secuencial, 'AREA_DESTINO', isnull(cast(co_area_dest as varchar),'NULO'), 600103,co_comprobante,6
    from cob_conta..cb_convivencia
    where co_secuencial     >  @w_asiento_min
    and   co_secuencial     <= @w_asiento_max
    and   ((co_area_dest is null ) or 
           co_area_dest not in (select ar_area
                               from   cob_conta..cb_area
                               where ar_estado = 'V'  and    ar_movimiento = 'S'
                               and   ar_empresa = co_empresa))
    and  co_empresa = @i_empresa  
    
    
    if @@error <> 0
    begin
         select @w_mensaje = 'ERROR EN INSERCION DE TABLA ERRORES AREA DESTINO'
         GOTO ERROR
    End
    
    /******* VALIDA EXCLUSION MONEDA NACIONAL **********/
    insert into cb_log_errores_mig (ler_fuente, ler_fila, ler_campo, ler_dato, ler_referencia, ler_clave, ler_producto)
    select @w_archivo, co_secuencial, 'EXCLUSION MN', cast(co_debito as varchar) + cast(co_debito as varchar), 600103,co_comprobante,6
    from cob_conta..cb_convivencia
    where co_secuencial     >  @w_asiento_min
    and   co_secuencial     <= @w_asiento_max
    and   (co_debito <> 0 and   co_credito <> 0)
    or    (co_debito = 0 and   co_credito = 0)
    and  co_moneda = 0

    if @@error <> 0
    begin
         select @w_mensaje = 'ERROR EN INSERCION DE TABLA ERRORES EXCLUSION MN'
         GOTO ERROR
    End

    /******* VALIDA EXCLUSION MONEDA EXTRANJERA **********/
    insert into cb_log_errores_mig (ler_fuente, ler_fila, ler_campo, ler_dato, ler_referencia, ler_clave, ler_producto)
    select @w_archivo, co_secuencial, 'EXCLUSION ME', cast(co_debito_me as varchar) + cast(co_debito_me as varchar), 600103,co_comprobante,6
    from cob_conta..cb_convivencia
    where co_secuencial     >  @w_asiento_min
    and   co_secuencial     <= @w_asiento_max
    and   (co_debito_me <> 0 and   co_credito_me <> 0) or
          (co_debito_me = 0 and   co_credito_me = 0)
    and  co_moneda <> 0

    if @@error <> 0
    begin
         select @w_mensaje = 'ERROR EN INSERCION DE TABLA ERRORES EXCLUSION ME'
         GOTO ERROR
    End

    /***** VALIDA MONEDA EXTRANJERA *********/
    insert into cb_log_errores_mig (ler_fuente, ler_fila, ler_campo, ler_dato, ler_referencia, ler_clave, ler_producto)
    select @w_archivo, co_secuencial, 'VALOR MONEDA EXTRANJERA', cast(co_debito_me as varchar) + cast(co_debito_me as varchar), 600103,co_comprobante,6
    from cob_conta..cb_convivencia
    where co_secuencial     >  @w_asiento_min
    and   co_secuencial     <= @w_asiento_max
    and   isnull(co_moneda, 0) = 0
    and   co_empresa = @i_empresa
    and  (co_debito_me <> 0 or co_credito_me <> 0)
    
    if @@error <> 0
    begin
         select @w_mensaje = 'ERROR EN INSERCION DE TABLA ERRORES VALOR ME'
         GOTO ERROR
    End

    insert into cb_log_errores_mig (ler_fuente, ler_fila, ler_campo, ler_dato, ler_referencia, ler_clave, ler_producto)
    select @w_archivo, co_secuencial, 'REFERENCIA MONEDA EXTRANJERA', cast(co_debito_me as varchar) + cast(co_debito_me as varchar), 600103,co_comprobante,6
    from cob_conta..cb_convivencia
    where co_secuencial     >  @w_asiento_min
    and   co_secuencial     <= @w_asiento_max
    and    isnull(co_moneda, 0) = 0
    and   (co_debito_me + co_credito_me) <> 0
    and   (co_debito + co_credito) = 0
    or    (((co_debito_me + co_credito_me) < 0
    and   (co_debito + co_credito) > 0) or
          ((co_debito_me + co_credito_me) > 0
    and   (co_debito + co_credito) < 0))

    if @@error <> 0
    begin
         select @w_mensaje = 'ERROR EN INSERCION DE TABLA ERRORES REFERENCIA ME'
         GOTO ERROR
    End

    /*** VALIDA TIPO IDENTIFICACION ***/
    insert into cb_log_errores_mig (ler_fuente, ler_fila, ler_campo, ler_dato, ler_referencia, ler_clave, ler_producto)
    select @w_archivo, co_secuencial, 'TIPO DOCUMENTO ERRONEO', isnull(cast(co_tipo as varchar),'NULO'), 600100,co_comprobante,6
    from cob_conta..cb_convivencia
    where co_secuencial     >  @w_asiento_min
    and   co_secuencial     <= @w_asiento_max
    and   co_tipo not in (select   codigo 
                          from cobis..cl_catalogo 
                          where tabla = (select codigo from cobis..cl_tabla where tabla = 'cl_tipo_documento') )
    and  co_empresa = @i_empresa
    and  co_cuenta in (select cp_cuenta from cob_conta..cb_cuenta_proceso 
                       where cp_proceso in (6003, 6095)
                       and   cp_empresa = @i_empresa)

    if @@error <> 0
    begin
         select @w_mensaje = 'ERROR EN INSERCION DE TABLA ERRORES TIPO IDENTIFICACION'
         GOTO ERROR
    End

    /*** VALIDA CONCEPTOS DE IMPUESTOS ***/
    
    insert into cb_log_errores_mig (ler_fuente, ler_fila, ler_campo, ler_dato, ler_referencia, ler_clave, ler_producto)
    select @w_archivo, co_secuencial, 'CONCEPTO IMPUESTO', isnull(cast(co_concepto_imp as varchar),'NULO'), 600103,co_comprobante,6
    from cob_conta..cb_convivencia
    where co_secuencial     >  @w_asiento_min
    and   co_secuencial     <= @w_asiento_max
    and   co_concepto_imp not in (select codigo from #conceptos_imp
                                  where empresa = co_empresa)
    and   co_empresa = @i_empresa
    and   co_cuenta in (select cp_cuenta from cob_conta..cb_cuenta_proceso
                        where cp_proceso = 6095
                        and   cp_empresa = @i_empresa)

    if @@error <> 0
    begin
         select @w_mensaje = 'ERROR EN INSERCION DE TABLA ERRORES CONCEPTO IMPUESTO'
         GOTO ERROR
    End

    select distinct co_tipo, co_identifica
    into #clientes
    from cob_conta..cb_convivencia
    where co_cuenta in (select cp_cuenta from cob_conta..cb_cuenta_proceso
                        where cp_proceso in (6003, 6095))
    and   co_secuencial     >  @w_asiento_min
    and   co_secuencial     <= @w_asiento_max

    select tipo = co_tipo, identifica = co_identifica, comprobante = co_comprobante 
    into #cliente_convivencia
    from cobis..cl_ente,
         cob_conta..cb_convivencia,
         cob_conta..cb_cuenta_proceso
    where co_secuencial     >  @w_asiento_min
    and   co_secuencial     <= @w_asiento_max
    and   en_ente > 0
    and   co_tipo = en_tipo_ced
    and   co_identifica = en_ced_ruc
    and   co_cuenta = cp_cuenta
    and   cp_proceso in (6003, 6095)

    delete #cliente_convivencia
    from cobis..cl_depu_ente
    where den_ente   > 0
    and   tipo       = den_tipo_ced
    and   identifica = den_ced_ruc

    insert into #cliente_convivencia
    select tipo = co_tipo, identifica = co_identifica, comprobante = co_comprobante 
    from cobis..cl_depu_ente,
         cob_conta..cb_convivencia,
         cob_conta..cb_cuenta_proceso
    where co_secuencial     >  @w_asiento_min
    and   co_secuencial     <= @w_asiento_max
    and   den_ente > 0
    and   co_tipo = den_tipo_ced
    and   co_identifica = den_ced_ruc
    and   co_cuenta = cp_cuenta
    and   cp_proceso in (6003, 6095)

    delete #clientes
    from #cliente_convivencia
    where co_identifica = identifica
    and   co_tipo       = tipo

    insert into cb_log_errores_mig (ler_fuente, ler_fila, ler_campo, ler_dato, ler_referencia, ler_clave, ler_producto)
    select @w_archivo, 0, 'CLIENTE NO EXISTE', isnull(cast(co_tipo + co_identifica as varchar),'NULO'), 600100,0,6
    from #clientes
    
    if @@error <> 0
    begin
         select @w_mensaje = 'ERROR EN INSERCION DE TABLA ERRORES CLIENTE'
         GOTO ERROR
    End    
    
    print '@w_contador '+cast(@w_contador as varchar)
    print '@w_asiento_max '+cast(@w_asiento_max as varchar)
    
    drop table #clientes
    
    drop table #cliente_convivencia    
    
    if @w_contador <= @w_asiento_max
    begin
        break
    end
        
    select @w_asiento_min = @w_asiento_max
    select @w_asiento_max = @w_asiento_max + 20000
  
    
    /******* VALIDA VALORES **********/
    
end    


select @w_compmax = max(co_comprobante),
       @w_compmin = min(co_comprobante)
from cob_conta..cb_convivencia

while 1 = 1
begin
    set rowcount 0
        
    /******* VALIDA ASIENTO > 0 Y SEA NUMERO ************/
    select @w_numasien = 0

    select @w_compt = @w_compmin + 5000
        
--    select distinct co_comprobante
--    from cob_conta..cb_convivencia
    
    select conteo  = count(1), 
           asiento = co_asiento, 
           comprobante = co_comprobante
    into #asiento_err
    from cob_conta..cb_convivencia
    where co_comprobante >= @w_compmin
    and   co_comprobante <= @w_compt
    group by co_asiento, co_comprobante
    having count(1) > 1
    union
    select count(1), max(co_asiento), co_comprobante
    from cob_conta..cb_convivencia
    where co_comprobante >= @w_compmin
    and   co_comprobante <= @w_compt
    group by co_comprobante
    having count(1) <> max(co_asiento)
    union
    select 1, min(co_asiento), co_comprobante
    from cob_conta..cb_convivencia
    where co_comprobante >= @w_compmin
    and   co_comprobante <= @w_compt
    group by co_comprobante
    having min(co_asiento) <> 1
    
  
    select @w_numasien = count(1)
    from #asiento_err
        
    if @w_numasien > 0
    begin
         insert into cb_log_errores_mig (ler_fuente, ler_fila, ler_campo, ler_dato, ler_referencia, ler_clave, ler_producto)
         values(@w_archivo, 0, 'NUMERACION ASIENTOS', '', 600100,@w_compt,6)

         if @@error <> 0
         begin
            select @w_mensaje = 'ERROR EN INSERCION DE TABLA ERRORES NUMERACION ASIENTOS'
            GOTO ERROR
         End
    end   
    
    drop table #asiento_err
    
    select count(1), co_descripcion
    from cob_conta..cb_convivencia
    where co_comprobante >= @w_compmin
    and   co_comprobante <= @w_compt
    group by co_comprobante, co_descripcion
    having count(distinct co_descripcion)> 1
    
    if @@rowcount > 1
    begin
        insert into cb_log_errores_mig (ler_fuente, ler_fila, ler_campo, ler_dato, ler_referencia, ler_clave, ler_producto)
        values (@w_archivo, 0, 'DESCRIPCION DEBE SER UNICA PARA EL COMPROBANTE', '',600200, @w_compt, 6)
        
         if @@error <> 0
         begin
            select @w_mensaje = 'ERROR EN INSERCION DE TABLA ERRORES DESCRIPCION UNICA'
            GOTO ERROR
         End        
    end
    
    select @w_compmin = @w_compt + 1
    
    if @w_compt >= @w_compmax
        break
end  

set rowcount 0

print 'inicia nuevo'

update cb_estado_mig
set em_estado  = 'F'

/***********  VALIDA TOTAL DEBITO / CREDITO  ******/  

select debito = isnull(sum(isnull(co_debito,0)), 0),
       credito = isnull(sum(isnull(co_credito,0)),0),
       co_comprobante
into #diferencia_comprobante
from cob_conta..cb_convivencia
where co_comprobante > 0
group by co_comprobante

insert into cb_log_errores_mig 
(ler_fuente,                   ler_fila,       ler_campo, 
ler_dato,                      ler_referencia, ler_clave, 
ler_producto)
select 
isnull(@w_archivo,'interfaz'), 0,              'COMPROBANTE DESCUADRADO', 
'DEBITO: '+ cast(debito as varchar) + ' CREDITO: ' + cast(credito as varchar), 600100,co_comprobante,
6
from #diferencia_comprobante
where debito <> credito

if @@error <> 0
begin
     select @w_mensaje = 'ERROR EN INSERCION DE TABLA ERRORES COMPROBANTE DESCUADRADO'
     GOTO ERROR
End    

-- VALIDA COMPROBANTES POR FECHA --

select co_comprobante, co_fecha_tran
into #comprobantes_fecha
from cob_conta..cb_convivencia
group by co_comprobante, co_fecha_tran

select cantidad = count(1), comprobante = co_comprobante
into #comp_def
from #comprobantes_fecha
group by co_comprobante
having count(1) > 1

select @w_error = 0

insert into cb_log_errores_mig (ler_fuente, ler_fila, ler_campo, ler_dato, ler_referencia, ler_clave, ler_producto)
select @w_archivo, 0, 'DIF.FECHA.COMP', ''+ cast(comprobante as varchar), 600100,comprobante,6   
from #comp_def

select @w_error = @@error

if @w_error <> 0
begin
   select @w_mensaje = 'ERROR AL INSERTAR EN TABLA DE ERRORES VARIAS FECHAS POR COMPROBANTE' + cast(@w_error as varchar)
   goto ERROR
end

-- VALIDA CUENTAS AUTOMATICAS EN COMPROBANTE --
if @i_valautomatica = 'S'
begin
   select re_substring
   into #cuenta_aut
   from cob_conta..cb_det_perfil,
         cob_conta..cb_relparam
   where dp_perfil like 'BOC%'
   and   dp_cuenta = re_parametro
   
   print '** CUENTAS EN BOC Y AUTOMATICAS **'
   PRINT ' '
   
   delete      #cuenta_aut
   from cob_conta..cb_cuenta
   where cu_acceso <> 'A'
   and   cu_cuenta = re_substring
   
   insert into cb_log_errores_mig 
   (ler_fuente,                     ler_fila,               ler_campo, 
    ler_dato,                       ler_referencia,         ler_clave, 
    ler_producto)
   select distinct
    @w_archivo,                     co_asiento,             '',
    'CTA. ES AUTOM. '+re_substring, 600100,                 co_comprobante, 
    6
   from cob_conta..cb_convivencia,
        #cuenta_aut
   WHERE co_cuenta = re_substring
   
   if @w_error <> 0
   begin
      select @w_mensaje = 'ERROR AL INSERTAR EN TABLA DE ERRORES CUENTAS AUTOMATIVAS' + cast(@w_error as varchar)
      goto ERROR
   end
end

/**** VALIDA VALORES NEGATIVOS ****/

select debito = isnull(sum(isnull(co_debito,0)), 0),
       credito = isnull(sum(isnull(co_credito,0)),0),
       co_comprobante,
       co_asiento
into #comp_negativo
from cob_conta..cb_convivencia (nolock)
where co_comprobante > 0
and   co_asiento     > 0
and   co_secuencial  > 0
and   (co_debito < 0 or co_credito < 0)
group by co_comprobante, co_asiento

insert into cb_log_errores_mig (ler_fuente, ler_fila, ler_campo, ler_dato, ler_referencia, ler_clave, ler_producto)
select @w_archivo, co_asiento, 'VALORES NEG.ASIENTO', 'ASIENTO: '+ cast(co_asiento as varchar) + ' COMPROBANTE: '+ cast(co_comprobante as varchar), 600100, co_comprobante,6   
from #comp_negativo

if @@error <> 0
begin
   select @w_mensaje = 'ERROR EN INSERCION DE TABLA ERRORES NUMERACION ASIENTOS'
   GOTO ERROR
End

/*****************************************/

update cb_estado_mig
set em_estado  = 'T'

select @o_archivo = @w_archivo

RETURN 0

ERROR:
    print @w_mensaje

    update cb_estado_mig
    set em_estado  = 'E'

    return 1

go
 
