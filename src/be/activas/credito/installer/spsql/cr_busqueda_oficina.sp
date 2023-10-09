/***********************************************************************/
/*     Archivo:                   cr_busqueda_oficina.sp               */
/*     Stored procedure:          sp_busqueda_oficina_oficial          */
/*     Base de Datos:             cob_credito                          */
/*     Producto:                  Credito                              */
/*     Disenado por:              Dario Cumbal                         */
/*     Fecha de Documentacion:    27/Sept/2018                         */
/***********************************************************************/
/*                         IMPORTANTE                                  */
/*     Este programa es parte de los paquetes bancarios propiedad de   */
/*     "MACOSA",representantes exclusivos para el Ecuador de la        */
/*     AT&T                                                            */
/*     Su uso no autorizado queda expresamente prohibido asi como      */
/*     cualquier autorizacion o agregado hecho por alguno de sus       */
/*     usuario sin el debido consentimiento por escrito de la          */
/*     Presidencia Ejecutiva de MACOSA o su representante              */
/***********************************************************************/
/*                                 PROPOSITO                           */
/*     Este stored procedure realiza la busqueda en funcion de su login*/
/*                                                                     */
/***********************************************************************/
/*               MODIFICACIONES                                        */
/*     FECHA          AUTOR               RAZON                        */
/*     27/Sept/95     Dario Cumbal        Obtener Oficina oficial      */
/***********************************************************************/

use cob_credito
go
if exists (select * from sysobjects where name = 'sp_busqueda_oficina_oficial')
   drop proc sp_busqueda_oficina_oficial
go
create proc sp_busqueda_oficina_oficial(
   @s_ssn           int          = null,
   @s_user          login        = null,
   @s_sesn          int          = null,
   @s_term          descripcion  = null,
   @s_date          datetime     = null,
   @s_srv           varchar(30)  = null,
   @s_lsrv          varchar(30)  = null,
   @s_rol           smallint     = null,
   @s_ofi           smallint     = null,
   @s_org_err       char(1)      = null,
   @s_error         int          = null,
   @s_sev           tinyint      = null,
   @s_msg           descripcion  = null,
   @s_org           char(1)      = null,
   @t_rty           char(1)      = null,
   @t_trn           smallint     = null,
   @t_debug         char(1)      = 'N',
   @t_file          varchar(14)  = null,
   @t_from          varchar(30)  = null,
   @i_operacion     char(1)      = 'Q',
   @i_login         varchar(14)  = null,
   @o_oficina       int          = null out  
)
as
  declare @w_codigo_oficina int

  select @w_codigo_oficina = fu_oficina
  from cobis..cl_funcionario
  where fu_login = @i_login
  
  
        
  select @o_oficina = @w_codigo_oficina
  

return 0
go


