/************************************************************************/
/*   Archivo:             cr_res_pmax.sp                                */
/*   Stored procedure:    sp_resp_plazo_max_gar                         */
/*   Base de datos:       cob_cartera                                   */
/*   Producto:            Cartera                                       */
/*   Disenado por:        Jose Julian Cortes                            */
/*   Fecha de escritura:  Mayo - 2011                                   */
/************************************************************************/
/*                              IMPORTANTE                              */
/*   Este programa es parte de los paquetes bancarios propiedad de      */
/*   'MACOSA'                                                           */
/*   Su uso no autorizado queda expresamente prohibido asi como         */
/*   cualquier alteracion o agregado hecho por alguno de sus            */
/*   usuarios sin el debido consentimiento por escrito de la            */
/*   Presidencia Ejecutiva de MACOSA o su representante.                */
/************************************************************************/
/*                             PROPOSITO                                */
/*   Recuperar el porcentaje o el plazo en dias segun el tipo de        */
/*   de garantia                                                        */
/************************************************************************/
/*                             ACTUALIZACIONES                          */
/*                                                                      */
/*     FECHA              AUTOR            CAMBIO                       */
/*   Jun/09/11           Jose Cortes       Version inicial              */                        
/************************************************************************/

use cob_credito
go
 
if exists (select 1 from sysobjects where name = 'sp_resp_plazo_max_gar')
   drop proc sp_resp_plazo_max_gar
go

create proc sp_resp_plazo_max_gar(   
 @s_ssn               int         = null,
 @s_date              datetime    = null,
 @s_user              login       = null,
 @s_term              descripcion = null,
 @s_ofi               smallint    = null,
 @t_debug             char(1)     = 'N',
 @t_file              varchar(14) = null,
 @t_trn               smallint    = null,
 @i_tipo_garantia     varchar(10) = null,
 @i_tipo_consulta     char(1),
 @o_valor             varchar(10) = null out
)
AS
DECLARE
 @w_return           int        ,
 @w_sp_name          varchar(32),
 @w_codigo	         int
  
select @w_sp_name = 'sp_resp_plazo_max_gar'

if @t_trn = 22284 
begin
	if @i_tipo_consulta = 'T'
	begin
		if not exists(select 1 from cr_corresp_sib
              where tabla = 'T121'
		      and   codigo = @i_tipo_garantia)
		begin
			select @o_valor = '99999'
			return 0
	    end
		select @o_valor = codigo_sib from cr_corresp_sib
		where tabla = 'T121'
		and   codigo = @i_tipo_garantia

        if isnumeric(@o_valor) = 0 or @o_valor < 0
        begin 
           exec cobis..sp_cerror
	        @t_debug	 = @t_debug,
	        @t_file	     = @t_file,
	        @t_from	     = @w_sp_name,
	        @i_num	     = 2101217
	        /*  'El plazo de la garantia tiene valores no numericos o negativos. Validar tabla de correspondencia T121' */
           return 1
        end 
	end
	
	if @i_tipo_consulta = 'P'
	begin
		if not exists(select 1 from cr_corresp_sib
              where tabla = 'T119'
		      and   codigo = @i_tipo_garantia)
		begin
			select @o_valor = 'X'
			return 0
	    end
		select @o_valor = codigo_sib from cr_corresp_sib
		where tabla = 'T119'
		and   codigo = @i_tipo_garantia
	end
end
else 
begin
	 exec cobis..sp_cerror
	   @t_debug	 = @t_debug,
	   @t_file	 = @t_file,
	   @t_from	 = @w_sp_name,
	   @i_num	 = 151051
	   /*  'No corresponde codigo de transaccion' */
	   return 1
end
return 0
go