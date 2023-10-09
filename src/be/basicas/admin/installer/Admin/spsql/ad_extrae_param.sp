/****************************************************************/
/* ARCHIVO:         ad_extrae_param.sp                          */
/* NOMBRE LOGICO:   sp_extrae_param                             */
/* PRODUCTO:        ADMIN                                       */
/****************************************************************/
/*                         IMPORTANTE                           */
/* Esta aplicacion es parte de los paquetes bancarios propiedad */
/* de MACOSA S.A.                                               */
/* Su uso no  autorizado queda  expresamente prohibido asi como */
/* cualquier  alteracion  o agregado  hecho por  alguno  de sus */
/* usuarios sin el debido consentimiento por escrito de MACOSA. */
/* Este programa esta protegido por la ley de derechos de autor */
/* y por las  convenciones  internacionales de  propiedad inte- */
/* lectual.  Su uso no  autorizado dara  derecho a  MACOSA para */
/* obtener  ordenes de  secuestro o retencion y  para perseguir */
/* penalmente a los autores de cualquier infraccion.            */
/****************************************************************/
/*                          PROPOSITO                           */
/* Este programa permite llenar datos de tablas de parametria   */
/* cob_comext..ce_oficina_rol                                   */
/****************************************************************/
/*                      MODIFICACIONES                          */
/* FECHA         AUTOR            RAZON                         */
/* 13/Sep/2011   Ivette Rojas     Emision Inicial               */
/*  04/ABR/12     Angelo Andy     Versionamiento del SP   	    */
/*  11-03-2016    BBO             Migracion Sybase-Sqlserver FAL*/
/****************************************************************/
use cobis
go

if exists (select 1 from sysobjects where name = 'sp_extrae_param')	
   drop proc sp_extrae_param 
go

create proc sp_extrae_param(
       @t_show_version            bit         = 0,    -- show the version of the stored procedure  
	   @i_fecha_proceso   datetime,
       --Parametros para el Visual Batch
       @i_sarta           int = null,
       @i_batch           int = null,
       @i_secuencial      int = null,
       @i_corrida         int = null,
       @i_intento         int = null
)
as

/* Declaracion de variables de uso interno */ 
declare
   @w_return              int,           -- valor retorno SPs
   @w_sp_name             varchar(32),   -- nombre del stored procedure
   @w_error_msg           descripcion,   -- mensaje de error para tabla sb_error_conta
   @w_tipo_extraccion     char(1),       -- 'I': Carga Inicial, 'D': Carga Diaria
   @w_banco               smallint

-- Asignar el nombre del stored procedure
select @w_sp_name = 'sp_extrae_param'

if @t_show_version = 1
        begin
            print 'Stored Procedure=' + @w_sp_name + ' Version=4.0.0.1'
            return 0
    end

--print 'INICIA sp_extrae_param'

-- Leer parametro de carga inicial
select @w_tipo_extraccion = pa_char
  from cobis..cl_parametro 
 where pa_producto = 'ADM'
   and pa_nemonico = 'TEDWH'
if @@rowcount = 0
begin
  select @w_tipo_extraccion = 'D'
end

select @w_banco = 0

--truncate table cob_comext..ce_ex_oficina_rol

while 1 = 1
begin
  --Escoger el banco a ser procesado
  set rowcount 1
  select @w_banco = bc_banco
    from cob_comext..ce_banco
   where bc_banco > @w_banco
   order
      by bc_banco
  if @@rowcount = 0
  begin
  	set rowcount 0
  	break
  end

  set rowcount 0
  
  insert into cob_comext..ce_ex_oficina_rol
  select 1,
         or_banco,
         or_oficina,
         or_rol,
         or_fecha,
         null
    from cob_comext..ce_oficina_rol
   where or_banco             = @w_banco
     and ((@w_tipo_extraccion = 'I')
      or  (@w_tipo_extraccion = 'D'
     and   convert(varchar(10),or_fecha,101) = convert(varchar(10),@i_fecha_proceso,101)))
end
--print 'FINALIZA sp_extrae_param'
set rowcount 0
return 0
go
