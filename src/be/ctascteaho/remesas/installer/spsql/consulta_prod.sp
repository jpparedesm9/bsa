/****************************************************************************/
/*     Archivo:     consulta_prod.sp                                        */
/*     Stored procedure: sp_consulta_prod                                   */
/*     Base de datos: cob_remesas                                           */
/*     Producto: Personalizacion                                            */
/*     Disenado por:    Jorge Baque                                         */
/*     Fecha de escritura: 13/May/2016                                      */
/****************************************************************************/
/*                            IMPORTANTE                                    */
/*    Esta aplicacion es parte de los paquetes bancarios propiedad          */
/*    de COBISCorp.                                                         */
/*    Su uso no    autorizado queda  expresamente   prohibido asi como      */
/*    cualquier    alteracion o  agregado  hecho por    alguno  de sus      */
/*    usuarios sin el debido consentimiento por   escrito de COBISCorp.     */
/*    Este programa esta protegido por la ley de   derechos de autor        */
/*    y por las    convenciones  internacionales   de  propiedad inte-      */
/*    lectual.    Su uso no  autorizado dara  derecho a    COBISCorp para   */
/*    obtener ordenes  de secuestro o  retencion y para  perseguir          */
/*    penalmente a los autores de cualquier   infraccion.                   */
/****************************************************************************/
/*                           PROPOSITO                                      */
/*                                                                          */
/****************************************************************************/
/*                           MODIFICACIONES                                 */
/*       FECHA          AUTOR           RAZON                               */
/*     13/May/2016     Jorge Baque     Migracion a CEN                      */
/****************************************************************************/
USE cob_remesas
GO

if exists (select
             1
           from   sysobjects
           where  name = 'sp_consulta_prod')
  drop proc sp_consulta_prod
go

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
create proc sp_consulta_prod (
        @s_ssn          int,
        @s_srv          varchar(30),
        @s_lsrv         varchar(30),
        @s_user         varchar(30),
        @s_sesn         int=null,
        @s_term         varchar(10),
        @s_date         datetime,
        @s_ofi          smallint,       
        @s_rol          smallint,
        @s_org_err      char(1) = null,
        @s_error        int     = null,
        @s_sev          tinyint = null,
        @s_msg          mensaje = null,
        @s_org          char(1),
        @t_corr         char(1) = 'N',
        @t_ssn_corr     int = null,   
        @t_debug        char(1) = 'N',
        @t_file         varchar(14) = null,
        @t_from         varchar(32) = null,
        @t_rty          char(1) = 'N',
        @t_trn          smallint,
        @i_producto     int = 0, 
        @i_ope          char(2) = 'A',
        @i_codigo		   varchar(10) = null      
)
as
declare	@w_return	int,
        @w_sp_name       varchar(64)

/*  Captura nombre de Stored Procedure  */
select	@w_sp_name = 'sp_consulta_prod'

/* Seleccionar todos los productos */

if @i_ope = 'B'
begin
   select 'CODIGO'   = pd_producto,
          'NOMBRE'   = substring(pd_descripcion, 1, 25)
   from cobis..cl_producto
   where pd_tipo = 'R'
   return 0
end  

/* Selecciona las transacciones asociadas a un producto */

if @i_ope = 'B1'
begin
   
   /*selecciona la trx */
   
   select cl_catalogo.valor, biometrico.codigo
   into   #trx_validas
   from cobis..cl_tabla, cobis..cl_catalogo, (select cl_catalogo.codigo
                                              from cobis..cl_tabla, cobis..cl_catalogo
                                              where cl_tabla.tabla = 'cl_transac_valida'
                                              and   cl_catalogo.tabla = cl_tabla.codigo
                                              and   cl_catalogo.estado = 'V') as biometrico
   where cl_tabla.tabla = 'cl_trn_central_local'
   and   cl_catalogo.tabla = cl_tabla.codigo
   and   cl_catalogo.codigo = biometrico.codigo

   
   set rowcount 20

   select 'CODIGO'   = #trx_validas.codigo,
          'NOMBRE'   = substring(tn_descripcion, 1, 25)
   from   cobis..cl_ttransaccion, cobis..ad_pro_transaccion, #trx_validas
   where  tn_trn_code       = pt_transaccion
   and    pt_producto       = @i_producto
   and    pt_estado         = 'V'
   and    tn_trn_code       = #trx_validas.valor
   and    #trx_validas.codigo > isnull(@i_codigo, 0)
   order by tn_trn_code
   
   set rowcount 0
   return 0
end

if @i_ope = 'V1'
begin
    select 'NOMBRE' = pd_descripcion
      from cobis..cl_producto
     where pd_producto = @i_producto
       and pd_tipo     = 'R'

    if @@rowcount = 0
      begin
        /* No existe cheque de camara */
        exec cobis..sp_cerror
             @t_debug     = @t_debug,
             @t_file      = @t_file,
             @t_from      = @w_sp_name,
             @i_num       = 101001
        return 1
      end
      return 0
end

if @i_ope = 'V2'
begin

   select cl_catalogo.valor, biometrico.codigo
   into   #trx_validas1
   from cobis..cl_tabla, cobis..cl_catalogo, (select cl_catalogo.codigo
                                              from cobis..cl_tabla, cobis..cl_catalogo
                                              where cl_tabla.tabla = 'cl_transac_valida'
                                              and   cl_catalogo.tabla = cl_tabla.codigo
                                              and   cl_catalogo.estado = 'V') as biometrico
   where cl_tabla.tabla = 'cl_trn_central_local'
   and   cl_catalogo.tabla = cl_tabla.codigo
   and   cl_catalogo.codigo = biometrico.codigo

   select 'NOMBRE'   = tn_descripcion
   from   cobis..cl_ttransaccion, cobis..ad_pro_transaccion, #trx_validas1
   where  tn_trn_code       = pt_transaccion
   and    pt_producto       = @i_producto
   and    pt_estado         = 'V'
   and    tn_trn_code       = #trx_validas1.valor
   and    #trx_validas1.codigo = @i_codigo

   if @@rowcount <> 1
      begin
        /* No existe cheque de camara */
        exec cobis..sp_cerror
             @t_debug     = @t_debug,
             @t_file      = @t_file,
             @t_from      = @w_sp_name,
             @i_num       = 101001
        return 1
      end
   return 0
end

if @i_ope = 'A'
  begin

    select 'CODIGO'   = pd_producto,
           'NOMBRE'   = substring(pd_descripcion, 1, 25)
      from cobis..cl_producto
     where pd_producto in (3,4,10)
       and pd_tipo = 'R'

  end
else
  begin

    if @i_producto not in (3, 4, 10,13)
      begin
        /* No existe cheque de camara */
        exec cobis..sp_cerror
             @t_debug     = @t_debug,
             @t_file      = @t_file,
             @t_from      = @w_sp_name,
             @i_num       = 101001
        return 1
      end

    select 'NOMBRE' = substring(pd_descripcion, 1, 25)
      from cobis..cl_producto
     where pd_producto = @i_producto
       and pd_tipo     = 'R'

    if @@rowcount = 0
      begin
        /* No existe cheque de camara */
        exec cobis..sp_cerror
             @t_debug     = @t_debug,
             @t_file      = @t_file,
             @t_from      = @w_sp_name,
             @i_num       = 101001
        return 1
      end
  end

return 0

