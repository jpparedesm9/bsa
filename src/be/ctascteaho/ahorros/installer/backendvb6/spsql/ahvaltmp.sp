-- ================================================
---
-- =============================================
-- Author:		<Author Johanna Chacon>
-- Create date: <31/05/2016>
-- Description:	<proceso que realiza la validacion 
---de la creacion de las tablas y sus indices>
-- =============================================

USE [cob_ahorros]
GO

if object_id('sp_ahvaltmp') is not null
begin
  drop procedure sp_ahvaltmp
  if object_id('sp_ahvaltmp') is not null
    print 'FAILED DROPPING PROCEDURE sp_ahvaltmp'  
end

go

create  proc [dbo].[sp_ahvaltmp]
(
@t_show_version     bit = 0,
@i_filial           int = null,
@i_fecha_proceso    varchar(13)=null,
@i_path_archivo     varchar(50)=null,
@i_usuario			varchar(10),
@i_contrasena       varchar(10),
@i_server			varchar(15),
--Parametros para registro de log ejecución 
 @i_sarta             int = null,
 @i_batch             int = null,
 @i_secuencial        int = null,
 @i_corrida           int = null,
 @i_intento           int = null,
 @o_registros         int  = 0 output

)
	
AS 
DECLARE
@w_existe        char(1),
@w_sp_name       varchar (500),
@w_existe_ind    char(1),
@w_mensaje       varchar (500),
@w_name          varchar(50),
@w_id            int ,
@w_ind           int,
@w_codigo        int,
@w_archivo       varchar(50), 
@w_comando       varchar(255),
@w_tabla         varchar (255),
@w_retorno       int,
@w_retorno_ej    int 



create table ah_valida_temporales (
 tabla varchar (500)
)

 
BEGIN

	SET NOCOUNT ON;
	select @w_sp_name = 'sp_ahvaltmp',
	       @w_tabla ='ah_valida_temporales'
	       

    if @t_show_version = 1
       begin
          print 'Stored Procedure = '+ @w_sp_name + 'Version = ' + '4.0.0.0'
          return 0
	   end

  select @w_codigo=1,
         @w_mensaje =null 

  select @w_archivo = 'ahvaltmp.lis'   
  

  while 1=1 
   begin 
	 set rowcount 1
	  select  @w_name = valor 
      from cobis..cl_catalogo b , cobis..cl_tabla c
      where b.tabla = c.codigo
      and   b.tabla  in (select codigo from cobis..cl_tabla 
	                     where tabla = 'ah_temps_ahorros') --354
	  and b.codigo = convert (varchar, @w_codigo)
	  group by valor
	
	 if @@rowcount = 0 
	 begin	  
		break --Salir del lazo 
	  end
	    set rowcount 0 
		select  @w_name
	    select @w_existe = 'S',
               @w_ind =id      
	    from tempdb..sysobjects
	    where name =@w_name	
	  

		if @w_existe = 'S'
		begin
			if exists (select 1 from tempdb..sysindexes
			            where id = @w_ind)
			begin
			    print 'no existe'   
			    select @w_mensaje = 'LA TABLA TEMPORAL    ' +  @w_name +  '   NO POSEE INDICE'
			end
		end
		else
		begin
			select  @w_mensaje = 'La Tabla   '+    @w_name + '   no existe'
		end
		
		
		---insert tabla de Mensajes
		insert  into  #ah_valida_temporales
		values (@w_mensaje) 
		PRINT 'PASO 5'
		
		select @w_codigo=@w_codigo+1
		select @w_existe ='N'
      end  
	
 
--Obtener bcp de la tabla

    select @w_comando = null
	select @w_comando = 'bcp cob_ahorros..' + @w_tabla + ' out ' +  @i_path_archivo + @w_archivo +' -U '+ @i_usuario +' -P '+ @i_contrasena +' -S '+ @i_server + ' -c' --     -b1000 -t -e ../listados/'  + @w_archivo + '.err > ../listados/' + @w_archivo + '.out'
	exec @w_retorno = master..xp_cmdshell @w_comando,no_output
	
	if @w_retorno > 0
    begin
    exec @w_retorno_ej = cobis..sp_ba_error_log
         @i_sarta        = @i_sarta,
         @i_batch        = @i_batch,
         @i_secuencial   = @i_secuencial,
         @i_corrida      = @i_corrida,
         @i_intento      = @i_intento,
         @i_error        = @w_retorno,
         @i_detalle      = 'Error ejecucion de bcp'

    if @w_retorno_ej > 0
    begin
        return @w_retorno_ej
    end
	  
    return @w_retorno    
end







	  
return 0

    
END

GO


