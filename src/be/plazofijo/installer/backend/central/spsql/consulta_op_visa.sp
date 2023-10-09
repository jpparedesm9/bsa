/************************************************************************/
/*	Archivo:		conopvisa.sp.				*/
/*	Stored procedure:	sp_consulta_op_visa              	*/
/*	Base de datos:		cob_pfijo                               */
/*	Producto: Plazo Fijo                     			*/
/*	Disenado por:  Ximena Cartagena					*/
/*	Fecha de escritura: 13-Ago-2006					*/
/************************************************************************/
/*				IMPORTANTE				*/
/*	Este programa es parte de los paquetes bancarios propiedad de	*/
/*	'MACOSA', representantes exclusivos para el Ecuador de la 	*/
/*	'NCR CORPORATION'.						*/
/*	Su uso no autorizado queda expresamente prohibido asi como	*/
/*	cualquier alteracion o agregado hecho por alguno de sus		*/
/*	usuarios sin el debido consentimiento por escrito de la 	*/
/*	Presidencia Ejecutiva de MACOSA o su representante.		*/
/*				PROPOSITO				*/
/*	Este programa procesa la consulta de operaciones                */
/*									*/
/************************************************************************/
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/* Ago/13/05	  Gabriela Arboleda   Emision Inicial                   */ 
/************************************************************************/
/*      se comenta todo el procedimiento porque en esta instalación no hay tarjeta de credito*/
use cob_pfijo
go

SET NOCOUNT ON
go

SET ANSI_NULLS OFF
go

SET QUOTED_IDENTIFIER OFF
go

if exists (select 1 from sysobjects where name = 'sp_consulta_op_visa')
   drop proc sp_consulta_op_visa
go

create proc sp_consulta_op_visa(
@s_ssn          int         = null,
@s_user         login       = null,
@s_term         varchar(30) = null,
@s_date         datetime    = null,
@s_srv          varchar(30) = null,
@s_lsrv         varchar(30) = null,
@s_ofi          smallint    = null,
@s_org          char(1)     = null,
@t_debug        char(1)     = 'N',
@t_file         varchar(10) = null,
@t_from         varchar(32) = null,
@t_trn          int         = null,
@i_operacion    char(1)     = 'H',
@i_producto     tinyint     = null,
@i_cliente      int         = null,
@i_cuenta       cuenta      = null,
@i_modo         int         = null,
@i_moneda       int)
with encryption
as
declare @w_sp_name varchar(32)
select  @w_sp_name = 'sp_consulta_op_visa'

/*


if @t_trn <> 14994

begin

   exec cobis..sp_cerror

      @t_debug = @t_debug,

      @t_file  = @t_file,

      @t_from  = @w_sp_name,

      @i_num   = 161500

   return 1

end



if @i_operacion = 'H'
begin
   set rowcount 20

   if @i_modo = 0
   begin
      select 'NUM. CUENTA '   = numcuenta, 
             'COD. CLIENTE '  = en_ente,
             'NOM. CLIENTE '  = en_nomlar
        from cob_tarj_cre..vpscuenta ,
             cobis..cl_ente
       where (en_ente   = @i_cliente  or @i_cliente is null)
         and (numcliente = en_ced_ruc  or convert(int,numctauser) = en_ente )
       order by numcuenta  

   end
   if @i_modo = 1
   begin
      select 'NUM. CUENTA '   = numcuenta, 
             'COD. CLIENTE '  = en_ente,
             'NOM. CLIENTE '  = en_nomlar
        from cob_tarj_cre..vpscuenta ,
             cobis..cl_ente
       where (en_ente   = @i_cliente  or @i_cliente is null)
         and (numcliente = en_ced_ruc  or convert(int,numctauser) = en_ente )
         and numcuenta > @i_cuenta
       order by numcuenta
   end
   set rowcount 0
end
else 
begin

      select 
             'COD. CLIENTE '  = en_ente,
             'NOM. CLIENTE '  = en_nomlar,
             'NUM. CUENTA '   = numcuenta
        from cob_tarj_cre..vpscuenta ,
             cobis..cl_ente
       where (en_ente   = @i_cliente  or @i_cliente is null)
         and (numcliente = en_ced_ruc  or convert(int,numctauser) = en_ente )
         and numcuenta = @i_cuenta
         and codbloque1 not in ('B','J','T')
       order by numcuenta

   if @@rowcount = 0
   begin
      exec cobis..sp_cerror
      @t_debug= @t_debug,
      @t_file = @t_file,
      @t_from= @w_sp_name,
      @i_msg = 'Tarjeta no existe o tiene bloqueo para pago...',
      @i_num= 141184
      return 1
   end
end
*/
return 0
go
