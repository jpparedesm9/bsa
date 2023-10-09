/******************************************************************************/
/* Archivo:            sp_hp_catalogo.sp                                      */
/* Stored procedure:   sp_hp_catalogo                                         */
/* Producto:           ADMINISTRACION                                         */
/******************************************************************************/
/*                                IMPORTANTE                                  */
/* Este programa es parte de los paquetes bancarios propiedad de COBISCorp.   */
/* Su uso no autorizado queda expresamente prohibido asi como cualquier       */
/* alteracion o agregado hecho por alguno de usuarios sin el debido           */
/* consentimiento por escrito de la Presidencia Ejecutiva de COBISCorp        */
/* o su representante.                                                        */
/******************************************************************************/
/*                                PROPOSITO                                   */
/* Consulta de catalogos con multilenguaje                                    */
/******************************************************************************/
/*                               MODIFICACIONES                               */
/******************************************************************************/
/* FECHA        VERSION  AUTOR  RAZON                                         */
/******************************************************************************/
/* 14-Mar-2012  4.0.0.0  PCL    Internacionalizacion (CIB4.1.0.5)             */
/* 02-Oct-2012  4.3.0.0  PCL    Interaccion con CEN (CIB4.3.0.0)              */
/* 07-Nov-2012  4.3.0.1  PCL    Correccion defaults por oficina               */
/* 11-04-2016            BBO    Migracion Sybase-Sqlserver FAL                */
/******************************************************************************/

use cobis
go
if exists (select * from sysobjects where name = 'sp_hp_catalogo')
    drop proc sp_hp_catalogo
go
create proc sp_hp_catalogo (
    @t_show_version    BIT = 0,
    @i_tipo            char(1) = null,
    @i_tabla           varchar(30) = null,
    @i_codigo          varchar(10) = null,
    @i_oficina         int = 1,
    @i_filas           int = 80,
    @s_culture         VARCHAR(10) = 'NEUTRAL',
	@i_valorcat        varchar(64) = null
)
as
declare @w_sp_name    varchar(32)
select @w_sp_name = 'sp_hp_catalogo'

---- VERSIONAMIENTO DEL PROGRAMA ----
IF @t_show_version = 1
BEGIN
   print 'Stored procedure ' +  @w_sp_name + '  Version 4.3.0.1'
   RETURN 0
END
-------------------------------------

---- INTERNACIONALIZACION ----
EXEC sp_ad_establece_cultura
    @o_culture = @s_culture OUT
------------------------------

if @i_tipo = 'A'
begin
    set rowcount @i_filas

    SELECT RTRIM(cl_catalogo.codigo) AS codigo, CONVERT(VARCHAR(64), ISNULL(re_valor, valor)) AS valor
    FROM cl_catalogo
        INNER JOIN cl_tabla
            ON cl_catalogo.tabla = cl_tabla.codigo
        INNER JOIN ad_catalogo_i18n
            ON (cl_tabla.tabla = pc_identificador
                AND cl_catalogo.codigo = pc_codigo
                AND re_cultura = @s_culture)
    WHERE cl_tabla.tabla  = @i_tabla
        /* FCO Estado para evitar mostrar catalogos cancelados */
        AND cl_catalogo.estado = 'V'
        /* FCO isnull para mostrar por primera vez los registros */
        AND cl_catalogo.codigo > ISNULL(@i_codigo, ' ')
		and (upper(cl_catalogo.valor) like upper(@i_valorcat + '%') or @i_valorcat is null)
    set rowcount 0
    return 0
end

if @i_tipo = 'V'
begin
    SELECT ISNULL(re_valor, valor) AS valor
    FROM cl_catalogo
        INNER JOIN cl_tabla
            ON cl_catalogo.tabla = cl_tabla.codigo
        INNER JOIN ad_catalogo_i18n
            ON (cl_tabla.tabla = pc_identificador
                AND cl_catalogo.codigo = pc_codigo
                AND re_cultura = @s_culture)
    WHERE cl_tabla.tabla = @i_tabla
        AND cl_catalogo.codigo = @i_codigo
        /* FCO Estado para evitar mostrar catalogos cancelados */
        AND cl_catalogo.estado = 'V'
    if @@rowcount =  0
    begin
        --raiserror 101001 'No existe dato solicitado'
        RAISERROR ('%d %s', 16, 1, 101001, 'No existe dato solicitado')          --migracion syb-sql 15042016
    end
end

if @i_tipo = 'D'
begin
    SELECT cl_default.codigo, ISNULL(re_valor, valor) AS valor
    FROM cl_default
        INNER JOIN cl_tabla
            ON cl_default.tabla = cl_tabla.codigo
        INNER JOIN cl_default_i18n
            ON (cl_tabla.tabla = pc_identificador
                AND cl_default.codigo = pc_codigo
                AND cl_default.oficina = pc_codigo_int
                AND re_cultura = @s_culture)
    WHERE cl_tabla.tabla = @i_tabla
        AND oficina = @i_oficina
    /* FCO Junio 1999
    if @@rowcount = 0
        raiserror 101001 'No existe dato solicitado'
    */
end
return 0
go
