/************************************************************************/
/*      Archivo:              ahcierrmas.sp                             */
/*      Stored procedure:     sp_cierre_masivo_ctaah                    */
/*      Base de datos:        cob_ahorros                               */
/*      Producto:             Cuentas de Ahorros                        */
/*      Disenado por:         Jaime Loyo                                */
/*      Fecha de escritura:   04/Sep/2012                               */
/************************************************************************/
/*              IMPORTANTE                                              */
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
/*      PROPOSITO                                                       */
/*      Este programa realiza lo SIGUIENTE:                             */
/*      Dada unas cuentas inactivas el proceso reactiva y cierra las    */
/*      Cuentas de ahorros con abono en cuenta contable.  Se basa en los*/
/*      los cuentas que se encuentran en la tabla ah_ctas_cancelar      */
/************************************************************************/
/*                        MODIFICACIONES                                */
/*      FECHA         AUTOR           RAZON                             */
/*      04/Sep/2012   Jaime Loyo      Emision Inicial                   */
/*      12/Sep/2012   Andres Muñoz    ORS 488                           */
/*      02/May/2016   J. Calderon     Migración a CEN                   */
/************************************************************************/

USE cob_ahorros
GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

set ansi_warnings off

if exists (select 1 from sysobjects where name = 'sp_cierre_masivo_ctaah' and type = 'P')
   drop proc sp_cierre_masivo_ctaah
go

create proc sp_cierre_masivo_ctaah(
   @t_show_version          bit = 0, 
   @i_param1                varchar(255)= null  -- Fecha de la cual se van a procesar los registros
   )
as

declare 
@w_cant_sec     int, 
@w_ssn          int,
@w_term         varchar(30),
@w_srv          varchar(30),
@w_return       int,
@w_fecha        smalldatetime,
@w_cta_banco    cuenta,
@w_oficina      smallint,
@w_monto_retiro money,
@w_fecha_proc   datetime,
@o_saldo         money,
@w_s_app         varchar(255),
@w_path          varchar(255),
@w_nombre        varchar(255),
@w_nombre_cab    varchar(255),
@w_destino       varchar(2500),
@w_errores       varchar(1500),
@w_error         int,
@w_comando       varchar(3500),
@w_nombre_plano  varchar(2500),
@w_msg           varchar(255),
@w_col_id        int,
@w_columna       varchar(100),
@w_cabecera      varchar(2500),
@w_nom_tabla     varchar(100),
@w_exclusivo     varchar(1),
@w_proc          char(1),
@w_cauciina      varchar(3),
@w_login_ope     varchar(10),
@w_tproceso      char(1),
@w_disponible    money,
@w_cuenta        int,
@w_base_gmf      money,
@w_val_gmf       money,
@w_numdeci_imp   tinyint,
@w_moneda        tinyint,
@w_valorven      money,
@w_valormax      money,
@w_sec           int,
@w_sp_name       varchar(30)



/* Captura del nombre del Stored Procedure */
select @w_sp_name = 'sp_cierre_masivo_ctaah'


---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
if @t_show_version = 1
begin
    print 'Stored Procedure = '+ @w_sp_name + 'Version = ' + '4.0.0.0'
    return 0
end

if @i_param1 is null
begin
    print 'No se dio fecha a Procesar'
    return 1
end

-- Lectura para login operador batch
select @w_login_ope = pa_char 
from   cobis..cl_parametro
where  pa_nemonico = 'LOB'
and    pa_producto = 'ADM'

if @w_login_ope is null
   select @w_login_ope = 'op_batch'

--Lectura parametro tipo de proceso
select @w_tproceso = pa_char
from   cobis..cl_parametro
where  pa_producto = 'AHO'
and    pa_nemonico = 'TPROM'

if @w_tproceso is null
   select @w_tproceso = 'C'

select @w_fecha_proc = convert(datetime,@i_param1), @w_term = 'TERM'

select @w_fecha  = convert(smalldatetime,fp_fecha)
from   cobis..ba_fecha_proceso

/***  Se trae el nombre del servidor Central, para dejar registro en el log ****/
select @w_srv = nl_nombre 
from   cobis..ad_nodo_oficina
where  nl_oficina = 1

if @@rowcount = 0
begin
    print 'No existe nombre del servidor'
    return 1
end

--Parametro de decimales para impuestos 
select @w_numdeci_imp = pa_tinyint 
from   cobis..cl_parametro         
where  pa_nemonico = 'DIM'         
and    pa_producto = 'AHO'  

if @w_numdeci_imp is null     
   select @w_numdeci_imp = 2      

if @w_tproceso = 'C' begin
   select @w_cauciina = pa_char --Causal cierre inactivas
   from   cobis..cl_parametro 
   where  pa_producto = 'AHO'
   and    pa_nemonico = 'CAUT'
   
   if @w_cauciina is null
       select @w_cauciina = '12'
end
else begin
   select @w_cauciina = pa_char --Causal debito ctas inactivas para abono a cartera
   from   cobis..cl_parametro 
   where  pa_producto = 'AHO'
   and    pa_nemonico = 'PMASA'
   
   if @w_cauciina is null
       select @w_cauciina = '44'
end



select @w_cant_sec = count(1) * 4 -- ( cantidad de transacciones maximas)
from   cob_ahorros..ah_ctas_cancelar


update cobis..ba_secuencial set  
@w_ssn    = se_numero ,  
se_numero = @w_ssn + @w_cant_sec

  if @@rowcount <> 1
  begin
     /* Error en actualizacion de SSN */
     exec cobis..sp_cerror
     @i_num       = 205031
     return 205031
  end


print ' INICIA EL PROCESO'
print ' Fecha a Procesar :' + cast(@w_fecha_proc as varchar)
print ' Secuencial = ' + cast (@w_ssn as varchar)


select top 1 
@w_cta_banco = cc_ctabanco,
@w_oficina   = cc_oficina,
@w_exclusivo = cc_exclusivo,
@w_disponible= cc_disponible,
@w_cuenta    = cc_cuenta,
@w_moneda    = 0,
@w_valorven  = cc_valorven,
@w_sec       = cc_sec
from cob_ahorros..ah_ctas_cancelar
where cc_fecha    = @w_fecha_proc
and   cc_procesado= 'N'
and   cc_disponible > 0
and   (cc_exclusivo = 'C' or (@w_tproceso = 'C' and cc_exclusivo = 'S'))
order by cc_ctabanco, cc_diasmora desc


print ''

while @w_cta_banco  is not null
begin
    begin tran
        
        if @w_tproceso = 'C' begin
           print 'Proceso ' + isnull(@w_tproceso,'X') + 'Cuenta : ' + @w_cta_banco + ' @w_valorven: ' + cast(@w_valorven as varchar) + ' @w_disponible ' + cast(@w_disponible as varchar)
           print '..........................Reactivacion de la cuenta'
           
           exec @w_return  =  cob_ahorros..sp_reactivacion_ah  
           @s_ssn       = @w_ssn,
           @s_ssn_branch= @w_ssn,
           @s_srv       = @w_srv,
           @s_sesn      = @w_ssn,
           @s_user      = @w_login_ope,
           @s_term      = @w_term,
           @s_date      = @w_fecha,
           @s_ofi       = @w_oficina,
           @s_org       = 'U',
           @t_trn       = 203,
           @i_cta       = @w_cta_banco,
           @i_mon       = 0,
           @o_saldo     = @o_saldo out
           
           if @w_return  = 0  and @@error = 0 /*** SI la cuenta se pudo reactivar *****/
           begin 
              print '..........................Consulta de cierre de la cuenta'
              select @w_ssn = @w_ssn + 1
           
              exec @w_return  =  cob_ahorros..sp_cons_cierre_ah
              @s_ssn      = @w_ssn,
              @s_srv      = @w_srv,
              @s_user     = @w_login_ope,
              @s_sesn     = @w_ssn,
              @s_org      = 'U',
              @s_term     = @w_term,
              @s_date     = @w_fecha,
              @s_ofi      = @w_oficina,
              @t_trn      = 214,
              @i_filial   = 1,
              @i_oficina  = @w_oficina,
              @i_cta      = @w_cta_banco,
              @i_mon      = @w_moneda,
              @i_val_inac = 'N',
              @i_cob_multa= 'N',
              @o_retiro   = @w_monto_retiro out
           
              if @w_return = 0  and @@error =  0 
              begin
                 print ' Valor a Retirar       ' + cast(@w_monto_retiro as varchar)
                 print ' Saldo de reactivacion ' + cast (@o_saldo   as varchar)
                 print ''
                 update cob_ahorros..ah_ctas_cancelar
                 set    cc_saldado    = @w_monto_retiro
                 where  cc_fecha    = @w_fecha_proc
                 and    cc_ctabanco = @w_cta_banco
                 and    cc_sec      = @w_sec
           
                 if @@error <> 0 
                 begin
                    print 'Se Presento error en la actualizacion -Monto de retiro'
                    rollback 
                    goto SIGUIENTE
                 end
                 
                 print '..........................Cierre  de la cuenta'
                 select @w_ssn = @w_ssn + 1
           
                 exec @w_return  = cob_ahorros..sp_ah_cierre
                 @s_ssn          = @w_ssn,
                 @s_term         = @w_term,
                 @s_srv          = @w_srv,
                 @s_lsrv         = @w_srv,
                 @s_user         = @w_login_ope,
                 @s_date         = @w_fecha,
                 @s_ofi          = @w_oficina,
                 @s_rol          = 1,
                 @s_org          = 'U',
                 @t_trn          = 213,
                 @i_val          = @w_monto_retiro,
                 @i_sldlib       = 0,
                 @i_cau          = @w_cauciina,
                 @i_ord          = 'M',
                 @i_aut          = @w_login_ope,
                 @i_nctrl        = 0,
                 @i_mon          = @w_moneda,                                      
                 @i_monto_maximo = 'S',
                 @i_tadmin       = 1,
                 @i_fcancel      = 'C',
                 @i_codbene      = 0,
                 @i_cta          = @w_cta_banco,
                 @i_cobra        = 0,
                 @i_observacion  =  'CIERRE MASIVO DE CUENTAS INACTIVAS',
                 @i_observacion1 = NULL,
                 @i_ejec_marca   = 'N'           
           
           
                 if @w_return = 0 and @@error =  0 
                 begin
                    print '______________________Cuenta Procesada OK'
                    if @w_exclusivo = 'S'
                       select @w_proc = 'X'
                    else
                       select @w_proc = 'S'
                    
                    print ''
                    update cob_ahorros..ah_ctas_cancelar set
                    cc_procesado      = @w_proc,
                    cc_fecha_proc     = @w_fecha,
                    cc_mensaje        = 'Proceso Ok'
                    where cc_fecha    = @w_fecha_proc
                    and   cc_ctabanco = @w_cta_banco
                    and   cc_sec      = @w_sec
                    
                    if @@error <> 0 
                    begin
                       print 'Se Presento error en la actualizacion -Proceso Ok'
                       rollback 
                       goto SIGUIENTE
                    end
                    
                    commit tran
                 end
                 else  /** Error al cerrar la cuenta hay que marcarla ***/
                 begin
                     
                    rollback
                 
                    print  '..........................ERROR: NO se pudo Saldar la cuenta'
                    print  'Error del return ' + cast( @w_return as varchar)
                    print ''
                    update cob_ahorros..ah_ctas_cancelar
                    set cc_procesado = 'E',
                    cc_mensaje  = 'NO se pudo Saldar la cuenta'
                    where cc_fecha    = @w_fecha_proc
                    and   cc_ctabanco = @w_cta_banco
                    and   cc_sec      = @w_sec
           
                    if @@error <> 0 
                    begin
                       print 'Se Presento error en la actualizacion -Error:Saldar cuenta'
                    end
                 end
              end
              else /*** Error al consultar para el cierre de cuenta ***/
              begin
                rollback
                  print  '..........................ERROR: NO se puedo consultar el cierre'
                  print  'Error del return ' + cast( @w_return as varchar)
                  print ''
                  update cob_ahorros..ah_ctas_cancelar
                  set cc_procesado = 'E',
                  cc_mensaje = 'NO se puedo consultar el cierre'
                  where cc_fecha    = @w_fecha_proc
                  and   cc_ctabanco = @w_cta_banco
                  and   cc_sec      = @w_sec
           
                  if @@error <> 0 
                  begin
                    print 'Se Presento error en la actualizacion -Error:Consulta de Cierre'
                  end
           
              end
           end
           else  /*** Error por no realizarse la reactivacion de la cuenta ****/
           begin
              rollback 
              print  '..........................ERROR: No se Reactivo la cuenta'
              print  'Error del return ' + cast( @w_return as varchar)
              print ''
              update cob_ahorros..ah_ctas_cancelar set
              cc_procesado = 'E',
              cc_mensaje   = 'No se Reactivo la cuenta'
              where cc_fecha    = @w_fecha_proc
              and   cc_ctabanco = @w_cta_banco
              and   cc_sec      = @w_sec
              
              if @@error <> 0 
              begin
                  print 'Se Presento error en la actualizacion -Error:Reactivacion de cuenta ' + isnull(@w_cta_banco, '')
              end
           end
        end --@w_tproceso = 'C'
        else begin 
           --Proceso de debito
           print 'Proceso ' + isnull(@w_tproceso,'X') + 'Cuenta : ' + @w_cta_banco + ' @w_valorven: ' + cast(@w_valorven as varchar) + ' @w_disponible ' + cast(@w_disponible as varchar)
           select @w_monto_retiro = 0, @w_val_gmf = 0, @w_base_gmf = 0
           select @w_valormax = @w_disponible
           
           if @w_disponible > @w_valorven begin
              --Calculo de valor GMF y valor a debitar
              exec @w_return = cob_ahorros..sp_calcula_gmf
              @s_date        = @w_fecha,     -- Fecha de Proceso
              @s_ofi         = @w_oficina,   -- Oficina de la Cuenta
              @s_user        = @w_login_ope, -- Usuario de proceso batch
              @i_operacion   = 'Q',
              @i_total       = 'N',
              @i_factor      = 1,
              @i_cuenta      = @w_cuenta,
              @i_val         = @w_valorven, 
              @i_numdeciimp  = @w_numdeci_imp,
              @o_total_gmf   = @w_val_gmf    out, --GMF a cobrar
              @o_base_gmf    = @w_base_gmf   out  --Valor a debitar
              
              select @w_valormax = @w_valorven + round(@w_val_gmf, @w_numdeci_imp) 
              
           end
           
           if @w_valormax > @w_disponible  or @w_disponible <= @w_valorven
           begin
              --Calculo de valor GMF y valor a debitar
              exec @w_return = cob_ahorros..sp_calcula_gmf
              @s_date        = @w_fecha,     -- Fecha de Proceso
              @s_ofi         = @w_oficina,   -- Oficina de la Cuenta
              @s_user        = @w_login_ope, -- Usuario de proceso batch
              @i_operacion   = 'Q',
              @i_total       = 'S',
              @i_factor      = 1,
              @i_cuenta      = @w_cuenta,
              @i_val         = @w_disponible, 
              @i_numdeciimp  = @w_numdeci_imp,
              @o_total_gmf   = @w_val_gmf    out, --GMF a cobrar
              @o_base_gmf    = @w_base_gmf   out  --Valor a debitar
              
              select @w_monto_retiro = @w_disponible - round(@w_val_gmf, @w_numdeci_imp)
           end
           else
              select @w_monto_retiro = @w_valorven
              
              
              
           /* -------------------------------- */
           
           if @w_return = 0  and @@error =  0 
           begin
              print ' Valor a Retirar       ' + cast(@w_monto_retiro as varchar)
              print ''
              update cob_ahorros..ah_ctas_cancelar
              set    cc_saldado  = @w_monto_retiro
              where  cc_fecha    = @w_fecha_proc
              and    cc_ctabanco = @w_cta_banco
              and    cc_sec      = @w_sec
           
              if @@error <> 0 
              begin
                 print 'Se Presento error en la actualizacion -Monto de retiro'
                 rollback 
                 goto SIGUIENTE
              end
              
              print '..........................Debito a la cuenta'
              select @w_ssn = @w_ssn + 1
           
              exec @w_return   = cob_ahorros..sp_ahndc_automatica 
              @s_srv          = @w_srv,
              @s_ssn          = @w_ssn,
              @s_ofi          = @w_oficina,
              @t_trn          = 264,
              @i_cta          = @w_cta_banco,
              @i_val          = @w_monto_retiro,  
              @i_cau          = @w_cauciina,
              @i_mon          = @w_moneda, 
              @i_fecha        = @w_fecha,
              @i_inmovi       = 'S',
              @i_activar_cta  = 'N',
              @i_is_batch     = 'S',
              @i_cobiva       = 'N',
              @i_concepto     = 'DEBITO MASIVO CTAS INACTIVAS PARA ABONO CCA'
           
              if @w_return = 0 and @@error =  0 
              begin
                 print '______________________Cuenta Procesada OK'
                 if @w_exclusivo = 'S'
                    select @w_proc = 'X'
                 else
                    select @w_proc = 'S'
                 
                 print ''
                 update cob_ahorros..ah_ctas_cancelar set
                 cc_procesado      = @w_proc,
                 cc_fecha_proc     = @w_fecha,
                 cc_mensaje        = 'Proceso Ok'
                 where cc_fecha    = @w_fecha_proc
                 and   cc_ctabanco = @w_cta_banco
                 and   cc_sec      = @w_sec
                 
                 if @@error <> 0 
                 begin
                    print 'Se Presento error en la actualizacion -Proceso Ok'
                    rollback 
                    goto SIGUIENTE
                 end
                 
                 commit tran
              end
              else  /** Error al cerrar la cuenta hay que marcarla ***/
              begin
                  
                 rollback
              
                 print  '..........................ERROR: NO se pudo debitar la cuenta'
                 print  'Error del return ' + cast( @w_return as varchar)
                 print ''
                 update cob_ahorros..ah_ctas_cancelar set 
                 cc_procesado = 'E',
                 cc_mensaje   = 'NO se pudo debitar la cuenta'
                 where cc_fecha    = @w_fecha_proc
                 and   cc_ctabanco = @w_cta_banco
                 and   cc_sec      = @w_sec
           
                 if @@error <> 0 
                 begin
                    print 'Se Presento error en la actualizacion -Error:Debitar cuenta ' + cast( @w_return as varchar)
                 end
              end
           end
           /*----------------------------------- */           
        end 
        
SIGUIENTE:        
        select top 1 
        @w_cta_banco = cc_ctabanco,
        @w_oficina   = cc_oficina,
        @w_exclusivo = cc_exclusivo,
        @w_disponible= cc_disponible,
        @w_cuenta    = cc_cuenta,
        @w_moneda    = 0,
        @w_valorven  = cc_valorven,
        @w_sec       = cc_sec
        from cob_ahorros..ah_ctas_cancelar
        where cc_fecha      = @w_fecha_proc
        and   cc_procesado  = 'N'
        and   cc_ctabanco   > @w_cta_banco
        and  (cc_exclusivo = 'C' or (@w_tproceso = 'C' and cc_exclusivo = 'S'))
        order by cc_ctabanco, cc_diasmora desc

        if @@rowcount = 0
             break
             
        select @w_ssn = @w_ssn + 1
end

while @@trancount > 0 commit tran


print ' Finalizo el proceso'
/*** GENERAR BCP ***/
select @w_s_app = pa_char
from cobis..cl_parametro
where pa_producto = 'ADM'
and   pa_nemonico = 'S_APP'

select @w_path = pp_path_destino
from cobis..ba_path_pro
where pp_producto = 4

----------------------------------------
--Generar Archivo de Cabeceras
----------------------------------------
select 
@w_nombre       = 'Cuentas_Cancelar_F',
@w_nom_tabla    = 'ah_ctas_cancelar',
@w_col_id       = 0,
@w_columna      = '',
@w_cabecera     = convert(varchar(2000), ''),
@w_nombre_cab   = @w_nombre

select 
@w_nombre_plano = @w_path + @w_nombre_cab + '_' + convert(varchar(2), datepart(dd,getdate())) + '_' + convert(varchar(2), datepart(mm,getdate())) + '_' + convert(varchar(4), datepart(yyyy, getdate())) + '.txt'

while 1 = 1 
begin
   set rowcount 1
   select 
   @w_columna = c.name,
   @w_col_id  = c.colid
   from cob_ahorros..sysobjects o, cob_ahorros..syscolumns c
   where o.id    = c.id
   and   o.name  = @w_nom_tabla
   and   c.colid > @w_col_id
   order by c.colid

   if @@rowcount = 0 begin
      set rowcount 0
      break
   end

   select @w_cabecera = @w_cabecera + @w_columna + '^|'
end

select @w_cabecera = left(@w_cabecera, datalength(@w_cabecera) - 2)

--Escribir Cabecera
select @w_comando = 'echo ' + @w_cabecera + ' > ' + @w_nombre_plano

exec @w_error = xp_cmdshell @w_comando

if @w_error <> 0 begin
   select @w_error = 2902797, @w_msg = 'EJECUCION comando bcp FALLIDA. REVISAR ARCHIVOS DE LOG GENERADOS.'
   goto ERRORFIN
end

--Ejecucion para Generar Archivo Datos
select @w_comando = @w_s_app + 's_app bcp -auto -login cob_ahorros..ah_ctas_cancelar out '

select 
@w_destino  = @w_path + 'Cuentas_Cancelar_F.txt',
@w_errores  = @w_path + 'Cuentas_Cancelar_F.err'

select @w_comando = @w_comando + @w_destino + ' -b5000 -c -e' + @w_errores + ' -t"|" ' + '-config '+ @w_s_app + 's_app.ini'

exec @w_error = xp_cmdshell @w_comando

if @w_error <> 0 begin
   print 'Error Generando Archivo Cuentas_Cancelar_F' 
end

----------------------------------------
--Union de archivos (cab) y (dat)
----------------------------------------

select @w_comando = 'copy ' + @w_nombre_plano + ' + ' + @w_path + 'Cuentas_Cancelar_F.txt' + ' ' + @w_nombre_plano

exec @w_error = xp_cmdshell @w_comando

if @w_error <> 0 begin
   select @w_error = 2902797, @w_msg = 'EJECUCION comando bcp FALLIDA. REVISAR ARCHIVOS DE LOG GENERADOS.'
   goto ERRORFIN
end

return 0

ERRORFIN: 
   print @w_msg


go

