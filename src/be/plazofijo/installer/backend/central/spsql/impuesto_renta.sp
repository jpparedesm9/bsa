/************************************************************************/
/*	Archivo:		imprenta.sp				*/
/*	Stored procedure:	sp_impuesto_renta                       */
/*	Base de datos: 	        cob_pfijo	                        */
/*	Producto:               Plazo Fijo              		*/
/*	Disenado por:           Gabriela Estupinan                      */  
/*	Fecha de escritura:     10/Sep/2001				*/
/************************************************************************/
/*				IMPORTANTE				*/
/*	Este programa es parte de los paquetes bancarios propiedad de	*/
/*	'MACOSA', representantes  exclusivos  para el  Ecuador  de la 	*/
/*	'NCR CORPORATION'.						*/
/*	Su  uso no autorizado  queda expresamente  prohibido asi como	*/
/*	cualquier   alteracion  o  agregado  hecho por  alguno de sus	*/
/*	usuarios   sin el debido  consentimiento  por  escrito  de la 	*/
/*	Presidencia Ejecutiva de MACOSA o su representante.		*/
/*				PROPOSITO				*/
/*	Este programa busca si la tasa de retencion de impuestos de -   */
/*      acuerdo al cliente, por su pais de residencia.                  */
/*	                        					*/
/*                           MODIFICACIONES                             */
/*	FECHA		AUTOR		RAZON				*/
/*	10/Sep/2001     G.Estupinan     Emision Inicial CUZ-031-002     */ 
/************************************************************************/
use cob_pfijo
go

SET NOCOUNT ON
go

SET ANSI_NULLS OFF
go

SET QUOTED_IDENTIFIER OFF
go

if exists (select 1 from sysobjects where name = 'sp_impuesto_renta')
   drop proc sp_impuesto_renta
go

create proc sp_impuesto_renta (
@s_ssn			        int         = NULL,
@s_user			        login       = NULL,
@s_sesn			        int         = NULL,
@s_term			        varchar(30) = NULL,
@s_date			        datetime    = NULL,
@s_srv			        varchar(30) = NULL,
@s_lsrv			        varchar(30) = NULL, 
@s_rol			        smallint    = NULL,
@s_ofi			        smallint    = NULL,
@s_org_err		        char(1)     = NULL,
@s_error		        int         = NULL,
@s_sev			        tinyint     = NULL,
@s_msg			        descripcion = NULL,
@s_org			        char(1)     = NULL,
@t_debug		        char(1)     = 'N',
@t_file			        varchar(14) = NULL,
@t_from			        varchar(32) = NULL,
@t_trn			        smallint    = NULL,
@i_tipo                 char(1),
@i_num_banco            cuenta      = NULL,
@i_operacion            int         = NULL,
@i_ente                 int         = NULL,
@o_tasa                 float       = NULL  out)
with encryption
as
declare
@w_return               int,
@w_sp_name	            varchar(32),
@w_pais_residencia      smallint,
@w_ente                 int,
@w_nemonico             char(6)

select @w_sp_name = 'sp_impuesto_renta'

if @t_trn <> 14813 begin
   /* 'Tipo de transaccion no corresponde' */
   exec cobis..sp_cerror
   @t_debug = @t_debug,
   @t_file  = @t_file,
   @t_from  = @w_sp_name,
   @i_num   = 141112
   return 1
end                     

if @i_tipo = 'N'    -- Numero de banco
begin
   select @o_tasa = op_impuesto
   from pf_operacion
   where op_num_banco = @i_num_banco

   if @@rowcount = 0
   begin
      exec cobis..sp_cerror
      @t_debug	 = @t_debug,
      @t_file	 = @t_file,
      @t_from	 = @w_sp_name,
      @i_num	 = 141004
      return 141004
   end
end

if @i_tipo = 'O'    -- Operacion
begin
   select @o_tasa = op_impuesto
   from pf_operacion
   where op_operacion = @i_operacion

   if @@rowcount = 0
   begin
      exec cobis..sp_cerror
      @t_debug	 = @t_debug,
      @t_file	 = @t_file,
      @t_from	 = @w_sp_name,
      @i_num	 = 141004
      return 141004
   end
end

if @i_tipo = 'E'    -- Ente      
begin
   select @w_ente = @i_ente

/****** Comentado no existe para global
   select @w_pais_residencia = en_pais_residencia
   from cobis..cl_ente
   where en_ente = @w_ente
   if @@rowcount = 0
   begin
      exec cobis..sp_cerror
      @t_debug	 = @t_debug,
      @t_file	 = @t_file,
      @t_from	 = @w_sp_name,
      @i_num	 = 141044
      return 141044
   end

   if @w_pais_residencia = 1
      select @w_nemonico = 'IMP'
   else

Fin comentado  no existe para global *****/

      select @w_nemonico = 'IMRE'

   select @o_tasa = pa_float
   from cobis..cl_parametro
   where pa_producto = 'PFI'
   and pa_nemonico = @w_nemonico
   if @@rowcount = 0
   begin
      exec cobis..sp_cerror
      @t_debug	 = @t_debug,
      @t_file	 = @t_file,
      @t_from	 = @w_sp_name,
      @i_num	 = 141140
      return 141140
   end
end

return 0
go
