/************************************************************************/
/*   Archivo:             sp_cusob.sp                                   */
/*   Stored procedure:    sp_cusob                                      */
/*   Base de datos:       cob_conta                                     */
/*   Producto:            Contabilidad                                  */
/*   Disenado por:        Ruben Dario Lopez Arenas                      */
/*   Fecha de escritura:  Noviembre 2 de 2006                           */
/************************************************************************/
/*                              IMPORTANTE                              */
/*   Este programa es parte de los paquetes bancarios propiedad de      */
/*   "MACOSA"                                                           */
/*   Su uso no autorizado queda expresamente prohibido asi como         */
/*   cualquier alteracion o agregado hecho por alguno de sus            */
/*   usuarios sin el debido consentimiento por escrito de la            */
/*   Presidencia Ejecutiva de MACOSA o su representante.                */
/************************************************************************/  
/*                             PROPOSITO                                */
/*   SP que almacena las saldos de cuentas sobregiradas.                */
/************************************************************************/  
/*                             ACTUALIZACIONES                          */
/*                                                                      */
/*     FECHA              AUTOR            CAMBIO                       */
/*     02/11/2006         R.Lopez          Emision Inicial              */
/************************************************************************/

use cob_conta
go
 
if exists (select * from sysobjects where name = "sp_cusob")
   drop proc sp_cusob
go

create proc sp_cusob(
    @i_empresa         smallint      = null,
    @i_periodo         int           = null,
    @i_corte           int           = null,
    @i_nivel           smallint      = null,
    @i_ofi_ini         smallint      = null,
    @i_ofi_fin         smallint      = null,
    @i_estado          char(1)       = null,
    @i_batch           int           = null
)
as
declare
    @w_cuenta_sig      varchar(14),
    @w_cuenta          varchar(14),
    @w_nom_cuenta      varchar(80),
    @w_oficina_sig     smallint,
    @w_oficina         smallint,
    @w_nom_oficina     varchar(80),
    @w_saldo           money,
    @w_saldo_me        money
    
select @w_cuenta_sig  = '',
       @w_cuenta      = '',
       @w_nom_cuenta  = '',
       @w_oficina_sig = 0,
       @w_oficina     = 0,
       @w_nom_oficina = ''       
       
  
if @i_empresa is null or
   @i_periodo is null or 
   @i_corte   is null or
   @i_nivel   is null or
   @i_ofi_ini is null or 
   @i_ofi_fin is null or 
   @i_estado  is null or 
   @i_batch   is null
begin
   return 101114   -- Parametros invalidos
end

if @i_ofi_ini != @i_ofi_fin
begin
   select 1
     from cb_oficina
    where of_empresa = @i_empresa
      and of_oficina in (@i_ofi_ini,@i_ofi_fin)
      and of_organizacion = @i_nivel
                                                     
   if @@rowcount <> 2
   begin
      print 'Error de Oficinas!!'
      return  601070 -- Oficina(s) no corresponde al nivel indicado
   end
end
else
begin
   select 1
     from cb_oficina
    where of_empresa = @i_empresa
      and of_oficina = @i_ofi_ini
      and of_organizacion = @i_nivel
                                                     
   if @@rowcount <> 1
   begin
      print 'Error de Oficinas!!'
      return  601070 -- Oficina(s) no corresponde al nivel indicado
   end
end

TRUNCATE TABLE  cb_saldo_cta_sobregiros
TRUNCATE TABLE  cp_tmp_saldos_sobregiros
TRUNCATE TABLE  cp_tmp_ofi_sobregiros

BEGIN TRAN

-- CARGA DE TABLA DE OFICINAS RELACIONADAS 
   
insert into cp_tmp_ofi_sobregiros 
select je_oficina, je_oficina_padre, of_descripcion
  from cb_jerarquia, cb_oficina
 where of_oficina = je_oficina_padre
   and of_empresa = je_empresa
   and je_oficina_padre between @i_ofi_ini and @i_ofi_fin
   and je_oficina >= 1
   and je_nivel = @i_nivel
   and je_empresa = @i_empresa


if @i_estado = 'A'
begin
   -- CARGA DE SALDOS Y CUENTAS TEMPORALES
   
   set rowcount 1
   
   select @w_oficina = sa_oficina,
          @w_cuenta  = sa_cuenta,
          @w_nom_cuenta = cu_nombre,
          @w_saldo = sa_saldo,
          @w_saldo_me = sa_saldo_me
     from cb_saldo,cb_cuenta_proceso,cb_cuenta
    where sa_empresa    = @i_empresa 
      and sa_periodo    = @i_periodo
      and sa_corte      = @i_corte
      and sa_oficina    >= 0
      and sa_area       >= 0
      and sa_cuenta     = cu_cuenta 
      and sa_empresa    = cu_empresa
      and cu_cuenta     = cp_cuenta
      and cp_proceso    = @i_batch
      and ((cu_categoria = 'D' and sa_saldo < 0) or (cu_categoria = 'C' and sa_saldo > 0))      
 order by sa_oficina, sa_cuenta
 
   if @@rowcount = 0
   begin 
      COMMIT TRAN
      return 0
   end 
   
   insert into cp_tmp_saldos_sobregiros  values (@w_oficina,@w_cuenta,@w_nom_cuenta,@w_saldo,@w_saldo_me)
   
   if @@error <> 0
   begin
      print 'Error de Insercion de Saldo'
      ROLLBACK TRAN
      return 601071  -- Error en la insercion de saldo temporal de cuenta sobregirada
   end
   
   select @w_oficina_sig = @w_oficina,
          @w_cuenta_sig = @w_cuenta
   
   while 1=1
   begin
      select @w_oficina = sa_oficina,
             @w_cuenta  = sa_cuenta,
             @w_nom_cuenta = cu_nombre,
             @w_saldo = sa_saldo,
             @w_saldo_me = sa_saldo_me
        from cb_saldo,cb_cuenta_proceso,cb_cuenta
       where sa_empresa    = @i_empresa 
         and sa_periodo    = @i_periodo
         and sa_corte      = @i_corte
         and sa_oficina    >= 0
         and sa_area       >= 0
         and sa_cuenta     = cu_cuenta 
         and sa_empresa    = cu_empresa
         and cu_cuenta     = cp_cuenta
         and cp_proceso    = @i_batch
         and ((cu_categoria = 'D' and sa_saldo < 0) or (cu_categoria = 'C' and sa_saldo > 0))      
         and ((sa_oficina =  @w_oficina_sig and sa_cuenta > @w_cuenta_sig) or
              (sa_oficina > @w_oficina_sig))
    order by sa_oficina, sa_cuenta
    
      if @@rowcount = 0
      begin
         set rowcount 0
         break
      end
     
      insert into cp_tmp_saldos_sobregiros  values (@w_oficina,@w_cuenta,@w_nom_cuenta,@w_saldo,@w_saldo_me)
   
      if @@error <> 0
      begin
         print 'Error de Insercion de Saldo'
         ROLLBACK TRAN
         return 601071  -- Error en la insercion de saldo temporal de cuenta sobregirada
      end
      
      select @w_oficina_sig = @w_oficina,
             @w_cuenta_sig = @w_cuenta     
   end
end
else  -- Estado V o Estado C
begin
   -- CARGA DE SALDOS Y CUENTAS TEMPORALES
   
   set rowcount 1
   
   select @w_oficina = hi_oficina,
          @w_cuenta  = hi_cuenta,
          @w_nom_cuenta = cu_nombre,
          @w_saldo = hi_saldo,
          @w_saldo_me = hi_saldo_me
     from cob_conta_his..cb_hist_saldo,cb_cuenta_proceso,cb_cuenta
    where hi_empresa    = @i_empresa 
      and hi_periodo    = @i_periodo
      and hi_corte      = @i_corte
      and hi_oficina    >= 0
      and hi_area       >= 0
      and hi_cuenta     = cu_cuenta 
      and hi_empresa    = cu_empresa
      and cu_cuenta     = cp_cuenta
      and cp_proceso    = @i_batch
      and ((cu_categoria = 'D' and hi_saldo < 0) or (cu_categoria = 'C' and hi_saldo > 0))      
 order by hi_oficina, hi_cuenta
 
   if @@rowcount = 0
   begin 
      COMMIT TRAN
      return 0
   end 
   
   insert into cp_tmp_saldos_sobregiros  values (@w_oficina,@w_cuenta,@w_nom_cuenta,@w_saldo,@w_saldo_me)
   
   if @@error <> 0
   begin
      print 'Error de Insercion de Saldo'
      ROLLBACK TRAN
      return 601071  -- Error en la insercion de saldo temporal de cuenta sobregirada
   end
   
   select @w_oficina_sig = @w_oficina,
          @w_cuenta_sig = @w_cuenta
   
   while 1=1
   begin
      select @w_oficina = hi_oficina,
             @w_cuenta  = hi_cuenta,
             @w_nom_cuenta = cu_nombre,
             @w_saldo = hi_saldo,
             @w_saldo_me = hi_saldo_me
        from cob_conta_his..cb_hist_saldo,cb_cuenta_proceso,cb_cuenta
       where hi_empresa    = @i_empresa 
         and hi_periodo    = @i_periodo
         and hi_corte      = @i_corte
         and hi_oficina    >= 0
         and hi_area       >= 0
         and hi_cuenta     = cu_cuenta 
         and hi_empresa    = cu_empresa
         and cu_cuenta     = cp_cuenta
         and cp_proceso    = @i_batch
         and ((cu_categoria = 'D' and hi_saldo < 0) or (cu_categoria = 'C' and hi_saldo > 0))      
         and ((hi_oficina = @w_oficina_sig and hi_cuenta > @w_cuenta_sig) or
              (hi_oficina > @w_oficina_sig))
    order by hi_oficina, hi_cuenta
    
      if @@rowcount = 0
      begin
         set rowcount 0
         break
      end
     
      insert into cp_tmp_saldos_sobregiros  values (@w_oficina,@w_cuenta,@w_nom_cuenta,@w_saldo,@w_saldo_me)
   
      if @@error <> 0
      begin
         print 'Error de Insercion de Saldo'
         ROLLBACK TRAN
         return 601071  -- Error en la insercion de saldo temporal de cuenta sobregirada
      end
      
      select @w_oficina_sig = @w_oficina,
             @w_cuenta_sig = @w_cuenta     
   end
end

-- CARGA DEFINITIVA
   
  set rowcount 1
   
  select @w_oficina = os_oficina_padre, 
         @w_nom_oficina = os_descripcion,
         @w_cuenta = ss_cuenta,
         @w_nom_cuenta = ss_nombre,
         @w_saldo = sum(ss_saldo),
         @w_saldo_me = sum(ss_saldo_me)
    from cp_tmp_saldos_sobregiros,cp_tmp_ofi_sobregiros
   where ss_oficina = os_oficina 
     and ss_oficina >= 1
     and os_oficina >= 1  
group by os_oficina_padre,os_descripcion,ss_cuenta,ss_nombre
order by os_oficina_padre,ss_cuenta

  if @@rowcount = 0
  begin 
     COMMIT TRAN
     return 0
  end 
  
  insert into cb_saldo_cta_sobregiros values (@w_cuenta, @w_nom_cuenta, @w_oficina, @w_nom_oficina, @w_saldo, @w_saldo_me)
  
  if @@error <> 0
  begin
     print 'Error de Insercion Actual'
     ROLLBACK TRAN
     return 601073  -- Error en la insercion de saldo de cuenta sobregirada
  end
  
  select @w_cuenta_sig  = @w_cuenta,
         @w_oficina_sig = @w_oficina
         
  
  while 1=1
  begin
     select @w_oficina = os_oficina_padre, 
            @w_nom_oficina = os_descripcion,
            @w_cuenta = ss_cuenta,
            @w_nom_cuenta = ss_nombre,
            @w_saldo = sum(ss_saldo),
            @w_saldo_me = sum(ss_saldo_me)
       from cp_tmp_saldos_sobregiros,cp_tmp_ofi_sobregiros
      where ss_oficina = os_oficina 
        and ss_oficina >= 1
        and os_oficina >= 1  
        and ((os_oficina_padre =  @w_oficina_sig and ss_cuenta > @w_cuenta_sig) or
             (os_oficina_padre > @w_oficina_sig))
   group by os_oficina_padre,os_descripcion,ss_cuenta,ss_nombre
   order by os_oficina_padre,ss_cuenta
     
     if @@rowcount = 0
     begin
        set rowcount 0
        break
     end
     
     insert into cb_saldo_cta_sobregiros values (@w_cuenta, @w_nom_cuenta, @w_oficina, @w_nom_oficina, @w_saldo, @w_saldo_me)
     
     if @@error <> 0
     begin
        print 'Error de Insercion Actual'
        ROLLBACK TRAN
        return 601073  -- Error en la insercion de saldo de cuenta sobregirada
     end
     
     select @w_cuenta_sig  = @w_cuenta,
            @w_oficina_sig = @w_oficina      
  end

COMMIT TRAN
    
return 0
go


