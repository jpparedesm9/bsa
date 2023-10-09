/******************************************************************/
/* Archivo:             pf_cuacon.sp                              */
/* Stored procedure:    sp_cuadre_contable                        */
/* Base de datos:       cob_pfijo                                 */
/* Producto:            Plazo Fijo                                */
/* Disenado por:        Luis Im                                   */
/* Fecha de escritura:  14-Dic-2005                               */
/******************************************************************/
/*                         IMPORTANTE                             */
/* Este programa es parte de los paquetes bancarios propiedad de  */
/* 'MACOSA', representantes exclusivos para el Ecuador de la      */
/* 'NCR CORPORATION'.                                             */
/* Su uso no autorizado queda expresamente prohibido asi como     */
/* cualquier alteracion o agregado hecho por alguno de sus        */
/* usuarios sin el debido consentimiento por escrito de la        */
/* Presidencia Ejecutiva de MACOSA o su representante.            */
/*                          PROPOSITO                             */
/******************************************************************/
/* Este programa se encarga de la generacion de los comprobantes  */
/* contables y sus respectivos asientos                           */
/******************************************************************/
/*                       MODIFICACIONES                           */
/* FECHA        AUTOR          RAZON                              */
/* 14/Dic/2005  Luis Im        Emision Inicial                    */
/* 30-11-2016   A.Zuluaga      desacople                          */
/******************************************************************/
use cob_pfijo
go

if exists (select * from sysobjects where name = 'sp_cuadre_contable')
   drop proc sp_cuadre_contable
go

create proc sp_cuadre_contable (
       @i_filial      tinyint,
       @i_fecha       datetime
)
with encryption
AS

declare  @w_return      int,
         @w_moneda      tinyint,
         @w_mon_loc     tinyint,
         @w_oficina     smallint,
         @w_valor       money,
         @w_valor_me    money,
         @w_toperacion  catalogo,
         @w_disponible  money, 
         @w_cuenta      cuenta,
         @w_cuenta_int  cuenta,
         @w_descerror   varchar(240),
         @w_cotiz       tinyint,
         @w_tran        smallint,
         @w_contador    int,
         @w_area_orig   int,
         @w_error       int,
         @w_interes     money,
         @w_valor_interes     money,
         @w_valor_interes_me  money
  

select   @w_mon_loc  = 0,
         @w_contador = 0, 
         @w_cotiz    = 1
 
-- Inicializacion de variables

--DESACOPLE
exec @w_return = cob_interfase..sp_iccontable
     @t_trn         = 60033,
     @i_operacion   = 'D',
     @i_fecha       = @i_fecha,
     @i_empresa     = @i_filial,
     @i_producto    = 14 -- PLAZO FIJO
     
select @w_tran = 14997
if @w_return != 0
   begin

   select @w_descerror = 'Error limpiando datos del cuadre contable'
   /*LLAMAR RUTINA PARA INSERCION DE LOG DE ERROR */

        if @@error <> 0
           begin
               /* Error en grabacion de archivo de errores */
               exec cobis..sp_cerror
               @i_num       = 203056

          return 203056
      end

       return @w_return
   end


declare totales cursor
for select
   ca_moneda,
   ca_oficina,
   substring(ca_tipo_deposito,1,3),
   sum(ca_capital),
   sum(ca_interes)
from pf_cuadre_auxiliar
where ca_fecha_proceso = @i_fecha
group by ca_moneda, ca_oficina, substring(ca_tipo_deposito,1,3)

open totales
fetch totales into
   @w_moneda,
   @w_oficina,
   @w_toperacion,
   @w_disponible,
    @w_interes
   
if @@fetch_status = -2
begin
   close totales
   deallocate totales

   exec cobis..sp_cerror
      @i_num       = 201157
   return 201157
end


while @@fetch_status = 0
begin
   select @w_valor = @w_disponible
   select @w_valor_me = 0
   select @w_valor_interes = @w_interes,
               @w_valor_interes_me = 0

   if @w_mon_loc  <> @w_moneda
      begin


      select @w_cotiz = isnull(ct_compra,0) 
           from cob_conta..cb_cotizacion
          where /*ct_empresa = @i_filial */
             ct_fecha   =  (select max(ct_fecha)
                              from cob_conta..cb_cotizacion
                                  where /*ct_empresa = @i_filial  */
                                    ct_moneda = @w_moneda)
            and ct_moneda  = @w_moneda


      select @w_valor_me = @w_valor,
             @w_valor    = @w_valor_me * @w_cotiz
      select @w_valor_interes_me =  @w_valor_interes,
                       @w_valor_interes    =  @w_valor_interes_me * @w_cotiz
      end

            select @w_cuenta = re_substring
             from cob_conta..cb_relparam 
       where re_parametro = 'PLZ'
              and re_clave = substring(@w_toperacion,1,3) + '.' + convert(varchar(10),@w_moneda)

      select @w_cuenta_int = re_substring
             from pf_cuadre_auxiliar, cob_conta..cb_relparam 
       where re_parametro = 'ACUM'
              and re_clave = substring(@w_toperacion,1,3) + '.' + convert(varchar(10),@w_moneda)


   select @w_area_orig = td_area_contable
   from pf_tipo_deposito
   where substring(td_mnemonico,1,3) = @w_toperacion
   --I. CVA May-06-06
      --and td_estado    = 'A'
   if @@rowcount = 0
   begin
         select @w_error = 141115
         insert into cob_pfijo..pf_errorlog
         values(@i_fecha, @w_error, 'sa', @w_tran, @w_toperacion, @w_descerror, @w_cuenta)
   end
   
   -------------------------
   -- Inserta transacciones
   -------------------------
   if @w_valor <> 0
         begin
      begin tran
         
         exec @w_return = cob_interfase..sp_iccontable
              @t_trn            = 60032,
              @i_operacion      = 'I',
              @i_empresa        = 1,
              @i_producto       = 14,
              @i_fecha          = @i_fecha,
              @i_cuenta         = @w_cuenta,
              @i_oficina        = @w_oficina,
              @i_area           = @w_area_orig,
              @i_moneda         = @w_moneda,
              @i_valor_opera_mn = @w_valor,
              @i_valor_opera_me = @w_valor_me,
              @i_tipo           = 'S' 

         if @w_return <> 0
         begin
            --  print 'ERRORCC: ' + cast(  @w_return as varchar) 
            rollback tran

            --print 'Procesando .....Continuar y notificar a sistemas al dia siguiente'

            select @w_descerror = 'ERROR EN INSERCION DE REGISTRO.... ' + @w_cuenta

         insert into cob_pfijo..pf_errorlog
         values(@i_fecha, @w_return, 'sa', @w_tran, null, @w_descerror, @w_cuenta)

               if @@error <> 0
                  begin
                  /* Error en grabacion de archivo de errores */
                  exec cobis..sp_cerror
                  @i_num       = 203056
            close totales
            deallocate totales

            return 203056
            end

               goto LEER
                  end
         
         
         exec @w_return = cob_interfase..sp_iccontable
              @t_trn           = 60032,
              @i_operacion     = 'I',
              @i_empresa       = 1,
              @i_producto      = 14,           
              @i_fecha         = @i_fecha,
              @i_cuenta        = @w_cuenta_int,
              @i_oficina       = @w_oficina,
              @i_area          = @w_area_orig,        
              @i_moneda        = @w_moneda,
              @i_val_opera_mn  = @w_valor_interes,
              @i_val_opera_me  = @w_valor_interes_me,
              @i_tipo          = 'S'

         if @w_return <> 0
         begin
                      --  print 'ERRORCC: ' + cast(  @w_return as varchar) 
         rollback tran

         --print 'Procesando .....Continuar y notificar a sistemas al dia siguiente'

            select @w_descerror = 'ERROR EN INSERCION DE REGISTRO.... ' + @w_cuenta

         insert into cob_pfijo..pf_errorlog
         values(@i_fecha, @w_return, 'sa', @w_tran, null, @w_descerror, @w_cuenta)

               if @@error <> 0
                  begin
                  /* Error en grabacion de archivo de errores */
                  exec cobis..sp_cerror
                  @i_num       = 203056
            close totales
            deallocate totales

            return 203056
            end

               goto LEER
                  end
            
      commit tran
      select @w_contador = @w_contador + 1
             end

LEER:
   fetch totales into
      @w_moneda,
      @w_oficina,
      @w_toperacion,
      @w_disponible,
      @w_interes

   if @@fetch_status = -2
   begin
      close totales
      deallocate totales
      
      exec cobis..sp_cerror
         @i_num       = 201157
      return 201157
   end
end      /*End while */


close totales
deallocate totales


--select @o_procesadas = @w_contador

return 0
go



