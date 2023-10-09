use cob_conta
go

if object_id('sp_cb_jerar2_ej') is not null
begin
  drop procedure sp_cb_jerar2_ej
  if object_id('sp_cb_jerar2_ej') is not null
  begin
    print 'FALLO BORRADO DE PROCEDIMIENTO sp_cb_jerar2_ej'
  end
end
go
create proc sp_cb_jerar2_ej
/************************************************************************/
/*      Archivo           :  cb_jerar2.sp                               */
/*      Base de datos     :  cob_conta                                  */
/*      Producto          :  Contabilidad                               */
/*      Disenado por      :                                             */
/*      Fecha de escritura:  18/Oct/94                                  */
/************************************************************************/
/*                              IMPORTANTE                              */
/*      Este programa es parte de los paquetes bancarios propiedad de   */
/*      "COBISCORP", representantes exclusivos para el Ecuador de la    */
/*      "COBISCORP CORPORATION".                                        */
/*      Su uso no autorizado queda expresamente prohibido asi como      */
/*      cualquier alteracion o agregado hecho por alguno de sus         */
/*      usuarios sin el debido consentimiento por escrito de la         */
/*      Presidencia Ejecutiva de COBISCORP o su representante.          */
/************************************************************************/
/*                              PROPOSITO                               */
/*      Genera la tabla cb_jerararea en base a las areas  de            */
/*      movimiento                                                      */
/*      CODIGO DE PROGRAMA : 6054                                       */
/************************************************************************/
/*                            MODIFICACIONES                            */
/*      FECHA           AUTOR           RAZON                           */
/*      25/Sep/96     G. Jaramillo      Emision Inicial                 */
/*      10/Jun/2011   I. Ortiz          Reescritura SQR's por SP's      */
/*      20-Oct-2011   I. Ortiz          Modificaciones por reescritura  */
/*      09/Abr/2012   I. Ortiz          Versionamiento                  */
/************************************************************************/

(
  @t_show_version  bit         = 0,    -- show the version of the stored procedure  
  @i_empresa       tinyint,
  @i_fecha_fin     datetime,
-- parametros para registro del log de ejcucion 
  @i_sarta         int         =null,
  @i_batch         int         =null,
  @i_secuencial    int         =null,
  @i_corrida       int         =null,
  @i_intento       int         =null
)
as
begin
declare @w_sp_name        varchar(30),
        @w_retorno        int,
        @w_retorno_ej     int,
        @w_temp_area      int,
        @w_ar_area        int,
        @w_ar_nivel_area  int,
        @w_flag           int,
        @w_superior       int,
        @w_nombre_empresa varchar(30)

select @w_sp_name = 'sp_cb_jerar2_ej'


---- VERSIONAMIENTO DEL PROGRAMA --------------------------------
if @t_show_version = 1
begin
   print 'Stored Procedure=' + @w_sp_name + ' Version=4.0.0.0'
   return 0
end
-----------------------------------------------------------------


Select @w_nombre_empresa = em_descripcion
  from cob_conta..cb_empresa
 where em_empresa = @i_empresa

if @@rowcount = 0
begin
  exec @w_retorno_ej = cobis..sp_ba_error_log
       @i_sarta      = @i_sarta,
       @i_batch      = @i_batch,
       @i_secuencial = @i_secuencial,
       @i_corrida    = @i_corrida,
       @i_intento    = @i_intento,
       @i_error      = 808076,
       @i_detalle    = 'ERROR DE EJECUCION: No existe la empresa'
  if @w_retorno_ej > 0
  begin
    return @w_retorno_ej
  end
  else
  begin
    return 808076
  end
end

delete cb_jerararea
where ja_empresa =  @i_empresa

declare cur_ar_area cursor for
  select ar_area, ar_nivel_area
    from cb_area
    where ar_empresa =  @i_empresa 
      and   ar_movimiento = 'S'
open cur_ar_area
fetch cur_ar_area into @w_ar_area, @w_ar_nivel_area
while @@fetch_status = 0
begin
  select @w_temp_area = @w_ar_area
  insert into cb_jerararea (ja_empresa,ja_area,ja_nivel,ja_area_padre)
    values (@i_empresa,@w_ar_area,@w_ar_nivel_area,@w_ar_area)
  select @w_flag = @w_ar_nivel_area - 1
  while @w_flag > 0
  begin
    select @w_superior = ar_area_padre
      from cb_area
     where ar_empresa =  @i_empresa 
       and ar_area = @w_temp_area
    insert into cb_jerararea (ja_empresa,ja_area,ja_nivel,ja_area_padre)
      values (@i_empresa,@w_ar_area,@w_flag,@w_superior)
    select @w_temp_area = @w_superior,@w_flag = @w_flag -1
  end
fetch cur_ar_area into @w_ar_area, @w_ar_nivel_area
end
close cur_ar_area
deallocate cur_ar_area

return 0
end
go

if object_id('sp_cb_jerar2_ej') is null
begin
  print 'FALLO CREACION DE PROCEDIMIENTO sp_cb_jerar2_ej'
end
go
