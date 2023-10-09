/************************************************************************/
/*      Archivo:                consulopgar.sp                          */
/*      Stored procedure:       sp_consulopgar                          */
/*      Base de datos:          cob_pfijo                               */
/*      Producto:               Plazo Fijo                              */
/*      Disenado por:           Roxana Sánchez                         */
/*      Fecha de documentacion: 18/Enero/17                             */
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
/*      18-Ene-17  Roxana Sanchez     Creacion                          */
/*      10-May-17  Jorge Salazar      CGS-S108546                       */
/************************************************************************/

use cob_pfijo
go

if exists (select * from sysobjects where name = 'sp_consulopgar')
   drop proc sp_consulopgar
go

create proc sp_consulopgar (
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
   @i_accion               catalogo        = null,
   @i_estado1              catalogo        = 'ACT',
   @i_estado2              catalogo        = 'VEN',
   @i_estado3              catalogo        = null,
   @i_operacion            char(1)         = null,
   @i_ente                 int             = NULL,
   @i_modo                 char(1)         = NULL,
   @i_tasa_variable        char(1)         = '%',
   @i_aprobacion           char(1)         = 'N',
   @i_login_oficial        login           = null,
   @i_oficina              int             = null,
   @i_busq_x_ofi           varchar(3)      = NULL
)
as

declare @w_sp_name              descripcion,
        @w_return               tinyint,
        @w_busq_ofi             varchar(4)   

select @w_sp_name = 'sp_consulopgar'

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
if  @i_operacion = 'H'
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

--------------------------------------------
-- Consulta de datos generales del deposito
--------------------------------------------
if @i_operacion = 'S'
begin 
--print 'consop.sp I_APROBACION %1! I_ENTE %2! I_MODO %3!',@i_aprobacion, @i_ente, @i_modo
if @i_ente is not null
begin
      if @i_modo = '1'
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
            or (op_estado like @i_estado3 ))
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
end
   
if @i_operacion ='Q'
  begin  
         select 'Monto'           = op_monto,
                'Monto Garantia'  = 0, -- No existe definicion para este valor
                'Monto Bloqueado' = op_monto_blq,
                'Descripcion' = (select isnull(en_nomlar, en_nombre + p_p_apellido + p_s_apellido ) from cobis..cl_ente where en_ente = B.be_ente)
         from   pf_operacion with (index = pf_operacion_Key), pf_beneficiario B
         where  op_num_banco = @i_num_banco
           and  op_num_banco like @i_codigo
           and be_operacion = op_operacion
           and be_estado_xren = 'N'
           and be_tipo        = 'T'
           and be_estado      = 'I'
           and ((op_estado like @i_estado1 )
            or (op_estado like @i_estado2  and op_accion_sgte like @i_accion_sgte)
            or ( op_estado like @i_estado3 ))
           and op_tasa_variable like @i_tasa_variable
         order by op_num_banco 
   end

set rowcount 0
return 0
go

