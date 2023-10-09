/******************************************************************************/
/*  Archivo:                sp_cerror.sp                                      */
/*  Stored procedure:       sp_cerror                                         */
/*  Base de datos:          cobis                                             */
/*  Producto:               Clientes                                          */
/*  Disenado por:           Mauricio Bayas/Sandra Ortiz                       */
/*  Fecha de documentacion: 17/Nov/93                                         */
/******************************************************************************/
/*                                 IMPORTANTE                                 */
/* Este programa es parte de los paquetes bancarios propiedad de COBISCorp.   */
/* Su uso no autorizado queda expresamente prohibido asi como cualquier       */
/* alteracion o agregado hecho por alguno de usuarios sin el debido           */
/* consentimiento por escrito de la Presidencia Ejecutiva de COBISCorp        */
/* o su representante.                                                        */
/******************************************************************************/
/*                                PROPOSITO                                   */
/* Despliega un mensaje de error de acuerdo al codigo ingresado o al mensaje  */
/* ingresado por el usuario                                                   */
/******************************************************************************/
/*                             MODIFICACIONES                                 */
/******************************************************************************/
/* FECHA        VERSION  AUTOR         RAZON                                  */
/******************************************************************************/
/* 17-Nov-1993           R. Minga V.   Documentacion                          */
/* 04-May-1994           F.Espinosa    Parametros tipo 'S'                    */
/* 20-Mar-2012  4.0.0.0  PCL           Internacionalizacion (CIB4.1.0.5)      */
/* 02-Oct-2012  4.3.0.0  PCL           Interaccion con CEN (CIB4.3.0.0)       */
/* 20-May-2015  4.6.0.0  PCL           Versión para SQL Server 2012           */
/******************************************************************************/
use cobis
go

SET ANSI_NULLS OFF
GO

if exists (select * from sysobjects where name = 'sp_cerror')
    drop proc sp_cerror
go

create proc sp_cerror (
    @s_ssn          int = NULL,
    @s_user         login = NULL,
    @s_sesn         int = NULL,
    @s_term         varchar(30) = NULL,
    @s_date         datetime = NULL,
    @s_srv          varchar(30) = NULL,
    @s_lsrv         varchar(30) = NULL,
    @s_rol          smallint = NULL,
    @s_ofi          smallint = NULL,
    @s_org_err      char(1) = NULL,
    @s_error        int = NULL,
    @s_sev          tinyint = NULL,
    @s_msg          descripcion = NULL,
    @s_org          char(1) = NULL,
    @s_culture      VARCHAR(10) = 'NEUTRAL',
    @t_debug        char(1) = 'N',
    @t_file         varchar(30) = null,
    @t_from         varchar(30) = null,
    @t_show_version BIT = 0,
    @i_num          int = NULL,
    @i_sev          int = null,
    @i_msg          varchar(132) = null)
as
declare
    @w_return           int,
    @w_sp_name          varchar(30),
    @w_etiqueta_i18n    VARCHAR(255),
	@w_msg				VARCHAR(132)

select @w_sp_name = 'sp_cerror'

---- VERSIONAMIENTO DEL PROGRAMA ----
IF @t_show_version = 1
BEGIN
   PRINT 'Stored procedure ' + @w_sp_name + ', Version 4.6.0.0'
   RETURN 0
END
-------------------------------------

---- INTERNACIONALIZACION ----
EXEC sp_ad_establece_cultura
    @o_culture = @s_culture OUT
------------------------------

SELECT  @w_etiqueta_i18n = ISNULL(re_valor, 'No hay mensaje asociado')
FROM    ad_etiqueta_i18n
WHERE   pc_identificador    = 'c-cobis'
AND     pc_codigo           = 'NO_MENSAJE'
AND     re_cultura          = UPPER(@s_culture)

/* Si el usuario, no envia su propio mensaje, buscarlo en la tabla */
if (@i_msg is null)
begin
     select @i_sev = severidad,
        @w_msg = '[' + convert(varchar,@i_num) + '] [' + @t_from + ']  ' + re_valor
     from cl_errores
        INNER JOIN ad_error_i18n
            ON (numero = pc_codigo_int
                AND re_cultura = UPPER(@s_culture))
     where numero = @i_num
     if @@rowcount != 1
     begin
      select @w_msg = '[' + convert(varchar,@i_num) + '] [' + @t_from + ']  ' + @w_etiqueta_i18n
      select @i_sev = 0
     end
end
else
	select @w_msg = '[' + convert(varchar,@i_num) + '] ' + @i_msg


/* Desplegar el numero y el mensaje en pantalla, e indicar al sistema
   que un error ha ocurrido */
raiserror (@w_msg, 16, 1)

/* si la severidad es cero, solo se despliega el mensaje, si es uno
   se realiza un rollback de las transacciones */

if @i_sev = 0
   return
else
   if @i_sev = 1
      rollback tran
return
go
