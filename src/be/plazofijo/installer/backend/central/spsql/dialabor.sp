/************************************************************************/
/* Archivo:             dialabor.sp                                     */
/* Stored procedure:    sp_primer_dia_labor                             */
/* Base de datos:       cob_pfijo                                       */
/* Producto:            PLAZO FIJO                                      */
/* Disenado por:        Sandra Ortiz                                    */
/* Fecha de escritura:  30/Sep/1993                                     */
/************************************************************************/
/*                            IMPORTANTE                                */
/* Este programa es parte de los paquetes bancarios propiedad de        */
/* 'MACOSA', representantes exclusivos para el Ecuador de la            */
/* 'NCR CORPORATION'.                                                   */
/* Su uso no autorizado queda expresamente prohibido asi como           */
/* cualquier alteracion o agregado hecho por alguno de sus              */
/* usuarios sin el debido consentimiento por escrito de la              */
/* Presidencia Ejecutiva de MACOSA o su representante.                  */
/*                             PROPOSITO                                */
/* Este stored procedure se encarga de verificar que la fecha           */
/* ingresada sea dia laborable, si no lo es busca el siguiente          */
/* dia laborable, retorna el dia laborable encontrado                   */
/*                          MODIFICACIONES                              */
/* FECHA            AUTOR           RAZON                               */
/* 30/Sep/93        R. Minga V.     Emision Inicial                     */
/* 10/Jun/97        D. Guerrero     Modificaciones                      */
/* 17-Oct-00        N. Silva        Correcciones BenchMark              */
/* 07-Nov-2014  	E.Ochoa			CDT tasa variable IBR -             */
/*                                  Cálculo de tasa IBR - RQ455         */
/************************************************************************/
use cob_pfijo
go

SET NOCOUNT ON
go

SET ANSI_NULLS OFF
go

SET QUOTED_IDENTIFIER OFF
go

if exists (select 1 from sysobjects where name = 'sp_primer_dia_labor')
   drop proc sp_primer_dia_labor
go

create proc sp_primer_dia_labor (
   @t_debug            char(1)     = 'N',
   @t_file             varchar(14) = null,
   @t_from             descripcion = null,
   @s_ofi              smallint    = null,   -- GAL 31/AGO/2009 - RVVUNICA
   @i_fecha            datetime,
   @i_operacion        char(1)     = 'N', --<N> normal <C> Compensacion <F> solo feriados nacionales
   @i_ttransito        smallint    = 0,
   @i_tran_sabado      char(1)     = null,   -- GAL 31/AGO/2009 - CSQL

   @i_tipo_deposito    varchar(20)  = null,

   @o_fecha_labor      datetime    = null out
)
with encryption
as
declare @w_sp_name       descripcion,
        @w_ciudad_fer_nac   int,
        @w_ciu_canje        int,
        @w_cont             smallint,
        @w_td_tipo_deposito int --Tipo deposito

--------------------------------------------
--  Inicializar nombre del stored procedure
--------------------------------------------
select   @w_sp_name = 'sp_primer_dia_labor',
        @w_cont    = 0 

select @o_fecha_labor = @i_fecha

-------------------------------------------------------
-- Mientras la fecha que se verifica no sea laborable
-- Compara primero feriados locales y luego nacionales
-------------------------------------------------------

if @t_debug = 'S' print ' i_operacion ' + cast(@i_operacion as varchar)
if @t_debug = 'S' print ' o_fecha_labor ' + cast(@o_fecha_labor as varchar)
if @t_debug = 'S' print ' s_ofi ' + cast(@s_ofi as varchar)
if @t_debug = 'S' print ' i_tipo_deposito ' + cast(@i_tipo_deposito as varchar)

--(RQ455) CDT TASA VARIABLE IBR - CALCULO DE TASA IBR -EOCHOA
if @i_operacion = 'X'
begin
---consulta el codigo del tipo de deposito enviado
select @w_td_tipo_deposito = td_tipo_deposito  
from pf_tipo_deposito
where  td_mnemonico = @i_tipo_deposito --@i_toperacion sp_cons_tasa_var

   select @w_ciudad_fer_nac = pa_int
   from   cobis..cl_parametro
   where  pa_nemonico = 'CIUN' -- Ciudad de Feriados Nacionales
     and  pa_producto = 'ADM'

    select @o_fecha_labor = dateadd(dd,-1,@o_fecha_labor)     

   while exists (select 1
                 from cobis..cl_dias_feriados, cobis..cl_ciudad, 
                      cobis..cl_oficina
                 where of_oficina = @s_ofi
                   and of_ciudad = df_ciudad
                   and ci_ciudad = of_ciudad
                   and ci_ciudad = df_ciudad
                   and df_fecha = @o_fecha_labor) or
            exists (select 1
                    from   cobis..cl_dias_feriados
                    where  df_ciudad  = @w_ciudad_fer_nac
                 and  df_fecha   = @o_fecha_labor) or 
            (  exists ( select 1
                        from pf_feriados_oficina
                        where fo_tipo_deposito = @w_td_tipo_deposito 
                        and   fo_oficina       = @s_ofi
                        and   fo_moneda        = 0
                        and   fo_cod_dia       = datepart(weekday,@o_fecha_labor )
                        and   fo_estado        = 'V') 
            )
   begin

       if @t_debug = 'S' print ' o_fecha_labor ' + cast(@o_fecha_labor as varchar)
       if @t_debug = 'S' print ' @i_tipo_deposito ' + cast(@i_tipo_deposito as varchar)
       if @t_debug = 'S' print ' @s_ofi ' + cast(@s_ofi as varchar)
       
        ---------------------------------------------
        -- Disminuye un dia hasta encontrar dia habil
        ---------------------------------------------
        select @o_fecha_labor = dateadd(dd,-1,@o_fecha_labor)     
   end
end


if @i_operacion = 'N'
begin
   select @w_ciudad_fer_nac = pa_int
   from   cobis..cl_parametro
   where  pa_nemonico = 'CIUN' -- Ciudad de Feriados Nacionales
     and  pa_producto = 'ADM'

   while exists (select 1
                 from cobis..cl_dias_feriados, cobis..cl_ciudad, 
                      cobis..cl_oficina
                 where of_oficina = @s_ofi
                   and of_ciudad = df_ciudad
                   and ci_ciudad = of_ciudad
                   and ci_ciudad = df_ciudad
                   and df_fecha = @o_fecha_labor) or
            exists (select 1
                    from   cobis..cl_dias_feriados
                    where  df_ciudad  = @w_ciudad_fer_nac
                 and  df_fecha   = @o_fecha_labor) or 
            (  exists ( select 1
                        from pf_feriados_oficina
                        where fo_tipo_deposito = @i_tipo_deposito
                        and   fo_oficina       = @s_ofi
                        and   fo_moneda        = 0
                        and   fo_cod_dia       = datepart(weekday,@o_fecha_labor )
                        and   fo_estado        = 'V') 
            )
   begin

       if @t_debug = 'S' print ' o_fecha_labor ' + cast(@o_fecha_labor as varchar)
       if @t_debug = 'S' print ' @i_tipo_deposito ' + cast(@i_tipo_deposito as varchar)
       if @t_debug = 'S' print ' @s_ofi ' + cast(@s_ofi as varchar)
       
        ---------------------------------------------
        -- Aumentar un dia hasta encontrar d¡a h bil
        ---------------------------------------------
        select @o_fecha_labor = dateadd(dd,1,@o_fecha_labor)     
   end
end
if @i_operacion = 'F' -- Validar solo con fechas de feriados nacionales
begin
   select @w_ciudad_fer_nac = pa_int
   from   cobis..cl_parametro
   where  pa_nemonico = 'CIUN' -- Ciudad de Feriados Nacionales
     and  pa_producto = 'ADM'

   while exists (select 1
                   from  cobis..cl_dias_feriados
                  where  df_ciudad  = @w_ciudad_fer_nac
                    and  df_fecha   = @o_fecha_labor)
   begin
        ---------------------------------------------
        -- Aumentar un dia hasta encontrar d¡a h bil
        ---------------------------------------------
        select @o_fecha_labor = dateadd(dd,1,@o_fecha_labor)     
   end
end
if @i_operacion = 'C' --Si la operaci¢n es con cheque y tiene dias de transito
begin
      select @w_ciu_canje = of_ciudad
      from   cobis..cl_oficina
      where  of_oficina = @s_ofi
      
      while @w_cont < @i_ttransito
      begin
         select @o_fecha_labor = dateadd(dd,1,@o_fecha_labor) 
         if not exists (select 1
                        from cobis..cl_dias_feriados
                        where df_ciudad  = @w_ciu_canje
                          and df_fecha   = @o_fecha_labor)
         begin
            select @w_cont = @w_cont + 1  
         end    
      end
end
   
return 0
go
