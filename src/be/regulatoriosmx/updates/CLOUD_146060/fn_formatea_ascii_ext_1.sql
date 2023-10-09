/************************************************************************/
/*      Archivo:                fn_formatea_ascii_ext_1.sql             */
/*      Base de datos:          cob_conta_super                         */
/*      Producto:		        Contabilidad                            */
/*      Disenado por:           Juan Sarzosa                            */
/*      Fecha de escritura:	    09/09/2020                              */
/************************************************************************/
/*                              IMPORTANTE                              */
/*      Este programa es parte de los paquetes bancarios propiedad de   */
/*      "COBISCORP", representantes exclusivos para el Ecuador de la    */
/*      "COBISCORP CORPORATION".                                        */
/*      Su uso no autorizado queda expresamente prohibido asi como      */
/*      cualquier alteracion o agregado hecho por alguno de sus         */
/*      usuarios sin el debido consentimiento por escrito de la         */
/*      Presidencia Ejecutiva de COBISCORP o su representante.          */
/************************************************************************/
/*                              PROPOSITO                               */
/*	    Optimizacion Batch, para evitar que se genere tracert por       */
/*	    Auditoria C2, en lugar de realizar select sobre tabla           */
/*	    sb_equivalencias, se hace sobre la variable de entrada tipo     */
/*	    tabla @w_equivalencias                                          */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*      FECHA           AUTOR           RAZON                           */
/*      09/09/2020      J Sarzosa       Optimizacion Batch              */
/************************************************************************/

USE cob_conta_super
GO

IF EXISTS (SELECT * FROM sysobjects WHERE name = 'fn_formatea_ascii_ext_1')
BEGIN
   EXEC ('drop function fn_formatea_ascii_ext_1')
END
GO

IF EXISTS (SELECT 1 FROM systypes WHERE name = 'equivalencias')
BEGIN
   EXEC ('drop type equivalencias')
END
GO

CREATE TYPE equivalencias AS TABLE
(
eq_catalogo VARCHAR(10),
eq_valor_cat varchar(64),
eq_valor_arch varchar (64),
eq_descripcion varchar (64),eq_estado CHAR(1)
)
GO

create function fn_formatea_ascii_ext_1(
   @w_equivalencias equivalencias READONLY,
   @w_valor_str varchar(255),
   @w_tipo char(2)
)
returns varchar(255)
begin
declare
   @w_cadena   varchar(255),
   @w_cad_ant  varchar(255),
   @w_cont     int

   if @w_valor_str is not null
   begin
      select @w_cont = 1, @w_cadena = ltrim(rtrim(@w_valor_str))
   end
   
   while len(@w_cadena) >= @w_cont
   begin
      select @w_cad_ant = @w_cadena
      if exists(select eq_valor_cat
                  from @w_equivalencias
                 where eq_catalogo  = 'CHAR_ASCII' 
                   and eq_valor_cat = substring(@w_cadena,@w_cont,1)
                   and eq_estado    = 'V')
      begin
         select @w_cadena = replace(@w_cadena, eq_valor_cat, (case @w_tipo when 'A' then eq_valor_arch when 'AN' then eq_descripcion end))
           from @w_equivalencias
          where eq_catalogo = 'CHAR_ASCII' 
            and eq_valor_cat = substring(@w_cadena,@w_cont,1)
            and eq_estado = 'V'
      end
      else
      begin
         select @w_cadena = replace(@w_cadena,substring(@w_cadena,@w_cont,1),'')
      end
      if len(@w_cad_ant) = len(@w_cadena)
      begin
         select @w_cont = @w_cont + 1
      end
   end

   return @w_cadena
end
GO

