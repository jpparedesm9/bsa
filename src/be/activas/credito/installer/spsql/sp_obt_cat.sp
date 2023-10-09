/* ************************************************************************/
/*    Archivo:                sp_obt_cat.sp                               */
/*    Stored procedure:       sp_obtener_catalogo                         */
/*    Base de datos:          cob_credito                                 */
/*    Producto:               Credito                                     */
/*    Disenado por:           Adriana Chiluisa                            */
/*    Fecha de escritura:     13-Jun-2017                                 */
/* ************************************************************************/
/*                              IMPORTANTE                                */
/*    Este programa es parte de los paquetes bancarios propiedad de       */
/*    "MACOSA", representantes exclusivos para el Ecuador de la           */
/*    "NCR CORPORATION".                                                  */
/*    Su uso no autorizado queda expresamente prohibido asi como          */
/*    cualquier alteracion o agregado hecho por alguno de sus             */
/*    usuarios sin el debido consentimiento por escrito de la             */
/*    Presidencia Ejecutiva de MACOSA o su representante.                 */
/**************************************************************************/
/*                              PROPOSITO                                 */
/*    Este programa procesa las transacciones del stored procedure        */
/*    Insercion de grupo                                                  */
/*    Actualizacion de grupo                                              */
/*    Permite obtener la información de catalogos                         */
/**************************************************************************/
/*                              MODIFICACIONES                            */
/*    FECHA           AUTOR                RAZON                          */
/*    22/Mar/2017     ACH       Version Inicial                           */
/*    17/Ago/2021     KVI       Op. Q - Req. 162647                       */
/*    22/Jul/2021     ACH       Caso#162288-Query Plazo segun frecuencia  */
/*    10/Abr/2023     KVI       Req203379-Query plazo segun seguro y prod */
/*    09/Ago/2023     FRE       Req211113-Contratación de asistencias C.I.*/
/* ************************************************************************/

use cob_credito
go

if exists (select 1 from sysobjects where name = 'sp_obtener_catalogo')
   drop proc sp_obtener_catalogo
go
IF OBJECT_ID ('dbo.sp_obtener_catalogo') IS NOT NULL
	DROP PROCEDURE dbo.sp_obtener_catalogo
GO

create proc sp_obtener_catalogo (
	@s_ssn			int         = null,
	@s_user			login       = null,
	@s_sesn			int         = null,
	@s_term			varchar(32) = null,
	@s_date			datetime    = null,
	@s_srv			varchar(30) = null,
	@s_lsrv			varchar(30) = null, 
	@s_rol			smallint    = null,
	@s_ofi			smallint    = null,
	@s_org_err		char(1)     = null,
	@s_error		int         = null,
	@s_sev			tinyint     = null,
	@s_msg			descripcion = null,
	@s_org			char(1)     = null,
	@t_debug		char(1)     = 'N',
	@t_file			varchar(14) = null,
	@t_from			varchar(32) = null,
	@t_trn			smallint    = null,
	@i_operacion 	varchar(2), 
	@i_modo      	tinyint     = null,
	@i_tipo      	varchar(1)  = null,
	@i_plazo        int         = null,
	@i_filtro       varchar(30) = null,
	@i_frecuencia   char(10)    = null,
	@i_producto     varchar(10) = null,  --Req203379
	@i_tramite		int			= null  --Req211113
)

as

declare @w_return         int,
        @w_sp_name        varchar(32),
        @w_tipo_plazo	    char(2), --Req211113
        @w_plazo		      smallint,
        @w_tiempo		      int,
        @w_periodo_cap		int

select @w_sp_name = 'sp_obtener_catalogo'

/* Search */
if @i_operacion = 'S' 
begin
if @t_trn = 21743
begin
    set rowcount 20
    if @i_modo = 0
        begin
		    if @i_tipo = 'P'
			begin
                select 'CODIGO' = C.codigo, 
		               'VALOR' = C.valor 
		        from   cobis..cl_tabla T, cobis..cl_catalogo C
                where  T.tabla  = 'cr_plazo_ind'
                and    T.codigo = C.tabla
                order by convert(int,C.codigo)    
                 
                if @@rowcount = 0
                exec cobis..sp_cerror
                     @t_debug = @t_debug,
                     @t_file  = @t_file,
                     @t_from  = @w_sp_name,
                     @i_num   = 101000 /*'No existe dato en catalogo'*/				
			end
		    else if @i_tipo = 'T'
			begin
                select 'CODIGO' = convert(char(10), pi_plazo),
		               'VALOR' = convert(varchar(10), pi_plazo)
		        from cr_plazo_ind
                where pi_frecuencia = @i_frecuencia
                 
                if @@rowcount = 0
                exec cobis..sp_cerror
                     @t_debug = @t_debug,
                     @t_file  = @t_file,
                     @t_from  = @w_sp_name,
                     @i_num   = 101000 /*'No existe dato en catalogo'*/				
			end			
	    end
		
     set rowcount 0
     return 0
end
else
begin
    exec cobis..sp_cerror
       @t_debug   = @t_debug,
       @t_file    = @t_file,
       @t_from    = @w_sp_name,
       @i_num     = 151051
       /*  'No corresponde codigo de transaccion' */
    return 1
end
end

/* Consulta todos los registros vigentes de catalogo*/
if @i_operacion = 'Q' 
begin
  if @t_trn = 21744
  begin
    if @i_tipo = 'C'
    begin
      if @i_modo = 0	
      begin    		    
        select 'CODIGO' = C.codigo, 
  	           'VALOR' = C.valor 
  	    from   cobis..cl_tabla T, cobis..cl_catalogo C
        where  T.tabla  = @i_filtro--'cl_hab_func_consulta_cuenta'
        and    T.codigo = C.tabla
        and    C.estado = 'V'
        order by convert(int,C.codigo)    
         
        if @@rowcount = 0
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 101000 /*'No existe dato en catalogo'*/				
  	  end
  	end
	else if @i_tipo = 'P' --Req203379
    begin
      if @i_modo = 0	
      begin
        --Req211113
        select @w_tipo_plazo = op_tplazo, @w_plazo = op_plazo, @w_periodo_cap = op_periodo_cap from cob_cartera..ca_operacion where op_tramite = @i_tramite
      
        if @w_periodo_cap = 2 and @w_tipo_plazo = 'W'
          select @w_tipo_plazo = 'BW'
        
        select 
          @w_tiempo = case 
                        when @w_tipo_plazo = 'D' then round(convert(float,@w_plazo)/30,0)
                        when @w_tipo_plazo = 'W' then round(convert(float,@w_plazo) * 7 /30,0)
                        when @w_tipo_plazo = 'BW' then round(convert(float,@w_plazo) * 14 /30,0)
                        when @w_tipo_plazo = 'Q' then round(convert(float,@w_plazo) /2,0)
                        when @w_tipo_plazo = 'M' then round(convert(float,@w_plazo),0)
                        when @w_tipo_plazo = 'B' then round(convert(float,@w_plazo) * 2,0)
                        when @w_tipo_plazo = 'T' then round(convert(float,@w_plazo) * 3,0)
                        when @w_tipo_plazo = 'S' then round(convert(float,@w_plazo) * 6,0)
                      end    		    

        select 'CODIGO' = pm_plazo, 
  	           'VALOR'  = (select td_descripcion from cob_cartera..ca_tdividendo 
			               where pm_frecuencia = td_tdividendo)
  	    from cob_cartera..ca_plazo_asis_med
		where pm_seguro = @i_filtro
		and pm_producto = @i_producto
    and pm_plazo    >= @w_tiempo
         
        if @@rowcount = 0
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 101000 /*'No existe dato en catalogo'*/				
  	  end
  	end
    return 0
  end
  else
  begin
    exec cobis..sp_cerror
      @t_debug   = @t_debug,
      @t_file    = @t_file,
      @t_from    = @w_sp_name,
      @i_num     = 151051
      /*  'No corresponde codigo de transaccion' */
    return 1
  end
end

go
