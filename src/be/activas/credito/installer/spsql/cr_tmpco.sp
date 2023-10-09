/************************************************************************/
/*  Archivo:                         cr_tmpco.sp                        */
/*  Stored procedure:                sp_tmp_concepto                    */
/*  Base de datos:                   cob_credito                        */
/*  Producto:                        Credito                            */
/*  Disenado por:                    Sheela Burbano                     */
/*  Fecha de escritura:              21-Jun-2001                        */
/************************************************************************/
/*              IMPORTANTE                                              */
/*  Este programa es parte de los paquetes bancarios propiedad de       */
/*  "MACOSA", representantes exclusivos para el Ecuador de NCR          */
/*  Su uso no autorizado queda expresamente prohibido asi como          */
/*  cualquier alteracion o agregado hecho por alguno de sus             */
/*  usuarios sin el debido consentimiento por escrito de la             */
/*  Presidencia Ejecutiva de MACOSA o su representante.                 */
/************************************************************************/
/*              PROPOSITO                                               */
/*  Este programa es llamado por otros modulos para llenar la tabla     */
/*  temporal de conceptos de las operaciones (cr_tmp_concepto) en el    */
/*  proceso mensual			                                */
/*									*/
/************************************************************************/
/*              MODIFICACIONES                                          */
/*  FECHA       AUTOR                    RAZON                          */
/*  21/Jun/01   Sheela Burbano           Emision inicial                */
/************************************************************************/


use cob_credito
go

if exists (select 1 from sysobjects where name = 'sp_tmp_concepto')
   drop proc sp_tmp_concepto
go

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO

create proc sp_tmp_concepto(
   @t_debug                   char(1) = 'N',
   @t_file                    varchar(10) = null,
   @t_from                    varchar(32) = null,
   @i_fecha		      datetime,	
   @i_codigo_producto         tinyint,
   @i_numero_operacion        int,
   @i_numero_operacion_banco  varchar(24),
   @i_concepto		      catalogo = null,
   @i_saldo	              money = 0,
   @i_operacion		      char(1)	--I insert, D delete
)
as
declare 
   @w_sp_name       	varchar(15),
   @w_error         	int,
   @w_descripcion	varchar(200)


select @w_sp_name = 'sp_tmp_concepto'


/* VERIFICACION VALORES NEGATIVOS */
if @i_saldo < 0 
begin
   /* SALDO NO PUEDE SER NEGATIVO */
   exec cobis..sp_cerror
   @t_debug = @t_debug,
   @t_file  = @t_file, 
   @t_from  = @w_sp_name,
   @i_num   = 2101145
   return 1 
end


/*** VERIFICACION DE CAMPOS NULOS Y CALCULOS VARIOS ***/
if (@i_operacion = "I")
begin
   if (@i_concepto is null)
   begin
      /* CAMPOS NOT NULL CON VALORES NULOS */
      exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file, 
      @t_from  = @w_sp_name,
      @i_num   = 2101001
      return 1 
   end
end


if @i_operacion = 'I'
begin
   begin tran
           if exists (select 1
                      from cr_tmp_concepto
           	      where cpt_producto = @i_codigo_producto
           	      and  cpt_num_op_banco = @i_numero_operacion_banco
                      and  cpt_concepto = @i_concepto)
           begin
	      delete cr_tmp_concepto 
              where cpt_producto = @i_codigo_producto
              and  cpt_num_op_banco = @i_numero_operacion_banco
              and  cpt_concepto = @i_concepto

	      if @@error != 0
	      begin
                 print 'Error al eliminar registro => No.Operacion: %1! Producto: %2! Concepto %3!' +cast (@i_numero_operacion_banco as varchar) + cast (@i_codigo_producto as varchar) + cast ( @i_concepto as varchar)

                 select @w_descripcion = 'Error al eliminar concepto: ' + @i_concepto 

   	         -- ERROR AL ELIMINAR REGISTRO EN TABLA TEMPORAL DE CONCEPTOS
   	         exec sp_error_batch        
   	         @i_fecha     = @i_fecha,
   	         @i_error     = 2107018,
   	         @i_programa  = @w_sp_name,
   	         @i_producto  = @i_codigo_producto,
                 @i_operacion = @i_numero_operacion_banco, 
	         @i_descripcion  = @w_descripcion

                 goto FIN
	      end
	   end

           if @i_saldo < 0
              select @i_saldo = 0

           insert into cr_tmp_concepto (
           cpt_fecha,			cpt_producto,		cpt_operacion,
	   cpt_num_op_banco, 		cpt_concepto,        	cpt_saldo )
	   values(
	   @i_fecha,				@i_codigo_producto,	@i_numero_operacion,
	   @i_numero_operacion_banco,	@i_concepto,		@i_saldo )

	   if @@error != 0
	   begin
              print 'Error al insertar registro => No.Operacion: %1! Producto: %2! Concepto %3!' + cast (@i_numero_operacion_banco as varchar) + cast (@i_codigo_producto as varchar) + cast (@i_concepto as varchar)

              select @w_descripcion = 'Error al eliminar concepto: ' + @i_concepto 

	      -- ERROR AL INGRESAR REGISTRO EN TABLA TEMPORAL DE CONCEPTOS
   	      exec sp_error_batch        
   	      @i_fecha     = @i_fecha,
   	      @i_error     = 2103049,
   	      @i_programa  = @w_sp_name,
   	      @i_producto  = @i_codigo_producto,
              @i_operacion = @i_numero_operacion_banco,
	      @i_descripcion  = @w_descripcion

              goto FIN
           end

    commit tran
end

if @i_operacion = 'D'
begin
   begin tran
	   delete cr_tmp_concepto 
           where cpt_producto = @i_codigo_producto
           and  cpt_num_op_banco = @i_numero_operacion_banco

	   if @@error != 0
	   begin
              print 'Error al eliminar registro => No.Operacion: %1! Producto: %2! Concepto %3!' + cast (@i_numero_operacion_banco as varchar )+ cast (@i_codigo_producto as varchar) + cast ( @i_concepto as varchar)

	      -- ERROR AL ELIMINAR REGISTRO EN TABLA TEMPORAL DE CONCEPTOS
   	      exec sp_error_batch        
   	      @i_fecha     = @i_fecha,
   	      @i_error     = 2107018,
   	      @i_programa  = @w_sp_name,
   	      @i_producto  = @i_codigo_producto,
              @i_operacion = @i_numero_operacion_banco

              goto FIN
	   end

    commit tran
end

return 0

FIN:
return 1 

go