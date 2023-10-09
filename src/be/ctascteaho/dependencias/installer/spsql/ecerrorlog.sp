/************************************************************************/
/*  Archivo           :  ecerrorlog.sp                                  */
/*  Base de datos     :  cob_conta_super                                */
/*  Producto          :  REC                                            */
/************************************************************************/
/*                              IMPORTANTE                              */
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
/*                            PROPOSITO                                 */
/************************************************************************/
/*                          MODIFICACIONES                              */
/*   FECHA           AUTOR               RAZON                          */
/*   16/08/2016      Jorge Salazar       Migracion Cobis CLOUD MEX      */
/************************************************************************/
use cob_conta_super
go 
if exists (select * from cob_conta_super..sysobjects where name = 'sp_errorlog')
    drop procedure sp_errorlog
go

create procedure sp_errorlog
(
   @t_show_version      bit          = 0,
   @i_operacion         char(1)      = 'A',
   @i_fecha_fin         datetime     = null,
   @i_fuente            varchar(64),
   @i_origen_error      varchar(255) = null,
   @i_descrp_error      varchar(255) = null   
)
as  

declare 
   @w_nombre_archivo    varchar(255),
--variables bcp
   @w_s_app             varchar(50),
   @w_cmd               varchar(255),   
   @w_comando           varchar(255),
   @w_path_destino      varchar(255),
   @w_mensaje           varchar(200),
   @w_retorno           int,
   @w_error             int,
   @w_sp_name           varchar(64)


select @w_sp_name = 'sp_errorlog'

-- Versionamiento del Programa --
if @t_show_version = 1
begin
  print 'Stored Procedure=' + @w_sp_name + ' Version=' + '4.0.0.0'
  return 0
end

if @i_operacion = 'I' begin
   insert into sb_errorlog
          (er_fecha,      er_fecha_proc, er_fuente, er_origen_error, er_descrp_error) 
   values (@i_fecha_fin,  getdate(),     @i_fuente, @i_origen_error, @i_descrp_error)
end

/*******GENERANDO ARCHIVO PLANO ****/
if @i_operacion = 'A' begin
   if  (select count(1) from cob_conta_super..sb_errorlog  where er_fuente = @i_fuente ) > 1 begin
   
      print 'PATH DESTINO ARCHIVO'
      select @w_path_destino = ba_path_destino
        from cobis..ba_batch
       where ba_batch = 28700
      if @@rowcount = 0 begin
         select 
         @w_retorno = 28001,
         @w_error   = 'NO EXISTE RUTA DE LISTADOS PARA EL BATCH 28700'
         goto ERROR
      end 
     
      select @w_s_app = pa_char
        from cobis..cl_parametro
       where pa_producto = 'ADM'
         and pa_nemonico = 'S_APP'
      if @@rowcount = 0 begin
         select 
         @w_retorno = 28009,
         @w_error   = 'NO EXISTE RUTA DEL S_APP'
         goto ERROR
      end 
     
     
      select  @w_nombre_archivo = @w_path_destino + 'errorlog_' + @i_fuente + '_' + convert(varchar(10),getdate(),112) + '.txt'
      
      if exists(select 1 from sysobjects where name = 'tmp_error')
         drop table tmp_error
      
      create table tmp_error(
        registro     varchar(800))
        
      insert into tmp_error 
      values ('FECHA EJECUCION | FECHA PROCESO |PROGRAMA |ORIGEN DEL ERROR |DESCRIPCIO DEL ERROR')
      
      insert into tmp_error 
      select convert(varchar(10),er_fecha,101) + '|' + convert(varchar(10),er_fecha_proc,101) + '|'+ er_fuente + '|'+ er_origen_error + '|'+ er_descrp_error
        from cob_conta_super..sb_errorlog
       where er_fuente = @i_fuente   
     
      --*******************************************--
      ---> GENERAR BCP
      --*******************************************--
          
      select @w_cmd     = @w_s_app + 's_app bcp -auto -login cob_conta_super..tmp_error out ' 
      select @w_comando = @w_cmd + @w_nombre_archivo + ' -b5000 -c -e' + 'errorlog.err' + ' -config '+ @w_s_app + 's_app.ini'
      print @w_comando
      exec @w_error = xp_cmdshell @w_comando
      print @w_error
      if @w_error <> 0 begin 
         select    
         @w_retorno = 28015,
         @w_error   = 'ERROR GENERANDO BCP ' + @w_comando
         goto ERROR
      end
      ---para registro tipo tres
   end    
end 
return 0

ERROR:
insert into sb_errorlog(
er_fecha        ,er_fecha_proc    ,er_fuente,
er_origen_error ,er_descrp_error) 
values( 
@i_fecha_fin    ,getdate()        ,@w_sp_name,
@w_retorno      ,@w_error)  
 
return  @w_retorno

go

