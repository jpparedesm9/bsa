/************************************************************************/
/*  Archivo:            cr_resegd.sp                                    */
/*  Stored procedure:   sp_valida_clientes_segdeuven                    */
/*  Base de datos:      cob_credito                                     */
/*  Producto:           Tramites                                        */
/*  Disenado por:       Igmar Berganza                                  */
/*  Fecha de escritura: 19-Ago-2014                                     */
/************************************************************************/
/*                          IMPORTANTE                                  */
/*  Este programa es parte de los paquetes bancarios propiedad de       */
/*  'COBISCorp'.                                                        */
/*  Su uso no autorizado queda expresamente prohibido asi como          */
/*  cualquier alteracion o agregado hecho por alguno de sus             */
/*  usuarios sin el debido consentimiento por escrito de la             */
/*  Presidencia Ejecutiva de MACOSA o su representante.                 */
/************************************************************************/
/*                            PROPOSITO                                 */
/*  Stored Procedure para realizar la busqueda en el listado de         */
/*  reclamaciones de seguros para linea                                 */
/************************************************************************/

use cob_credito
go

if exists (select 1 from sysobjects where name = 'sp_valida_clientes_segdeuven')
   drop proc sp_valida_clientes_segdeuven
go

create proc sp_valida_clientes_segdeuven (  
@s_ssn                 int          = null,
@s_user                login        = null,
@s_sesn                int          = null,
@s_term                descripcion  = null,
@s_date                datetime     = null,
@s_srv                 varchar(30)  = null,
@s_lsrv                varchar(30)  = null,
@s_rol                 smallint     = null,
@s_ofi                 smallint     = null,
@s_org_err             char(1)      = null,
@s_error               int          = null,
@s_sev                 tinyint      = null,
@s_msg                 descripcion  = null,
@s_org                 char(1)      = null,
@t_rty                 char(1)      = null,
@t_trn                 smallint     = null,
@t_debug               char(1)      = 'N',
@t_file                varchar(14)  = null,
@t_from                varchar(30)  = null,
@i_cliente             int          = null
)  
  
as  
declare  
@w_sp_name             varchar(60),
@w_valor               varchar(1)

select @w_sp_name = 'SP_VALIDA_CLIENTES_SEGDEUVEN' 

select @w_valor = 'N'

if exists(select 1
          from cobis..cl_ente, cobis..cl_mercado
          where en_ente     = @i_cliente
          and   en_ced_ruc  = me_ced_ruc
          and   en_tipo_ced = me_tipo_ced
          and   me_estado   = '025')
begin
   print 'CLIENTE NO OBJETIVO PARA PRESTAMO'
   select @w_valor = 'S'
end

--Mapeo al FE
select @w_valor

return 0

go
