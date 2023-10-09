/************************************************************************/
/*      Archivo:                        ah_carga_ext.sp                 */
/*      Stored procedure:               sp_ah_carga_ext                 */
/*      Base de Datos:                  cob_externos                    */
/*      Producto:                       Ahorros                         */
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
/*                             PROPOSITO                                */
/* Realiza la carga a las tablas externas de clientes para la migracion */
/************************************************************************/
use cob_externos
go

if exists(select * from sysobjects where name = 'sp_ah_carga_ext')
   drop proc sp_ah_carga_ext
go

create proc sp_ah_carga_ext(
   @t_show_version        bit          = 0,
   @i_param1              char(2)      = null, --operacion
   @i_param2              varchar(255) = null  --archivo
   
)
as 
declare 
    @w_s_app        varchar(64),
    @w_path         varchar(64),
    @w_comando      varchar(500),
    @w_archivo      varchar(255),
    @w_error        int,
    @w_sp_name      varchar(32),  
    @w_mensaje      varchar(255),
    @w_contador     int,
    @w_fecha        datetime
  
  
select @w_sp_name = 'sp_ah_carga_ext',  
       @w_archivo = @i_param2 
   
---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
if @t_show_version = 1
begin
    print 'Stored Procedure = ' + @w_sp_name + 'Version = ' + '4.0.0.0'
    return 0
end
     
select @w_s_app = pa_char
from   cobis..cl_parametro
where  pa_producto = 'ADM'
and    pa_nemonico = 'S_APP'

select @w_path = ba_path_destino
from   cobis..ba_batch 
where  ba_batch = 4300

---MAPEO PARA LA AH_CUENTA
if @i_param1 = 'AH'
begin
     
    truncate table ah_cuenta_ext
   
    select
        @w_comando = @w_s_app + 's_app' +
                     ' bcp -auto -login cob_externos..ah_cuenta_ext in '
                     +
                     @w_path
                     + @w_archivo +  ' -c -t"|" '
                     + '-config ' + @w_s_app + 's_app.ini'

                    print  @w_comando

    /* EJECUTAR CON CMDSHELL */
    exec @w_error = xp_cmdshell @w_comando

    if @w_error <> 0
    begin
        select @w_mensaje = 'ERROR CARGANDO ARCHIVO POR BCP ' + upper(@w_archivo) +' ',
               @w_error   = 4000003      
        goto ERRORFIN
    end

    select @w_contador = isnull(count(*),0) from cob_externos..ah_cuenta_ext
    if @w_contador = 0
    begin
        select
          @w_mensaje = 'NO HAY REGISTROS EN LA AH_CUENTA_EXT ',
          @w_error = 4000003      
        goto ERRORFIN
    end
end  
  
---MAPEO PARA LA RE_CUENTA_CONTRACTUAL
if @i_param1 = 'CC'
begin
 
    truncate table re_cuenta_contractual_ext
         
    select
    @w_comando = @w_s_app + 's_app' +
                 ' bcp -auto -login cob_externos..re_cuenta_contractual_ext in '
                 +
                 @w_path
                 + @w_archivo +  ' -c -t"|" '
                 + '-config ' + @w_s_app + 's_app.ini'

    /* EJECUTAR CON CMDSHELL */
    exec @w_error = xp_cmdshell @w_comando

    if @w_error <> 0
    begin
        select
          @w_mensaje = 'ERROR CARGANDO ARCHIVO POR BCP ' + upper(@w_archivo)+' ',
          @w_error   = 4000003

        goto ERRORFIN
    end
/*
    select @w_contador = isnull(count(*),0) from cob_externos..re_cuenta_contractual_ext
    if @w_contador = 0
    begin
        select
          @w_mensaje = 'NO HAY REGISTROS EN LA RE_CUENTA_CONTRACTUAL_EXT ',
          @w_error = 4000003      
        goto ERRORFIN
    end
*/
end

--MAPEO PARA AH_CTABLOQUEADA
if @i_param1 = 'CB'
begin

    truncate table ah_ctabloqueada_ext

    select
        @w_comando = @w_s_app + 's_app' +
                     ' bcp -auto -login cob_externos..ah_ctabloqueada_ext in '
                     +
                     @w_path
                     + @w_archivo +  ' -c -t"|" '
                     + '-config ' + @w_s_app + 's_app.ini'

    /* EJECUTAR CON CMDSHELL */
    exec @w_error = xp_cmdshell @w_comando

    if @w_error <> 0
    begin
        select @w_mensaje = 'ERROR CARGANDO ARCHIVO POR BCP ' + upper(@w_archivo)+' ',
               @w_error   = 4000003
        goto ERRORFIN
    end
/*
    select @w_contador = isnull(count(*),0) from cob_externos..ah_ctabloqueada_ext
    if @w_contador = 0
    begin
        select @w_mensaje = 'NO HAY REGISTROS EN LA AH_CTABLOQUEADA_EXT ',
               @w_error   = 4000003      
        goto ERRORFIN
    end
*/
end

--MAPEO PARA AH_HIS_BLOQUEO
if @i_param1 = 'HB'
begin
     
    truncate table ah_his_bloqueo_ext

    select
        @w_comando = @w_s_app + 's_app' +
                     ' bcp -auto -login cob_externos..ah_his_bloqueo_ext in '
                     + @w_path
                     + @w_archivo +  ' -c -t"|" '
                     + '-config ' + @w_s_app + 's_app.ini'

                     print @w_comando

    /* EJECUTAR CON CMDSHELL */
    exec @w_error = xp_cmdshell @w_comando

    if @w_error <> 0
    begin
        select @w_mensaje = 'ERROR CARGANDO ARCHIVO POR BCP ' + upper(@w_archivo) + ' ',
               @w_error   = 4000003
        goto ERRORFIN
    end
/*
    select @w_contador = isnull(count(*),0) from cob_externos..ah_his_bloqueo_ext
    if @w_contador = 0
    begin
        select @w_mensaje = 'NO HAY REGISTROS EN LA AH_HIS_BLOQUEO_EXT ',
               @w_error   = 4000003      
        goto ERRORFIN
    end
*/
end  

--MAPEO PARA AH_CIUDAD_DEPOSITO
if @i_param1 = 'CD'
begin
     
    truncate table ah_ciudad_deposito_ext

    select
        @w_comando = @w_s_app + 's_app' +
                     ' bcp -auto -login cob_externos..ah_ciudad_deposito_ext in '
                     + @w_path
                     + @w_archivo +  ' -c -t"|" '
                     + '-config ' + @w_s_app + 's_app.ini'

    print @w_comando  

    /* EJECUTAR CON CMDSHELL */
    exec @w_error = xp_cmdshell @w_comando

    if @w_error <> 0
    begin
        select @w_mensaje = 'ERROR CARGANDO ARCHIVO POR BCP ' + upper(@w_archivo)+' ',
               @w_error   = 4000003

        goto ERRORFIN
    end
/*
    select @w_contador = isnull(count(*),0) from cob_externos..ah_ciudad_deposito_ext
    if @w_contador = 0
    begin
        select @w_mensaje = 'NO HAY REGISTROS EN LA AH_CIUDAD_DEPOSITO_EXT ',
               @w_error   = 4000003      
        goto ERRORFIN
    end
*/
end

--MAPEO PARA AH_HIS_INMOVILIZADAS
if @i_param1 = 'HI'
begin
     
    truncate table ah_his_inmovilizadas_ext

    select
        @w_comando = @w_s_app + 's_app' +
                     ' bcp -auto -login cob_externos..ah_his_inmovilizadas_ext in '
                     + @w_path
                     + @w_archivo +  ' -c -t"|" '
                     + '-config ' + @w_s_app + 's_app.ini'
      
    /* EJECUTAR CON CMDSHELL */
    exec @w_error = xp_cmdshell @w_comando

    if @w_error <> 0
    begin
        select @w_mensaje = 'ERROR CARGANDO ARCHIVO POR BCP ' + upper(@w_archivo)+' ',
               @w_error   = 4000003

        goto ERRORFIN
    end
/*
    select @w_contador = isnull(count(*),0) from cob_externos..ah_his_inmovilizadas_ext
    if @w_contador = 0
    begin
        select @w_mensaje = 'NO HAY REGISTROS EN LA AH_HIS_INMOVILIZADAS_EXT ',
               @w_error   = 4000003      
        goto ERRORFIN
    end
*/
end

--MAPEO PARA AH_VAL_SUSPENSO
if @i_param1 = 'VS'
begin

    truncate table ah_val_suspenso_ext

    select
        @w_comando = @w_s_app + 's_app' +
                     ' bcp -auto -login cob_externos..ah_val_suspenso_ext in '
                     + @w_path
                     + @w_archivo +  ' -c -t"|" '
                     + '-config ' + @w_s_app + 's_app.ini'
      
    /* EJECUTAR CON CMDSHELL */
    exec @w_error = xp_cmdshell @w_comando

    if @w_error <> 0
    begin
        select @w_mensaje = 'ERROR CARGANDO ARCHIVO POR BCP ' + upper(@w_archivo)+' ',
               @w_error   = 4000003

        goto ERRORFIN
    end
/*
    select @w_contador = isnull(count(*),0) from cob_externos..ah_val_suspenso_ext
    if @w_contador = 0
    begin
        select @w_mensaje = 'NO HAY REGISTROS EN LA AH_VAL_SUSPENSO_EXT ',
               @w_error   = 4000003      
        goto ERRORFIN
    end
*/
end

--MAPEO PARA AH_TRAN_MONET
if @i_param1 = 'TM'
begin
     
    truncate table ah_tran_monet_ext

    select
        @w_comando = @w_s_app + 's_app' +
                     ' bcp -auto -login cob_externos..ah_tran_monet_ext in '
                     + @w_path
                     + @w_archivo +  ' -c -t"|" '
                     + '-config ' + @w_s_app + 's_app.ini'
      
    /* EJECUTAR CON CMDSHELL */
    exec @w_error = xp_cmdshell @w_comando

    if @w_error <> 0
    begin
        select @w_mensaje = 'ERROR CARGANDO ARCHIVO POR BCP ' + upper(@w_archivo)+' ',
               @w_error   = 4000003

        goto ERRORFIN
    end
/*
    select @w_contador = isnull(count(*),0) from cob_externos..ah_tran_monet_ext
    if @w_contador = 0
    begin
        select @w_mensaje = 'NO HAY REGISTROS EN LA AH_TRAN_MONET_EXT ',
               @w_error   = 4000003      
        goto ERRORFIN
    end
*/
end

--MAPEO PARA AH_HIS_MOVIMIENTO
if @i_param1 = 'HM'
begin

    truncate table ah_his_movimiento_ext

    select
        @w_comando = @w_s_app + 's_app' +
                     ' bcp -auto -login cob_externos..ah_his_movimiento_ext in '
                     + @w_path
                     + @w_archivo +  ' -c -t"|" '
                     + '-config ' + @w_s_app + 's_app.ini'
      
    /* EJECUTAR CON CMDSHELL */
    exec @w_error = xp_cmdshell @w_comando

    if @w_error <> 0
    begin
        select @w_mensaje = 'ERROR CARGANDO ARCHIVO POR BCP ' + upper(@w_archivo)+' ',
               @w_error   = 4000003

        goto ERRORFIN
    end
/*
    select @w_contador = isnull(count(*),0) from cob_externos..ah_his_movimiento_ext
    if @w_contador = 0
    begin
        select @w_mensaje = 'NO HAY REGISTROS EN LA AH_HIS_MOVIMIENTO_EXT ',
               @w_error   = 4000003      
        goto ERRORFIN
    end
*/
end

--MAPEO PARA RE_ACCION_ND
if @i_param1 = 'AN'
begin
     
    truncate table re_accion_nd_ext

    select
        @w_comando = @w_s_app + 's_app' +
                     ' bcp -auto -login cob_externos..re_accion_nd_ext in '
                     + @w_path
                     + @w_archivo +  ' -c -t"|" '
                     + '-config ' + @w_s_app + 's_app.ini'
      
    /* EJECUTAR CON CMDSHELL */
    exec @w_error = xp_cmdshell @w_comando

    if @w_error <> 0
    begin
        select @w_mensaje = 'ERROR CARGANDO ARCHIVO POR BCP ' + upper(@w_archivo)+' ',
               @w_error   = 4000003

        goto ERRORFIN
    end
/*
    select @w_contador = isnull(count(*),0) from cob_externos..re_accion_nd_ext
    if @w_contador = 0
    begin
        select @w_mensaje = 'NO HAY REGISTROS EN LA RE_ACCION_ND_EXT ',
               @w_error   = 4000003      
        goto ERRORFIN
    end
*/
end

--MAPEO PARA AH_LINEA_PENDIENTE
if @i_param1 = 'LP'
begin
     
    truncate table ah_linea_pendiente_ext

    select
        @w_comando = @w_s_app + 's_app' +
                     ' bcp -auto -login cob_externos..ah_linea_pendiente_ext in '
                     + @w_path
                     + @w_archivo +  ' -c -t"|" '
                     + '-config ' + @w_s_app + 's_app.ini'
      
    /* EJECUTAR CON CMDSHELL */
    exec @w_error = xp_cmdshell @w_comando

    if @w_error <> 0
    begin
        select @w_mensaje = 'ERROR CARGANDO ARCHIVO POR BCP ' + upper(@w_archivo)+' ',
               @w_error   = 4000003

        goto ERRORFIN
    end
/*
    select @w_contador = isnull(count(*),0) from cob_externos..ah_linea_pendiente_ext
    if @w_contador = 0
    begin
        select @w_mensaje = 'NO HAY REGISTROS EN LA AH_LINEA_PENDIENTE_EXT ',
               @w_error   = 4000003      
        goto ERRORFIN
    end
*/
end

--MAPEO PARA RE_DETALLE_CHEQUE
if @i_param1 = 'DC'
begin
     
    truncate table re_detalle_cheque_ext

    select
        @w_comando = @w_s_app + 's_app' +
                     ' bcp -auto -login cob_externos..re_detalle_cheque_ext in '
                     + @w_path
                     + @w_archivo +  ' -c -t"|" '
                     + '-config ' + @w_s_app + 's_app.ini'
    print @w_comando
    /* EJECUTAR CON CMDSHELL */
    exec @w_error = xp_cmdshell @w_comando

    if @w_error <> 0
    begin
        select @w_mensaje = 'ERROR CARGANDO ARCHIVO POR BCP ' + upper(@w_archivo)+' ',
               @w_error   = 4000003

        goto ERRORFIN
    end
/*
    select @w_contador = isnull(count(*),0) from cob_externos..re_detalle_cheque_ext
    if @w_contador = 0
    begin
        select @w_mensaje = 'NO HAY REGISTROS EN LA RE_DETALLE_CHEQUE_EXT ',
               @w_error   = 4000003      
        goto ERRORFIN
    end
*/
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
    @i_tran_name   = 'sp_ah_carga_ext'

return @w_error
 
go
