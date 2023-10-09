/************************************************************************/
/*   Archivo:              sp_relacion_cliente_cons.sp                  */
/*   Stored procedure:     sp_relacion_cliente_cons                     */
/*   Base de datos:        cobis                                        */
/*   Producto:             CLIENTE                                      */
/*   Disenado por:         PXSG                                         */
/*   Fecha de escritura:   09/08/2017                                   */
/************************************************************************/
/*                               IMPORTANTE                             */
/*   Este programa es parte de los paquetes bancarios propiedad de      */
/*   'MACOSA'.                                                          */
/*   Su uso no autorizado queda expresamente prohibido asi como         */
/*   cualquier alteracion o agregado hecho por alguno de sus            */
/*   usuarios sin el debido consentimiento por escrito de la            */
/*   Presidencia Ejecutiva de MACOSA o su representante.                */
/************************************************************************/
/*                                PROPOSITO                             */
/************************************************************************/
/*                               CAMBIOS                                */
/*      FECHA          AUTOR            CAMBIO                          */
/*      09/08/2017     PXSG             Emision Inicial                 */
/*      09/08/2017     P. Ortiz         Devolucion Cliente Relacionado  */
/************************************************************************/
USE cobis
go
IF OBJECT_ID ('dbo.sp_relacion_cliente_cons') IS NOT NULL
	DROP PROCEDURE dbo.sp_relacion_cliente_cons
GO

create procedure sp_relacion_cliente_cons (
   @s_ssn                  int             = null,
   @s_user                 login           = null,
   @s_term                 varchar(32)     = null,
   @s_date                 datetime        = null,
   @s_srv                  varchar(30)     = null,
   @s_lsrv                 varchar(30)     = null,
   @s_ofi                  smallint        = null,
   @s_rol                  smallint        = null,
   @s_org_err              char(1)         = null,
   @s_error                int             = null,
   @s_sev                  tinyint         = null,
   @s_msg                  descripcion     = null,
   @s_org                  char(1)         = null,
   @t_debug                char(1)         = 'N',
   @t_file                 varchar(10)     = null,
   @t_from                 varchar(32)     = null,
   @t_trn                  int        = null,
   @i_operacion            char(1),
   @i_ente                 int             = null,
   @i_tipo                 char(1)         = null,
   @i_nit                  numero          = null,
   @i_formato_fecha        int             = null,
   @t_show_version         bit             = 0,
   @s_sesn	               int 	           = NULL,
   @i_grupo                INT             =NULL
)
as
declare 
  @w_today                        datetime,
  @w_sp_name                      varchar(32),
  @w_rfc                          numero,
  @w_relacion                     SMALLINT,
  @w_desc_relacion                VARCHAR(64)
   

-------------------------------------------
---VERSIONAMIENTO PROGRAMA-----------------
-------------------------------------------
if @t_show_version = 1
begin
    print 'Stored procedure sp_relacion_cliente_cons, Version 4.0.0.19'
    return 0
end

select @w_today = @s_date
select @w_sp_name = 'sp_relacion_cliente_cons'
if @t_trn != 7067120
BEGIN
exec sp_cerror
               @t_debug      = @t_debug,
               @t_file       = @t_file,
               @t_from       = @w_sp_name,
               @i_num        = 151051
               --NO CORRESPONDE CODIGO DE TRANSACCION
            return 1
END 
if @i_operacion = 'Q' --CONSULTA DE DATOS DE PERSONA
   begin   
        SELECT 
         'idEnte' = en_ente,
         'rfc' = en_nit, 
         'relacion' = in_relacion,
         'desc_relacion' = (select re_descripcion from cobis..cl_relacion where I.in_relacion = re_relacion)
        from cobis..cl_instancia I, cobis..cl_ente
         where in_ente_i = @i_ente
         AND in_ente_d = en_ente
         and in_ente_d IN (SELECT cg_ente FROM cobis..cl_cliente_grupo WHERE cg_grupo = @i_grupo)
         AND in_relacion IN (select re_relacion from cobis..cl_relacion)
   end
return 0

GO