use cobis
go
/* **********************************************************************/
/*      Archivo           : sp_generar_curp.sp                          */
/*      Stored procedure  : sp_generar_curp                             */
/*      Base de datos     : cobis                                       */
/*      Producto          : Clientes                                    */
/*      Disenado por      : LGU                                         */
/*      Fecha de escritura: 14-Jun-2017                                 */
/* **********************************************************************/
/*                          IMPORTANTE                                  */
/*  Esta aplicacion es parte de los paquetes bancarios propiedad        */
/*  de 'COBISCorp'.                                                     */
/*  Su uso no    autorizado queda  expresamente   prohibido asi como    */
/*  cualquier    alteracion o  agregado  hecho por    alguno  de sus    */
/*  usuarios sin el debido consentimiento por   escrito de COBISCorp.   */
/*  Este programa esta protegido por la ley de   derechos de autor      */
/*  y por las    convenciones  internacionales   de  propiedad inte-    */
/*  lectual.    Su uso no  autorizado dara  derecho a    COBISCorp para */
/*  obtener ordenes  de secuestro o  retencion y para  perseguir        */
/*  penalmente a los autores de cualquier   infraccion.                 */
/************************************************************************/
/*                           PROPOSITO                                  */
/*  Para calcular el CURP y RFC (mexico), elimina acentos               */
/* **********************************************************************/
/*                             MODIFICACIONES                           */
/*      FECHA            AUTOR                RAZON                     */
/*   14/Jun/2017      LGU                  Emision inicial              */
/*   20/Ene/2020      ACH                  Se a�ade parametro por caso  */
/*                                         #133126 en fn_filtra_acentos */
/*   17/Abr/2023      WTO                  Version productiva           */
/************************************************************************/
if exists(select 1 from sysobjects where name = 'fn_filtra_acentos')
   drop function fn_filtra_acentos
go

create function fn_filtra_acentos(
    @i_cadena    varchar(200)
)
returns varchar(200)
as

begin
    SELECT @i_cadena = ltrim(rtrim(upper(@i_cadena)))

    --select @i_cadena = replace(@i_cadena,'�','X')--Se va a tratar en el java

    select @i_cadena = replace(@i_cadena,'�','Y')
    
    select @i_cadena = replace(@i_cadena,'�','A')
    select @i_cadena = replace(@i_cadena,'�','A')
    select @i_cadena = replace(@i_cadena,'�','A')
    select @i_cadena = replace(@i_cadena,'�','A')
    select @i_cadena = replace(@i_cadena,'�','A')
    select @i_cadena = replace(@i_cadena,'�','A')
    select @i_cadena = replace(@i_cadena,'�','A')

    select @i_cadena = replace(@i_cadena,'�','E')
    select @i_cadena = replace(@i_cadena,'�','E')
    select @i_cadena = replace(@i_cadena,'�','E')
    select @i_cadena = replace(@i_cadena,'�','E')

    select @i_cadena = replace(@i_cadena,'�','I')
    select @i_cadena = replace(@i_cadena,'�','I')
    select @i_cadena = replace(@i_cadena,'�','I')
    select @i_cadena = replace(@i_cadena,'�','I')

    select @i_cadena = replace(@i_cadena,'�','O')
    select @i_cadena = replace(@i_cadena,'�','O')
    select @i_cadena = replace(@i_cadena,'�','O')
    select @i_cadena = replace(@i_cadena,'�','O')
    select @i_cadena = replace(@i_cadena,'�','O')

    select @i_cadena = replace(@i_cadena,'�','U')
    select @i_cadena = replace(@i_cadena,'�','U')
    select @i_cadena = replace(@i_cadena,'�','U')
    select @i_cadena = replace(@i_cadena,'�','U')
    
    return (@i_cadena)
    
end

go



