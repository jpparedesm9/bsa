/************************************************************************/
/*      Archivo:                consop.sp                               */
/*      Stored procedure:       sp_consop                               */
/*      Base de datos:          cobis                                   */
/*      Producto:               Plazo Fijo                              */
/*      Disenado por:           Miryam Davila                           */
/*      Fecha de documentacion: 24/Oct/94                               */
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
/*      Este script crea los procedimientos para las consultas de las   */
/*      operaciones de plazos fijos.                                    */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*      FECHA      AUTOR              RAZON                             */
/*      25-Nov-94  Juan Lam           Creacion                          */
/*      04-Sep-95  Carolina Alvarado  Acceso por estado y accion_sgte   */
/*      23-May-00  Ximena Catagena U  Control para consulta de Fusion y */
/*                                    Fraccionamiento.                  */
/*      18-Mar-2005 N. Silva          Correcciones Indentacion          */
/*      01-Nov-2005 Luis Im           Modo de consulta para reverso     */
/*                                    de orden de pago                  */
/************************************************************************/

use cob_pfijo
go

SET NOCOUNT ON
go

SET ANSI_NULLS OFF
go

SET QUOTED_IDENTIFIER OFF
go

if exists (select 1 from sysobjects where name = 'sp_consop')
   drop proc sp_consop
go

create proc sp_consop (
	@s_ssn                  int             = NULL,
	@s_user                 login           = NULL,
	@s_term                 varchar(30)     = NULL,
	@s_date                 datetime        = NULL,
	@s_srv                  varchar(30)     = NULL,
	@s_lsrv                 varchar(30)     = NULL,
	@s_ofi                  smallint        = NULL,
	@s_rol                  smallint        = NULL,
	@t_debug                char(1)         = 'N',
	@t_file                 varchar(10)     = NULL,
	@t_from                 varchar(32)     = NULL,
	@t_trn                  smallint        = NULL,
	@i_num_banco            cuenta          = ' ',
	@i_codigo               varchar(30)     = '%',
	@i_accion_sgte          catalogo        = null,
	@i_accion		catalogo	= null,	
	@i_estado1          	catalogo        = 'ACT',
	@i_estado2          	catalogo        = 'VEN',
	@i_estado3          	catalogo        = null,
	@i_operacion            char(1)         = null,
	@i_ente                 int             = NULL,
        @i_modo                 char(1)         = NULL,
        @i_tasa_variable        char(1)         = '%',
        @i_aprobacion           char(1)         = 'N',
        @i_login_oficial        login           = null,
        @i_oficina		        int		        = null,
        @i_busq_x_ofi           varchar(3)      = NULL,
        @w_busq_ofi             varchar(4)      = NULL
)
with encryption
as
declare @w_sp_name              descripcion,
        @w_return               tinyint

select @w_sp_name = 'sp_consop'

/*----------------------------------*/
/*  Verificar codigo de transaccion */
/*----------------------------------*/
if @t_trn <> 14806 and @i_operacion = 'H'
begin
  exec cobis..sp_cerror
       @t_debug = @t_debug,
       @t_file  = @t_file,
       @t_from  = @w_sp_name,
       @i_num   = 141042
  return 1
end

if @i_num_banco is null or @i_num_banco = ''
  select @i_aprobacion = 'N'

if @i_num_banco is null
  select @i_num_banco = ' '

if @i_tasa_variable is null
   select @i_tasa_variable = '%'

if @i_busq_x_ofi in ('CAN','REN','EPP') begin
   if @s_ofi = 28 
      select @w_busq_ofi = '%'
   else
      select @w_busq_ofi = @s_ofi
end
else
begin
   select @w_busq_ofi = '%'
end   
   
if @i_codigo is null
  select @i_codigo = '%'
else
  select @i_codigo = '%' + @i_codigo + '%'

set rowcount 20

----------------------------
-- Condiciones para Endoso
----------------------------
if @i_accion = 'END'
begin
  select distinct 'Num. Deposito'= op_num_banco,
                  Descripcion    = op_descripcion,
                  Estado         = op_estado
    from pf_operacion with (index = pf_operacion_Key),pf_endoso_prop
   where op_num_banco > @i_num_banco
     and op_num_banco like @i_codigo
     and ((op_estado like @i_estado1)
          or (op_estado like @i_estado2  and op_accion_sgte like @i_accion_sgte)
          or ( op_estado like @i_estado3 ))
     and op_operacion = en_operacion  
  order by op_num_banco
 
  return 0
end

------------------------------------------------------------------
-- Proceso para consulta de operaciones Fusionadas o Fraccionadas 
------------------------------------------------------------------
if @i_accion in('FRA', 'FUS') --23-May-2000 xca
begin
   select distinct 'Num. Deposito'= op_num_banco,
                   Descripcion=op_descripcion,
                   Estado=op_estado
     from pf_operacion with (index = pf_operacion_Key),pf_fusfra
    where op_num_banco > @i_num_banco
      and op_num_banco like @i_codigo
      and ((op_estado like @i_estado1)
          or (op_estado like @i_estado2  and op_accion_sgte like @i_accion_sgte)
          or ( op_estado like @i_estado3 )) 
      and ((op_operacion = fu_operacion)  or (op_operacion = fu_operacion_new))
      and fu_mnemonico = @i_accion
   order by op_num_banco
end

--Criterio para Retencion CVA Set-28-2005
if @i_accion = 'B'
begin
         select 'Num. Deposito'= op_num_banco,
                Descripcion    = op_descripcion,
                Estado         = op_estado
           from pf_operacion pf with (index = pf_operacion_Key) 
          where op_num_banco > @i_num_banco
            and op_num_banco like @i_codigo
            and ((op_estado   like @i_estado1)
                or (op_estado like @i_estado2  and op_accion_sgte like @i_accion_sgte)
                or ( op_estado like @i_estado3 ))
            and op_retenido = 'S'
            and op_operacion not in (select op_operacion from pf_retencion where rt_operacion = pf.op_operacion and rt_motivo = 'BCHQL') -- NYMR NR 192
          order by op_num_banco
end

--Criterio para Bloqueo Legal
if @i_accion = 'L'
begin
         select 'Num. Deposito'= op_num_banco,
                Descripcion    = op_descripcion,
                Estado         = op_estado
           from pf_operacion with (index = pf_operacion_Key)
          where op_num_banco > @i_num_banco
            and op_num_banco like @i_codigo
            and ((op_estado   like @i_estado1)
                or (op_estado like @i_estado2  and op_accion_sgte like @i_accion_sgte)
                or ( op_estado like @i_estado3 ))
            and op_bloqueo_legal = 'S'
          order by op_num_banco
end

--Criterio para Pignoracion
if @i_accion = 'P'
begin
         select 'Num. Deposito'= op_num_banco,
                Descripcion    = op_descripcion,
                Estado         = op_estado
           from pf_operacion with (index = pf_operacion_Key)
          where op_num_banco > @i_num_banco
            and op_num_banco like @i_codigo
            and ((op_estado   like @i_estado1)
                or (op_estado like @i_estado2  and op_accion_sgte like @i_accion_sgte)
                or ( op_estado like @i_estado3 ))
            and op_pignorado = 'S'
          order by op_num_banco

end

--Reverso de Orden de Pago
if @i_accion = 'R'							--LIM 01/NOV/2005
begin
         select 'Num. Deposito'= op_num_banco,
                Descripcion    = op_descripcion,
                Estado         = op_estado
           from pf_operacion with (index = pf_operacion_Key)
          where op_num_banco > @i_num_banco
            and op_num_banco like @i_codigo
            and ((op_estado   like @i_estado1)
                or (op_estado like @i_estado2  and op_accion_sgte like @i_accion_sgte)
                or ( op_estado like @i_estado3 ))
            and op_operacion in (select mm_operacion from pf_mov_monet
                            where  mm_estado    = 'A'
                            and mm_tran      = 14943
                            and mm_fecha_aplicacion = @s_date)
          order by op_num_banco

end


--------------------------------------------
-- Consulta de datos generales del deposito
--------------------------------------------
--print 'consop.sp I_APROBACION %1! I_ENTE %2! I_MODO %3!',@i_aprobacion, @i_ente, @i_modo
if @i_ente is not null
begin
      if @i_modo <> '1'
      begin
         select 'Num. Deposito'= op_num_banco,
                'Descripcion' = (select isnull(en_nomlar, en_nombre + p_p_apellido + p_s_apellido ) from cobis..cl_ente where en_ente = B.be_ente)   , 
                Estado         = op_estado
         from pf_operacion with (index = pf_operacion_Key), pf_beneficiario B
         where op_num_banco > @i_num_banco
           and op_num_banco like @i_codigo
           and be_operacion = op_operacion
           and be_ente      = @i_ente
	   and be_estado_xren = 'N'
           and be_tipo        = 'T'
           and be_estado      = 'I'
           and ((op_estado like @i_estado1 )
	          or (op_estado like @i_estado2  and op_accion_sgte like @i_accion_sgte)
	          or ( op_estado like @i_estado3 ))
           and op_tasa_variable like @i_tasa_variable
         order by op_num_banco
      end
      else   -- Se envia monto pignorado 
      begin
     
         select 'Num. Deposito'   = op_num_banco,
                'Descripcion' = (select isnull(en_nomlar, en_nombre + p_p_apellido + p_s_apellido ) from cobis..cl_ente where en_ente = B.be_ente)   , 
                'Estado'          = op_estado,
                'Fecha Ven'       = op_fecha_ven,
                'Monto'           = op_monto,
                'Monto Pignorado' = op_monto_pgdo,
                'Moneda '         = op_moneda
         from   pf_operacion with (index = pf_operacion_Key), pf_beneficiario B
         where  op_num_banco > @i_num_banco
           and  op_num_banco like @i_codigo
           and be_operacion = op_operacion
           and be_ente        = @i_ente 
	   and be_estado_xren = 'N'
           and be_tipo        = 'T'
           and be_estado      = 'I'
           and ((op_estado like @i_estado1 )
            or (op_estado like @i_estado2  and op_accion_sgte like @i_accion_sgte)
            or ( op_estado like @i_estado3 ))
           and op_tasa_variable like @i_tasa_variable
         order by op_num_banco 
      end
end
else
begin

   if @i_aprobacion <> 'S'
   begin


      if @i_accion = 'O' begin

	      if @i_modo <> '1'
	      begin
	         select 'Num. Deposito'= op_num_banco,
	                Descripcion    = op_descripcion,
	                Estado         = op_estado
	           from pf_operacion with (index = pf_operacion_Key)
	          where op_num_banco > @i_num_banco
	            and op_num_banco like @i_codigo
	            and ((op_estado like @i_estado1)
	                or (op_estado like @i_estado2  and op_accion_sgte like @i_accion_sgte)
	                or ( op_estado like @i_estado3 ))
	            and op_tasa_variable like @i_tasa_variable
	            and op_oficina = isnull(@i_oficina,@s_ofi)
	          order by op_num_banco
	      end
	      else   -- Se envia monto pignorado 
	      begin
	     
	         select 'Num. Deposito'= op_num_banco,
	                'Descripcion' = op_descripcion,
	                'Estado'= op_estado,
	                'Fecha Ven'= op_fecha_ven,
	                'Monto'= op_monto,
	                'Monto Pignorado'= op_monto_pgdo,
	                'Moneda ' = op_moneda  
	           from pf_operacion with (index = pf_operacion_Key)
	          where op_num_banco > @i_num_banco
	            and op_num_banco like @i_codigo
	            and ((op_estado like @i_estado1)
	                or (op_estado like @i_estado2  and op_accion_sgte like @i_accion_sgte)
	                or ( op_estado like @i_estado3 ))
	            and op_tasa_variable like @i_tasa_variable
	            and op_oficina = isnull(@i_oficina,@s_ofi)
	          order by op_num_banco       
	      end

      end
      else
      begin
      
	      if @i_modo <> '1'
	      begin
	      
	         select 'Num. Deposito'= op_num_banco,
	                Descripcion    = op_descripcion,
	                Estado         = op_estado
	           from pf_operacion with (index = pf_operacion_Key)
	          where op_num_banco > @i_num_banco
	            and op_num_banco like @i_codigo
	            and ((op_estado like @i_estado1)
	                or (op_estado like @i_estado2  and op_accion_sgte like @i_accion_sgte)
	                or ( op_estado like @i_estado3 ))
	            and op_tasa_variable like @i_tasa_variable
	            and op_oficina like @w_busq_ofi
	          order by op_num_banco
	      end
	      else   -- Se envia monto pignorado 
	      begin
	      
	         select 'Num. Deposito'= op_num_banco,
	                'Descripcion' = op_descripcion,
	                'Estado'= op_estado,
	                'Fecha Ven'= op_fecha_ven,
	                'Monto'= op_monto,
	                'Monto Pignorado'= op_monto_pgdo,
	                'Moneda ' = op_moneda  
	           from pf_operacion with (index = pf_operacion_Key)
	          where op_num_banco > @i_num_banco
	            and op_num_banco like @i_codigo
	            and ((op_estado like @i_estado1)
	                or (op_estado like @i_estado2  and op_accion_sgte like @i_accion_sgte)
	                or ( op_estado like @i_estado3 ))
	            and op_tasa_variable like @i_tasa_variable
	            and op_oficina like @w_busq_ofi
	          order by op_num_banco       
	      end
      end
   end --if @i_aprobacion <> 'S'
end

   ----------------------------------------------
   -- Condiciones para funcionarios relacionados
   ----------------------------------------------
   if @i_aprobacion = 'S'
   begin
      select distinct 'Num. Deposito'= op_num_banco,
                       Descripcion    = op_descripcion,
                       Estado         = op_estado
      from pf_operacion with (index = pf_operacion_Key),pf_funcionario
      where op_num_banco     > @i_num_banco
        and op_num_banco     like @i_codigo
        and op_estado        like @i_estado1
        and op_oficial       = fu_func_relacionado
        and fu_tautorizacion = 'APRO'
        and fu_estado        = 'A'
        and fu_funcionario   = @i_login_oficial
     order by op_num_banco
   end

set rowcount 0
return 0
go

