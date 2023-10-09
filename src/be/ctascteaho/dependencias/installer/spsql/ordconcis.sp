use cob_interfase
go
/************************************************************************/
/*      Archivo:            ordconcis.sp                                */
/*      Stored procedure:   sp_orden_consulta_cis                       */
/*      Base de datos:      cob_interface                               */
/*      Producto:           Cuentas de Ahorros                          */
/*      Disenado por:       Claudia Ballen                              */
/*      Fecha de escritura: 30-Abril-2009                               */
/************************************************************************/
/*                              IMPORTANTE                              */
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
/*                              PROPOSITO                               */
/*      Este programa realiza la transaccion de actualizacion GMF       */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*      FECHA           AUTOR           RAZON                           */
/*    08/Jul/2016       Jorge Salazar   Migración a CEN                 */
/************************************************************************/
 
if exists (select 1 from sysobjects where name = 'sp_orden_consulta_cis')
   drop proc sp_orden_consulta_cis
go

create proc sp_orden_consulta_cis
(
   @s_user          login        = null,
   @s_ofi           smallint     = null,
   @s_date          datetime     = null,
   @s_ssn           int          = null,
   @s_term          descripcion  = null,
   @s_srv           varchar(30)  = null,
   @s_lsrv          varchar(30)  = null,
   @t_debug         char(1)      = 'N',
   @t_file          varchar(10)  = null,
   @t_trn           int          = null,
   @t_show_version  bit          = 0,
   @i_user          login        = null,
   @i_ofi           smallint     = null,
   @i_modo          char(1)      = null,
   @i_tipo_ced      char(2)      = null,
   @i_ced_ruc       numero       = null,
   @i_p_apellido    varchar(16)  = null,
   @i_ente          int          = null,
   @i_batch         char(1)      = 'N', --MAL02222012
   @i_tconsulta     varchar(10)  = null,
   @i_orden         int          = null,
   @i_observacion   varchar(255) = null,-- GAL 30/AGO/2010 - ORD. SER. 000057
   @i_tramite       int          = null,-- GAL 22/ABR/2010 - REQ 132: GESTOR MIR
   @i_motivo        varchar(10)  = '24',
   @i_cuenta        cuenta       = null,--CEH 05/MAR/2012 - REQ 315: GMF
   @i_exenta        tinyint      = null,--CEH 05/MAR/2012 - REQ 315: GMF
   @i_fec_marcacion datetime     = null,
   @o_orden         int          = null out,
   @o_respuesta     char(1)      = null out,
   @o_msg           varchar(255) = null out,
   @o_sec_error     int          = null out --CEH 05/MAR/2012 - REQ 315: GMF
)
as
declare
   @w_sp_name       varchar(30)

select @w_sp_name = 'sp_orden_consulta_cis'

if @t_show_version = 1
begin
   print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
   return 0
end

select
   @o_orden,
   @o_respuesta,
   @o_msg,
   @o_sec_error

return 0

go

