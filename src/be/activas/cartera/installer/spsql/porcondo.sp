/************************************************************************/
/*      Archivo:                porcondo.sp                             */
/*      Stored procedure:       sp_porc_condonacion                     */
/*      Producto:               Cartera                                 */
/*      Disenado por:           Jonnatan Peña                           */
/*      Fecha de escritura:     May. 2009                               */
/************************************************************************/
/*                              IMPORTANTE                              */
/*      Este programa es parte de los paquetes bancarios propiedad de   */
/*      "COBISCORP".                                                    */
/*      Su uso no autorizado queda expresamente prohibido asi como      */
/*      cualquier alteracion o agregado hecho por alguno de sus         */
/*      usuarios sin el debido consentimiento por escrito de la         */
/*      Presidencia Ejecutiva de COBISCORP o su representante.          */
/************************************************************************/  
/*                              PROPOSITO                               */
/*      Calcula el porcentaje que se ingrese del los rubros IMO y INT   */
/*      para la condonacion de pagos por este concepto.                 */
/************************************************************************/

use cob_cartera
go

if exists (select 1 from sysobjects where name = 'sp_porc_condonacion')
   drop proc sp_porc_condonacion
go

---Ver-9 Inc. 18447 MAr-10-2011 PAriendo de la Ver. 8

create proc sp_porc_condonacion 
   @s_user              login       = NULL,
   @i_banco             varchar(20) = NULL,  
   @i_concepto          catalogo    = NULL,
   @i_valor             smallint    = NULL,
   @i_operacion         char(1)     = NULL,
   @i_fecha_ini         datetime    = NULL,
   @i_fecha_fin         datetime    = NULL,
   @i_secuencial        int         = 0
as

declare 
   @w_sp_name           varchar(32),
   @w_error             int, 
   @w_msg               varchar(100),
   @t_trn               int,
   @w_smv               money,
   @w_operacion         int,
   @w_monto             money,
   @w_dividendo         int,
   @w_monto_porcentaje  money
                           
select @w_sp_name  = 'sp_porc_condonacion' 

if @i_operacion = 'S' begin

   select    
   'RUBROS'           = ac_rubro, 
   'DESCRIPCION'      = ac_des_rubro,
   'PROCENTAJE'     = ac_procentaje
   from ca_autorizacion_condonacion
   where ac_cargo = (select fu_cargo from cobis..cl_funcionario   -- ITO 3Feb2010 Req00072
                      where fu_login = @s_user)
         
   if @@rowcount = 0  begin                        
      select                                 
      @w_error  = 2101005,                    
      @w_msg    = 'NO EXISTEN REGISTROS PARA EL USUARIO'     
      goto ERROR                             
   end                                  
             
end

/* consulta de los rubros condonables de la operacion */
if @i_operacion = 'R' begin

    select @w_operacion = op_operacion 
    from   ca_operacion 
    where  op_banco = @i_banco

    select 'RUBROS'      = am_concepto, 
           'DESCRIPCION' = co_descripcion
    from   ca_dividendo,
           ca_amortizacion,
           ca_rubro_op,
           ca_concepto
    where  am_operacion = @w_operacion
    and    di_operacion = @w_operacion
    and    ro_operacion = @w_operacion
    and    am_operacion = di_operacion
    and    am_concepto  = ro_concepto
    and    di_operacion = ro_operacion
    and    (di_estado  = 2 or di_estado = 1 )
    and    co_concepto  = am_concepto
    and    am_estado    <> 3
    and    ((am_dividendo = di_dividendo + charindex (ro_fpago, 'A') and not(co_categoria in ('S','A') and am_secuencia > 1))
    or     (co_categoria in ('S','A') and am_secuencia > 1 and am_dividendo = di_dividendo))
    group by am_concepto, co_descripcion
end

if @i_operacion = 'Q' begin

   select ac_procentaje   
   from   ca_autorizacion_condonacion
   where  ac_cargo = (select fu_cargo from cobis..cl_funcionario   -- ITO 3Feb2010 Req00072
                      where fu_login = @s_user)
   and ac_rubro   = @i_concepto
         
   if @@rowcount = 0  begin                        
      select                                 
      @w_error = 2101005,                    
      @w_msg   = 'RUBRO NO AUTORIZADO PARA EL ROL DEL USUARIO, SOLICITE AUTORIZACON'     
      goto ERROR                             
   end                                  
             
end

/*  CONSULTA DE CONDONACIONES   */
-- ITO 3Feb2010: Req 00072

if @i_operacion = 'C' 
begin

   create table #consolidacion   (
   secuencial    int          identity,
   fecha         varchar(10)  null,
   cliente       int          null,
   cedula        int          null,
   usuario       varchar(15)  null,
   cargo         varchar(60)  null,
   item          varchar(15)  null,
   valor         money        null,
   porcentaje    float        null,
   estado        char(3)      null
   )
   
   insert into #consolidacion
   select 
   'FECHA'       = convert(varchar(10),ab_fecha_pag,103),
   'CLIENTE'     = op_cliente,
   'CED CLIENTE' = (select en_ced_ruc from cobis..cl_ente where en_ente = op_cliente),
   'USUARIO'     = ab_usuario,
   'CARGO'       = (select valor from   cobis..cl_catalogo 
                    where  tabla in (select codigo from cobis..cl_tabla where tabla = 'cl_cargo')
                    and    codigo in (select fu_cargo from cobis..cl_funcionario 
                                       where fu_login = ab_usuario)) ,  
   'RUBRO'        = abd_concepto,
   'VALOR'       = abd_monto_mpg,
   'PORCENTAJE'  = abd_porcentaje_con,
   'ESTADO'      = ab_estado
   from  ca_operacion, ca_abono,ca_abono_det
   where ab_secuencial_ing = abd_secuencial_ing
   and   op_banco      = @i_banco
   and   abd_operacion = op_operacion
   and   ab_operacion  = op_operacion
   and   abd_tipo      = 'CON'
   and   ab_fecha_pag between @i_fecha_ini and @i_fecha_fin

   if @@rowcount = 0  begin                        
      select                                 
      @w_error = 2101005,                    
      @w_msg   = 'NO EXISTEN REGISTROS PARA EL USUARIO'     
      goto ERROR                             
   end       

   set rowcount 25
   select 
   'FECHA'       = fecha,
   'CLIENTE'     = cliente,
   'CED CLIENTE' = cedula,
   'RUBRO'        = item,
   'VALOR'       = valor,
   'PORCENTAJE'  = porcentaje,
   'ESTADO'      = estado,
   'USUARIO'     = usuario,
   'CARGO'       = cargo
   from #consolidacion
   where secuencial > @i_secuencial
   order by secuencial

   set rowcount 0
                           
end

-- fin - ITO 3Feb2010: Req 00072



/*DATOS DE LA OPERACION*/

select 
@w_operacion = op_operacion 
from ca_operacion 
where op_banco = @i_banco

select 
@w_dividendo = max(di_dividendo)
from ca_dividendo
where di_operacion = @w_operacion
and   di_estado    in (1,2)

if @i_concepto = 'CAP'
   select @w_monto  = isnull(sum(am_cuota + am_gracia - am_pagado), 0)
   from   ca_amortizacion
   where  am_concepto  = @i_concepto
   and    am_operacion = @w_operacion
   and    am_dividendo <= @w_dividendo 
else
   select @w_monto  = isnull(sum(am_acumulado + am_gracia - am_pagado), 0)
   from   ca_amortizacion
   where  am_concepto  = @i_concepto
   and    am_operacion = @w_operacion
   and    am_dividendo <= @w_dividendo 

select @w_monto_porcentaje = (@w_monto * @i_valor)/100

select @w_monto_porcentaje

return 0       
        

ERROR:

exec cobis..sp_cerror
@t_debug = 'N',
@t_file  = null, 
@t_from  = @w_sp_name,
@i_num   = @w_error,
@i_msg   = @w_msg

return @w_error

go



