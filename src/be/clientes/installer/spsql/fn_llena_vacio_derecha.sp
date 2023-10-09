/*************************************************************************/
/*   Archivo:              fn_llena_vacio_derecha.sp                     */
/*   Function:             fn_llena_vacio_derecha                        */
/*   Base de datos:        cobis                                         */
/*   Producto:             Regulatorios                                  */
/*   Disenado por:         Dario Cumbal - Daniel Berrio                  */
/*   Fecha de escritura:   Abril 2022                                    */
/*************************************************************************/
/*                                  IMPORTANTE                           */
/*   Este programa es parte de los paquetes bancarios propiedad de       */
/*   'COBIS'.                                                            */
/*   Su uso no autorizado queda expresamente prohibido asi como          */
/*   cualquier alteracion o agregado hecho por alguno de sus             */
/*   usuarios sin el debido consentimiento por escrito de la             */
/*   Presidencia Ejecutiva de COBIS o su representante legal.            */
/*************************************************************************/
/*                                   PROPOSITO                           */
/*   Función que le agrega espacios vacios a la derecha de un varchar    */
/*   hasta que complete un ancho indicado por el parámetro lenght        */
/*                                                                       */
/*       Parametros de Entrada                                           */
/*			cadena                                                       */
/*          tamaño final de la cadena con ' '                            */
/*************************************************************************/
/*                             MODIFICACION                              */
/*    FECHA                 AUTOR                 RAZON                  */
/*    27/Abril/2022          DBM              emision inicial            */
/*************************************************************************/

USE cobis
GO


IF OBJECT_ID ('dbo.fn_llena_vacio_derecha') IS NOT NULL
	DROP function dbo.fn_llena_vacio_derecha
GO

CREATE function fn_llena_vacio_derecha
(
@i_cadena    varchar(250),
@i_lenght        int
)
returns varchar(250)
as
begin
  RETURN convert(varchar(250),convert(varchar(250),ltrim(rtrim(@i_cadena))) + replicate (' ',(@i_lenght - len(ltrim(rtrim(@i_cadena))))))
END
GO
