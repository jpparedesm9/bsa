/****************************************************************/
/*   ARCHIVO:         	sp_var_experiencia_crediticia.sp		*/
/*   NOMBRE LOGICO:   	sp_var_experiencia_crediticia           */
/*   PRODUCTO:        		CARTERA                             */
/****************************************************************/
/*                     IMPORTANTE                           	*/
/*   Esta aplicacion es parte de los  paquetes bancarios    	*/
/*   propiedad de MACOSA S.A.                               	*/
/*   Su uso no autorizado queda  expresamente  prohibido    	*/
/*   asi como cualquier alteracion o agregado hecho  por    	*/
/*   alguno de sus usuarios sin el debido consentimiento    	*/
/*   por escrito de MACOSA.                                 	*/
/*   Este programa esta protegido por la ley de derechos    	*/
/*   de autor y por las convenciones  internacionales de    	*/
/*   propiedad intelectual.  Su uso  no  autorizado dara    	*/
/*   derecho a MACOSA para obtener ordenes  de secuestro    	*/
/*   o  retencion  y  para  perseguir  penalmente a  los    	*/
/*   autores de cualquier infraccion.                       	*/
/****************************************************************/
/*                     PROPOSITO                            	*/
/*                                                              */
/*	Se obtiene de sumar los siguientes valores:                 */
/*  - Número de ciclos que el cliente haya tenido en otras      */
/*    entidades                                                 */
/*  - Número de préstamos individuales que el cliente haya      */
/*    terminado de pagar (CANCELADAS) que la persona tenga en la*/
/*	  entidad, sin importar si es en este grupo o si son        */
/*	  créditos grupales o individuales.                         */
/*  - Mas UNO, es decir, si este es el primer crédito que       */
/*	  solicita esta persona, este variable debe valer UNO.      */
/*                                                              */
/****************************************************************/
/*                     MODIFICACIONES                       	*/
/*   FECHA         AUTOR               RAZON                	*/
/*   24-Abr-2018   PXSG              Emision Inicial.     	*/
/*   05-07-2019    srojas       Reestructuración Buro histórico */
/* 24-Abr-2018   P. Ortiz            Indexar, update cl_ente_aux*/
/* 09/Nov/2020     DCU                 Mejoras                  */
/****************************************************************/

use cob_credito
go

if exists (select 1 from sysobjects where name = 'sp_var_experiencia_crediticia')
   drop proc sp_var_experiencia_crediticia
go

create proc [dbo].[sp_var_experiencia_crediticia](
	@t_debug       		char(1)        = 'N',
	@t_from        		varchar(30)    = null,
	@s_ssn              int            = null,
	@s_user             varchar(30)    = null,
	@s_sesn             int            = null,
	@s_term             varchar(30)    = null,
	@s_date             datetime       = null,
	@s_srv              varchar(30)    = null,
	@s_lsrv             varchar(30)    = null,
	@s_ofi              smallint       = null,
	@t_file             varchar(14)    = null,
	@s_rol              smallint       = null,
	@s_org_err          char(1)        = null,
	@s_error            int            = null,
	@s_sev              tinyint        = null,
	@s_msg              descripcion    = null,
	@s_org              char(1)        = null,
	@s_culture         	varchar(10)    = 'NEUTRAL',
	@t_rty              char(1)        = null,
	@t_trn				int            = null,
	@t_show_version     bit            = 0,
    @i_id_cliente    	int            ,--codigo del cliente,
   @o_resultado         varchar(2)      out

    
)
as
declare	
@w_sp_name 				       varchar(64),
@w_error				       int,
@w_secuencial               int,
@w_fecha_apertura_cuenta    datetime ,
@w_fecha_consulta           datetime,
@w_num_dias                 int,
@w_cad                      varchar(30),
@w_fecha_cierre_cuenta_c_c  datetime ,
@w_fecha_consulta_c_c       datetime,
@w_num_dias_c_c             int,
@w_cad_c_c                     varchar(30),
@w_param_cc_abiertas        int ,
@w_param_cc_cerradas        int
		
select @w_sp_name 	= 'sp_var_experiencia_crediticia'

 
if @i_id_cliente is null
begin
   select @w_error = 2109003 
   goto ERROR
end

select @o_resultado='N'

select @w_param_cc_abiertas = pa_int 
  from cobis..cl_parametro
 where pa_nemonico = 'NDCCAB'
 
if @w_param_cc_abiertas is null
begin
   select @w_error = 2109004 
   goto ERROR
end
 
select @w_param_cc_cerradas = pa_int   
  from cobis..cl_parametro
 where pa_nemonico = 'NDCCCE'
 
if @w_param_cc_cerradas is null
begin
   select @w_error = 2109005 
   goto ERROR
end

--declaro tabla que almacena las cuentas abiertas del cliente
declare @w_cuentas_abiertas table(secuencial_c_a           int identity ,
                                  ib_fecha_c_a                 datetime ,   
                                  bc_fecha_apertura_cuenta_c_a varchar(8)  ,
                                  bc_id_cliente_c_a            int,
                                  fecha_apertura_cuenta        datetime null,
                                  numero_dias                  int      null)
                                          

                                         
insert into @w_cuentas_abiertas
select DISTINCT ib_fecha ,bc_fecha_apertura_cuenta ,ib_cliente, null, null
from cr_interface_buro, cr_buro_cuenta 
where ib_cliente             = @i_id_cliente 
and   ib_estado              = 'V'
and   bc_ib_secuencial = ib_secuencial
and   bc_fecha_cierre_cuenta is  null 
and   bc_nombre_otorgante    not in ( select c.valor from
                                      cobis..cl_tabla t,cobis..cl_catalogo c
                                      where  t.tabla  = 'cr_tipo_negocio'
                                      and t.codigo = c.tabla )


select @w_secuencial= 0
 
--select top 1 @w_cad=bc_fecha_apertura_cuenta_c_a
update @w_cuentas_abiertas set
fecha_apertura_cuenta = Convert (datetime,substring(bc_fecha_apertura_cuenta_c_a, 1, 2) + '/' + substring(bc_fecha_apertura_cuenta_c_a, 3, 2) + '/' + substring(bc_fecha_apertura_cuenta_c_a, 5, 4),103)

update @w_cuentas_abiertas set
numero_dias = datediff(dd,fecha_apertura_cuenta, ib_fecha_c_a) 
 

if exists (select 1 from @w_cuentas_abiertas where numero_dias > @w_param_cc_abiertas)
begin
   select @o_resultado='S'
   
   update cobis..cl_ente_aux set
   ea_experiencia = @o_resultado
   where ea_ente = @i_id_cliente
   
   if @@error <> 0
   begin
      select @w_error = 103149 --' No existe el registro que desea actualizar '
	  goto ERROR
   end
       
   goto fin
end
  
--print'Resultado cuentas abiertas'+ convert(varchar(50),@o_resultado)
  
--Declaro tabla temporal para la cuentas cerradas de un cliente.
declare @w_cuentas_cerradas	table (secuencial_c_c int identity ,
                                   ib_fecha_c_c datetime  ,   
                                   bc_fecha_cierre_cuenta_c_c varchar(8)  ,
                                   bc_id_cliente_c_c int, 
                                   fecha_cierre datetime null,
                                   num_dias_cierre int   null)  
                                            
---Inserto la cuentas cerradas del cliente
insert into @w_cuentas_cerradas
select DISTINCT ib_fecha ,bc_fecha_cierre_cuenta ,ib_cliente, null, null
from cr_buro_cuenta,cr_interface_buro
where  ib_cliente   = @i_id_cliente
and ib_estado        = 'V'
and bc_ib_secuencial = ib_secuencial
and bc_fecha_cierre_cuenta is not null 
and bc_nombre_otorgante not in ( select c.valor from
                                 cobis..cl_tabla t,cobis..cl_catalogo c
                                 where  t.tabla  = 'cr_tipo_negocio'
                                 and t.codigo = c.tabla
                                   )
    
--imprimo cuentas cerradas
--select * from @w_cuentas_cerradas

update @w_cuentas_cerradas set
fecha_cierre = Convert (datetime,substring(bc_fecha_cierre_cuenta_c_c, 1, 2) + '/' + substring(bc_fecha_cierre_cuenta_c_c, 3, 2) + '/' + substring(bc_fecha_cierre_cuenta_c_c, 5, 4),103)

update @w_cuentas_cerradas set
num_dias_cierre = datediff(dd, fecha_cierre, ib_fecha_c_c)

if exists (select 1 from @w_cuentas_cerradas where num_dias_cierre<@w_param_cc_cerradas)
begin
   select @o_resultado='S'

   update cobis..cl_ente_aux 
   set ea_experiencia = @o_resultado
   where ea_ente = @i_id_cliente

   if @@error <> 0
   begin
      select @w_error = 103149 --' No existe el registro que desea actualizar '
      goto ERROR
   end
        
   goto fin
end
     


--print'RESULTADO EXPERIENCIA CREDITICIA'+ convert(varchar(50),@o_resultado)

if @t_debug = 'S'
begin
	print '@w_resultado: ' + convert(varchar, @o_resultado )	
end
	
if @o_resultado is null
begin
	select @w_error = 6904007 --No existieron resultados asociados a la operacion indicada   
	goto ERROR
end

update cobis..cl_ente_aux 
set ea_experiencia = @o_resultado
where ea_ente = @i_id_cliente
if @@error <> 0
begin
	select @w_error = 103149 --' No existe el registro que desea actualizar '
	goto ERROR
end

goto fin

ERROR:
	exec cobis..sp_cerror
			@t_debug  = 'N',
			@t_file   = '',
			@t_from   = @w_sp_name,
			@i_num    = @w_error
	return @w_error
	
fin:
return 0

go
