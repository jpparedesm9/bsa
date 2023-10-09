/*****************************************************************/
/* Archivo:            ente_bloqueado.sp                         */
/* Stored procedure:   sp_ente_bloqueado                         */
/* Base de datos:      cob_pfijo                                 */
/* Producto:           PLAZO FIJO                                */
/* Disenado por:       Ximena Cartagena                          */
/* Fecha de escritura: 02-Dic-1997                               */
/*****************************************************************/
/*                          IMPORTANTE                           */
/* Este programa es parte de los paquetes bancarios propiedad de */
/* 'MACOSA', representantes exclusivos para el Ecuador de la     */
/* 'NCR CORPORATION'.                                            */
/* Su uso no autorizado queda expresamente prohibido asi como    */
/* cualquier alteracion o agregado hecho por alguno de sus       */
/* usuarios sin el debido consentimiento por escrito de la       */
/* Presidencia Ejecutiva de MACOSA o su representante.           */
/*****************************************************************/
/*                          PROPOSITO                            */
/* Este programa tiene como objetivo realizar la prorroga auto-  */
/* matica de aquellas operaciones en las cuales la fecha de ven -*/
/* cimiento sea igual a la fecha en la cual se ejecuta el batch  */
/* de fin de dia, ademas la operacion debera estar en estado ACT */
/*****************************************************************/
/*                        MODIFICACIONES                         */
/* FECHA       AUTOR          RAZON                              */
/*****************************************************************/
/* 20-mar-2007 Ricardo Ramos   Operaciones overnight, hererar    */
/*                             el spread autorizado al momento   */
/*                             de la prorroga                    */
/* 25-Abr-2007 Humberto Ayarza Cambia @s_date x @w_fecha_hoy     */
/*                             en pf_historia.                   */
/* 11-May-2007 Clotilde Vargas Cambios para tener funcional      */
/*                             el manejo de dias de gracia       */
/*****************************************************************/
use cob_pfijo
go

SET NOCOUNT ON
go

SET ANSI_NULLS OFF
go

SET QUOTED_IDENTIFIER OFF
go

if exists (select 1 from sysobjects where name = 'sp_ente_bloqueado')
   drop proc sp_ente_bloqueado
go

create proc sp_ente_bloqueado (
@s_ssn            int          = NULL,
@s_user           login        = NULL,
@s_term           varchar(30)  = NULL,
@s_date           datetime     = NULL,
@s_srv            varchar(30)  = NULL,
@s_lsrv           varchar(30)  = NULL,
@s_rol            smallint     = NULL,
@s_ofi            smallint     = NULL,
@s_org_err        char(1)      = NULL,
@s_error          int          = NULL,
@s_sev            tinyint      = NULL,
@s_msg            descripcion  = NULL,
@s_org            char(1)      = NULL,
@t_debug          char(1)      = 'N',
@t_file           varchar(14)  = NULL,
@t_from           varchar(32)  = NULL,
@t_trn            int          = NULL,
@i_operacion_pf   int          = NULL,
@o_bloqueado      varchar(10)  = NULL out,
@o_malaref        varchar(10)  = NULL out,
@o_lista    	  varchar(10)  = NULL out ,
@o_mensaje        varchar(100) = NULL out,
@o_ente           int          = NULL out)
with encryption
as
declare
@w_fecha_hoy       datetime,
@w_ente_aux        int,
@w_return          int

----------------------------------------------------------------
   -- Proceso para validar que el tiotular y beneficario no esten 
   -- bloqueados por referencias hinibitoiras o bloqueos administrativos
   ----------------------------------------------------------------
   select @w_ente_aux = 0
   while 1= 1 
   begin
      set rowcount 1

      select @o_bloqueado = 'N'	,
             @o_malaref = 'N'

      select 	@w_ente_aux = be_ente
      from 	pf_beneficiario
      where 	be_operacion 	= @i_operacion_pf
      and	be_estado 	= 'I' 
      and	be_estado_xren 	<> 'S'
      and	be_tipo 	<> 'F'
      and	be_ente   	> @w_ente_aux
      order by be_operacion, be_ente

      if @@rowcount <= 0
      	break
      
      print '@w_ente ' + cast(@w_ente_aux as varchar)

      exec @w_return = cobis..sp_ente_bloqueado
      	@t_trn  	= 175,
      	@i_operacion 	= 'B',
      	@i_ente		= @w_ente_aux,
      	@o_bloqueado 	= @o_bloqueado out,
      	@o_malaref   	= @o_malaref out,
      	@o_lista     	= @o_lista   out,
      	@o_mensaje   	= @o_mensaje out

      if @o_bloqueado = 'S' or 	@o_malaref = 'S' or @w_return <> 0
      begin
	  select @o_ente = @w_ente_aux         
         return  141255
      end
   end
   set rowcount 0

return 0
go
