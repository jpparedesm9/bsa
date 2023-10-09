/****************************************************************************/
/*     Archivo:     fecha_habil.sp                                          */
/*     Stored procedure: sp_fecha_habil                                     */
/*     Base de datos: cob_remesas                                           */
/*     Producto: Personalizacion                                            */
/*     Disenado por:    Jorge Baque                                         */
/*     Fecha de escritura: 13/May/2016                                      */
/****************************************************************************/
/*                            IMPORTANTE                                    */
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
/*                           PROPOSITO                                      */
/*                                                                          */
/****************************************************************************/
/*                           MODIFICACIONES                                 */
/*       FECHA          AUTOR           RAZON                               */
/*     13/May/2016     Jorge Baque     Migracion a CEN                      */
/****************************************************************************/
use cob_remesas
go

if exists (select
             1
           from   sysobjects
           where  name = 'sp_fecha_habil')
  drop proc sp_fecha_habil
go

SET ANSI_NULLS OFF
go
SET QUOTED_IDENTIFIER OFF
go


CREATE proc sp_fecha_habil(
   @s_srv              varchar(30)  = null,
   @s_ofi              smallint     = null,
   @s_ssn              int          = null,    
   @s_user             varchar(30)  = null,   
   @t_debug            char(1)      = 'N',
   @t_file             varchar(14)  = null,                             
   @t_from             varchar(32)  = null,
   @t_trn              smallint     = null,
   @i_fecha            datetime,          
   @i_val_dif          char(1)      = 'N',
   @i_oficina          int,                      
   @i_efec_dia         char(1)      = 'N',
   @i_dif              char(1)      = 'N',
   @w_dias_ret         int          = 0,
   @i_ciudad_matriz    int          = null,
   @i_finsemana        char(1)      = 'S', --S ==>Excluye dias fin semana(camara)
   @o_ciudad_matriz    int          = null out,
   @o_ciudad           int          = null out,
   @o_fecha_sig        datetime     = null out
)
as
declare 
   @w_sp_name        varchar(32),
   @w_return         int,
   @w_cont           int,
   @w_ciudad         int

select @w_sp_name = 'sp_fecha_habil'

/****   Validaciones Previas       ******/
/**** No se pueden ejecutar los dos procesos al tiempo  ***/
if @i_val_dif = 'S'  and @i_efec_dia = 'S'
begin
    /*** Parametros incongruentes **/
    exec cobis..sp_cerror
    @t_debug = @t_debug,
    @t_file  = @t_file,
    @t_from  = @w_sp_name,
    @i_num   = 101113
    return 101113
end

/***** Ninguno de los dos procesos se va a ejecutar     ****/
if @i_val_dif = 'N'  and @i_efec_dia = 'N'
begin
   /*** Parametros invalidos **/
   exec cobis..sp_cerror
   @t_debug = @t_debug,
   @t_file  = @t_file,
   @t_from  = @w_sp_name,
   @i_num   = 101114
   return 101114
end

if @i_ciudad_matriz  is null
begin 
   select @i_ciudad_matriz = pa_int
     from cobis..cl_parametro
    where pa_nemonico = 'CMA'
      and pa_producto = 'CTE'

   if @@rowcount <> 1
   begin
      /* Error en lectura de parametro */ 
      exec cobis..sp_cerror
           @t_debug     = @t_debug,
           @t_file      = @t_file,
           @t_from      = @w_sp_name,
           @i_num       = 201196
      return 201196
   end
end

select @w_ciudad = of_ciudad
from  cobis..cl_oficina
where of_oficina = @i_oficina

if @@rowcount != 1
begin
    /*** NO EXISTE OFICINA ***/
    exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 201094
        return 201094
end

select  @o_ciudad_matriz  = @i_ciudad_matriz 
select  @o_ciudad = @w_ciudad

/**** La dada una fecha en horario extendido devuelve la fecha siguiente habil *******/
if @i_val_dif = 'S'  
begin
   select @i_fecha = dateadd(dd, 1, @i_fecha)

   /*** Si el dia dado es viernes horario extendido, se aumenta en uno para el dia siguiente **/
   if (DATEDIFF(day,0,@i_fecha)%7 + 1) = 6 -- Cambio por manejo de sabado como habil
       select @i_fecha = dateadd(dd, 1, @i_fecha)
  
   while 1 = 1
   begin
      if exists (select 1 
                 from  cobis..cl_dias_feriados
                 where (df_ciudad = @w_ciudad or df_ciudad = @i_ciudad_matriz)
                 and    df_fecha  = @i_fecha)
      begin
         select @i_fecha = dateadd(dd, 1, @i_fecha)
         if (DATEDIFF(day,0,@i_fecha)%7 + 1) = 6 and @i_finsemana = 'S' -- Cambio por manejo de sabado como habil
             select @i_fecha = dateadd(dd, 1, @i_fecha)
      end    
      else
         break
   end
   select @o_fecha_sig = @i_fecha 
end

/*****************************************************************************/
/**** Caso donde nos pasan una fecha y una cantidad de dia para efectivizar***/
/*****************************************************************************/
if @i_efec_dia = 'S'
begin
   if  @w_dias_ret > 0 
   begin

      if (DATEDIFF(day,0,@i_fecha )%7 + 1 = 6)  --begin /** SI el dia de entrada es sabado se coloca  diferido S  para aumentar un dia la suma ***/
         select @i_dif = 'S' 
         select  @i_fecha = dateadd(dd,1,@i_fecha)
--      end
      /* Determinar la fecha de efectivizacion del deposito */
      if @i_dif = 'S'
          select  @w_cont = 0
      else
          select  @w_cont = 1

      /*** Si el siguiente dia es sabado debo aumentar un dia mas   ****/
      if (DATEDIFF(day,0,@i_fecha )%7 + 1) = 6 and @i_finsemana = 'S'-- Cambio por manejo de sabado como habil
          select @i_fecha = dateadd(dd, 1, @i_fecha )

      while @w_cont <= @w_dias_ret
      begin
         if exists  (select 1
                     from  cobis..cl_dias_feriados
                     where (df_ciudad = @w_ciudad or df_ciudad = @i_ciudad_matriz)
                     and   df_fecha  = @i_fecha )
            select @i_fecha = dateadd(dd,1,@i_fecha )
         else 
         begin
            /** Si el siguiente dia es sabado debo aumentar en un dia     *****/
            if (DATEDIFF(day,0,@i_fecha )%7 + 1) = 6 and @i_finsemana = 'S'-- Cambio por manejo de sabado como habil
               select @i_fecha = dateadd(dd, 1, @i_fecha )
            else
            begin   
               select @w_cont = @w_cont + 1
               if @w_cont <= abs(@w_dias_ret)
                   select @i_fecha  = dateadd(dd,1,@i_fecha )
            end
         end    
      end
   end
   else    
   begin
      /**** Colocar el numero de dias retenidos en positivo  *****/
      select  @w_dias_ret = ( @w_dias_ret * -1),
              @w_cont = 1
      select @i_fecha = dateadd(dd, -1, @i_fecha )

      /*** Si el anterior dia es sabado debo disminuir un dia mas   ****/
      if (DATEDIFF(day,0,@i_fecha )%7 + 1) = 6 and @i_finsemana = 'S'-- Cambio por manejo de sabado como habil
          select @i_fecha = dateadd(dd, -1, @i_fecha )

      while @w_cont <= @w_dias_ret
      begin
          if exists  (  select 1
                      from cobis..cl_dias_feriados
                     where (df_ciudad = @w_ciudad or df_ciudad = @i_ciudad_matriz)
                       and df_fecha  = @i_fecha )
                  select @i_fecha = dateadd(dd,-1,@i_fecha )
          else 
          begin
              /** Si el dia anterior es sabado debo disminuir en un dia     *****/
              if (DATEDIFF(day,0,@i_fecha )%7 + 1) = 6 and @i_finsemana = 'S'-- Cambio por manejo de sabado como habil
                  select @i_fecha = dateadd(dd, -1, @i_fecha )
              else
              begin
                 select @w_cont = @w_cont + 1
                 if @w_cont <= @w_dias_ret
                    select @i_fecha  = dateadd(dd,-1,@i_fecha )
              end
          end     
      end
   end
   select @o_fecha_sig = @i_fecha 
end



go
