/************************************************************************/
/*      Archivo:                conhis.sp                               */
/*      Stored procedure:       sp_conhis                               */
/*      Base de datos:          cob_pfijo                               */
/*      Producto:               Plazo_fijo                              */
/*      Disenado por:           Myriam Davila                           */
/*      Fecha de documentacion: 16/Nov/94                               */
/************************************************************************/
/*                              IMPORTANTE                              */
/*      Este programa es parte de los paquetes bancarios propiedad de   */
/*      'MACOSA', representantes exclusivos para el Ecuador de la       */
/*      'NCR CORPORATION'.                                              */
/*      Su uso no autorizado queda expresamente prohibido asi como      */
/*      cualquier alteracion o agregado hecho por alguno de sus         */
/*      usuarios sin el debido consentimiento por escrito de la         */
/*      Presidencia Ejecutiva de MACOSA o su representante.             */
/*                              PROPOSITO                               */
/*      Este programa realiza la consulta de la tabla pf_historia       */
/*      para una operacion de deposito a plazo fijo dada.               */
/*                                                                      */
/*                                                                      */
/*                                                                      */
/*                          MODIFICACIONES                              */
/*      FECHA                   AUTOR              RAZON                */
/*     16/Nov/94            Roxana Serrano     Emision Inicial          */
/*     10/Ago/16            N.Martillo         Agregar opcion 'N'       */
/*                                                                      */
/************************************************************************/
use cob_pfijo
go

SET NOCOUNT ON
go

SET ANSI_NULLS OFF
go

SET QUOTED_IDENTIFIER OFF
go

if exists (select 1 from sysobjects where name = 'sp_conhis')
   drop proc sp_conhis
go

create proc sp_conhis(
@s_ssn                  int 		= null,
@s_user                 login       = null,
@s_term                 varchar(30) = null,
@s_date                 datetime 	= null,
@s_srv                  varchar(30) = null,
@s_lsrv                 varchar(30) = null,
@s_ofi                  smallint 	= null,
@s_rol                  smallint 	= NULL,
@t_debug                char(1) 	= 'N',
@t_file                 varchar(10) = null,
@t_from                 varchar(32) = null,
@t_trn                  smallint,
@i_operacion            char(1),
@i_num_banco            cuenta, 
@i_modo                 smallint 	= 0,
@i_secuencial           smallint 	= null,
@i_formato_fecha        int 		= 0)
with encryption
as
declare         
@w_sp_name        varchar(32),
@w_operacionpf    int

select @w_sp_name = 'sp_conhis'

/** Consulta de la historia de la operacion **/
if @i_operacion = 'S'
begin 
   if @t_trn <> 14805
   begin
      exec cobis..sp_cerror
       @t_debug      = @t_debug,
       @t_file       = @t_file, 
       @t_from       = @w_sp_name,
       @i_num        = 141042
       /*  'No corresponde codigo de transaccion' */
      return 1
   end

   /* Verifica si la operacion existe en tabla pf_operacion */
   select @w_operacionpf = op_operacion
   from pf_operacion
   where op_num_banco = @i_num_banco
 
   if @@rowcount = 0
   begin
      exec cobis..sp_cerror
      @t_debug      = @t_debug,
      @t_file       = @t_file,
      @t_from       = @w_sp_name,
      @i_num        = 141051
      /*  'No Existe operacion' */
      return 1
   end

   /* Consulta por numero de operacion,  se controla de 20 en 20 */
   set rowcount 20
   
   if @i_modo = 0
   begin                          
      /* Extrae los primeros veinte registros de la tabla pf_historia */
      select  'Secuencial'                    = hi_secuencial,
              'Cupon'                         = hi_cupon,
              'Fecha de Transaccion'          = convert (char(10),hi_fecha, @i_formato_fecha),   /* GESCY2K B227 */
              'Codigo de Transaccion'         = hi_trn_code, 
              'Descripcion de la Transaccion' = t.tn_descripcion, 
              'Valor de la operacion'         = hi_valor,           
              'Observacion'                   = hi_observacion,
              'Funcionario'                   = hi_funcionario,
              'Tasa'                          = hi_tasa
      from    pf_historia, 
              cobis..cl_ttransaccion t 
      where   @w_operacionpf = hi_operacion
        and   hi_trn_code    = t.tn_trn_code
        and   hi_trn_code    <> 14904
       order  by hi_secuencial 
   end
 
   if @i_modo = 1
   begin
      /* Extrae los siguientes 20 registros de pf_historia para la operacion */
      select   'Secuencial'                    = hi_secuencial,
               'Cupon'                         = hi_cupon,
               'Fecha de Transaccion'          = convert (char(10),hi_fecha,@i_formato_fecha), /* GESCY2K B228 */
               'Codigo de Transaccion'         = hi_trn_code, 
               'Descripcion de la Transaccion' = t.tn_descripcion, 
               'Valor de la operacion'         = hi_valor,           
               'Observacion'                   = hi_observacion,
               'Funcionario'                   = hi_funcionario,
               'Tasa'                          = hi_tasa
      from   pf_historia, 
             cobis..cl_ttransaccion t 
      where  @w_operacionpf = hi_operacion
        and  hi_trn_code    = t.tn_trn_code
        and  hi_trn_code    <> 14904
        and  hi_secuencial  > @i_secuencial
      order  by hi_secuencial 
   end
   set rowcount 0 
   return 0   

end /* end del if 'Consulta' */

if @i_operacion = 'N' --detalle de titulares anteriores del endoso
begin 
      /* Verifica si la operacion existe en tabla pf_operacion */
      select @w_operacionpf = op_operacion
      from pf_operacion
      where op_num_banco = @i_num_banco
	  
      select 'Cliente' = b.en_ente,
             'Rol'     = en_rol,
             'Nombre'  = b.en_nomlar
      from cob_pfijo..pf_endoso_prop a,
           cobis..cl_ente b
      where en_operacion = @w_operacionpf
        and en_historia  = @i_secuencial
        and b.en_ente    = a.en_ente
      order by en_rol desc 
end

go
