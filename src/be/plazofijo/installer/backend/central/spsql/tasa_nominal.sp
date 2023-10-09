/************************************************************************/
/*      Archivo:                tasanom.sp                              */
/*      Stored procedure:       sp_tasa_nominal                         */
/*      Base de datos:          cobis                                   */
/*      Producto:               Plazo Fijo                              */
/*      Disenado por:           JHON MARIO HOLGUIN                      */
/*      Fecha de documentacion: 11/Ago/97                               */
/************************************************************************/
/*                              PROPOSITO                               */
/*      Calcular la tasa nominal dada una tasa efectiva.                */
/*                                                                      */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*      FECHA      AUTOR              RAZON                             */
/************************************************************************/
use cob_pfijo
go

SET NOCOUNT ON
go

SET ANSI_NULLS OFF
go

SET QUOTED_IDENTIFIER OFF
go

if exists (select 1 from sysobjects where name = 'sp_tasa_nominal' and type = 'P')
   drop proc sp_tasa_nominal
go

create proc sp_tasa_nominal
@s_ssn                  int             = NULL,
@s_user                 login           = NULL,
@s_term                 varchar(30)     = NULL,
@s_date                 datetime        = NULL,
@s_srv                  varchar(30)     = NULL,
@s_lsrv                 varchar(30)     = NULL,
@s_ofi                  smallint        = NULL,
@s_rol                  smallint        = NULL,
@t_debug                char(1)         = 'N',
@t_file                 varchar(10)     = NULL,
@t_from                 varchar(32)     = NULL,
@t_trn                  int             = 14950,
@i_tasa_efectiva        float	        = 0,
@i_op_ppago	            catalogo        = NULL,
@i_op_fpago     	    catalogo        = NULL,  	
@i_op_num_dias     	    smallint        = NULL,
@i_td_base_calculo      smallint        = 360,
@i_aper                 char(1)         = 'N', 
@o_tasa_nominal         float           = NULL out
with encryption
as
declare 
@w_sp_name              descripcion,
@w_return               tinyint,
@w_error                int,
@w_periodo              float,
@w_numdeci              tinyint

/** DEBUG **/
select @w_sp_name = 'sp_tasa_nominal'

if   @t_trn <> 14950
begin
   exec cobis..sp_cerror
           @t_debug     = @t_debug,
           @t_file      = @t_file,
           @t_from      = @w_sp_name,
           @i_num       = 141112

   return 1

end  


select @w_numdeci = isnull(pa_tinyint,0)
  from cobis..cl_parametro
 where pa_nemonico = 'DCI' and
       pa_producto = 'PFI'

   if @@rowcount = 0
   begin
      exec cobis..sp_cerror
           @t_debug        = @t_debug,
           @t_file         = @t_file,
           @t_from         = @w_sp_name,
           @i_num          = 141140
	   return 1
   end
 

	
 /* Se consugue el periodo de pago  */

    select @w_periodo=pp_factor_dias 
    from pf_ppago where pp_codigo = @i_op_ppago

   if @@rowcount = 0 begin  
	--if @i_op_num_dias > @i_td_base_calculo
--		select @w_periodo = 12
	--else


if @t_debug = 'S' PRINT ' @i_td_base_calculo  ' + cast( @i_td_base_calculo   as varchar)
if @t_debug = 'S' PRINT ' @i_op_num_dias  ' + cast( @i_op_num_dias   as varchar)

		select @w_periodo = @i_op_num_dias  
        select @w_periodo = @i_td_base_calculo / convert(float,@w_periodo)

if @t_debug = 'S' PRINT ' @w_periodo  ' + cast( @w_periodo   as varchar)
if @t_debug = 'S' PRINT ' @i_tasa_efectiva  ' + cast( @i_tasa_efectiva   as varchar)

    end 
    else 
    begin

if @t_debug = 'S' PRINT ' @i_td_base_calculo  ' + cast( @i_td_base_calculo   as varchar)
if @t_debug = 'S' PRINT ' @w_periodo  ' + cast( @w_periodo   as varchar)

        select @w_periodo = @i_td_base_calculo / @w_periodo
if @t_debug = 'S' PRINT ' @w_periodo  ' + cast( @w_periodo   as varchar)

    end

    if @i_op_fpago in ('ANT', 'PRA')
       select @o_tasa_nominal = ( 1. - power(1. + (@i_tasa_efectiva/100.), -1./@w_periodo) ) *  @w_periodo * 100. 
    else 
      select @o_tasa_nominal =  ( power(1. + @i_tasa_efectiva / 100., 1./@w_periodo) - 1 ) *  @w_periodo   *100.      


    select @o_tasa_nominal = round(@o_tasa_nominal,4.0)

if @i_aper = 'N'
   select 'valor' = @o_tasa_nominal

return 0
go


