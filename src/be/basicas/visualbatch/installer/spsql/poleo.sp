/************************************************************************/
/* Archivo:                poleo.sp                                     */
/* Stored procedure:       sp_poleo                                     */
/* Base de datos:          cobis                                        */
/* Producto:               cobis                                        */
/* Disenado por:                                                        */
/* Fecha de escritura:     22-Marzo-1994                                */
/************************************************************************/
/*                         IMPORTANTE                                   */
/*    Este programa es parte de los paquetes bancarios propiedad de     */
/*    "MACOSA", representantes exclusivos para el Ecuador de la         */
/*    "NCR CORPORATION".                                                */
/*    Su uso no autorizado queda expresamente prohibido asi como        */
/*    cualquier alteracion o agregado hecho por alguno de sus           */
/*    usuarios sin el debido consentimiento por escrito de la           */
/*    Presidencia Ejecutiva de MACOSA o su representante.               */
/************************************************************************/
/*                          PROPOSITO                                   */
/*    Este programa procesa las transacciones de: Poleo de batch        */
/*                                                                      */
/************************************************************************/
/*                        MODIFICACIONES                                */
/*    FECHA          AUTOR           RAZON                              */
/*    22-Abr-1994    G. Jaramillo    Emision Inicial                    */
/************************************************************************/

use cobis
go

if exists (select * from sysobjects where name = 'sp_poleo')
   drop proc sp_poleo

go
create proc sp_poleo   (
   @s_ssn        int = null,
   @s_date       datetime = null,
   @s_user       login = null,
   @s_term       descripcion = null,
   @s_corr       char(1) = null,
   @s_ssn_corr       int = null,
   @s_ofi        smallint = null,
   @t_rty            char(1) = null,
   @t_trn        smallint = 804,
   @t_debug   char(1) = 'N',
   @t_file       varchar(14) = null,
   @t_from       varchar(30) = null,
   @i_operacion     char(1),
   @i_modo       smallint = null,
   @i_sarta   int = null,
   @i_batch   int = null,
   @i_secuencial     smallint = null,
   @i_corrida    smallint = null 
)
as 
declare
   @w_today    datetime,   /* fecha del dia */
   @w_return   int,     /* valor que retorna */
   @w_sp_name  varchar(32),   /* descripcion del stored procedure*/
   @w_existe   int,     /* codigo existe = 1 
                      no existe = 0 */
   @w_sarta      int,
   @w_batch   int,
   @w_secuencial    smallint,
   @w_dependencia    smallint,
   @w_corrida    smallint,
   @w_maximo     smallint,
   @w_estatus    char(1)

select @w_today = getdate()
select @w_sp_name = 'sp_poleo'


if (@t_trn <> 8042 and @i_operacion = 'U') or
   (@t_trn <> 8048 and @i_operacion = 'E') 
begin
   /* Tipo de transaccion no corresponde */
   exec cobis..sp_cerror
   @t_debug = @t_debug,
   @t_file  = @t_file,
   @t_from  = @w_sp_name,
   @i_num   = 801077
   return 1
end


/* Chequeo de Existencias */
/**************************/

if @i_operacion = 'U'
begin
   select @w_maximo = 0

   select max(lo_corrida)
   from cobis..ba_log
   where    lo_sarta = @i_sarta and
      lo_batch = @i_batch and
      lo_secuencial = @i_secuencial
   
   if @@rowcount = 0
   begin
      select @w_maximo 
   end
   return 0
end


if @i_operacion = 'E'
begin
   if exists(select *
      from cobis..ba_log
      where lo_sarta = @i_sarta and
         lo_batch = @i_batch and
         lo_secuencial = @i_secuencial and
         lo_corrida = @i_corrida)
   begin
      select lo_estatus
      from cobis..ba_log
      where lo_sarta = @i_sarta and
         lo_batch = @i_batch and
         lo_secuencial = @i_secuencial and
         lo_corrida = @i_corrida
         
   end
   else begin
      begin tran
         insert into cobis..ba_log
         (lo_sarta,lo_batch,lo_secuencial,lo_corrida,
          lo_fecha_inicio,lo_fecha_terminacion,lo_estatus)
         values(@i_sarta,@i_batch,@i_secuencial,@i_corrida,
         @w_today,@w_today,'A')

      commit tran 

      select @w_estatus = 'A'
           select @w_estatus
   end

   return 0
end
go

