/************************************************************************/
/*  Archivo:            ahconscartera.sp                                */
/*  Stored procedure:   sp_consulta_cartera                             */
/*  Base de datos:      cob_interfase                                   */
/*  Producto:           Cuentas de Ahorros                              */
/************************************************************************/
/*              IMPORTANTE                                              */
/*  Esta aplicacion es parte de los paquetes bancarios propiedad        */
/*  de COBISCorp.                                                       */
/*  Su uso no    autorizado queda  expresamente   prohibido asi como    */
/*  cualquier    alteracion o  agregado  hecho por    alguno  de sus    */
/*  usuarios sin el debido consentimiento por   escrito de COBISCorp.   */
/*  Este programa esta protegido por la ley de   derechos de autor      */
/*  y por las    convenciones  internacionales   de  propiedad inte-    */
/*  lectual.    Su uso no  autorizado dara  derecho a    COBISCorp para */
/*  obtener ordenes  de secuestro o  retencion y para  perseguir        */
/*  penalmente a los autores de cualquier   infraccion.                 */
/************************************************************************/
/*              PROPOSITO                                               */
/*  Este programa DUMMY consulta transacciones de cartera pendientes    */
/************************************************************************/
/*              MODIFICACIONES                                          */
/*  FECHA         AUTOR            RAZON                                */
/*  22/Jul/2016   J.Tagle          Emisión Inicial                      */
/************************************************************************/
use cob_interfase
GO

set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

if exists (select 1 from sysobjects where name = 'sp_consulta_cartera')
   drop proc sp_consulta_cartera
go

create proc sp_consulta_cartera 
(
    @s_ssn              int            = null,
    @s_ssn_branch       int            = null, 
    @s_srv              varchar(30)    = null,
    @s_lsrv             varchar(30)    = null,
    @s_user             varchar(30)    = null,
    @s_sesn             int            = null,
    @s_term             varchar(32)    = null,
    @s_date             datetime       = null,
    @s_ofi              smallint       = null,
    @s_rol              smallint       = 1,
    @s_org_err          char(1)        = null,
    @s_error            int            = null,
    @s_sev              tinyint        = null,
    @s_msg              varchar(255)   = null,  
    @s_org              char(1)        = null,       
    @t_debug            char(1)        = 'N',
    @t_file             varchar(14)    = null,
    @t_from             varchar(32)    = null,
    @t_rty              char(1)        = 'N',
    @t_show_version     bit            = 0,   
    @t_trn              smallint       = null,      
    @t_ssn_corr         int            = null,    
    @i_cliente          int            = null,
    @o_cvigenteinp      char(1)        = 'S',
    @o_opercar          char(1)        = null,
    @o_saldoDeuda       money          = null

)
as
declare    
    @w_sp_name          varchar(30)
   
/*  Captura nombre de Stored Procedure  */
select @w_sp_name = 'sp_consulta_cartera'

if @t_show_version = 1
   begin
      print 'Stored procedure sp_consulta_cartera, Version 4.0.0.0'
      return 0
   end

/*  Activacion del Modo de debug  */
if @t_debug = 'S'
begin
    exec cobis..sp_begin_debug 
	   @t_file=@t_file
    select '/** Store Procedure **/' = @w_sp_name,
       s_ssn          = @s_ssn,
       s_srv          = @s_srv,
       s_lsrv         = @s_lsrv,
       s_user         = @s_user,
       s_sesn         = @s_sesn,
       s_term         = @s_term,
       s_date         = @s_date,
       s_ofi          = @s_ofi,
       s_rol          = @s_rol,
       s_org_err      = @s_org_err,
       s_error        = @s_error,
       s_sev          = @s_sev,
       s_msg          = @s_msg,
       s_org          = @s_org,   
       t_from         = @t_from,
       t_file         = @t_file, 
       t_rty          = @t_rty,
       t_trn          = @t_trn,
       i_cliente      = @i_cliente,          
       o_cvigenteinp  = @o_cvigenteinp,      
       o_opercar      = @o_opercar,          
       o_saldoDeuda   = @o_saldoDeuda       
          
         

    exec cobis..sp_end_debug
end
  
  return 0

go

