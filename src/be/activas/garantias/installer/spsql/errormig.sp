/************************************************************************/
/*	Archivo: 	        errormig.sp                             */ 
/*	Stored procedure:       sp_cerror_mig                           */ 
/*	Base de datos:  	cob_custodia                           	*/
/*	Producto:               GARANTIAS                		*/
/*	Disenado por:           Milena Gonzalez                 	*/
/*	Fecha de escritura:     Diciembre 2000 				*/
/************************************************************************/
/*				IMPORTANTE				*/
/*	Este programa es parte de los paquetes bancarios propiedad de	*/
/*	"MACOSA", representantes exclusivos para el Ecuador de la 	*/
/*	"NCR CORPORATION".						*/
/*	Su uso no autorizado queda expresamente prohibido asi como	*/
/*	cualquier alteracion o agregado hecho por alguno de sus		*/
/*	usuarios sin el debido consentimiento por escrito de la 	*/
/*	Presidencia Ejecutiva de MACOSA o su representante.		*/
/*				PROPOSITO				*/
/*      Ingresa datos a la tabla de errores de migracion, al realizar   */
/*      la carga masiva de vencimientos de una garantia.                */
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/************************************************************************/
use cob_custodia
go

if exists (select 1 from sysobjects where name = 'sp_cerror_mig')
    drop proc sp_cerror_mig
go
create proc sp_cerror_mig  (
   @s_user                 login,
   @s_sesn                 int,
   @s_date                 datetime,
   @t_trn                  smallint     = NULL,
   @t_debug                char(1)      = 'N',
   @t_file                 varchar(14)  = NULL,
   @t_from                 varchar(30)  = NULL,
   @i_msg                  varchar(255) = NULL,
   @i_sp                   varchar(30)  = NULL,
   @i_secuencia            int    = NULL, 
   @i_modo                 tinyint      = NULL,
   @i_er_num		   int          = NULL,
   @i_tm_sp                varchar(30)  = NULL,
   @i_tm_archivo           varchar(30)  = NULL,
   @i_operacion            char(1)       
)
as
declare @w_num int,
        @w_sp_name                   char(30)

select @w_sp_name = 'Errores en migracion'


if (@t_trn <> 19907 and @i_operacion = 'S')  or
   (@t_trn <> 19908 and @i_operacion = 'I')
begin
    /* tipo de transaccion no corresponde */
    exec cobis..sp_cerror
    @t_debug = @t_debug,
    @t_file  = @t_file, 
    @t_from  = @w_sp_name,
    @i_num   = 1901006
    return 1 
end

if @i_operacion = 'I' 
begin
   select @w_num = max(em_num) 
     from cob_custodia..cu_error_mig
    where em_user = @s_user
      and em_sesn = @s_sesn
      and em_date = @s_date

 if @w_num is null
    select @w_num = 0
 else
    select @w_num = @w_num + 1

 -- Insertar el error
   insert into cu_error_mig (em_user, em_sesn, em_date, em_num, em_msg, em_sp, em_secuencia)
   values (@s_user, @s_sesn, @s_date, @w_num, @i_msg, @i_sp, 
         @i_secuencia)  
   if @@error <> 0 
   begin
      /* Error en insercion de registro */
      exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file  = @t_file, 
         @t_from  = @w_sp_name,
         @i_num   = 1903001
         return 1 
   end
end

if @i_operacion = 'S'
begin
   set rowcount  20
   if @i_modo = 0
   begin
      select "NUMERO"    = em_num,
             "SECUENCIA" = em_secuencia, 
             "MENSAJE"   = em_msg, 
             "PROGRAMA"  = em_sp
        from cob_custodia..cu_error_mig
       where em_user = @s_user
         and em_date = @s_date
         and em_sesn = @s_sesn  
   end
   if @i_modo = 1
   begin
      select "NUMERO"    = em_num,
             "SECUENCIA" = em_secuencia, 
             "MENSAJE"   = em_msg, 
             "PROGRAMA"  = em_sp
        from cob_custodia..cu_error_mig
       where em_user = @s_user
         and em_date = @s_date
         and em_sesn = @s_sesn  
         and em_num  > @i_er_num
   end
end  
go

