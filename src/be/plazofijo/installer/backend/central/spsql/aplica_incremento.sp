/************************************************************************/
/*      Archivo:                aplicinc.sp                             */
/*      Stored procedure:       sp_aplica_incremento                    */
/*      Base de datos:          cobis                                   */
/*      Producto:               Plazo Fijo                              */
/*      Disenado por:           Gabriela Estupinan                      */
/*      Fecha de documentacion: 20/Ago/01                               */
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
/*      Este script se encarga de realizar la aplicacion de incrementos */
/*      para prorrogas automaticas de depositos vencidos.               */
/*                                                                      */
/*                              MODIFICACIONES                          */
/*      FECHA       AUTOR              RAZON                            */
/*      20-Ago-01   Gabriela Estupinan Emision Inicial  CUZ-024-045     */
/*      09-Jun-2005 N. Silva           Correcciones e identacion        */
/************************************************************************/
use cob_pfijo
go

SET NOCOUNT ON
go

SET ANSI_NULLS OFF
go

SET QUOTED_IDENTIFIER OFF
go

if exists (select 1 from sysobjects where name = 'sp_aplica_incremento' and type = 'P')
   drop proc sp_aplica_incremento
go
create proc sp_aplica_incremento (
       @s_ssn                  int             = 0,
       @s_sesn                 INT             = NULL,
       @s_user                 login           = NULL,
       @s_ofi                  smallint        = NULL,
       @s_date                 datetime        = NULL,
       @s_srv                  varchar(30)     = NULL,
       @s_term                 varchar(30)     = NULL,
       @t_file                 varchar(10)     = NULL,
       @t_from                 varchar(32)     = NULL,
       @t_debug                char(1)         = 'N',
       @t_trn                  int,
       @i_num_banco            cuenta,
       @i_tipo                 char(1),
       @i_secuencia            int,
       @i_empresa              tinyint         = 1,     
       @i_total                money,
       @i_op_operacion         int,
       @i_en_linea             char(1)         = 'S'
  )
with encryption
as
declare @w_sp_name                   descripcion,
        @w_moneda_base               tinyint,

        /*  Variables para det_cheque_tmp   */
        @w_ct_banco                     catalogo,         
        @w_ct_cuenta                    cuenta,
        @w_ct_fpago                     catalogo,
        @w_ct_cheque                    int,
        @w_ct_fecha_crea                datetime,
        @w_ct_valor                     money,
        @w_ct_val                       money,
        @w_ct_val_tot                   money,
        @w_ct_descripcion               varchar(255),
        @w_ct_sub_secuencia             int,

        /* VARIABLES NECESARIAS PARA PF_MOV_MONET */

        @w_mm_sub_secuencia             tinyint,
        @w_mm_producto                  catalogo,
        @w_mm_cuenta                    cuenta,
        @w_mm_moneda                    smallint,
        @w_mm_valor                     money,
        @w_mm_valor_ext                 money,
        @w_mm_impuesto                  money,
        @w_mm_impuesto_capital_me       money,

        /* VARIABLES NECESARIAS PARA PF_OPERACION */
        @w_return                       int,
        @w_numdeci                      tinyint,
        @w_comprobante                  int,
        @w_descripcion                  descripcion

-------------------------------------

-- Obtener codigo de moneda nacional
-------------------------------------

select @w_moneda_base = em_moneda_base
  from cob_conta..cb_empresa
 where em_empresa = @i_empresa
if @@rowcount = 0
begin
   exec cobis..sp_cerror
        @t_debug=@t_debug,
        @t_file=@t_file,
        @t_from=@w_sp_name,
        @i_num = 601018
   return 1
end 

-------------------------------------------------
-- Buscar la existencia del movimiento monetario
-------------------------------------------------

if not exists(select mm_valor
                from pf_mov_monet
               where mm_operacion   = @i_op_operacion             
                 and mm_tran        = 14989
                 and mm_secuencia   = @i_secuencia) 
begin

   exec cobis..sp_cerror 
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,   
        @i_num   = 141150
   return 1
end   


----------------------------------------

-- Aplicacion de movimientos monetarios
----------------------------------------
begin tran

  -------------------------------------------------------------
  -- Actualizacion de registro de secuencia de ticket aplicado
  -------------------------------------------------------------

  update pf_secuen_ticket
  set st_estado = 'C'
  where st_operacion = @i_op_operacion
    and st_secuencia = @i_secuencia
    and st_estado = 'I'

commit tran

return 0                                                      
go

