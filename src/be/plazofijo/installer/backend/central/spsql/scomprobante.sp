/************************************************************************/
/*      Archivo:                comprcst.sp                             */
/*      Stored procedure:       sp_scomprobante                         */
/*      Base de datos:          cob_pfijo                               */
/*      Producto:               Plazo Fijo                              */
/*      Disenado por:           M.Suarez                                */
/*      Fecha de escritura:     07-oct/1995                             */
/************************************************************************/
/*                              IMPORTANTE                              */
/*      Este programa es parte de los paquetes bancarios propiedad de   */
/*      'MACOSA', representantes exclusivos para el Ecuador de la       */
/*      'NCR CORPORATION'.                                              */
/*      Su uso no autorizado queda expresamente prohibido asi como      */
/*      cualquier alteracion o agregado hecho por alguno de sus         */
/*      usuarios sin el debido consentimiento por escrito de la         */
/*      Presidencia Ejecutiva de MACOSA o su representante.             */
/*                              PROPOSITO                               */
/*      Este programa procesa las transacciones de:                     */
/*      Inserta el header de comprobante en la tabla temporal           */
/*                              MODIFICACIONES                          */
/*      FECHA           AUTOR           RAZON                           */
/*      07/Oct/1995     M.Suarez        Emision Inicial                 */
/*      05/Oct/2001     M.Saborio       Inclusi=n del procedimiento para*/
/*                                      cambio de divisas.              */
/************************************************************************/   
use cob_pfijo
go

SET NOCOUNT ON
go

SET ANSI_NULLS OFF
go

SET QUOTED_IDENTIFIER OFF
go

if exists (select 1 from sysobjects where name = 'sp_scomprobante')
   drop proc sp_scomprobante
go

create proc sp_scomprobante (
@s_ssn                  int          = NULL,
@s_date                 datetime     = NULL,
@s_user                 login        = 'reentry',
@s_term                 descripcion  = NULL,
@s_corr                 char(1)      = NULL,
@s_ssn_corr             int          = NULL,
@s_ofi                  int          = NULL,
@t_rty                  char(1)      = NULL,
@t_trn                  int          = NULL,
@t_debug                char(1)      = 'N',
@t_file                 varchar(14)  = NULL,
@t_from                 varchar(30)  = NULL,
@i_operacion            char(1)      = NULL,
@i_comprobante          int          = NULL, 
@i_empresa              smallint     = NULL, 
@i_producto             smallint     = NULL, 
@i_fecha_tran           datetime     = NULL,    
@i_oficina_orig         int          = NULL,
@i_area_orig            int          = 0,
@i_digitador            descripcion  = NULL,   
@i_descripcion          varchar(150) = NULL, 
@i_perfil               varchar(10)  = NULL,
@i_detalles             int          = 0,         
@i_tot_debito           money        = NULL,    
@i_tot_credito          money        = NULL,    
@i_tot_debito_me        money        = NULL,
@i_tot_credito_me       money        = NULL,
@i_reversado            char(1)      = NULL,
@i_tran                 int          = NULL)
with encryption
as
declare
@w_today                datetime,    /* fecha del dia */
@w_return               int,         /* valor que retorna */
@w_sp_name              varchar(32), /* nombre del stored procedure*/
@w_numero_actual        int,
@w_paso                 varchar(3),
@w_estado               char(1),
@w_corte                int,
@w_siguiente            int,
@w_periodo              smallint,
@w_string               varchar(10),
@w_existe               int,   /* codigo existe = 1 no existe = 0 */
@w_td_debito            money,
@w_td_credito           money,
@w_td_debito_me         money,
@w_td_credito_me        money,
@w_diferencia           money,
@w_detalle              int,
@w_td_detalles          int,
@w_sum_debito_me        money,
@w_sum_credito_me       money,
@w_diferencia_me        money,
@w_moneda_base          tinyint ,
@w_fecha_tran           datetime   -- GES 12/17/01 CUZ-053-005

select @w_today = getdate()
select @w_sp_name = 'sp_scomprobante'

select @w_moneda_base = em_moneda_base
from cob_conta..cb_empresa
where em_empresa = @i_empresa
if @@rowcount = 0
begin
   return  601018
end 

--I. CVA Jun-14-06 Obtener fecha con la que se grabaran los comprobantes contables
exec sp_fecha_contable
     @i_fecha_proceso  = @i_fecha_tran,
     @o_fecha_contable = @w_fecha_tran out 
if @w_fecha_tran is null
begin
   exec sp_primer_dia_labor 
      @t_debug       = @t_debug, 
      @t_file        = @t_file,
      @t_from        = @w_sp_name, 
      @i_fecha       = @i_fecha_tran,
      @s_ofi         = @s_ofi,
      -- @i_flag_conta  = 1,             GAL 21/AGO/2009 - CSQL
      @o_fecha_labor = @w_fecha_tran out
end
--F. CVA Jun-14-06 Obtener fecha con la que se grabaran los comprobantes contables         


select   @w_td_debito         = isnull(sum(sa_debito),0),
         @w_td_credito     = isnull(sum(sa_credito),0),
        @w_td_debito_me    = isnull(sum(sa_debito_me),0),
        @w_td_credito_me   = isnull(sum(sa_credito_me),0),
            @w_td_detalles       = count(*)
from pf_sasiento
where sa_fecha_tran = @w_fecha_tran 
   and   sa_comprobante = @i_comprobante 
   and   sa_empresa = @i_empresa 
   
-- print 'Comp: ' + cast(@i_comprobante as varchar) + ' Fecha: ' + convert(varchar, @w_fecha_tran, 103) + 'Deb: ' + cast(@w_td_debito as varchar) + 'Cred: ' + cast(@w_td_credito as varchar)
/******** COMPARA CON DATOS DE CABECERA ********/
-- Nro. de detalles diferente al total registrado en tabla temporal
--print 'fecha %1!', @i_fecha_tran 
--print 'compr %1!, i_det %2!, td_det %3!', @i_comprobante, @i_detalles, @w_td_detalles 
if @i_detalles <> @w_td_detalles 
   return    141147

/*** AJUSTE POR DIFERENCIA DE 1 SUCRE UNICAMENTE ****/
select @w_diferencia = @w_td_debito - @w_td_credito

if @w_diferencia <> 0 
   return 143062

if @w_diferencia  <> 0 and abs(@w_diferencia) <= 0.02
begin
   select @w_detalle = 1 --xca
      
   select @w_td_debito = @w_td_debito - @w_diferencia --cal 

   update pf_sasiento 
   set sa_debito  = sa_debito - @w_diferencia
   where sa_comprobante = @i_comprobante
   and sa_asiento = @w_detalle
   and sa_debito > 0
         
   if @@rowcount = 0
   begin
      update pf_sasiento 
      set sa_credito = sa_credito + @w_diferencia
      where sa_comprobante = @i_comprobante
      and sa_asiento = @w_detalle
      and sa_credito > 0

      select @w_td_credito = @w_td_credito + @w_diferencia 
   end
end
/**** FIN DE AJUSTE POR DIFERENCIA DE 2 CENTAVOS UNICAMENTE ****/

   
select   @w_td_debito   = isnull(sum(sa_debito),0),
         @w_td_credito  = isnull(sum(sa_credito),0),
        @w_td_debito_me = isnull(sum(sa_debito_me),0),
        @w_td_credito_me = isnull(sum(sa_credito_me),0)
from pf_sasiento
where sa_fecha_tran = @w_fecha_tran 
   and   sa_comprobante = @i_comprobante 
   and sa_empresa = @i_empresa 
      
/* GES 02/11/1999 MODIFICACION DE ASIENTOS SI EXISTE MEZCLA DE CUENTAS 
   EN MONEDA EXTRANJERA CON CUENTAS EN MONEDA NACIONAL */

if exists (select * from pf_sasiento 
           where sa_fecha_tran = @w_fecha_tran 
             and sa_comprobante = @i_comprobante 
             and sa_empresa = @i_empresa 
             and sa_moneda <> @w_moneda_base)
begin
  select @w_sum_debito_me = sum(sa_debito_me),
          @w_sum_credito_me = sum(sa_credito_me)
  from pf_sasiento
  where sa_fecha_tran = @w_fecha_tran 
   and sa_comprobante = @i_comprobante 
   and sa_empresa = @i_empresa 
   and sa_moneda <> @w_moneda_base

  if @w_sum_debito_me <> @w_sum_credito_me
  begin
    update pf_sasiento
    set sa_tipo_doc = 'C' 
      where sa_fecha_tran = @w_fecha_tran 
         and sa_comprobante = @i_comprobante 
        and sa_empresa = @i_empresa 
        and sa_moneda <>@w_moneda_base  
        and sa_debito_me > 0 
           
    update pf_sasiento
    set sa_tipo_doc = 'V' 
     where sa_fecha_tran = @w_fecha_tran 
       and  sa_comprobante = @i_comprobante 
       and sa_empresa = @i_empresa 
       and sa_moneda <> @w_moneda_base 
       and sa_credito_me > 0 
  end
end

/* GES 02/11/1999 FIN MODIFICACION DE ASIENTOS PARA PODER REALIZAR POSICION */

--print 'llego al insert'

     
insert into pf_scomprobante (
         sc_comprobante,sc_empresa,sc_fecha_tran,
         sc_oficina_orig,sc_area_orig,sc_fecha_gra,
         sc_digitador,sc_descripcion,
         sc_detalles,sc_perfil,
         sc_tot_debito,sc_tot_credito,sc_tot_debito_me,
         sc_tot_credito_me,
         sc_estado )
values (@i_comprobante,@i_empresa,@w_fecha_tran,    -- GES 12/17/01 CUZ-053-006
         @i_oficina_orig,@i_area_orig,@w_today,
         @i_digitador,@i_descripcion,
         @i_detalles, @i_perfil,
         @w_td_debito,@w_td_credito,    
         @w_td_debito_me, @w_td_credito_me ,
                        'I')
if @@rowcount  <> 1  
  return 141080         

return 0

go

