/*************************************************************************/
/*   Archivo:            fn_filtra_diacriticos.sp                        */
/*   Stored procedure:   fn_filtra_diacriticos                           */
/*   Base de datos:      cobis                                           */
/*   Producto:           Clientes                                        */
/*   Disenado por:       KVI                                             */
/*   Fecha de escritura: Mayo 2023                                       */
/*************************************************************************/
/*                       IMPORTANTE                                      */
/*   Este programa es parte de los paquetes bancarios propiedad de       */
/*   'COBIS'.                                                            */
/*   Su uso no autorizado queda expresamente prohibido asi como          */
/*   cualquier alteracion o agregado hecho por alguno de sus             */
/*   usuarios sin el debido consentimiento por escrito de la             */
/*   Presidencia Ejecutiva de COBIS o su representante legal.            */
/*************************************************************************/
/*                       PROPOSITO                                       */
/*   Eliminar tildes y diacriticos en una palabra                        */
/*************************************************************************/
/*                       MODIFICACIONES                                  */
/*   FECHA       AUTOR                       RAZON                       */
/*   11/05/2023  KVI     Emision Inicial - Caso193221                    */
/*************************************************************************/
use cobis
go

if exists(select 1 from sysobjects where name = 'fn_filtra_diacriticos')
   drop function fn_filtra_diacriticos
go

create function fn_filtra_diacriticos(
    @i_cadena    varchar(200)
)
returns varchar(200)
as

begin
    select @i_cadena = ltrim(rtrim(upper(@i_cadena)))
    
    select @i_cadena = replace(@i_cadena,'Ý','Y')
    
    select @i_cadena = replace(@i_cadena,'À','A')
    select @i_cadena = replace(@i_cadena,'Á','A')
    select @i_cadena = replace(@i_cadena,'Â','A')
    select @i_cadena = replace(@i_cadena,'Ã','A')
    select @i_cadena = replace(@i_cadena,'Ä','A')
    select @i_cadena = replace(@i_cadena,'Å','A')
    select @i_cadena = replace(@i_cadena,'Æ','A')

    select @i_cadena = replace(@i_cadena,'È','E')
    select @i_cadena = replace(@i_cadena,'É','E')
    select @i_cadena = replace(@i_cadena,'Ê','E')
    select @i_cadena = replace(@i_cadena,'Ë','E')

    select @i_cadena = replace(@i_cadena,'Ì','I')
    select @i_cadena = replace(@i_cadena,'Í','I')
    select @i_cadena = replace(@i_cadena,'Î','I')
    select @i_cadena = replace(@i_cadena,'Ï','I')

    select @i_cadena = replace(@i_cadena,'Ò','O')
    select @i_cadena = replace(@i_cadena,'Ó','O')
    select @i_cadena = replace(@i_cadena,'Ô','O')
    select @i_cadena = replace(@i_cadena,'Õ','O')
    select @i_cadena = replace(@i_cadena,'Ö','O')

    select @i_cadena = replace(@i_cadena,'Ù','U')
    select @i_cadena = replace(@i_cadena,'Ú','U')
    select @i_cadena = replace(@i_cadena,'Û','U')
    select @i_cadena = replace(@i_cadena,'Ü','U')
    
    return (@i_cadena)
    
end

go

