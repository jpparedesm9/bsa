/************************************************************************/
/*      Archivo:                pfactloc.sp                             */
/*      Stored procedure:       sp_actualizacion_localizacion           */
/*      Base de datos:          cob_pfijo                               */
/*      Producto:               Plazo Fijo                              */
/*      Disenado por:           Juan Carlos Suarez A.                   */
/*      Fecha de escritura:     22-Oct-2005                             */
/************************************************************************/
/*                              IMPORTANTE                              */
/*      Este programa es parte de los paquetes bancarios propiedad de   */
/*      'MACOSA', representantes exclusivos para el Ecuador de la       */
/*      'NCR CORPORATION'.                                              */
/*      Su uso no autorizado queda expresamente prohibido asi como      */
/*      cualquier alteracion o agregado hecho por alguno de sus         */
/*      usuarios sin el debido consentimiento por escrito de la         */
/*      Presidencia Ejecutiva de MACOSA o su representante.             */
/************************************************************************/
/*                              PROPOSITO                               */
/*   Este programa actualiza el campo op_inactivo si la diferencia      */
/*   entre la fecha de no localizaci¢n con la fecha de proceso es igual */
/*   al parametro de dias de inactivacion                               */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*      FECHA            AUTOR                 RAZON                    */ 
/*      22/10/2005       JCSA                  Emision Inicial          */
/*      13/08/2009       JBQ                   Adaptacion SQLserver     */
/************************************************************************/
use cob_pfijo
go

SET NOCOUNT ON
go

SET ANSI_NULLS OFF
go

SET QUOTED_IDENTIFIER OFF
go

if exists (select 1 from sysobjects where name = 'sp_actualizacion_localizacion')
   drop proc sp_actualizacion_localizacion
go

create proc sp_actualizacion_localizacion(
@s_date                    datetime    = null,
@s_user                    login       = null,
@i_fecha                   smalldatetime)
with encryption
as
declare
@w_return                  int,
@w_moneda                  tinyint,
@w_mensaje                 varchar(254),
@w_fecha_no_localiza       datetime,
@w_contador                int,
@w_lote                    int,
@w_dias_inactivacion       smallint,
@w_operacion               int,
@w_nomtrn                  varchar(10),
@w_inactivo                char(1),
@w_sp_name                 varchar(64),
@w_num_banco               cuenta
 

/* Inicializacion de variables */
select @w_contador = 0,
       @w_lote     = 100,
       @w_nomtrn   = 'REGISTRO',
       @w_sp_name  = 'sp_actualizacion_localizacion'

if @s_date is null
   select @s_date = @i_fecha

/* Dias de Inactivacion */
select @w_dias_inactivacion = pa_int
  from cobis..cl_parametro
 where pa_producto = 'PFI'
   and pa_nemonico = 'DINAC'
if @@rowcount = 0
    return 141207


-- Cursor
declare inactiva cursor
for select op_num_banco,
           op_fecha_no_localiza,
           op_inactivo        
      from cob_pfijo..pf_operacion
     where op_estado    in ('ACT', 'VEN')
       and op_localizado = 'N'
       and op_inactivo   is null
for update of op_inactivo

open inactiva

begin tran @w_nomtrn                 -- GAL 31/AGO/2009 - RVVUNICA

fetch inactiva into
        @w_num_banco,
        @w_fecha_no_localiza,
        @w_inactivo 
        
while @@fetch_status <> -1
begin
   if @@fetch_status = -2
   begin
      close inactiva
      deallocate inactiva
      raiserror ('200001 - Fallo lectura del cursor ', 16, 1)
      
      rollback tran @w_nomtrn
      return 201157
   end

   -- Determinacion de inactivacion
   if (datediff(dd, @w_fecha_no_localiza, @i_fecha) >=  @w_dias_inactivacion) 
   begin
      update cob_pfijo..pf_operacion
      set op_inactivo = 'S'
      where current of inactiva
      
      if @@error <> 0
      begin
         rollback tran @w_nomtrn
         select @w_contador = 0

         exec sp_errorlog 
            @i_fecha       = @s_date,
            @s_date        = @s_date,
            @i_usuario     = @s_user,
            @i_cuenta      = @w_num_banco,
            @i_descripcion = @w_sp_name

         begin tran @w_nomtrn
         goto LEER
      end
      
      select @w_contador = @w_contador + 1
      
      if @w_contador % @w_lote = 0
      begin
         commit tran @w_nomtrn
         select @w_contador = 0
         
         begin tran @w_nomtrn
      end   
   end
   
LEER:

   fetch inactiva into
      @w_num_banco,
      @w_fecha_no_localiza,
      @w_inactivo 
end

close inactiva
deallocate inactiva

commit tran @w_nomtrn

return 0
go
