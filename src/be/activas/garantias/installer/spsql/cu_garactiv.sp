/*cu_garactiv.sp***************************************************/
/*  Archivo:            cu_garactiv.sp                            */
/*  Stored procedure:   sp_gar_actividad                          */
/*  Base de datos:      cob_custodia                              */ 
/*  Producto:           Credito                                   */
/*  Disenado por:       Luis Ponce                                */
/*  Fecha de escritura: 13-Dic-2010                               */
/******************************************************************/
/*                      IMPORTANTE                                */
/*  Este programa es parte de los paquetes bancarios propiedad de */
/*  'MACOSA', representantes exclusivos para el Ecuador de        */
/*  AT&T GIS  .                                                   */
/*  Su uso no autorizado queda expresamente prohibido asi como    */
/*  cualquier alteracion o agregado hecho por alguno de sus       */
/*  usuarios sin el debido consentimiento por escrito de la       */
/*  Presidencia Ejecutiva de MACOSA o su representante.           */
/******************************************************************/
/*                      PROPOSITO                                 */
/*  Este programa hace mantenimiento a la tabla cu_gar_actividad  */
/*  de cob_custodia, que guarda los tipos de garantias con los    */
/*  codigos de actividades economicas asociados                   */
/******************************************************************/
/*                    MODIFICACIONES                              */
/*  FECHA       AUTOR                 RAZON                       */
/*  13/Dic/10   Alfredo Zuluaga       Emision Inicial             */
/******************************************************************/

use cob_custodia
go

if exists (select 1 from sysobjects where name = 'sp_gar_actividad')
   drop proc sp_gar_actividad
go

create proc sp_gar_actividad(

   @s_ssn                int         = null,
   @s_user               login       = null,
   @s_sesn               int         = null,
   @s_term               varchar(30) = null,
   @s_date               datetime    = null,
   @s_srv                varchar(30) = null,
   @s_lsrv               varchar(30) = null,
   @s_rol                smallint    = null,
   @s_ofi                smallint    = null,
   @s_org_err            char(1)     = null,
   @s_error              int         = null,
   @s_sev                tinyint     = null,
   @s_msg                descripcion = null,
   @s_org                char(1)     = null,
   @t_debug              char(1)     = 'N',
   @t_file               varchar(10) = null,
   @t_from               varchar(32) = null,
   @t_trn                smallint    = null,
   @i_operacion          char(1),
   @i_modo               tinyint     = null,
   @i_tipo_garantia      varchar(64) = null,
   @i_actividad          varchar(10) = null
)
as

declare
@w_sp_name            varchar(25),
@w_msg                varchar(255)
  

select @w_sp_name = 'sp_gar_actividad'


if @i_operacion = 'I'  begin

   insert into cu_gar_actividad
   values (@i_tipo_garantia,  @i_actividad) 
         
   if @@error <> 0 begin
      select @w_msg = 'Error Insertando cu_gar_actividad ' 

      exec cobis..sp_cerror
      @t_debug    = @t_debug,
      @t_file     = @t_file,
      @t_from     = @w_sp_name,
      @i_msg      = @w_msg,
      @i_num      = 1903001

      return 1903001
   end

end


if @i_operacion = 'D'  begin

   delete cu_gar_actividad
   where ga_tipo  = @i_tipo_garantia
         
   if @@error <> 0 begin
      select @w_msg = 'Error Eliminando cu_gar_actividad ' 

      exec cobis..sp_cerror
      @t_debug    = @t_debug,
      @t_file     = @t_file,
      @t_from     = @w_sp_name,
      @i_msg      = @w_msg,
      @i_num      = 1907001

      return 1907001
   end

end


if @i_operacion = 'S'  begin

   select distinct
   marca         = 0,
   actividad     = aa_actividad,
   des_actividad = aa_descripcion
   into #temporal
   from cobis..cl_asociacion_actividad

   update #temporal set
   marca = 1
   from cu_gar_actividad
   where ga_tipo      = @i_tipo_garantia
   and   ga_actividad = actividad

   set rowcount 15

   select 
   'MARCA    '                                          = marca, 
   'ACTIVIDAD   '                                       = actividad,
   'DESCRIPCION                                       ' = des_actividad
   from #temporal
   where actividad > @i_actividad
   order by actividad

   set rowcount 0

end


return 0

go


