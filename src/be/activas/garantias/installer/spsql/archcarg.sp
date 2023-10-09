/************************************************************************/
/*	Archivo: 	        archcarg.sp                             */ 
/*	Stored procedure:       sp_archivos_cargados                    */ 
/*	Base de datos:  	cob_custodia                            */
/*	Producto:               GARANTIAS    			        */
/*	Fecha de escritura:     Diciembre 2000   			*/
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
/*      Permite buscar los archivos de vencimientos que han sido        */
/*      cargados desde diskette.                                        */
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		 RAZON				*/
/************************************************************************/
use cob_custodia
go

if exists (select 1 from sysobjects where name = 'sp_archivos_cargados')
    drop proc sp_archivos_cargados
go
create proc sp_archivos_cargados  (
   @s_ssn                  int      = NULL,
   @s_date                 datetime = NULL,
   @s_user                 login    = NULL,
   @s_term                 descripcion = NULL,
   @s_corr                 char(1)  = NULL,
   @s_ssn_corr             int      = NULL,
   @s_ofi                  smallint  = NULL,
   @s_sesn                 int       = NULL,
   @t_rty                  char(1)  = NULL,
   @t_trn                  smallint = NULL,
   @t_debug                char(1)  = 'N',
   @t_file                 varchar(14) = NULL,
   @t_from                 varchar(30) = NULL,
   @i_operacion            char(1) = NULL,
   @i_archivo              varchar(30) = NULL,
   @i_archivo_vto         varchar(30) = NULL

)
as

declare
   @w_sp_name char(30)

select @w_sp_name = 'sp_archivos_cargados'

if (@i_operacion = "S" and @t_trn <> 19904) or
   (@i_operacion = "D" and @t_trn <> 19905) or
   (@i_operacion = "I" and @t_trn <> 19906)

begin
    /* tipo de transaccion no corresponde */
    exec cobis..sp_cerror
    @t_debug = @t_debug,
    @t_file  = @t_file, 
    @t_from  = @w_sp_name,
    @i_num   = 1901006
    return 1 
end

-- Buscar los datos
if @i_operacion = "S"
begin
   set rowcount 20
   select "ARCHIVO" = ac_archivo,
          "CARGADO POR" = ac_user,
          "FECHA" = convert(char(10),ac_date,103)   
     from cu_archivos_cargados_mig
     where ac_user = @s_user
   set rowcount 0
end



-- Eliminar un dato de archivos cargados
if @i_operacion = "D"
begin

  delete cu_archivos_cargados_mig
   where ac_archivo = @i_archivo
     and ac_user    = @s_user

  if @@error <> 0 
  begin
     /* Error en insercion de registro */
     exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file, 
        @t_from  = @w_sp_name,
        @i_num   = 1907001
        return 1 
  end
end

 -- Ingresar los datos del archivo cargado
if @i_operacion = "I"
begin
  insert into cu_archivos_cargados_mig (ac_archivo, ac_user, ac_date, ac_sesn)
       values (@i_archivo_vto,@s_user,@s_date,@s_sesn)

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

return 0
go

