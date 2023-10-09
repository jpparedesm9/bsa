/*  Archivo               : icartera.sp                                 */
/*  Stored procedure      : sp_icartera                                 */
/*  Base de datos         : cob_interfase                               */
/*  Producto              : Plazo_fijo                                  */
/*  Disenado por          : Alfredo Zuluaga                             */
/*  Fecha de documentacion: 29 de Noviembre de 2016                     */
/************************************************************************/
/*                          IMPORTANTE                                  */
/*  Este programa es parte de los paquetes bancarios propiedad de       */
/*  'MACOSA', representantes exclusivos para el Ecuador de la           */
/*  'NCR CORPORATION'.                                                  */
/*  Su uso no autorizado queda expresamente prohibido asi como          */
/*  cualquier alteracion o agregado hecho por alguno de sus             */
/*  usuarios sin el debido consentimiento por escrito de la             */
/*  Presidencia Ejecutiva de MACOSA o su representante.                 */
/************************************************************************/
/*                          PROPOSITO                                   */
/*  Este programa busca desacoplar el modulo de Cuadre Contable         */
/*  con el modulo de plazo fijo                                         */
/************************************************************************/
/*                          MODIFICACIONES                              */
/*  FECHA          AUTOR              RAZON                             */
/*  29/Nov/2016    Alfredo Zuluaga    Emision Inicial DPF-H91368        */
/************************************************************************/
use cob_interfase
go

--DROP TABLE #comprobantes_conaut

create table #comprobantes_conaut( 
cc_comprobante  int      null,
cc_fecha        datetime null,
cc_mensaje      varchar(60))
      
if exists (select 1 from sysobjects where  name = 'sp_iccontable')
   drop proc sp_iccontable
go

SET NOCOUNT ON
go

SET ANSI_NULLS OFF
go

SET QUOTED_IDENTIFIER OFF
go

create proc sp_iccontable (
       @s_ssn               int             = NULL,
       @s_date              datetime        = NULL,
       @s_term              varchar(30)     = NULL,
       @s_sesn              int             = NULL,
       @s_srv               varchar(30)     = NULL,
       @s_lsrv              varchar(30)     = NULL,
       @s_user              varchar(30)     = NULL,
       @s_ofi               smallint        = NULL,
       @s_rol               smallint        = NULL,
       @s_ssn_corr          int             = NULL,
       @s_org               char(1)         = NULL,
       @s_ssn_branch        int             = NULL,
       @t_debug             char(1)         = NULL,
       @t_file              varchar(14)     = NULL,
       @t_trn               int             = NULL,
       @t_corr              char(1)         = 'N', 
       @t_ssn_corr          int             = NULL, 
       @i_empresa           int             = NULL,
       @i_fecha             datetime        = NULL,
       @i_producto          int             = NULL,
       @i_operacion         varchar(2)      = NULL,
       @i_tran_modulo       int             = NULL, 
       @i_asiento           int             = NULL,
       @i_fecha_conta       datetime        = NULL,
       @i_numerror          int             = NULL,
       @i_mensaje           varchar(255)    = NULL,
       @i_perfil            varchar(10)     = NULL,
       @i_oficina           int             = NULL,
       @i_cuenta            varchar(24)     = NULL,
       @i_area              int             = NULL,   
       @i_valor_opera_mn    money           = NULL,
       @i_valor_opera_me    money           = NULL,
       @i_tipo              char(1)         = NULL,
       @i_moneda            int             = NULL,  
       @i_fecha_desde       datetime        = NULL,     
       @o_existe_ccontable  char(1)         = NULL OUT
) 
with encryption   
as

declare @w_error           int,
        @w_mensaje         varchar(255),
        @w_producto        int,
        @w_return          int,
        @w_sp_name         varchar(24)

select @w_sp_name = 'sp_iccontable'

/* VALIDACION EXISTENCIA DEL PRODUCTO DE AHORROS */
select @w_producto = COUNT(1) 
from cobis..cl_producto 
where pd_producto = 60
  and pd_estado   = 'V'

if @w_producto = 0
begin
  /* MAPEO DE VARIBALES */
  select @o_existe_ccontable  = 'N'
  
end

/* LA LECTURA DE LA INFORMACION DE COBIS SE HABILITARA DEPENDIENDO DE LA NECESIDAD */

/*

if @w_producto > 0 
begin 
   
   select @o_existe_ccontable = 'S'

   if @i_operacion = 'D'
   begin
      
      exec @w_return = cob_ccontable..sp_errorcconta
           @i_operacion = @i_operacion,
           @i_empresa   = @i_empresa,
           @i_fecha     = @i_fecha,
           @i_producto  = @i_producto,
           @t_trn       = @t_trn 
      
      if @w_return <> 0
      begin
         select @w_error = @w_return
         goto ERROR
      end
   end
   
   if @i_operacion = 'I'
   begin
   
      exec @w_return = cob_ccontable..sp_errorcconta
           @t_trn         = @t_trn,
           @i_operacion   = @i_operacion,
           @i_empresa     = @i_empresa,
           @i_fecha       = @i_fecha,
           @i_producto    = @i_producto,
           @i_cuenta      = @i_cuenta,
           @i_area        = @i_area,
           @i_tran_modulo = @i_tran_modulo, 
           @i_asiento     = @i_asiento,
           @i_fecha_conta = @i_fecha_conta,
           @i_numerror    = @i_numerror,
           @i_mensaje     = @i_mensaje,
           @i_perfil      = @i_perfil,
           @i_oficina     = @i_oficina,
           @i_moneda      = @i_moneda,
           @i_valor_opera_mn = @i_valor_opera_mn,
           @i_valor_opera_me = @i_valor_opera_me,
           @i_tipo           = @i_tipo
           
      if @w_return <> 0
      begin
         select @w_error = @w_return
         goto ERROR
      end
   end
   
   if @i_operacion = 'A'
   begin
     
      insert into #comprobantes_conaut 
      select ec_comprobante, ec_fecha_conta, substring (ec_mensaje, 1,60)
      from cob_ccontable..cco_error_conaut
      where ec_producto    = @i_producto
        and ec_fecha_conta = @i_fecha_desde 

      if @@error <> 0
      begin
         select @w_error = 103118
		 goto ERROR
      end
   end

end

*/

return 0

ERROR:

   exec cobis..sp_cerror
        @t_debug    = @t_debug,
        @t_file     = @t_file,
        @t_from     = @w_sp_name,
        @i_num      = @w_error
        
   return @w_error
go