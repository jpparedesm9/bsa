/************************************************************************/
/*  Archivo:            query_clientes_ah.sp                            */
/*  Stored procedure:   sp_query_clientes_ah                            */
/*  Base de datos:      cob_ahorros                                     */
/*  Producto:           Cuentas de Ahorros                              */
/*  Disenado por:       Mauricio Bayas/Sandra Ortiz                     */
/*  Fecha de escritura: 24-Nov-1993                                     */
/************************************************************************/
/*              IMPORTANTE                                              */
/*  Esta aplicacion es parte de los paquetes bancarios propiedad        */
/*  de COBISCorp.                                                       */
/*  Su uso no    autorizado queda  expresamente   prohibido asi como    */
/*  cualquier    alteracion o  agregado  hecho por    alguno  de sus    */
/*  usuarios sin el debido consentimiento por   escrito de COBISCorp.   */
/*  Este programa esta protegido por la ley de   derechos de autor      */
/*  y por las    convenciones  internacionales   de  propiedad inte-    */
/*  lectual.    Su uso no  autorizado dara  derecho a    COBISCorp para */
/*  obtener ordenes  de secuestro o  retencion y para  perseguir        */
/*  penalmente a los autores de cualquier   infraccion.                 */
/************************************************************************/
/*                              PROPOSITO                               */
/*  Este programa realiza la transaccion de consulta de clientes        */
/*  para un numero de cuenta dado.                                      */
/************************************************************************/
/*                          MODIFICACIONES                              */
/*  FECHA           AUTOR           RAZON                               */
/*  24/Nov/1993     P Mena          Emision inicial                     */
/*  07/Jun/2000     Juan F. Cadena  Optimizaciones                      */
/*  06/Oct/2006     Ricardo Ramos   Control para apellido de casada     */
/*  12/12/2006      R.Linares       Control valida Inactiva             */
/*  24/Mar/2007     Clotilde Vargas Correccion control 12/12/2006       */
/*  02/May/2016     Juan Tagle      Migración a CEN                     */
/************************************************************************/
use cob_ahorros
go

if exists (select 1 from sysobjects where name = 'sp_query_clientes_ah')
   drop proc sp_query_clientes_ah
go

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE proc sp_query_clientes_ah (
    @t_debug          char(1) = 'N',
    @t_file           varchar(14) = null,
    @t_from           varchar(32) = null,
    @t_show_version   bit = 0,
    @i_cta            cuenta,
    @i_mon            tinyint,
    @i_cerrada        char(1) = 'A',
    @i_val_inac       char(1) = 'S',   --PARA VALIDAR O NO LA INACTIVIDAD
    @i_corresponsal   char(1) = 'N'  --Req. 381 CB Red Posicionada
)
as
declare @w_return       int,
        @w_sp_name      varchar(30),
        @w_est          char(1),
        @w_cuenta       int,
        @w_det_producto int,
        @w_oficina      smallint,
        @w_producto     tinyint,
        @w_tipo         char(1),
        @w_msg          varchar(40),
        @w_error        int,
        @w_prod_bancario   varchar(50) --Req. 381 CB Red Posicionada

/* Captura del nombre del Store Procedure */
select @w_sp_name = 'sp_query_clientes_ah'

---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
if @t_show_version = 1
begin
 print 'Stored Procedure= ' + @w_sp_name +  ' Version= ' + '4.0.0.0'
 return 0
end

/* Modo de debug */
if @t_debug = 'S'
begin
    exec cobis..sp_begin_debug @t_file=@t_file
    select '/** Store Procedure **/ ' = @w_sp_name,
    t_debug     = @t_debug,
    t_file          = @t_file,
    t_from      = @t_from,
    i_cta       = @i_cta,
    i_mon       = @i_mon
    exec cobis..sp_end_debug
end

--Extraer el catalogo re_pro_banc_cb Req. 381 CB Red Posicionada
select @w_prod_bancario = rtrim(cl_catalogo.codigo)
from cobis..cl_catalogo, cobis..cl_tabla
where cl_catalogo.tabla  = cl_tabla.codigo and
      cl_tabla.tabla     = 're_pro_banc_cb'
and   cl_catalogo.estado = 'V'

-- Req. 381 CB Red Posicionada - Si no es corresponsal no debe presentar las cuentas de corresponsales
if @i_corresponsal = 'N'
begin
   select
   @w_cuenta   = ah_cuenta,
   @w_est      = ah_estado,
   @w_oficina  = ah_oficina,
   @w_producto = ah_producto,
   @w_tipo     = ah_tipo
   from  cob_ahorros..ah_cuenta
   where ah_cta_banco = @i_cta
   and ah_moneda    = @i_mon
   and ah_prod_banc <> @w_prod_bancario -- Req. 381 CB Red Posicionada
   -- set transaction isolation level read uncommitted

   if @@rowcount = 0
   begin
      select
      @w_msg   = 'No existe cuenta de ahorros',
      @w_error = 251001
      goto ERROR
   end
end
else
begin
   select
   @w_cuenta   = ah_cuenta,
   @w_est      = ah_estado,
   @w_oficina  = ah_oficina,
   @w_producto = ah_producto,
   @w_tipo     = ah_tipo
   from  cob_ahorros..ah_cuenta
   where ah_cta_banco = @i_cta
   and   ah_moneda    = @i_mon
   -- set transaction isolation level read uncommitted

   if @@rowcount = 0
   begin
      select
      @w_msg   = 'No existe cuenta de ahorros',
      @w_error = 251001
      goto ERROR
   end
end

/* Validaciones */

/* Validar el estado de cuenta si @i_cerrada <> 'C' */

if @i_cerrada <> 'C'
  if (@w_est = 'I' and @i_val_inac = 'N')  --CVA Mar-09-07 Cambiar la forma de validacion
     goto novalida

  if @w_est not in ('A','G')   --or (@w_est = 'I' and @i_val_inac = 'S')
  begin
    /* Cuenta no activa o cancelada */
     if @w_est <> 'C'
     begin
        select
        @w_msg   = 'Cuenta no activa o cancelada',
        @w_error = 251002
        goto ERROR
     end
     else
     begin --Canceladas
        select
        @w_msg   = 'Cuenta cancelada',
        @w_error = 201088
        goto ERROR
     end
  end

novalida:

select @w_det_producto = dp_det_producto
from   cobis..cl_det_producto
where  dp_cuenta = @i_cta
and    dp_producto = @w_producto
and    dp_oficina = @w_oficina
and    dp_tipo = @w_tipo
and    dp_moneda = @i_mon
set transaction isolation level read uncommitted


select  '9937' = en_ente,                                                   -- 'CODIGO'         
        '9938' = en_ced_ruc, --p_pasaporte,                                  'IDENTIFICACION' 
        '9939' = en_subtipo,                                                 --'TIPO'           
        '9940' = case en_subtipo                                             --'NOMBRE'         
                 when 'C' then ltrim(rtrim(isnull(en_nomlar,en_nombre)))                   
                 else ltrim(rtrim(en_nomlar))                                              
                end,                                                                         
        '9941' = cl_rol,                                                     --'ROL'            
        '9942' = valor                                                       --'DESCRIPCION'    
from  cobis..cl_ente,
      cobis..cl_cliente,
      cobis..cl_catalogo
where cl_det_producto = @w_det_producto
and   en_ente = cl_cliente
and   cl_rol  = codigo
and   tabla   = (select cobis..cl_tabla.codigo
                 from   cobis..cl_tabla
                 where  tabla = 'cl_rol')

if @@error <> 0
begin
   select
   @w_msg   = 'No existe cliente',
   @w_error = 101061
   goto ERROR
end
return 0
ERROR:
   exec cobis..sp_cerror
   @i_num   = @w_error,
   @i_sev   = 0,
   @i_msg   = @w_msg
   return @w_error

go

