/***********************************************************************/
/*     Archivo:                sp_obtener_tablas_sincronizacion.sp     */
/*     Stored procedure:       sp_obtener_tablas_sincronizacion		   */
/*     Base de datos:          cob_sincroniza                          */
/*     Producto:               Cobis                                   */
/*     Disenado por:                                                   */
/*     Fecha de escritura:     30/Jul/2022                             */
/***********************************************************************/
/*                         IMPORTANTE                                  */
/*  Esta aplicacion es parte de los paquetes bancarios propiedad       */
/*  de COBISCorp.                                                      */
/*  Su uso no    autorizado queda  expresamente   prohibido asi como   */
/*  cualquier    alteracion o  agregado  hecho por    alguno  de sus   */
/*  usuarios sin el debido consentimiento por   escrito de COBISCorp.  */
/*  Este programa esta protegido por la ley de   derechos de autor     */
/*  y por las    convenciones  internacionales   de  propiedad inte-   */
/*  lectual.    Su uso no  autorizado dara  derecho a    COBISCorp para*/
/*  obtener ordenes  de secuestro o  retencion y para  perseguir       */
/*  penalmente a los autores de cualquier   infraccion.                */
/***********************************************************************/
/*                              PROPOSITO                              */
/*     Este programa obtiene las tablas de catalogo con su fecha a     */
/*     sincronizar                                                     */
/***********************************************************************/
/*                              MODIFICACIONES                         */
/*     FECHA             AUTOR                 RAZON                   */
/*     30/Jul/2022       srojas                Emision inicial         */
/***********************************************************************/

use cob_sincroniza
go

if object_id('sp_obtener_tablas_sincronizacion') is not null
begin
    drop procedure sp_obtener_tablas_sincronizacion
end
go


create proc sp_obtener_tablas_sincronizacion(
  @s_ssn            int         = NULL,
  @s_user           login       = NULL,
  @s_term           varchar(32) = NULL,
  @s_date           datetime    = NULL,
  @s_sesn           int         = NULL,
  @s_culture        varchar(10) = NULL,
  @s_srv            varchar(30) = NULL,
  @s_lsrv           varchar(30) = NULL,
  @s_ofi            smallint    = NULL,
  @s_rol            smallint    = NULL,
  @s_org_err        char(1)     = NULL,
  @s_error          int         = NULL,
  @s_sev            tinyint     = NULL,
  @s_msg            descripcion = NULL,
  @s_org            char(1)     = NULL,
  @t_debug          char(1)     = 'N',
  @t_file           varchar(10) = null,
  @t_from           varchar(32) = null,
  @t_trn            smallint    = null,
  @t_show_version   bit         = 0,
  @i_operacion      char(1)     = 'Q',              -- Opcion con la que se ejecuta el programa
  @i_mac 			varchar(30) = null,
  @i_mac1 			varchar(30) = null,
  @i_mac2 			varchar(30) = null,
  @i_reference1 	varchar(50) = null,
  @i_reference2 	varchar(50) = null

)
as
declare @w_sp_name                    varchar(32),
		@w_num_error                  int,
		@w_count                      int

select @w_sp_name = 'sp_obtener_tablas_sincronizacion'
/*--VERSIONAMIENTO--*/
if @t_show_version = 1
   begin
      print 'Stored procedure ' + @w_sp_name + ' Version 1.0.0.0'
      return 0
   end
/*--FIN DE VERSIONAMIENTO--*/
 
/*search*/
if @i_operacion = 'Q'
begin

  SELECT 'Nombre Catalogo'      = sc_catalog_name,
  		 'Fecha Sincronizacion' = sc_synchronization_date
  from si_catalog_synchronization   
  
END


RETURN 0

ERROR:
    EXEC cobis..sp_cerror
        @t_from  = @w_sp_name,
        @i_num   = @w_num_error

    RETURN 1
GO