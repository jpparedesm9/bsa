use cob_conta
go

if object_id('sp_cb_jerar1_ej') is not null
begin
  drop procedure sp_cb_jerar1_ej
  if object_id('sp_cb_jerar1_ej') is not null
  begin
    print 'FALLO BORRADO DE PROCEDIMIENTO sp_cb_jerar1_ej'
  end
end
go
create proc sp_cb_jerar1_ej
/************************************************************************/
/*      Archivo           :  cb_jerar1.sp                               */
/*      Base de datos     :  cob_conta                                  */
/*      Producto          :  Contabilidad                               */
/*      Disenado por      :  Gonzalo Jaramillo                          */
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
/*      Genera la tabla cb_jerarquia en base a las oficinas de          */
/*      movimiento                                                      */
/*      CODIGO DE PROGRAMA :6053                                        */
/************************************************************************/
/*                            MODIFICACIONES                            */
/*      FECHA           AUTOR           RAZON                           */
/*      25/Sep/96     G. Jaramillo      Emision Inicial                 */
/*      13/Jun/2011   I. Ortiz          Reescritura SQR's por SP's      */
/*      20/Oct/2011   I. Ortiz          Modificaciones por reescritura  */
/*      09/Abr/2012   I. Ortiz          Versionamiento                  */
/************************************************************************/
(
  @t_show_version  bit         = 0,    -- show the version of the stored procedure  
  @i_empresa       tinyint,
-- parametros para registro del log de ejcucion
  @i_sarta         int         =null,
  @i_batch         int         =null,
  @i_secuencial    int         =null,
  @i_corrida       int         =null,
  @i_intento       int         =null
)
as
begin
declare @w_sp_name         varchar(30),
        @w_retorno         int,
        @w_retorno_ej      int,
        @w_superior        int,
        @w_flag            int,
        @w_of_organizacion int,
        @w_of_oficina      int,
        @w_temp_ofic       int

select @w_sp_name = 'sp_cb_jerar1_ej'


---- VERSIONAMIENTO DEL PROGRAMA --------------------------------
if @t_show_version = 1
begin
   print 'Stored Procedure=' + @w_sp_name + ' Version=4.0.0.0'
   return 0
end
-----------------------------------------------------------------


delete cb_jerarquia
  where je_empresa =  @i_empresa 

declare cur_main cursor for
select of_oficina, of_organizacion
  from cb_oficina
 where of_empresa =  @i_empresa
   and of_movimiento = 'S'

open cur_main
fetch cur_main into @w_of_oficina, @w_of_organizacion
while @@fetch_status = 0
begin
  insert into cb_jerarquia (
        je_empresa,
        je_oficina,
        je_nivel,
        je_oficina_padre)
    values (
        @i_empresa,
        @w_of_oficina,
        @w_of_organizacion,
        @w_of_oficina)
  
  select @w_flag      = @w_of_organizacion -1,
         @w_temp_ofic = @w_of_oficina

  while @w_flag > 0
  begin
     select @w_superior = of_oficina_padre
       from cb_oficina
      where of_empresa = @i_empresa 
        and of_oficina = @w_temp_ofic

    insert into cb_jerarquia (
        je_empresa,
        je_oficina,
        je_nivel,
        je_oficina_padre)
      values (
        @i_empresa,
        @w_of_oficina,
        @w_flag,
        @w_superior)
    select @w_temp_ofic = @w_superior,
           @w_flag      = @w_flag -1
  end
  fetch cur_main into @w_of_oficina, @w_of_organizacion
end
close cur_main
deallocate cur_main

return 0
end
go

if object_id('sp_cb_jerar1_ej') is null
begin
  print 'FALLO CREACION DE PROCEDIMIENTO sp_cb_jerar1_ej'
end
go
