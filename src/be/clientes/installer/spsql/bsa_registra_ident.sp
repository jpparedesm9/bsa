SET QUOTED_IDENTIFIER OFF

/****************************************************************************/
/*  Archivo:            bsa_registra_ident.sp                               */
/*  Stored procedure:   sp_bsa_registra_ident                               */
/*  Base de datos:      cobis                                               */
/*  Producto:           Clientes                                            */
/*  Disenado por:       Gisella Demera V.                                   */
/*  Fecha de documentacion: Septiembre 26, 2012                             */
/****************************************************************************/
/*              IMPORTANTE                                                  */
/*  Este programa es parte de los paquetes bancarios propiedad de           */
/*  "MACOSA", representantes exclusivos para el Ecuador de la               */
/*  "NCR CORPORATION".                                                      */
/*  Su uso no autorizado queda expresamente prohibido asi como              */
/*  cualquier alteracion o agregado hecho por alguno de sus                 */
/*  usuarios sin el debido consentimiento por escrito de la                 */
/*  Presidencia Ejecutiva de MACOSA o su representante.                     */
/****************************************************************************/
/*              PROPOSITO                                                   */
/*  Registrar hist�ricamente los cambios de identificaci�n de los clientes  */
/****************************************************************************/
/*                        MODIFICACIONES                                    */
/*  FECHA              AUTOR              RAZON                             */
/*  26-Sep-2012        Gisella Demera     Emision Inicial                   */
/****************************************************************************/
use cobis
go

if exists (select * from sysobjects where name = 'sp_bsa_registra_ident')
   drop proc sp_bsa_registra_ident
go

create proc sp_bsa_registra_ident (  
@s_ssn                 int = null,             
@s_user                login = null,
@s_sesn                int = null,
@s_term                varchar(32) = null,
@s_date                datetime = null,
@s_srv                 varchar(30) = null,
@s_lsrv                varchar(30) = null,
@s_rol                 smallint = null,
@s_ofi                 smallint = null,
@s_org_err             char(1) = null,
@s_error               int = null,
@s_sev                 tinyint = null,
@s_msg                 descripcion = null,
@s_org                 char(1) = null, 
@t_debug               char(1) = 'N',
@t_file                varchar(14) = null,
@t_from                varchar(32) = null,
@t_trn                 smallint = null,
@t_show_version        bit = 0,             --Versionamiento
-------------------------------------------------
@i_operacion           char(1) = null,      --Operacion: (I) Insert (S) Search 
@i_modo                int = null,
@i_ente                int = null,
@i_ente_sec            int = null,
@i_tipo_iden           char(4) = null,
@i_identificacion      numero = null,
@i_fecha_ini           datetime = null,
@i_fecha_fin           datetime = null,
@i_formato_fecha       int = 103
)
as
declare 
@w_sp_name           varchar(32),
@w_error             int,
@w_fecha             datetime,
@w_hora              datetime,		  
@w_nom_user          varchar(80),
@w_nombre            varchar(150),
@w_tablas            varchar(250),
@w_columnas          varchar(5000),
@w_criterio          varchar(3000),
@w_ordenamiento      varchar(250),
@w_and               varchar(10),
@w_fecha_hoy         datetime

select @w_sp_name   = 'sp_registra_ident'

--* VERSIONAMIENTO 
if @t_show_version = 1
begin
    print 'Stored procedure sp_registra_ident, Version 4.0.0.6'
    return 0
end
	   
     --* INSERTA EN EL REGISTRO
if @i_operacion = 'I' 
 begin
   --* AUTORIZACION
   if (@t_trn <> 1037) 
   begin
	   return  151051 --Transaccion no permitida--                         
                         
   end 
   ------------------------------------------------------------------------------
   --* :: P e r s o n a s   n a t u r a l e s   o   J u r � d i c a s
   ------------------------------------------------------------------------------
	--* Obtengo el nombre del usuario
   select @w_nom_user = fu_nombre 
   from cl_funcionario
   where fu_login = @s_user
   
   if @@rowcount = 0
   begin
     return 101036 --No existe funcionario-
   end
   
   --* Bitacoriza
       
   select @w_fecha = getdate()
   select @w_fecha_hoy =  fp_fecha from cobis..ba_fecha_proceso
   insert into cl_registro_identificacion(
   ri_ente,
   ri_tipo_iden,
   ri_identificacion,
   ri_fecha_act,
   ri_hora_act,
   ri_usuario,
   ri_nom_usuario)
   values(
   @i_ente,
   @i_tipo_iden,
   @i_identificacion,
   @w_fecha_hoy,
   @w_fecha,
   @s_user,
   @w_nom_user)
   
   --* Verificamos el error
   if  @@error <> 0 begin
      return 107231
   end                                               
                     
end
     
return 0

go

SET QUOTED_IDENTIFIER ON