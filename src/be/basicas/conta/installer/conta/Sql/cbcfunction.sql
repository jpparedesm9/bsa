USE [cob_conta]
GO
/****** Object:  UserDefinedFunction [dbo].[funt_sum_deb]    Script Date: 03/14/2016 08:44:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
create function [dbo].[funt_sum_deb] (@w_comprobante int, @w_moneda char(1))  returns  money
as
begin
     declare @w_debito   money

     select  @w_debito = 0

     if @w_moneda = 'N'
     begin     
         select @w_debito = sum(isnull(co_debito,0))
         from cob_conta..cb_convivencia
         where co_comprobante = @w_comprobante
     end

     if @w_moneda = 'E'
     begin     
         select @w_debito = sum(isnull(co_debito_me,0))
         from cob_conta..cb_convivencia
         where co_comprobante = @w_comprobante     
     end
     return @w_debito
end
GO
/****** Object:  UserDefinedFunction [dbo].[funt_sum_cred]    Script Date: 03/14/2016 08:44:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
create function [dbo].[funt_sum_cred] (@w_comprobante int, @w_moneda char(1))  returns  money
as
begin
     declare @w_credito   money

     select  @w_credito = 0

     if @w_moneda = 'N'
     begin
         select @w_credito = sum(isnull(co_credito,0))
         from cob_conta..cb_convivencia
         where co_comprobante = @w_comprobante
     end

     if @w_moneda = 'E'
     begin
         select @w_credito = sum(isnull(co_credito_me,0))
         from cob_conta..cb_convivencia
         where co_comprobante = @w_comprobante
     end
               
     return @w_credito
end
GO
/****** Object:  UserDefinedFunction [dbo].[funt_count_comp]    Script Date: 03/14/2016 08:44:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
create function [dbo].[funt_count_comp] (@w_comprobante int)  returns  int
as
begin
     declare @w_cantidad   int

     select  @w_cantidad = 0

         select @w_cantidad = count(1)
         from cob_conta..cb_convivencia
         where co_comprobante = @w_comprobante
     
     return @w_cantidad 
end
GO
/****** Object:  UserDefinedFunction [dbo].[funct_procta]    Script Date: 03/14/2016 08:44:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
create function [dbo].[funct_procta] (@w_cuenta varchar(14), @w_empresa  tinyint)  returns int
as
begin
     declare   @w_condicion    char(4),
               @w_proceso      int,
               @w_proc_cuenta  int

     select @w_condicion = cp_condicion,
            @w_proceso   = cp_proceso
     from cob_conta..cb_cuenta_proceso
     where cp_proceso in (6003, 6095)
     and   cp_cuenta  = @w_cuenta
     and   cp_empresa = @w_empresa

     if (@w_proceso = '6003') and (@w_condicion = 'X')
               select @w_proc_cuenta = 2
     if (@w_proceso = '6003') and (@w_condicion = 'D')
               select @w_proc_cuenta = 3
     if (@w_proceso = '6095') and (@w_condicion = 'I')
               select @w_proc_cuenta = 4
     if (@w_proceso = '6095') and (@w_condicion = 'C')
               select @w_proc_cuenta = 5
     if (@w_proceso = '6095') and (@w_condicion = 'P')
               select @w_proc_cuenta = 6
     if (@w_proceso = '6095') and (@w_condicion = 'T')
               select @w_proc_cuenta = 7
     if (@w_proceso = '6095') and (@w_condicion = 'R')
               select @w_proc_cuenta = 8
     if (@w_proceso = '6095') and (@w_condicion = 'V')
               select @w_proc_cuenta = 20
     if (@w_proceso = '6095') and (@w_condicion = 'E')
               select @w_proc_cuenta = 21

     return @w_proc_cuenta
end
GO
/****** Object:  UserDefinedFunction [dbo].[funct_ente]    Script Date: 03/14/2016 08:44:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
create function [dbo].[funct_ente] (@w_doc  varchar(30), @w_tipo_doc char(2), @w_tipo_ente varchar(1))  returns int

as

begin

   declare   @w_ente    int
   
   if (@w_tipo_ente = 'N') or (@w_tipo_ente = ' ') begin
      select @w_ente = en_ente
      from cobis..cl_ente
      where en_tipo_ced = @w_tipo_doc
      and   en_ced_ruc  = @w_doc
   end
   if @w_tipo_ente = 'D' begin

      select @w_ente = den_ente
      from cobis..cl_depu_ente
      where den_tipo_ced = @w_tipo_doc
      and   den_ced_ruc  = @w_doc
   end
   
   return @w_ente
   
end
GO
/****** Object:  UserDefinedFunction [dbo].[cp_descripcion]    Script Date: 03/14/2016 08:44:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
create function [dbo].[cp_descripcion] (@w_operacion char(1), @w_concepto int)  returns  varchar(50)
as
begin

     declare @descripcion   descripcion,
             @w_impuesto    descripcion

     if @w_concepto = 9999
     begin
          select @w_impuesto = ' '
     
          select @w_impuesto = valor
          from cobis..cl_catalogo
          where tabla = (select codigo from cobis..cl_tabla
                         where tabla = 'cb_tipo_impuesto')
          and   codigo = convert(char(10),@w_operacion)
     
          select @descripcion = 'PAGO ' + @w_impuesto
          return @descripcion
     End
          
     if @w_operacion = 'C'
          select @descripcion = ic_descripcion
          from cob_conta..cb_ica
          where ic_codigo = @w_concepto

          
     if @w_operacion = 'I'
          select @descripcion = iva_descripcion
          from cob_conta..cb_iva
          where iva_codigo = @w_concepto
          and   iva_descripcion <> null

     if @w_operacion = 'P'
          select @descripcion = ip_descripcion
          from cob_conta..cb_iva_pagado
          where ip_codigo = @w_concepto
          
     if @w_operacion = 'R'
          select @descripcion = cr_descripcion
          from cb_conc_retencion
          where cr_codigo = @w_concepto
          and   cr_tipo = 'R'
        
     if @w_operacion = 'T'
          select @descripcion = cr_descripcion
          from cb_conc_retencion
          where cr_codigo = @w_concepto
          and   cr_tipo = 'R'

     if @w_operacion = 'V'
          select @descripcion = iva_descripcion
          from cob_conta..cb_iva
          where iva_codigo = @w_concepto
          and   iva_descripcion <> null;
          
     return @descripcion

end
GO
