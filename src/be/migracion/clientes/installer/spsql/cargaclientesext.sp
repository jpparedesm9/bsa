/************************************************************************/
/*      Archivo:                        cargaclientesext.sql            */
/*      Stored procedure:               sp_carga_cliente_ext            */
/*      Base de Datos:                  cob_externos                    */
/*      Producto:                       Clientes                        */
/************************************************************************/
/*                      IMPORTANTE                                      */
/*  Esta aplicacion es parte de los paquetes bancarios propiedad        */
/*  de COBISCorp.                                                       */
/*  Su uso no    autorizado queda  expresamente   prohibido asi como    */
/*  cualquier    alteracion o  agregado  hecho por    alguno  de sus    */
/*  usuarios sin el debido consentimiento por   escrito de COBISCorp.   */
/*  Este programa esta protegido por la ley de   derechos de autor      */
/*  y por las    convenciones  internacionales   de  propiedad inte-    */
/*  lectual.    Su uso no  autorizado dara  derecho a    COBISCorp para */
/*  obtener ordenes  de secuestro o  retencion y para  perseguir        */
/*  penalmente a los autores de cualquier   infraccion.                 */
/************************************************************************/
/*                      PROPOSITO                                       */
/* Realiza la carga a las tablas externas de clientes para la migracion */
/************************************************************************/
/*                            MODIFICACIONES                            */
/*      FECHA           AUTOR                   RAZON                   */
/*      25/08/2016      Ignacio Yupa            Emision Inicial         */  
/************************************************************************/
use cob_externos
go

if exists(select * from sysobjects where name = 'sp_carga_cliente_ext')
   drop proc sp_carga_cliente_ext
go

create proc sp_carga_cliente_ext(
   @t_show_version         bit          = 0,
   @i_param1               char(1)      = null,--operacion
   @i_param2              datetime  = null,  --fecha
   @i_param3              varchar(255)      = null --archivo
   
)
as declare 
  @w_s_app        varchar(64),
  @w_path         varchar(64),
  @w_comando      varchar(500),
  @w_archivo      varchar(255),
  @w_error        int,
  @w_sp_name      varchar(32),  
  @w_mensaje      varchar(255),
  @w_contador     int,
  @w_fecha        datetime
  
  
  select
    @w_sp_name = 'sp_carga_cliente_ext',  
    @w_archivo  = @i_param3

 ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure = ' + @w_sp_name + 'Version = ' + '4.0.0.0'
    return 0
  end
     
 --select
    --@w_path = 'C:/Cobis/vbatch/ahorros/listados/'
     
  select
    @w_s_app = pa_char
  from   cobis..cl_parametro
  where  pa_producto = 'ADM'
     and pa_nemonico = 'S_APP'
	 
---MAPEO PARA LA Cl_ente	 
	 
if @i_param1 = 'N'
begin
  
 select @w_path = ba_path_destino
    from cobis..ba_batch 
    where ba_batch = 5002
 
 truncate table cl_ente_ext
		   
select
    @w_comando = @w_s_app + 's_app' +
                 ' bcp -auto -login cob_externos..cl_ente_ext in '
                 +
                 @w_path
                 + @w_archivo +  ' -c -t"|" '
                 + '-config ' + @w_s_app + 's_app.ini'
				 
				 print  @w_comando

  /* EJECUTAR CON CMDSHELL */
  exec @w_error = xp_cmdshell
    @w_comando
	
if @w_error <> 0
  begin
    select
      @w_mensaje = 'ERROR CARGANDO ARCHIVO POR BCP ' + upper(@w_archivo) +' ',
      @w_error = 4000003      
    goto ERRORFIN
  end
  
  select @w_contador = isnull(count(*),0) from cob_externos..cl_ente_ext
  if @w_contador = 0
  begin
    select
      @w_mensaje = 'NO HAY REGISTROS EN LA CL_ENTE_EXT ',
      @w_error = 4000003      
    goto ERRORFIN
  end
end  
  
  ---MAPEO PARA LA Cl_direccion
  
  if @i_param1 = 'D'
begin

 select @w_path = ba_path_destino
    from cobis..ba_batch 
    where ba_batch = 5003
 
	 	 
truncate table cl_direccion_ext
         
select
    @w_comando = @w_s_app + 's_app' +
                 ' bcp -auto -login cob_externos..cl_direccion_ext in '
                 +
                 @w_path
                 + @w_archivo +  ' -c -t"|" '
                 + '-config ' + @w_s_app + 's_app.ini'

  /* EJECUTAR CON CMDSHELL */
  exec @w_error = xp_cmdshell
    @w_comando
	
if @w_error <> 0
  begin
    select
      @w_mensaje = 'ERROR CARGANDO ARCHIVO POR BCP ' + upper(@w_archivo)+' ',
      @w_error = 4000003

    goto ERRORFIN
  end	
  
  select @w_contador = isnull(count(*),0) from cob_externos..cl_direccion_ext
  if @w_contador = 0
  begin
    select
      @w_mensaje = 'NO HAY REGISTROS EN LA CL_DIRECCION_EXT ',
      @w_error = 4000003      
    goto ERRORFIN
  end
  
end

--MAPEO PARA Cl_refinh
 if @i_param1 = 'R'
begin

 select @w_path = ba_path_destino
    from cobis..ba_batch 
    where ba_batch = 5004
 

truncate table cl_refinh_ext
	 	 
select
    @w_comando = @w_s_app + 's_app' +
                 ' bcp -auto -login cob_externos..cl_refinh_ext in '
                 +
                 @w_path
                + @w_archivo +  ' -c -t"|" '
                 + '-config ' + @w_s_app + 's_app.ini'

  /* EJECUTAR CON CMDSHELL */
  exec @w_error = xp_cmdshell
    @w_comando
	
if @w_error <> 0
  begin
    select
      @w_mensaje = 'ERROR CARGANDO ARCHIVO POR BCP ' + upper(@w_archivo)+' ',
      @w_error = 4000003

    goto ERRORFIN
  end
  
   select @w_contador = isnull(count(*),0) from cob_externos..cl_refinh_ext
  if @w_contador = 0
  begin
    select
      @w_mensaje = 'NO HAY REGISTROS EN LA CL_REFINH_EXT ',
      @w_error = 4000003      
    goto ERRORFIN
  end
  
end	
  
--MAPEO PARA cl_telefono
 if @i_param1 = 'T'
begin

 select @w_path = ba_path_destino
    from cobis..ba_batch 
   where ba_batch = 5005
 

truncate table cl_telefono_ext
	 	 
select
    @w_comando = @w_s_app + 's_app' +
                 ' bcp -auto -login cob_externos..cl_telefono_ext in '
                 + @w_path
                + @w_archivo +  ' -c -t"|" '
                 + '-config ' + @w_s_app + 's_app.ini'

                 print @w_comando
                 
  /* EJECUTAR CON CMDSHELL */
  exec @w_error = xp_cmdshell
    @w_comando
	
if @w_error <> 0
  begin
    select
      @w_mensaje = 'ERROR CARGANDO ARCHIVO POR BCP ' + upper(@w_archivo)+' ',
      @w_error = 4000003

    goto ERRORFIN
  end
  
   select @w_contador = isnull(count(*),0) from cob_externos..cl_telefono_ext
  if @w_contador = 0
  begin
    select
      @w_mensaje = 'NO HAY REGISTROS EN LA CL_TELEFONO_EXT ',
      @w_error = 4000003      
    goto ERRORFIN
  end
  
end	  


--MAPEO PARA CL_ref_personal
 if @i_param1 = 'P'
begin

  select @w_path = ba_path_destino
    from cobis..ba_batch 
    where ba_batch = 5006
 

  truncate table cl_ref_personal_ext
	 	 
  select
    @w_comando = @w_s_app + 's_app' +
                 ' bcp -auto -login cob_externos..cl_ref_personal_ext in '
                 + @w_path
                + @w_archivo +  ' -c -t"|" '
                 + '-config ' + @w_s_app + 's_app.ini'

  print @w_comando                  
  /* EJECUTAR CON CMDSHELL */
  exec @w_error = xp_cmdshell
    @w_comando
	
  if @w_error <> 0
  begin
    select
      @w_mensaje = 'ERROR CARGANDO ARCHIVO POR BCP ' + upper(@w_archivo)+' ',
      @w_error = 4000003

    goto ERRORFIN
  end
  
   select @w_contador = isnull(count(*),0) from cob_externos..cl_ref_personal_ext
  if @w_contador = 0
  begin
    select
      @w_mensaje = 'NO HAY REGISTROS EN LA CL_REF_PERSONAL_EXT ',
      @w_error = 4000003      
    goto ERRORFIN
  end
  
end 

--MAPEO PARA CL_trabajo
if @i_param1 = 'B'
begin

  select @w_path = ba_path_destino
    from cobis..ba_batch 
    where ba_batch = 5007
 
 
  truncate table cl_trabajo_ext
	 	 
  select
    @w_comando = @w_s_app + 's_app' +
                 ' bcp -auto -login cob_externos..cl_trabajo_ext in '
                 + @w_path
                + @w_archivo +  ' -c -t"|" '
                 + '-config ' + @w_s_app + 's_app.ini'
  /* EJECUTAR CON CMDSHELL */
  exec @w_error = xp_cmdshell
    @w_comando
	
  if @w_error <> 0
  begin
    select
      @w_mensaje = 'ERROR CARGANDO ARCHIVO POR BCP ' + upper(@w_archivo)+' ',
      @w_error = 4000003

    goto ERRORFIN
  end
  
  select @w_contador = isnull(count(*),0) from cob_externos..cl_trabajo_ext
  if @w_contador = 0
  begin
    select
      @w_mensaje = 'NO HAY REGISTROS EN LA CL_TRABAJO_EXT ',
      @w_error = 4000003      
    goto ERRORFIN
  end
end

--MAPEO PARA cl_instancia
if @i_param1 = 'I'
begin

  select @w_path = ba_path_destino
    from cobis..ba_batch 
    where ba_batch = 5011
 

  truncate table cl_instancia_ext
  select
    @w_comando = @w_s_app + 's_app' +
                 ' bcp -auto -login cob_externos..cl_instancia_ext in '
                 + @w_path
                + @w_archivo +  ' -c -t"|" '
                 + '-config ' + @w_s_app + 's_app.ini'

  print @w_comando                  
  /* EJECUTAR CON CMDSHELL */
  exec @w_error = xp_cmdshell
    @w_comando
  
  if @w_error <> 0
  begin

    select
      @w_mensaje = 'ERROR CARGANDO ARCHIVO POR BCP ' + upper(@w_archivo)+' ',
      @w_error = 4000003

    goto ERRORFIN
  end
  
  select @w_contador = isnull(count(*),0) from cob_externos..cl_instancia_ext
  if @w_contador = 0
  begin
    select
      @w_mensaje = 'NO HAY REGISTROS EN LA cl_instancia_ext ',
      @w_error = 4000003      
    goto ERRORFIN
  end
end  

return 0
   
  ERRORFIN:
  select @w_fecha = getdate() 
exec cobis..sp_errorlog
   @i_fecha       = @w_fecha,
   @i_error       = @w_error,
   @i_usuario     = 'admuser',     
   @i_descripcion = @w_mensaje,
   @i_rollback    = 'N',
   @i_tran        = 4000,
   @i_tran_name   = 'sp_carga_cliente_ext'
  
  return @w_error
 
go
