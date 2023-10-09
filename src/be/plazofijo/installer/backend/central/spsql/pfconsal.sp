/************************************************************************/
/*      Archivo:                pfconsal.sp                             */
/*      Stored procedure:       sp_pfconsal                             */
/*      Base de datos:          cob_pfijo                               */
/*      Producto:               Plazo_fijo                              */
/*      Disenado por:           Ivonne Torres                           */
/*      Fecha de documentacion: 05/oct/2005                             */
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
/*      Este procedimiento almacenado realiza la actualizacion de datos */
/*      de clientes en Plazo Fijo cuando se han modificado.             */
/*                                                                      */
/************************************************************************/
/*      02/23/2007    R.Linares   Agregar campo estado                  */
/************************************************************************/
use cob_pfijo
go

SET NOCOUNT ON
go

SET ANSI_NULLS OFF
go

SET QUOTED_IDENTIFIER OFF
go

if exists (select 1 from sysobjects where name = 'sp_pfconsal')
   drop proc sp_pfconsal 
go

create proc sp_pfconsal (
   @s_ssn                  int          = NULL,
   @s_user                 login        = NULL,
   @s_sesn                 int          = NULL,
   @s_term                 varchar(30)  = NULL,
   @s_date                 datetime     = NULL,
   @s_srv                  varchar(30)  = NULL,
   @s_lsrv                 varchar(30)  = NULL,
   @s_ofi                  smallint     = NULL,
   @s_rol                  smallint     = NULL,
   @t_debug                char(1)      = 'N',
   @t_trn                  int          = 14201,
   @i_fecha                datetime)
with encryption
as
declare         
   @w_op_ente                            int,
   @w_op_descripcion            varchar(255),
   @w_op_ced_ruc                      numero,
   @w_op_oficial_principal             login,
   @w_op_fecha_valor                datetime,
   @w_op_num_banco                    cuenta,
   @w_op_saldo                         money,
   @w_op_saldo_contable                money,
   @w_op_fecha_ven                  datetime,
   @w_op_tasa                          float,
   @w_error                              int,
   @w_op_funcionario                smallint,
   @w_en_grupo                           int,
   @w_cuenta                      varchar(15),
   @w_estado                      varchar(10),
   @w_descestado                  varchar(64)


delete from cob_reportes..cl_cons_saldos where cs_fecha_saldo = @i_fecha and cs_producto = 'PFI'


declare cursor_reporte cursor
for select  op_ente,
            op_descripcion,
            op_ced_ruc,
            op_oficial_principal,
            op_fecha_valor,
            op_num_banco,
            op_monto, --I.CVA Ene-26-07 
            op_monto,
            op_fecha_ven,
            op_tasa,
            op_estado
    from pf_operacion
    where op_estado in ('ACT','VEN','XACT')
for read only
open cursor_reporte

fetch cursor_reporte into
   @w_op_ente,
   @w_op_descripcion,
   @w_op_ced_ruc,
   @w_op_oficial_principal,
   @w_op_fecha_valor,
   @w_op_num_banco,
   @w_op_saldo,
   @w_op_saldo_contable,
   @w_op_fecha_ven,
   @w_op_tasa,
   @w_estado

while @@fetch_status <> -1
begin
   if @@fetch_status = -2
   begin
      print 'Error en ejecucion del cursor'
      close cursor_reporte
      deallocate cursor_reporte
      
      return 1
   end
   
   
   select @w_descestado  = NULL

   select @w_op_funcionario = fu_funcionario 
   from cobis..cl_funcionario 
   where fu_login = @w_op_oficial_principal

   select @w_cuenta = convert(varchar,@w_op_ente)

   select @w_op_ced_ruc = en_ced_ruc,
     @w_en_grupo   = isnull(en_grupo,0)
   from cobis..cl_ente
   where en_ente = @w_op_ente

   select @w_descestado  = valor
   from cobis..cl_tabla t,
                cobis..cl_catalogo c
   where t.tabla  = 'pf_estado'
     and t.codigo = c.tabla
     and c.codigo = @w_estado
   


   insert into cob_reportes..cl_cons_saldos (cs_ente, cs_nomlar, cs_ced_ruc,cs_oficial,
                                      cs_producto,cs_fecha_apertura,cs_cuenta,cs_saldo,
                                      cs_fecha_vecimiento,cs_tasa_int,cs_fecha_saldo,cs_saldo_capital,
                  cs_grupo,cs_estado,cs_descestado)
                              values (@w_op_ente,@w_op_descripcion,@w_op_ced_ruc,@w_op_funcionario,
                                      'PFI',@w_op_fecha_valor,@w_op_num_banco,@w_op_saldo,
                                      @w_op_fecha_ven,@w_op_tasa,@i_fecha,@w_op_saldo_contable,
                  @w_en_grupo,@w_estado,@w_descestado)

   if @@rowcount <> 1 
   begin
      exec sp_errorlog 
         @i_fecha   = @s_date,
         @i_error   = 150000,
         @i_usuario = @s_user,
         @i_tran    = @t_trn,
         @i_cuenta  = @w_cuenta

      goto SIGUIENTE
   end

SIGUIENTE:

   fetch cursor_reporte into
      @w_op_ente,
      @w_op_descripcion,
      @w_op_ced_ruc,
      @w_op_oficial_principal,
      @w_op_fecha_valor,
      @w_op_num_banco,
      @w_op_saldo,
      @w_op_saldo_contable,
      @w_op_fecha_ven,
      @w_op_tasa,
      @w_estado
   
end

close cursor_reporte
deallocate cursor_reporte

return 0

go
